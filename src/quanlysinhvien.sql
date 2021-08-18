CREATE Schema quanlysinhvien;
USE quanlysinhvien;
CREATE table Class
(
    ClassID   int         not null auto_increment primary key,
    ClassName varchar(60) not null,
    StartDate datetime    not null,
    Status    Bit
);
CREATE table Student
(
    StudentID   int         not null auto_increment primary key,
    StudentName varchar(30) not null,
    Address     varchar(50),
    Phone       varchar(20),
    Status      Bit,
    ClassID     int         not null,
    foreign key (ClassID) references Class (ClassID)
);
CREATE table Subject
(
    SubID   int         not null auto_increment primary key,
    SubName varchar(30) not null,
    Credit  tinyint     not null default 1 CHECK (Credit >= 1),
    Status  Bit                  default 1
);
CREATE table Mark
(
    MarkID       int not null auto_increment primary key,
    SubID        int not null,
    StudentID    int,
    Mark         Float   Default 0 Check (Mark between 0 and 100),
    ExampleTimes tinyint default 1,
    Unique (SubID, StudentID),
    foreign key (StudentID) references Student (StudentID),
    foreign key (SubID) references Subject (SubID)
);
Insert Into Class(ClassID, ClassName, StartDate, Status)
Values (1, 'A1', '2008-12-20', 1),
       (2, 'A2', '2008-12-22', 1),
       (3, 'B3', current_date, 0);

Insert Into Student(StudentName, Address, Phone, Status, ClassID)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);

Insert Into Student(studentname, address, status, classid)
VALUES ('Hoa', 'Hai phong', 1, 1);

INSERT INTO Student(StudentName, Address, Phone, Status, ClassID)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject(subid, subname, credit, status)
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);

INSERT INTO Mark(subid, studentid, mark, exampletimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);

SELECT *
FROM Student;

SELECT *
FROM Student
WHERE Status = true;

SELECT *
FROM Subject
WHERE Credit < 10;

Select S.StudentID, S.StudentName, C.ClassName
FROM Student S
         join Class C on C.ClassID = S.ClassID;

# hiển thị danh sách học viên lớp A1
Select S.StudentID, S.StudentName, C.ClassName
FROM Student S
         join Class C on C.ClassID = S.ClassID
WHERE C.ClassName = 'A1';

# Hiển thị tất cả các điểm đang có của học viên
SELECT s.StudentID, s.StudentName, Sub.Subname, m.Mark
FROM Student S
         join Mark M on S.StudentID = M.StudentID
         join subject sub on M.SubID = sub.SubID;

# hiển thị điểm môn CF của các học viên
SELECT s.StudentID, s.StudentName, Sub.Subname, m.Mark
FROM Student S
         join Mark M on S.StudentID = M.StudentID
         join subject sub on M.SubID = sub.SubID
WHERE sub.SubName = 'CF';
# Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT *
FROM Student
WHERE StudentName like 'h%';
# Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
SELECT *
FROM Class
WHERE month(StartDate) = 12;
# Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
SELECT *
FROM Subject
WHERE Credit between 3 and 5;
# Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';
# Hiển thị các thông tin: StudentName, SubName, Mark.
# Dữ liệu sắp xếp theo điểm thi (mark) giảm dần.
# nếu trùng sắp theo tên tăng dần.
SELECT s.StudentName, s2.SubName, mark
from Mark
         join Student S on S.StudentID = Mark.StudentID
         join Subject S2 on S2.SubID = Mark.SubID
ORDER BY Mark desc, SubName asc;


