-- James R Von Holle
-- CS 425
-- Problem 6.5 for Assignment 4

create table STUDENT (
    Name varchar(20) not null,
    Student_number int,
    Class varchar(20),
    Major varchar(20),
    primary key(Student_number)
);
create table COURSE (
    Course_name varchar(20) not null,
    Course_number int not null,
    Credit_hours float,
    Department varchar(20),
    primary key(Course_number)
);
create table PREREQUISITE (
    Course_number int not null,
    Prerequisite_number int,
    foreign key(Course_number) references COURSE(Course_number)
);
create table SECTION (
    Section_ID int,
    Course_number int,
    Semester varchar(5),
    Year date,
    Instructor varchar(20),
    primary key(Course_number, Section_ID, Semester, Year)
);
create table GRADE_REPORT (
    Student_number int,
    Section_ID int,
    Grade int
    foreign key (Student_number) references STUDENT(Student_number),
    foreign key (Section_ID) references SECTION(Section_ID, Course_number, Semester, Year)
);