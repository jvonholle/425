-- cs425_midterm_jrvonhollejr.sql
-- James R Von Holle
-- Oct 25 2017
-- midterm database for CS 425

set @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
set @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
set @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL';
set sql_log_bin = 0;

-----------------------
-- CLEAN-UP FOR MAKE --
-----------------------
drop table if exists `midterm`.`Address`;
drop table if exists `midterm`.`Coach`;
drop table if exists `midterm`.`Employee`;
drop table if exists `midterm`.`Fan`;
drop table if exists `midterm`.`Game`;
drop table if exists `midterm`.`Location`;
drop table if exists `midterm`.`Official`;
drop table if exists `midterm`.`Person`;
drop table if exists `midterm`.`Player`;
drop table if exists `midterm`.`Player_Stats`;
drop table if exists `midterm`.`Position`;
drop table if exists `midterm`.`State`;
drop table if exists `midterm`.`Team`;
drop view if exists `midterm`.`view_coaches`;
drop view if exists `midterm`.`view_players`;
drop view if exists `midterm`.`view_current_players_coaches`;
drop trigger if exists `midterm`.`official_check`;
drop trigger if exists `midterm`.`coach_check`;
drop trigger if exists `midterm`.`player_check`;
-----------------------
-- CLEAN-UP FOR MAKE --
-----------------------

-----------
-- STATE --
-----------
create table if not exists State ( name varchar(75) not null primary key );
---------------
-- END STATE --
---------------

----------
-- TEAM --
----------
create table if not exists Team (
    -- columns
    name varchar(75) not null unique,
    captain int unsigned not null,
    color varchar(75) not null,
    State_name varchar(75) not null,
    -- keys
    primary key(name),
    foreign key(captain) references Player(number),
    foreign key(State_name) references State(name)
);
--------------
-- END TEAM --
--------------

----------
-- GAME --
----------
create table if not exists Game (
    -- columns
    date datetime not null,
    Home varchar(75) not null,
    home_score smallint unsigned not null,
    Visitor varchar(75) not null,
    visitor_score smallint unsigned not null,
    -- keys
    primary key (date, Home, Visitor),
    foreign key(Home) references Team(name),
    foreign key(Visitor) references Team(name)
);
---------------
-- END GAME --
---------------

------------------
-- PERSON STUFF --
------------------
create table if not exists Person (
    -- columns
    id int unsigned not null auto_increment,
    first varchar(75) not null,
    mi char(1),
    last varchar(75) not null,
    -- keys
    primary key(id)
);
create table if not exists Fan (
    -- columns
    Person_id int unsigned not null,
    Player_id int unsigned,
    Team_name varchar(75) not null,
    -- keys
    foreign key(Person_id) references Person(id),
    foreign key(Player_id) references Player(Employee_id),
    foreign key(Team_name) references Team(name)
);
create table if not exists Location ( type varchar(75) not null unique primary key );
create table if not exists Address (
    -- columns
    id int unsigned not null,
    Location_type varchar(75) not null,
    street varchar(75) not null, city varchar(75) not null,
    zip smallint unsigned not null,
    State_name varchar(75) not null,
    -- keys
    foreign key(id) references Person(id),
    foreign key(State_name) references State(name),
    foreign key(Location_type) references Location(type)
);
create table if not exists Employee (
    -- columns
    Person_id int unsigned not null,
    salary double unsigned not null,
    -- keys
    foreign key(Person_id) references Person(id)
);
create table if not exists Player (
    -- columns
    Employee_id int unsigned not null,
    number int unsigned not null unique,
    Team_name varchar(75) not null,
    start_date date not null,
    end_date date,
    -- keys
    foreign key(Employee_id) references Employee(Person_id),
    foreign key(Team_name) references Team(name)
);
create table if not exists Player_Stats (
    -- columns
    Player_id int unsigned not null,
    assists int unsigned not null,
    rebounds int unsigned not null,
    points int unsigned not null,
    fouls int unsigned not null,
    Game_date datetime not null,
    Game_Home varchar(75) not null,
    Game_Visitor varchar(75) not null,
    -- keys
    foreign key(Game_date, Game_Home, Game_Visitor) references Game(date, Home, Visitor),
    foreign key(Player_id) References Player(Employee_id)
);
create table if not exists Coach (
    -- columns
    Employee_id int unsigned not null,
    Team_name varchar(75) not null,
    -- keys
    foreign key(Employee_id) references Employee(Person_id) on update cascade on delete cascade,
    foreign key(Team_name) references Team(name)
);
create table if not exists Position ( type varchar(75) not null primary key );
create table if not exists Official (
    -- columns
    Employee_id int unsigned not null,
    Position_type varchar(75) not null,
    Game_date datetime not null,
    Game_Home varchar(75) not null,
    Game_Visitor varchar(75) not null,
    -- keys
    foreign key(Employee_id) references Employee(Person_id) on update cascade on delete cascade,
    foreign key(Game_date, Game_Home, Game_Visitor) references Game(date, Home, Visitor),
    foreign key(Position_type) references `Position`(type)
);
----------------------
-- END PERSON STUFF --
----------------------

