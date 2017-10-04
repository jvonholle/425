-- James R Von Holle
-- CS 425
-- Problem 6.6 for Assignment 4

create table AIRPORT (
    Airport_code int,
    Name varchar(20),
    City varchar(20),
    State varchar(20),
    primary key(Airport_code)
);
create table FLIGHT (
    Flight_number int,
    Airline varchar(20),
    WeekDays varchar(20),
    primary key(Flight_number)
);
create table FLIGHT_LEG (
    Flight_number int,
    Leg_number int,
    Departure_airport_code int,
    Scheduled_departure_time int,
    Arrival_airport_code int,
    Scheduled_arrival_time int,
    primary key(Flight_number, Leg_number),
    foreign key(Flight_number) references FLIGHT(Flight_number)
);
create table LEG_INSTANCE (
    Flight_number int,
    Leg_number int,
    DateOccured date,
    Number_of_available_seats int,
    Airplane_id int,
    Departure_airport_code int,
    Departure_time int,
    Arrival_airport_code int,
    Arrival_time int,
    primary key(Flight_number, Leg_number, DateOccured),
    foreign key(Flight_number, Leg_number) references FLIGHT_LEG(Flight_number, Leg_number)
);
create table FARE (
    Flight_number int,
    Fare_code int,
    Amount number,
    Restrictions varchar(200),
    primary key(Flight_number, Fare_code),
    foreign key(Flight_number) references FLIGHT(Flight_number)
);
create table AIRPLANE_TYPE (
    Airplane_type_name varchar(20),
    Max_seats int,
    Company varchar(20),
    primary key(Airplane_type_name)
);
create table CAN_LAND (
    Airplane_type_name varchar(20),
    Airport_code int,
    primary key(Airplane_type_name, Airport_code),
    foreign key(Airport_code) references AIRPORT(Airport_code)
);
create table AIRPLANE (
    Airplane_id int,
    Total_number_of_seats int,
    Airplane_type varchar(20),
    primary key(Airplane_id)
);
create table SEAT_RESERVATION (
    Flight_number int,
    Leg_number int,
    DateOccured date,
    Seat_number int,
    Customer_name varchar(40),
    Customer_phone int,
    primary key(Flight_number, Leg_number, DateOccured, Seat_number),
    foreign key(Flight_number, Leg_number, DateOccured) references FLIGHT_LEG(Flight_number, Leg_number, DateOccured)
);