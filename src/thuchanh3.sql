CREATE SCHEMA thuchanh2;
USE thuchanh2;
CREATE table Students(
                         StudentID int primary key auto_increment,
                         StudentName varchar(50),
                         born DATETIME,
                         Class varchar(20),
                         GT varchar(20)
);
CREATE table Subjects(
                         SubjectID int primary key auto_increment,
                         StudentName varchar(20),
                         TeacherID int,
                         foreign key (TeacherID) references Teachers(TeacherID)
);
CREATE table Marks(
                      StudentID int,
                      SubjectID int,
                      mark int,
                      testDay datetime,
                      primary key (StudentID,SubjectID),
                      foreign key (StudentID) references students (StudentID),
                      foreign key (SubjectID) references Subjects(SubjectID)
);
CREATE table Teachers(
                         TeacherID int primary key auto_increment,
                         TeacherName varchar(50),
                         phone int
);