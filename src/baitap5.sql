CREATE Schema baitap5;
use baitap5;
CREATE table Products (
                          id_product int auto_increment primary key,
                          productCode varchar(50),
                          productName varchar(50),
                          productPrice int not null,
                          productAmount varchar(50),
                          productDescription int not null,
                          productStatus bit not null
);
ALTER table Products ADD UNIQUE  INDEX (productCode);
ALTER table Products ADD  INDEX CompositeIndex(productName, productPrice);

explain SELECT *From Products;
explain SELECT productName From products;
explain SELECT *From products where productCode ='a12';

CREATE view  ViewProduct
as SELECT productCode,productName,productPrice,productStatus From products;

DROP view ViewProduct;

DELIMITER //
CREATE PROCEDURE  Products()
BEGIN
SELECT*From products;
end //

DELIMITER //
CREATE PROCEDURE Products()
BEGIN
INSERT INTO products VALUES (1,'a12','computer',50,1,13,true);
end //