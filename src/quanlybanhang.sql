CREATE schema quanlybanhang;
use quanlybanhang;
CREATE table Customer(
                         cID int not null auto_increment primary key,
                         cName varchar(50),
                         cAge int(3)
);
CREATE table quanlybanhang.Order(
                                    oID int not null auto_increment primary key,
                                    cID int,
                                    oDate datetime,
                                    oTotalPrice varchar(50),
                                    foreign key (cID) references Customer(cID)
);
CREATE table Product(
                        pID int not null auto_increment primary key,
                        pName varchar(50),
                        pPrice varchar(50)
);
CREATE table OrderDetail(
                            oID int,
                            pID int,
                            odQTY varchar(50),
                            primary key(oID,pID),
                            foreign key (oID) references `order`(oID),
                            foreign key (pID) references Product(pID)
);