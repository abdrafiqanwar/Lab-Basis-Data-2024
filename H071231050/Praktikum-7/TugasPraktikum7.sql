use classicmodels;


## NO 1
select p.productCode, p.productName, p.buyPrice
from products p
where p.buyPrice > (select avg(buyPrice)
					from products);


##NO 2
select o.orderNumber, o.orderDate 
from orders o
join customers c
using(customerNumber)
where c.salesRepEmployeeNumber in (select employeeNumber
								   from employees
                                   join offices
                                   using(officeCode)
                                   where city = "Tokyo");

## NO 3
select c.customerName, o.orderNumber, o.shippedDate, o.requiredDate, group_concat(p.productName) products, sum(od.quantityOrdered)total_quantity_ordered , concat(e.firstName, " ", e.lastName) employeeName 
from customers c
join orders o
using(customerNumber)
join orderdetails od
using (orderNumber)
join products p
using(productCode)
join employees e
on c.salesRepEmployeeNumber = e.employeeNumber
where o.orderNumber in (select orderNumber from orders
						where requiredDate < shippedDate)
group by o.orderNumber;
                                                

## NO 4
select p.productName, p.productLine, sum(od.quantityOrdered) total_quantity_ordered
from products p
join orderdetails od
using (productCode)
where p.productLine in (select * from(select productLine
									  from products
                                      join orderdetails
                                      using(productCode)
                                      group by productLine
                                      order by sum(quantityOrdered) desc
                                      limit 3) top3)
group by p.productCode
order by  p.productLine,total_quantity_ordered desc;



#LIVE CODING
select concat(e.firstName, " ", e.lastName) `nama karyawan` , sum(p.amount) pendapatan, employeeNumber
from employees e
join customers c
on e.employeeNumber = c.salesRepEmployeeNumber
join payments p
using(customerNumber)
where e.employeeNumber in ((select c.salesRepEmployeeNumber
							from customers c
							join payments p
							using(customerNumber)
							join employees e
							on e.employeeNumber = c.salesRepEmployeeNumber
							group by c.salesRepEmployeeNumber
							order by sum(amount) desc
                            limit 1),
                            
                            (select c.salesRepEmployeeNumber
							from customers c
							join payments p
							using(customerNumber)
							join employees e
							on e.employeeNumber = c.salesRepEmployeeNumber
							group by c.salesRepEmployeeNumber
							order by sum(amount) asc
                            limit 1))
group by e.employeeNumber;


                                                      

