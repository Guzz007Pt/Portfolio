import java.io.*;
import java.net.*;
import java.nio.*;
import java.nio.channels.*;
import java.nio.charset.*;
import java.util.*;
import java.util.concurrent.*;

public class ChatServer{

    static private Map<SocketChannel, String> clientRooms = new ConcurrentHashMap<>();
    static private Map<String, Set<SocketChannel>> chatRooms = new ConcurrentHashMap<>();
    static private Map<SocketChannel, String> clientNames = new ConcurrentHashMap<>();

    
    static private final Charset charset = Charset.forName("UTF8");
    static private final CharsetDecoder decoder = charset.newDecoder();

    static public void main(String args[]) throws Exception {
        if (args.length < 1) {
            System.out.println("Usage: java ChatServer <port>");
            return;
        }

        int port = Integer.parseInt(args[0]);

        try (Selector selector = Selector.open();
             ServerSocketChannel ssc = ServerSocketChannel.open()) {

            ssc.configureBlocking(false);
            ServerSocket ss = ssc.socket();
            InetSocketAddress isa = new InetSocketAddress(port);
            ss.bind(isa);
            ssc.register(selector, SelectionKey.OP_ACCEPT);
            System.out.println("Listening on port " + port);


            while (true) {
                int num = selector.select();

                if (num == 0) {
                    continue;
                }

                Set<SelectionKey> keys = selector.selectedKeys();
                Iterator<SelectionKey> it = keys.iterator();

                while (it.hasNext()) {
                    SelectionKey key = it.next();
                    it.remove(); 

                    if (key.isAcceptable()) {
                        ServerSocketChannel server = (ServerSocketChannel) key.channel();
                        SocketChannel sc = server.accept();
                        if (sc != null) {
                            sc.configureBlocking(false);
                            SelectionKey clientKey = sc.register(selector, SelectionKey.OP_READ);
                            ByteBuffer clientBuffer = ByteBuffer.allocate(16384);
                            clientKey.attach(clientBuffer);
                            String defaultName = "User" + sc.hashCode();
                            clientNames.put(sc, defaultName);
                            System.out.println("Connected: " + sc.getRemoteAddress() + " as " + defaultName);
                        }
                    } else if (key.isReadable()) {
                        SocketChannel sc = (SocketChannel) key.channel();
                        ByteBuffer clientBuffer = (ByteBuffer) key.attachment();

                        try {
                            boolean ok = processInput(sc, clientBuffer);
                            if (!ok) {
                                closeConnection(sc, key);
                            }
                        } catch (IOException e) {
                            System.err.println("Error reading from client: " + e.getMessage());
                            closeConnection(sc, key);
                        }
                    }
                }
            }
        } catch (IOException ie) {
            System.err.println("Server error: " + ie.getMessage());
        }
    }

    static private boolean processInput(SocketChannel sc, ByteBuffer clientBuffer) throws IOException {
      int bytesRead = sc.read(clientBuffer);
      if (bytesRead == -1) {
          return false; 
      }
  
      clientBuffer.flip();
      CharBuffer charBuffer = decoder.decode(clientBuffer);
      String data = charBuffer.toString();
      clientBuffer.clear();
  
   
      String[] messages = data.split("\n");
      for (String message : messages) {
          message = message.trim();
          if (!message.isEmpty()) {
              handleClientMessage(sc, message);
          }
      }
      return true;
  }
  
  static private void handleClientMessage(SocketChannel sc, String message) throws IOException {
      if (message.startsWith("//")) {
          String submessage = message.substring(1); 
          handleMessage(sc, submessage);
      }
      else if(message.startsWith("/leave")) {
          handleLeave(sc);
      }
      else if (message.startsWith("/nick")) {
          handleNick(sc, message);
      }
      else if (message.startsWith("/join")) {
          handleJoin(sc, message);
      } 
      else if (message.startsWith("/bye")) {
          handleBye(sc);
      }
      else if (message.startsWith("/priv")) {
          handlePriv(sc, message);
      }
      else {
          handleMessage(sc, message);
      }
  }
  

    static private void sendMessage(SocketChannel sc, String message) throws IOException {
        sc.write(ByteBuffer.wrap((message + "\n").getBytes(charset)));
    }

    static private void groupMessage(SocketChannel sc, String roomName, String message) {
        Set<SocketChannel> roomSockets = chatRooms.get(roomName);
        if (roomSockets == null) {
            return;
        }

        synchronized(roomSockets){
            for (SocketChannel neighbour : roomSockets ){
                if (!neighbour.equals(sc)){
                    try{
                        sendMessage(neighbour, message);
                    }
                    catch(IOException e){
                        System.err.println("Failed to send message to a client: " + e.getMessage());
                    }
                }
            }
        }
    }

