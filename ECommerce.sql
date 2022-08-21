create database ECommerce;
use ECommerce;
create table suppliers(Supp_Id int primary key, Supp_Name varchar(50) not null, Supp_City varchar(50) not null,supp_Phone varchar(50) not null);
create table Customer(Cus_Id int primary key, Cus_Name varchar(50) not null, Cus_Phone varchar(50) not null, Cus_City varchar(50),  Cus_Gender char);
create table Category(Cat_Id int primary key, Cat_name varchar(20) not null);
create table Product(Pro_Id int primary key, pro_name varchar(20) not null, Pro_Desc varchar(60), Cat_Id int, Foreign key(Cat_Id) references Category(Cat_Id));
create table supplier_pricing(Pricing_Id int primary key, Pro_Id int, Supp_Id int, Supp_Price int default 0, 
Foreign key (Pro_Id) references Product(Pro_Id), 
Foreign key(Supp_Id) references Suppliers(Supp_Id));
drop table supplier_pricing;
create table Orders(Ord_Id int primary key, Ord_Amount int not null, Ord_Date date not null, Cus_Id int, Pricing_Id int,
Foreign key(Cus_Id) references Customer(Cus_Id),
Foreign key(Pricing_Id) references supplier_pricing(Pricing_Id));
create table rating(Rat_Id int primary key, Ord_Id int, Rat_RatStars int not null, 
Foreign key(Ord_id) references Orders(Ord_Id));
insert into suppliers values(1, 'Rajesh Retails', 'Delhi', '1234567890');
INSERT INTO suppliers VALUES(2,"Appario Ltd.","Mumbai",'2589631470');
INSERT INTO suppliers VALUES(3,"Knome products","Banglore",'9785462315');
INSERT INTO suppliers VALUES(4,"Bansal Retails","Kochi",'8975463285');
INSERT INTO suppliers VALUES(5,"Mittal Ltd.","Lucknow",'7898456532');
INSERT INTO Customer VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO Customer VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO Customer VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO Customer VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO Customer VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');
INSERT INTO CATEGORY VALUES( 1,"BOOKS");
INSERT INTO CATEGORY VALUES(2,"GAMES");
INSERT INTO CATEGORY VALUES(3,"GROCERIES");
INSERT INTO CATEGORY VALUES (4,"ELECTRONICS");
INSERT INTO CATEGORY VALUES(5,"CLOTHES");

INSERT INTO Product VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
INSERT INTO Product VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO Product VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
INSERT INTO Product VALUES(4,"OATS","Highly Nutritious from Nestle",3);
INSERT INTO Product VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
INSERT INTO Product VALUES(6,"MILK","1L Toned MIlk",3);
INSERT INTO Product VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO Product VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO Product VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO Product VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO Product VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO Product VALUES(12,"Train Your Brain","By Shireen Stephen",1);

INSERT INTO supplier_pricing VALUES(1,1,2,1500);
INSERT INTO supplier_pricing VALUES(2,3,5,30000);
INSERT INTO supplier_pricing VALUES(3,5,1,3000);
INSERT INTO supplier_pricing VALUES(4,2,3,2500);
INSERT INTO supplier_pricing VALUES(5,4,1,1000);
INSERT INTO supplier_pricing VALUES(6,12,2,780);
INSERT INTO supplier_pricing VALUES(7,12,4,789);
INSERT INTO supplier_pricing VALUES(8,3,1,31000);
INSERT INTO supplier_pricing VALUES(9,1,5,1450);
INSERT INTO supplier_pricing VALUES(10,4,2,999);
INSERT INTO supplier_pricing VALUES(11,7,3,549);
INSERT INTO supplier_pricing VALUES(12,7,4,529);
INSERT INTO supplier_pricing VALUES(13,6,2,105);
INSERT INTO supplier_pricing VALUES(14,6,1,99);
INSERT INTO supplier_pricing VALUES(15,2,5,2999);
INSERT INTO supplier_pricing VALUES(16,5,2,2999);

