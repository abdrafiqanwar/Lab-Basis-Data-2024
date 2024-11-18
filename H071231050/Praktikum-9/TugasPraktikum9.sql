create database FootballManagement;

use FootballManagement;


## NO 1
create table klub (
	id int auto_increment primary key,
    nama_klub varchar(50) not null,
    kota_asal varchar(20) not null
);

create table pemain (
	id int auto_increment primary key,
    nama_pemain varchar(50) not null,
    posisi varchar(20) not null,
    id_klub int,
    foreign key(id_klub) references klub(id) 
);

create table pertandingan (
	id int auto_increment primary key,
    id_klub_tuan_rumah int,
    id_klub_tamu int,
    tanggal_pertandingan DATE,
    skor_tuan_rumah int default 0,
    skor_tamu int default 0,
    foreign key(id_klub_tuan_rumah) references pemain(id_klub),
    foreign key(id_klub_tamu) references klub(id)
);

create index info_posisi on pemain(posisi);
create index info_kota_asal on klub(kota_asal);

desc klub;
desc pemain;


## NO 2
use classicmodels;

select c.customerName, c.country, round(sum(amount),2) `TotalPayment`, count(orderNumber) orderCount, max(p.paymentDate) LastPaymentDate,
case
	when sum(amount) > 100000 then 'VIP'
    when sum(amount) between 5000 and 100000 then 'Loyal'
    when sum(amount) < 5000 or amount is null then 'New'
    end as Status
from customers c
left join payments p
using(customerNumber)
left join orders o
using(customerNumber)
group by c.customerNumber
order by customerName asc;


## NO 3
select customerNumber, customerName, sum(quantityOrdered) `total_quantity`,
case
	when sum(quantityOrdered) > (select avg(quantityOrdered) from orderdetails) then "Di Atas Rata-Rata"
    else "Di Bawah Rata-Rata"
    end as kategori_pembelian
from customers c
join orders o
using(customerNumber)
join orderdetails od
using(orderNumber)
group by customerNumber
order by total_quantity desc;