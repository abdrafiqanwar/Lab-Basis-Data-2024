use classicmodels;

#NO 1
select c.customerName,concat(e.firstName, " ", e.lastName) as salesRep, c.creditLimit - sum(p.amount) as `remainingCredit` 
from customers c
join employees e
on c.salesRepEmployeeNumber = e.employeeNumber
join payments p
using(customerNumber)
group by c.customerName
having `remainingCredit` > 0;


#NO 2
select p.productName `Nama Produk`, group_concat(distinct c.customerName) `Nama Customer`, count(distinct c.customerName) `Jumlah Customer`, sum(od.quantityOrdered) `Total Quantitas` 
from products p
join orderdetails od 
using(productCode)
join orders o
using(orderNumber)
join customers c
using(customerNumber)
group by p.productName;

#NO 3
select concat(firstName, " ", lastName) `employeeName`, count(customerName) `totalCustomers`
from employees e
join customers c
on e.employeeNumber = c.salesRepEmployeeNumber
group by `employeeName`
order by `totalCustomers` desc;


#NO 4 
select concat(e.firstName, " ", e.lastName) `Nama Karyawan`, p.productName `Nama Produk`, sum(od.quantityOrdered) `Jumlah Pesanan`
from products p 
join orderdetails od
on p.productCode = od.productCode
join orders o
on od.orderNumber = o.orderNumber
join customers c
on o.customerNumber = c.customerNumber
right join employees e
on c.salesRepEmployeeNumber = e.employeeNumber
join offices ofc
on e.officeCode = ofc.officeCode
where e.officeCode = 6
group by e.employeeNumber , p.productCode
order by sum(od.quantityOrdered) desc;

#NO 5
select c.customerName  `Nama Pelanggan`, group_concat(p.productName) `Nama Prooduk`, count(p.productCode) `Banyak Jenis Produk`, o.status
from customers  c
join orders o
using(customerNumber)
join orderdetails od
using(orderNumber)
join products p
using (productCode)
where o.shippedDate is null
group by c.customerName;


# select * from orders;


#tampilkan nama customer beserta dengan jumlah pembayarannya tiap tahum 
select c.customerName, p.paymentDate, sum(p.amount)
from customers c
join payments p
using(customerNumber)
group by c.customerNumber, year(p.paymentDate);
 