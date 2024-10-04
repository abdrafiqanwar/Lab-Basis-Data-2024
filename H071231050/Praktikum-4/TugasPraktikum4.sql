use classicmodels;

#NO 1 
select customerNumber, customerName , country from customers
where (country = "USA" and creditLimit between 50000 and 100000)
or (country != "USA" and creditLimit between 100000 and 200000)
order by creditLimit desc;

#NO 2
select productCode, productName, quantityInStock, buyPrice from products
where quantityInStock between 1000 and 2000 
and buyPrice not between 50 and 150 
and productName not like ("%Vintage%"); 

#NO 3 
select productCode, productName, MSRP from products
where productLine like ("%Classic%")
and buyPrice > 50;

#NO 4
select orderNumber, orderDate, status, customerNumber from orders
where (orderNumber > 10250)
and (status not in ("Shipped","Cancelled")) 
and (orderDate like "2004%" or "2005%");

# NO 5
select orderNumber , orderLineNumber, productCode, quantityOrdered, priceEach, priceEach * 0.95 as `discountedTotalPrice` from orderdetails
where quantityOrdered > 50 
and priceEach > 100 
and productCode not like "S18%"
order by quantityOrdered, priceEach, discountedTotalPrice;



