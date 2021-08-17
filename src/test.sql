create schema StudentManager;
use
StudentManager;
create table Address
(
    AddressID   int auto_increment primary key,
    AddressName varchar(100)
);
create table Classes
(
    ClassesID   int auto_increment primary key,
    ClassesName varchar(50),
    language    varchar(50),
    description varchar(200)
);
create table Students
(
    StudentID int auto_increment primary key,
    fullName  varchar(50),
    AddressID int,
    phone     int unique,
    ClassesId int,
    foreign key (AddressID) references Address (AddressID),
    foreign key (ClassesID) references Classes (ClassesID)
);

create table Course
(
    CourseID    int auto_increment primary key,
    CourseName  varchar(50),
    description varchar(200)
);
create table Point
(
    id        int auto_increment primary key,
    CourseID  int,
    StudentID int,
    point     int,
    foreign key (CourseID) references Course (CourseID),
    foreign key (Studentid) references Students (StudentID)
);

insert into Address(AddressName)
values (''Hà Nội''),
       (''Hồ Chí Minh''),
       (''Lào''),
       (''Cambodia''),
       (''Singapore'');

insert into Classes(ClassesName, language, description)
VALUES (''A'', ''English'', ''Lớp tiếng Anh''),
       ('' B'', ''French'', ''Lớp tiếng Pháp''),
       (''C'', ''Chinese'', ''Lớp tiếng Tàu''),
       (''D'', ''Korean'', ''Lớp tiếng Hàn''),
       (''E'', ''Japanese'', ''Lớp tiếng Nhật'');

insert into Students(fullName, AddressID, phone, ClassesId)
VALUES (''Trần Ngọc Đại'', ''1'', ''0123456789'', ''1''),
       (''Vũ Văn Bình'', ''2'', ''0123456788'', ''2''),
       (''Mai Đức Trung'', ''3'', ''0123456787'', ''3''),
       (''Nguyễn Văn Thản'', ''4'', ''0123456786'', ''4''),
       (''Hoàng Mạnh Cường'', ''5'', ''0123456785'', ''5''),
       (''Đỗ Xuân Văn'', ''1'', ''0123456784'', ''1''),
       (''Nguyễn Huy Nam'', ''2'', ''0123456783'', ''2''),
       (''Đỗ Hoài Nam'', ''3'', ''0123456782'', ''3''),
       (''Vũ Thị Kiều Anh'', ''4'', ''0123456781'', ''4''),
       (''Nguyễn Đồng Chính'', ''5'', ''0123456780'', ''5'');

insert into Course(CourseName, description)
VALUES (''So Easy'', ''Mới''),
       (''Easy'', ''Bắt đầu''),
       (''Normal'', ''Đã biết''),
       (''Difficulty'', ''Thông thạo''),
       (''Very Difficulty'', ''Master'');

insert into Point(CourseID, StudentID, point)
values (''1'', ''1'', ''10''),
       (''2'', ''5'', ''9''),
       (''3'', ''3'', ''5''),
       (''4'', ''2'', ''1''),
       (''5'', ''4'', ''0''),
       (''5'', ''6'', ''7''),
       (''4'', ''7'', ''6''),
       (''3'', ''10'', ''3''),
       (''2'', ''9'', ''2''),
       (''1'', ''1'', ''8''),
       (''1'', ''3'', ''7''),
       (''2'', ''4'', ''6''),
       (''3'', ''6'', ''5''),
       (''4'', ''8'', ''9''),
       (''5'', ''7'', ''10'');
#
Thống kê số lượng HV các lớp
select ClassesName, count(ClassesName) ''Số lượng học viên các lớp''
from classes join students s on classes.ClassesID = s.ClassesId
group by ClassesName;
