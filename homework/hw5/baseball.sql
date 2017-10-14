-- baseball.sql 
-- James R Von Holle
-- Oct 13, 2017

create table if not exists PERSONEL (
    id int,
    first_name varchar(45) not null,
    last_name  varchar(45) not null,
    birth_date date not null,
    birth_place varchar(45) not null
);
    
create table if not exists COACH (
    
);
create table if not exists MANAGER();
create table if not exists UMPIRE ();
create table if not exists PLAYER ();
create table if not exists STATS ();
create table if not exists SCHEDULE ();
create table if not exists DIVISION ();
create table if not exists LEAGUE ();
create table if not exists Orientation ();
create table if not exists Record ();
create table if not exists Game_Pitcher ();
create table if not exists Player_Score ();
create table if not exists PITCHER ();
create table if not exists VISITOR ();
create table if not exists Game_Umpire ();
create table if not exists GAME ();
create table if not exists TEAM ();