INSERT INTO orders VALUES (101,1500,"2021-10-06",2,1);
INSERT INTO orders VALUES(102,1000,"2021-10-12",3,5);
INSERT INTO orders VALUES(103,30000,"2021-09-16",5,2);
INSERT INTO orders VALUES(104,1500,"2021-10-05",1,1);
INSERT INTO orders VALUES(105,3000,"2021-08-16",4,3);
INSERT INTO orders VALUES(106,1450,"2021-08-18",1,9);
INSERT INTO orders VALUES(107,789,"2021-09-01",3,7);
INSERT INTO orders VALUES(108,780,"2021-09-07",5,6);
INSERT INTO orders VALUES(109,3000,"2021-09-10",5,3);
INSERT INTO orders VALUES(110,2500,"2021-09-10",2,4);
INSERT INTO orders VALUES(111,1000,"2021-09-15",4,5);
INSERT INTO orders VALUES(112,789,"2021-09-16",4,7);
INSERT INTO orders VALUES(113,31000,"2021-09-16",1,8);
INSERT INTO orders VALUES(114,1000,"2021-09-16",3,5);
INSERT INTO orders VALUES(115,3000,"2021-09-16",5,3);
INSERT INTO orders VALUES(116,99,"2021-09-17",2,14);

INSERT INTO Rating VALUES(1,101,4);
INSERT INTO Rating VALUES(2,102,3);
INSERT INTO Rating VALUES(3,103,1);
INSERT INTO Rating VALUES(4,104,2);
INSERT INTO Rating VALUES(5,105,4);
INSERT INTO Rating VALUES(6,106,3);
INSERT INTO Rating VALUES(7,107,4);
INSERT INTO Rating VALUES(8,108,4);
INSERT INTO Rating VALUES(9,109,3);
INSERT INTO Rating VALUES(10,110,5);
INSERT INTO Rating VALUES(11,111,3);
INSERT INTO Rating VALUES(12,112,4);
INSERT INTO Rating VALUES(13,113,2);
INSERT INTO Rating VALUES(14,114,1);
INSERT INTO Rating VALUES(15,115,1);
INSERT INTO Rating VALUES(16,116,0);

/*
3)Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.
*/
select count(t2.cus_gender) as NoOfCustomers, t2.cus_gender from
(select t1.cus_id, t1.cus_gender, t1.ord_amount, t1.cus_name from
(select orders.*, customer.cus_gender, customer.cus_name from orders inner join customer where orders.cus_id=customer.cus_id having
orders.ord_amount>=3000)
as t1 group by t1.cus_id) as t2 group by t2.cus_gender;

/*
4)	Display all the orders along with product name ordered by a customer having Customer_Id=2
*/
select product.pro_name, orders.* from orders, supplier_pricing, product
where orders.cus_id=2 and
orders.pricing_id=supplier_pricing.pricing_id and supplier_pricing.pro_id=product.pro_id;

/*
5)	Display the Supplier details who can supply more than one product.
*/
select suppliers.* from suppliers where suppliers.supp_id in
(select supp_id from supplier_pricing group by supp_id having
count(supp_id)>1)
group by suppliers.supp_id;

/*
6)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product
*/
select category.cat_id,category.cat_name, min(t3.min_price) as Min_Price from category inner join
(select product.cat_id, product.pro_name, t2.* from product inner join
(select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id)
as t2 where t2.pro_id = product.pro_id)
as t3 where t3.cat_id = category.cat_id group by t3.cat_id;

/*
7)	Display the Id and Name of the Product ordered after “2021-10-05”.
*/
select product.pro_id,product.pro_name from `order` inner join supplier_pricing on supplier_pricing.pricing_id=`order`.pricing_id inner join product
on product.pro_id=supplier_pricing.pro_id where `order`.ord_date>"2021-10-05";

/*
8)	Display customer name and gender whose names start or end with character 'A'.
*/
select customer.cus_name,customer.cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A';

/*
9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
*/
CREATE PROCEDURE proc2()
select report.supp_id,report.supp_name,report.Average,
CASE
WHEN report.Average =5 THEN 'Excellent Service'
WHEN report.Average >4 THEN 'Good Service'
WHEN report.Average >2 THEN 'Average Service'
ELSE 'Poor Service'
END AS Type_of_Service from
(select final.supp_id, suppliers.supp_name, final.Average from
(select test2.supp_id, sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
(select supplier_pricing.supp_id, test.ORD_ID, test.RAT_RATSTARS from supplier_pricing inner join
(select orders.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS from orders inner join rating on rating.ord_id = orders.ord_id ) as test
on test.pricing_id = supplier_pricing.pricing_id)
as test2 group by supplier_pricing.supp_id)
as final inner join suppliers where final.supp_id = suppliers.supp_id) as report;

call proc2();
