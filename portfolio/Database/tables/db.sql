
-- Table: Champions
CREATE TABLE IF NOT EXISTS Champions
 ( championID     ID primary key,
  name            varchar2(30) not null,
  times_played    number(2) not null,
  games_won       number(2));

-- Table: Countries
CREATE TABLE IF NOT EXISTS Countries 
  (countryID  ID PRIMARY KEY,
  name        varchar2 (50) NOT NULL);

-- Table: People
CREATE TABLE IF NOT EXISTS People
  (peopleID       ID primary key,
    in_game_name  varchar2(30) not null,
    function      [main,sub,coach] not null,
    teamID        ID  references Teams(TeamID), 
    countryID     ID references Countries(countryID));

-- Table: Pool
CREATE TABLE IF NOT EXISTS Pool
  (peopleID      ID,
  championID     ID,
  times_played   number(2) not null,
  games_won      number(2),
  primary key    (peopleID,ChampionID));

-- Table: Teams
CREATE TABLE IF NOT EXISTS Teams (teamID ID PRIMARY KEY,
  name            varchar2 (30) NOT NULL,
  placement       number (2) NOT NULL,
  matches_played  number (3) NOT NULL,
  countryID       ID,
  wins            number(2));