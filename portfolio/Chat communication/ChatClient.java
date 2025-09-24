import java.io.*;
import java.net.*;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class ChatClient {

  
    JFrame frame = new JFrame("Chat Client");
    private JTextField chatBox = new JTextField();
    private JTextArea chatArea = new JTextArea();
   


    private Socket socket;
    private PrintWriter out;
    private BufferedReader in;

    
    public void printMessage(final String message) {
        chatArea.append(message);
    }


    public ChatClient(String server, int port) throws IOException {

     
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        panel.add(chatBox);
        frame.setLayout(new BorderLayout());
        frame.add(panel, BorderLayout.SOUTH);
        frame.add(new JScrollPane(chatArea), BorderLayout.CENTER);
        frame.setSize(500, 300);
        frame.setVisible(true);
        chatArea.setEditable(false);
        chatBox.setEditable(true);
        chatBox.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    newMessage(chatBox.getText());
                } catch (IOException ex) {
                    printMessage("Error sending message: " + ex.getMessage() + "\n");
                } finally {
                    chatBox.setText("");
                }
            }
        });
        frame.addWindowListener(new WindowAdapter() {
            public void windowOpened(WindowEvent e) {
                chatBox.requestFocusInWindow();
            }
        });
      
        socket = new Socket(server, port);
        out = new PrintWriter(socket.getOutputStream(), true);
        in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
    }



    
    public void newMessage(String message) throws IOException {
        if (message.trim().isEmpty()) {
            return;
        }
        out.println(message);
    }


    public void run() throws IOException {
        Thread receiverThread = new Thread(() -> {
            try {
                String response;
                while ((response = in.readLine()) != null) {
                    processServerMessage(response);
                }
            } catch (IOException e) {
                printMessage("Connection lost.\n");
                handleConnectionClosure();
            } finally {
                try {
                    socket.close();
                } catch (IOException ex) {
                    printMessage("Error closing connection: " + ex.getMessage() + "\n");
                }
            }
        });

        receiverThread.start();
    }

   
    private void processServerMessage(String response) {
        String formattedMessage;

        if (response.startsWith("MESSAGE")) {
            String[] parts = response.split(" ", 3);
            if (parts.length >= 3) {
                formattedMessage = String.format("%s: %s\n", parts[1], parts[2]);
            } else {
                formattedMessage = String.format("Invalid MESSAGE format.\n");
            }
        } else if (response.startsWith("NEWNICK")) {
            String[] parts = response.split(" ", 3);
            if (parts.length >= 3) {
                formattedMessage = String.format("%s mudou de nome para %s\n", parts[1], parts[2]);
            } else {
                formattedMessage = String.format("Invalid NEWNICK format.\n");
            }
        } else if (response.startsWith("JOINED")) {
            String[] parts = response.split(" ", 2);
            if (parts.length >= 2) {
                formattedMessage = String.format("%s entrou na sala.\n", parts[1]);
            } else {
                formattedMessage = String.format("Invalid JOINED format.\n");
            }
        } else if (response.startsWith("LEFT")) {
            String[] parts = response.split(" ", 2);
            if (parts.length >= 2) {
                formattedMessage = String.format("%s saiu da sala.\n", parts[1]);
            } else {
                formattedMessage = String.format("Invalid LEFT format.\n");
            }
        } else if (response.startsWith("BYE")) {
            formattedMessage = String.format("Você saiu do chat.\n");
        } else if (response.startsWith("OK")) {
            formattedMessage = String.format("Comando executado com sucesso.\n");
        } else if (response.startsWith("ERROR")) {
            formattedMessage = String.format("Erro ao executar comando: %s\n", response.substring(6));
        }
        // Msg Privada
        else if (response.startsWith("PRIVATE")) {
            String[] parts = response.split(" ", 3);
            if (parts.length >= 3) {
                formattedMessage = String.format("(Privado) %s: %s\n", parts[1], parts[2]);
            } else {
                formattedMessage = String.format("Invalid PRIVATE format.\n");
            }
        } else {
            formattedMessage = String.format(" Mensagem desconhecida do servidor: %s\n", response);
        }

        printMessage(formattedMessage);
    }

    
    private void handleConnectionClosure() {
        printMessage("Connection lost. Please restart the application to try again.\n");
        chatBox.setEditable(false);
    }

   
    public static void main(String[] args) throws IOException {
        if (args.length != 2) {
            System.out.println("Usage: java ChatClient <server> <port>");
            System.exit(1);
        }
        ChatClient client = new ChatClient(args[0], Integer.parseInt(args[1]));
        client.run();
    }

}

