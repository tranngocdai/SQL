CREATE Schema quanlysinhvien;
USE quanlysinhvien;
CREATE table Class(
    ClassID int not null auto_increment primary key,
    ClassName varchar(60) not null,
    StartDate datetime not null,
    Status Bit
);
CREATE table Student(
    StudentID int not null auto_increment primary key,
    StudentName varchar(30) not null,
    Address varchar(50),
    Phone varchar(20),
    Status Bit,
    ClassID int not null,
    foreign key (ClassID) references Class(ClassID)
);
CREATE Subject(
    SubID int not null auto_increment primary key,
    SubName varchar(30) not null,
    Credit tinyint not null default 1 (Credit Check >=1),
    Status Bit default 1
);
CREATE table Mark(
    MarkID int not null auto_increment primary key,
    SubID int not null ,
    StudentID int not ,
    Mark Float Default 0 Check (Mark between 0 and 100),
    ExampleTimes tinyint default 1,
    Unique(SubID,StudentID),
    foreign key (StudentID) references Student (StudentID),
    foreign key (SubID) references Subject(SubID)
);