    static private void handleJoin(SocketChannel sc, String message) throws IOException {
        String[] parts = message.split(" ", 2);
        if (parts.length < 2 || parts[1].trim().isEmpty()){
            sendMessage(sc, "ERROR: Room name required.");
            return;
        }

        String roomName = parts[1].trim();
        String currentRoom = clientRooms.get(sc);
        if (currentRoom != null) {
            handleLeave(sc);
        }

        clientRooms.put(sc, roomName);
        chatRooms.computeIfAbsent(roomName, k -> ConcurrentHashMap.newKeySet()).add(sc);
        sendMessage(sc, "OK Joined room: " + roomName);
        groupMessage(sc, roomName, "JOINED " + clientNames.get(sc));
    }

    static private void handleNick(SocketChannel sc, String message) throws IOException {
        String[] parts = message.split(" ", 2);
        if (parts.length < 2 || parts[1].trim().isEmpty()){
            sendMessage(sc, "ERROR: Nickname cannot be empty.");
            return;
        } 	
        String newName = parts[1].trim(); 

        if(clientNames.containsValue(newName)){
            sendMessage(sc, "ERROR: Nickname already in use.");
            return;
        }
        String oldName = clientNames.get(sc);
        clientNames.put(sc, newName);
        String roomName = clientRooms.get(sc);

        sendMessage(sc, "OK Nickname changed to " + newName);

        if (roomName != null) {
            groupMessage(sc, roomName, "NEWNICK " + oldName + " " + newName);
        }
    }

    static private void handleLeave(SocketChannel sc) throws IOException {
        String roomName = clientRooms.remove(sc);
        if (roomName == null) {
            sendMessage(sc, "ERROR: You are not in any room.");
            return;
        }

        Set<SocketChannel> roomSockets = chatRooms.get(roomName);
        if (roomSockets != null) {
            roomSockets.remove(sc);
            if (roomSockets.isEmpty()) {
                chatRooms.remove(roomName);
            }
            groupMessage(sc, roomName, "LEFT " + clientNames.get(sc));
            sendMessage(sc, "OK Left room: " + roomName);
        }
    }

    static private void handleMessage(SocketChannel sc, String message) throws IOException {
        String room = clientRooms.get(sc);
        if (room == null) {
            sendMessage(sc, "ERROR: You are not in any room.");
            return;
        }

        String senderName = clientNames.get(sc);
        String formattedMessage = "MESSAGE " + senderName + ": " + message;
        groupMessage(sc, room, formattedMessage);
        sendMessage(sc, formattedMessage);
    }

    static private void handleBye(SocketChannel sc) throws IOException {
        handleLeave(sc);
        clientNames.remove(sc);
        sc.close();
        System.out.println("Connection closed: " + sc.getRemoteAddress());
    }

    static private void handlePriv(SocketChannel sc, String message) throws IOException {
      String[] parts = message.split(" ", 3);
      
      if (parts.length < 3) {
          sendMessage(sc, "ERROR: Invalid private message format. Usage: /priv <username> <message>");
          return;
      }
      
      String recipientName = parts[1].trim();
      String privateMessage = parts[2].trim();
      
      if (recipientName.isEmpty() || privateMessage.isEmpty()) {
          sendMessage(sc, "ERROR: Recipient name and message cannot be empty.");
          return;
      }
      
      // Find the recipient's SocketChannel
      SocketChannel recipientChannel = null;
      for (Map.Entry<SocketChannel, String> entry : clientNames.entrySet()) {
          if (entry.getValue().equalsIgnoreCase(recipientName)) {
              recipientChannel = entry.getKey();
              break;
          }
      }
      
      if (recipientChannel == null) {
          sendMessage(sc, "ERROR: User '" + recipientName + "' not found.");
          return;
      }
      
      String senderName = clientNames.get(sc);
      String formattedMessage = "PRIVATE " + senderName + ": " + privateMessage;
      

      sendMessage(recipientChannel, formattedMessage);
      
      
      sendMessage(sc, "PRIVATE to " + recipientName + ": " + privateMessage);
  }
  

    static private void closeConnection(SocketChannel sc, SelectionKey key) {
        try {
            String roomName = clientRooms.get(sc);
            if (roomName != null) {
                handleLeave(sc);
            }
            clientNames.remove(sc);
            key.cancel();
            sc.close();
            System.out.println("Closed connection to " + sc.getRemoteAddress());
        } catch (IOException e) {
            System.err.println("Error closing connection: " + e.getMessage());
        }
    }
}

