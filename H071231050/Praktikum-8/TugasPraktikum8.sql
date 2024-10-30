use classicmodels;


## NO 1
(select p.productName, sum(od.priceEach * od.quantityOrdered) `TotalRevenue`, 'Pendapatan Tinggi' Pendapatan
	from products p
	join orderdetails od
	using(productCode)
	join orders o
	using(orderNumber)
where Month(o.orderDate) = 9
group by p.productCode
order by TotalRevenue desc
limit 5)
union
(select p.productName, sum(od.priceEach * od.quantityOrdered) `TotalRevenue`, 'Pendapatan Rendah' Pendapatan
	from products p
	join orderdetails od
	using(productCode)
	join orders o
	using(orderNumber)
where Month(o.orderDate) = 9
group by p.productCode
order by TotalRevenue asc
limit 5)
order by TotalRevenue desc;


## NO 2
select productName
from products
where productCode not in (Select od.productCode
						  from orderdetails od
                          join orders o
                          using(orderNumber)
						  where o.customerNumber in (select o.customerNumber
													 from orders o
													 group by o.customerNumber
								 					 having count(orderNumber) > 10
								  					 intersect
													 select o.customerNumber
													 from orders o
													 join orderdetails od
													 using(orderNumber)
													 where od.productCode in (select productCode from orderdetails
																		      where priceEach > (select avg(priceEach) from orderdetails)
													 )));


## NO 3
select c.customerName
from customers c
join payments p
using(customerNumber)
where customerNumber in (select o.customerNumber
						 from orders o
                         join orderdetails od
                         using(orderNumber) 
                         join products p
                         using(productCode)
                         where productLine = "Planes"
                         group by o.customerNumber, p.productLine
                         having sum(quantityOrdered * priceEach) > 20000
                         intersect
                         select o.customerNumber
						 from orders o
                         join orderdetails od
                         using(orderNumber) 
                         join products p
                         using(productCode)
                         where productLine = "Trains"
                         group by o.customerNumber, p.productLine
                         having sum(quantityOrdered * priceEach) > 20000)
group by customerNumber
having sum(amount) > (select avg(amount) * 2 from payments);

## NO 4
select Tanggal, customerNumber , group_concat(DISTINCT Riwayat1 separator " Dan ") Riwayat
from (  select o.orderDate `Tanggal`, c.customerNumber, "Memesan Barang" Riwayat1
		from orders o
		join customers c
		using(customerNumber)
		where o.orderDate like ("2003-09-%")
        union
		select p.paymentDate `Tanggal`, c.customerNumber, "Membayar Pesanan" Riwayat1
		from payments p
		join customers c
		using(customerNumber)
		where p.paymentDate like ("2003-09-%")
        order by customerNumber) s
group by Tanggal;

## NO 5
select p.productCode
	from products p
	join orderdetails od
	using(productCode)
	join orders o
	using(orderNumber)
	join customers c
	using(customerNumber)
where od.quantityOrdered > 48
and left(productVendor, 1) in ("A", "I", "U", "E", "O") 
and od.priceEach > (select avg(od.priceEach) 
						from products p
						join orderdetails od
						using(productCode)
						join orders o
						using(orderNumber)
						where orderDate between "2001-01-01" and "2004-03-31")
group by p.productCode
except
select p.productCode
	from products p
	join orderdetails od
	using(productCode)
	join orders o
	using(orderNumber)
	join customers c
	using(customerNumber)
where c.country in ("Italy", "Japan", "Germany");



