-- baseball.sql 
-- James R Von Holle
-- Oct 13, 2017

create table if not exists PERSONNEL (
    id int,
    first_name varchar(45) not null,
    last_name  varchar(45) not null,
    birth_date date not null,
    birth_place varchar(45) not null
);
    
create table if not exists COACH (
    PersonID int not null,
    Team_name varchar(45),
    key ix_PERSONEL_id,
    key ix_TEAM_name,
    constraint fk_PERSONNEL_id foreign key(PersonID) references PERSONNEL(id),
    constraint fk_TEAM_name foreign key(Team_name) references TEAM(name) 
);
create table if not exists UMPIRE (
    PersonID int not null,
    primary key(PersonID)
);
create table if not exists PLAYER (
    PersonID int not null,
    batting_average double not null,
    Team_name varchar(45),
    Orientation_type varchar(10),
    primary key (PersonID),
    constraint fk_Player_Team_idx foreign key(Team_name) references TEAM(name),
    constraint fk_Player_Orientation_idx foreign key(Orientation_type) references Orientation(type)
);
create table if not exists Orientation (
    type varchar(10)
);
create table if not exists PITCHER (
    Player_Personnel_id int not null,
    ERA double not null,
    primary key (Player_Personnel_id) references PLAYER(PersonID)
);
create table if not exists TEAM (
    name varchar(45) not null unique,
    city varchar(45) not null,
    manager int not null unique,
    Division_name varchar(45),
    primary key (name),
    constraint fk_Team_Personnel1_idx foreign key (),
    constraint fk_Team_Divison_idx foreign key(Division_name) references DIVISION(name)
);
create table if not exists DIVISION (
    name varchar(45) not null,
    League_name varchar(45) not null,
    primary key(name),
    constraint fk_DIVISION_League1_idx foreign key(League_name) references LEAGUE(name)
);
create table if not exists LEAGUE (
    name varchar(45) not null unique,
    primary key(name)
);
create table if not exists GAME(
    Schedule_date datetime not null,
    Home_Team_name varchar(45) not null,
    Away_team_name varchar(45) not null,
    primary key(Schedule_date, Home_Team_name, Away_team_name),
    constraint fk_Game_Away1_idx foreign key(Away_team_name) references AWAY(Team_name),
    constraint fk_Game_Home1_idx foreign key(Home_Team_name) references HOME(Team_name)
);
create table if not exists HOME(
    Schedule_date datetime not null,
    Team_name varchar(45) not null,
    runs int not null,
    hits int not null,
    errors int not null,
    Pitcher_Player_PersonID int,
    primary key(Team_name, Schedule_date),
    constraint fk_Home_Pitcher1_idx foreign key(Pitcher_Player_PersonID) references PITCHER(Player_Personnel_id)
);
create table if not exists AWAY(
    Schedule_date datetime not null,
    Team_name varchar(45) not null,
    runs int not null,
    hits int not null,
    errors int not null,
    Pitcher_Player_PersonID int,
    primary key(Team_name, Schedule_date),
    constraint fk_Away_Pitcher1_idx foreign key(Pitcher_Player_PersonID) references PITCHER(Player_Personnel_id)
);
create table if not exists Game_Umpire (
    Umpire_Personnel_id int not null,
    Game_Schedule_date datetime not null,
    Game_Home_Team_name varchar(45) not null,
    Game_Away_Team_name varchar(45) not null,
    primary key (Umpire_Personnel_id),
    constraint fk_Game_Umpire_Game1_idx foreign key(Game_Away_Team_name, Game_Home_Team_name, Game_Schedule_date) references GAME(key)
);
create table if not exists Game_Pitcher(
    Pitcher_Player_PersonID int not null,
    Record_type varchar(15) not null,
    Game_Schedule_date datetime not null,
    Game_Home_Team_name varchar(45) not null,
    primary key(Pitcher_Player_PersonID),
    constraint fk_Game_Pitcher_Record1_idx foreign key(Record_type) references Record(type)
);
create table if not exists Record (
    type varchar(15) not null,
    primary key(type)
);
create table if not exists Player_Score( 
    Player_Personnel_id int not null,
    single int,
    double int,
    triple int,
    home_run int,
    Game_Schedule_date datetime not null,
    Game_Home_Team_name varchar(45) not null,
    Game_Away_Team_name varchar(45) not null,
    primary key(Player_Personnel_id),
    constraint fk_Game_Statistics_Game1_idx foreign key(Game_Schedule_date) references GAME(Schedule_date)
);