------------------
-- DATA LOADING --
------------------
load data local infile 'CSV/Address.csv' into table Address fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Coach.csv' into table Coach fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Employee.csv' into table Employee fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Fan.csv' into table Fan fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Game.csv' into table Game fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Location.csv' into table Location fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Official.csv' into table Official fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Person.csv' into table Person fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Player.csv' into table Player fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Player_Stats.csv' into table Player_Stats fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Position.csv' into table Position fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/State.csv' into table State fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
load data local infile 'CSV/Team.csv' into table Team fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;
----------------------
-- END DATA LOADING --
----------------------

-----------
-- VIEWS --
-----------
create view view_coaches as 
    select Person.id, Person.first, Person.mi, Person.last,
           Address.Location_type, Address.street, Address.city, Address.zip, Address.State_name,
           Employee.salary,
           Coach.Team_name from ((( Person
                        join Address on Person.id = Address.id)
                        join Employee on Person.id = Employee.Person_id)
                        join Coach on Employee.Person_id = Coach.Employee_id);

create view view_players as 
    select Person.id, Person.first, Person.mi, Person.last,
           Address.Location_type, Address.street, Address.city, Address.zip, Address.State_name,
           Employee.salary,
        Player.Team_name, Player.number, Player.start_date, Player.end_date from ((( Person
                        join Address on Person.id = Address.id)
                        join Employee on Person.id = Employee.Person_id)
                        join Player on Employee.Person_id = Player.Employee_id);

create view view_current_players_coaches as
    select *, 'coach' as position from view_coaches
        union
    select id, first, mi, last,
           Location_type, street, city, zip, State_name,
        salary, Team_name, 'player' as postion from view_players where end_date is null;
---------------
-- END VIEWS --
---------------

--------------
-- TRIGGERS --
--------------
delimiter !!
create trigger player_check before insert on Player
    for each row 
        begin
            if( exists (select 1 from Coach where Coach.Employee_id = NEW.Employee_id) or
                exists (select 1 from Official where Official.Employee_id = NEW.Employee_id) ) then
                signal SQLSTATE value '45000'
                set MESSAGE_TEXT = 'You can\'t be more than one type of employee';
            end if;
        end!!

create trigger coach_check before insert on Coach
    for each row 
        begin
            if( exists (select 1 from Player where Player.Employee_id = NEW.Employee_id) or
                exists (select 1 from Official where Official.Employee_id = NEW.Employee_id) ) then
                signal SQLSTATE value '45000'
                set MESSAGE_TEXT = 'You can\'t be more than one type of employee';
            end if;
        end!!

create trigger official_check before insert on Official
    for each row 
        begin
            if( exists (select 1 from Coach where Coach.Employee_id = NEW.Employee_id) or
                exists (select 1 from Player where Player.Employee_id = NEW.Employee_id) ) then
                signal SQLSTATE value '45000'
                set MESSAGE_TEXT = 'You can\'t be more than one type of employee';
            end if;
        end!!
delimiter ;
------------------
-- END TRIGGERS --
------------------

set @SQL_MODE = @OLD_SQL_MODE;
set @FOREIGN_KEY_CHECK = @OLD_FOREIGN_KEY_CHECKS;
set @UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

-- EOF
------------------------
