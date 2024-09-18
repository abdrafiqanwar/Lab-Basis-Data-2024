USE classicmodels;


#NO 1 
select productCode as 'Kode Produk', productName as 'Nama Produk' ,quantityInStock as 'Jumlah Stock' from products
where quantityInStock >= 5000 and quantityInStock <= 6000;

#NO 2 
select orderNumber as 'Nomor Pesanan' , orderDate as 'Tanggal Pesanan' , status, customerNumber as 'Nomor Pelanggan' from orders
where status != "shipped" 
order by customerNumber asc; 

#NO 3 
select employeeNumber as 'Nomor Karyawan' , firstName, lastName, email, jobTitle as 'Jabatan' from employees
where jobTitle = "Sales Rep"
order by firstName asc
limit 10;

#NO 4
select  productCode as 'Kode Produk' , productName as 'Nama Produk', productLine as 'Lini Produk', buyPrice as 'Harga Beli' from products
order by buyPrice desc
limit 10 offset 5;

#NO 5
select distinct country, city from customers
order by country,city;
