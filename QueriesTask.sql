/*SQL Queries for JYA Car Hire CA Project Databases
Authors: 
	Joshua Cassidy
	Yotsaphon Sutweha
    Andrew Roux
*/

/*Query for rentals with specified date or interval*/
SELECT  r.rent_id, r.start_date, r.end_date, 
		cust.cust_id, CONCAT(cust.f_name," ",cust.l_name) AS 'Customer Name',
		c.car_id, c.reg_num,
        m.model_name, 
        cl.class_price, cl.class_deposit, 
        cl.class_price*datediff(r.end_date, r.start_date) AS 'Total Due' 
FROM   ((((rentalcontract AS r
INNER JOIN customer AS cust ON r.cust_id = cust.cust_id)
INNER JOIN car AS C ON r.car_id = c.car_id)
INNER JOIN car_model AS m ON m.model_id = c.model_id)     
INNER JOIN rental_class AS cl ON cl.class_id = c.class_id)		
WHERE r.start_date BETWEEN '2015-12-31' AND '2016-02-01';

/*Query for Rentals with payments and other details for a certain period*/
SELECT  p.pay_id, p.pay_date, 
		r.rent_id, r.start_date, r.end_date, 
		cust.cust_id, CONCAT(cust.f_name," ",cust.l_name) AS 'Customer Name',
		c.car_id, c.reg_num,
        m.model_name, 
        cl.class_price, 
        cl.class_price*datediff(r.end_date, r.start_date) AS 'Total Due'
FROM   (((((payment AS p
INNER JOIN rentalcontract AS r ON p.rent_id = r.rent_id)
INNER JOIN customer AS cust ON r.cust_id = cust.cust_id)
INNER JOIN car AS C ON r.car_id = c.car_id)
INNER JOIN car_model AS m ON m.model_id = c.model_id)     
INNER JOIN rental_class AS cl ON cl.class_id = c.class_id)		
WHERE r.start_date BETWEEN '2015-12-31' AND '2016-01-11';

/*Query for revenue for the period*/
SELECT  SUM(cl.class_price*datediff(r.end_date, r.start_date)) AS 'Total Revenue'
FROM   (((rentalcontract AS r
INNER JOIN payment AS p ON r.rent_id = p.rent_id)
INNER JOIN car AS c ON 	r.car_id = c.car_id)
INNER JOIN rental_class AS cl ON c.class_id = cl.class_id)	
WHERE p.pay_date BETWEEN '2015-01-01' AND '2015-04-01';

/*Query for cars, car models and rental classes*/
SELECT  c.reg_num, c.year_prod, 
		m.fuel_type, m.num_seats,
		m.model_name,
        cl.class_name, cl.class_price
FROM 	((car as c
INNER JOIN	car_model as m ON c.model_id = m.model_id)
INNER JOIN rental_class as cl ON cl.class_id = c.class_id);

/*Query for Car Services with service type, garage, cost and car involved with the cost date for period*/
SELECT  s.carserv_id, s.serv_type, s.serv_date,
		g.gar_name,
        c.car_id, c.reg_num, cm.model_name,
        s.serv_cost
FROM carservice AS s
INNER JOIN garage AS g ON s.gar_id = g.gar_id
INNER JOIN car AS c ON s.car_id = c.car_id
INNER JOIN car_model AS cm ON c.model_id = cm.model_id
WHERE s.serv_date BETWEEN '2015-01-01' AND '2015-04-01';

/*Query for Service Expenditure for the given period*/

SELECT SUM(serv_cost) AS 'Total Expenditure' 
FROM carservice 
WHERE serv_date BETWEEN '2015-01-01' AND '2015-04-01';

/*Query for sum of staff salary for the given period*/
SELECT SUM(staff_salary*(datediff('2015-04-01', '2015-01-01')/365)) AS 'Qaurterly Salary Paid'
FROM staff;


/*Query for cars purchased from supplier number 1*/
SELECT  cp.car_id, m.model_name, c.reg_num,
	    s.sup_name, s.sup_city,
        cp.purch_date, cp.purch_price
FROM (((carpurch AS cp
INNER JOIN supplier AS s ON s.sup_id=cp.sup_id)
INNER JOIN car AS c ON cp.car_id = c.car_id)
INNER JOIN car_model AS m ON m.model_id = c.model_id)
WHERE s.sup_id = 1;


/*Testing Queries*/
/*Test Population
SELECT *
FROM customer;
SELECT *
FROM staff;
SELECT *
FROM car;
SELECT *
FROM rentalcontract;
SELECT COUNT(*)
FROM customer;

SELECT rent_id, start_date, end_date, car_id,
	   DATEDIFF(end_date, start_date) AS 'Duration'
FROM rentalcontract
WHERE rent_id BETWEEN 1 AND 5;

SELECT *
FROM payment;

SELECT *
FROM carservice; 
/*Testing price assignment*/
/*SELECT *
FROM carpurch
WHERE purch_date BETWEEN '2012-01-03' AND '2012-01-29';

SELECT MAX(serv_date)
FROM carservice;
        
SELECT MIN(staff_salary)
FROM staff
WHERE staff_position LIKE '%Manager%';
*/

