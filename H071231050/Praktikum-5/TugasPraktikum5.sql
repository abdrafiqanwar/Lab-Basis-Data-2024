use classicmodels;

# NO 1
select DISTINCT c.customerName `namaKustomer`, p.productName `namaProduk`, pl.textDescription
from customers c
join orders o
on c.customerNumber = o.customerNumber
join orderDetails od
on o.orderNumber =  od.orderNumber
join products p
on od.productCode = p.productCode
join productlines pl
on p.productLine = pl.productLine
where p.productName like ("%Titanic%")
order by c.customerName asc;


# NO 2
select 
	customerName, 
	productName, 
	status, 
	shippedDate 
from customers c
join orders o
on c.customerNumber = o.customerNumber
join orderDetails od
on o.orderNumber =  od.orderNumber
join products p
on od.productCode = p.productCode
where p.productName like ("%ferrari%")
and o.status = "Shipped"
and o.shippedDate between "2003-10-01" and "2004-10-01"
order by o.shippedDate desc;


# NO 3
select * from employees;

select e.firstName as Supervisor, r.firstName as Karyawan
from employees e
join employees r
on e.employeeNumber = r.reportsTo
where e.firstName = "Gerard"
order by r.firstName asc;

# NO 4
#  A
select 
	customerName, 
	paymentDate, 
	firstName employeeName, 
	amount
from customers c
join payments p 
on c.customerNumber = p.customerNumber
join employees e
on c.salesRepEmployeeNumber = e.employeeNumber
where paymentDate like ("%-11-%");

# B 
select 
	customerName, 
	paymentDate, 
	firstName employeeName, 
	amount
from customers c
join payments p 
on c.customerNumber = p.customerNumber
join employees e
on c.salesRepEmployeeNumber = e.employeeNumber 
where paymentDate like ("%-11-%")
order by amount desc
limit 1;


# C 
select 
	c.customerName, 
    p.productName
from customers c
join orders o
on c.customerNumber = o.customerNumber
join orderDetails od
on o.orderNumber =  od.orderNumber
join products p
on od.productCode = p.productCode
join payments pa 
on c.customerNumber = pa.customerNumber
where customerName = "Corporate Gift Ideas Co." 
and paymentDate like ("%-11-%");



#LIVE CODING
select 
	c.customerName, 
    p.productName,
    pa.amount
from customers c
join orders o
on c.customerNumber = o.customerNumber
join orderDetails od
on o.orderNumber =  od.orderNumber
join products p
on od.productCode = p.productCode
join payments pa 
on c.customerNumber = pa.customerNumber 
where pa.amount >= 50000;






