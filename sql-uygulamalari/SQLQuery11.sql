use magaza

-- en az bir satýþ yapmýþ çalýþanlarýn adlarýný getir.

SELECT first_name,last_name
from
employees
where employee_id
in
(SELECT distinct employee_id
from sales) 


--5000 den fazla maaþ alan çalýþanlarý listeleyin ama sadece satýþ yapmýþ olanlar arasýndan

Select first_name,last_name,salary
from
employees 
where
salary>5000
and employee_id
in

(SELECT distinct employee_id
from sales )


-- stokta bulunan ürünleri listele(inventory tablosuna göre)

SELECT product_name,price
from
products where
product_id 
in
(Select product_id
from inventory
where quantity>0)


-- toplam satýþýn 15000 üzerinde olan maðazalarýn þehirlerini listele


SELECT city
 from locations
 WHERE store_id
 in
 (SELECT distinct store_id
from stores
where total_sales>15000
)

-- sales depatrmanýnda çalýþan kiþileri getir

SELECT first_name,last_name
from employees
WHERE department_id
in
(SELECT department_id 
from departments
where department_name='Sales')



--2023 yýlý mayýs ayýnda satýþ yapmýþ çalýþanlarý listeleyiniz.

SELECT first_name,last_name
from 
employees
where
employee_id
in
(SELECT employee_id
from sales
where  
sale_date BETWEEN '2023-05-01' and '2023-05-31')


--sipariþi olan müþteriler
SELECT first_name,last_name
from 
customers
where customer_id
in
(SELECT customer_id
from orders
)

-- sipariþi 1000 tl den fazla olan müþterileri listele
SELECT first_name,last_name
from 
customers
where customer_id
in
(SELECT customer_id
from orders
where total_amount>=1000
)

--hiç satýþ yapmamýþ çalýþanlarý listele
SELECT first_name,last_name
from
employees
where employee_id
 not in
(SELECT employee_id
from sales
) 


--hiç stoðu kalmamýþ ürünleri listeleyin

SELECT product_name,product_id
from
products where
product_id 
  not in
(Select product_id
from inventory
where quantity>0)


--stok miktarý 10 dan az olan ürünleri listele
SELECT product_name,product_id
from
products where
product_id 
   in
(Select product_id
from inventory
where quantity<10)


--2 numaralý maðazanýn bulunduðu þehirleri getir

SELECT city
 from locations
 WHERE location_id
 in
 (SELECT location_id
from stores
where store_id=2
)


--2023 yýlý boyunca en çok bir sipariþ veren müþterileri listeleyin
SELECT first_name,last_name
from 
customers
where customer_id
in
(SELECT customer_id
from orders
where 
order_date between '2023-01-01' and '2023-12-31'
group by customer_id
HAVING count (order_id)<=1)





--en az 5 adet satýþý yapýlmýþ ürünleri listele

Select product_name
from products
where product_id
in
(Select product_id
from sales
where
quantity>=5)


--maaþý 5000 tl nin altýnda olan ama satýþ yapan çalýþanlrý getir

Select first_name,last_name,salary
from
employees 
where
salary<5000
and employee_id
in

(SELECT distinct employee_id
from sales )




--exists çalýþma mantýðý
/*
select 
from ana_tablo
where EXISTS (
select 1
from alt_tablo
where alt_tablo.kolon_adi=ana_tablo.kolon_Adi
)
*/


--EXISTS Kullanýmý
--satýþ yapmýþ çalýþanlarý listele

select first_name,last_name
from employees e
where Exists 
(SELECT 1
from sales s
WHERE s.employee_id=e.employee_id)


--en az bir ürünün stokta bulunduðu ürünleri listele

SELECT product_name
from products p
WHERE EXISTS

(SELECT 1
from
inventory i
where i.product_id=p.product_id
and i.quantity>0)


--2023 yýlýnda sipariþ vermiþ müþterileri exists kullanarak listeleyin

select c.first_name,c.last_name
from customers c
where exists
(SELECT 1
from orders o
where o.customer_id=c.customer_id
and o.order_date between '2023-01-01' and '2023-12-31')



--2023 yýlýnda en fazla satýþ yapan çalýþan bilgilerini getir

select first_name,last_name
from
employees
where employee_id=(

SELECT top 1 employee_id
from sales 
WHERE
sale_date between '2023-01-01' and '2023-12-31')
GROUP BY employee_id
order by sum(quantity) desc)


--maaþý kendi departmanýndaki ortalama maaþtan düþük olan çalýþanlarý listeleyiniz

select first_name,last_name
from employees e
where
salary <(
SELECT 
avg(salary)
from employees
where e.department_id=department_id)




use magaza
--hiç stoðu kalmamýþ ürünleri getiriniz

select product_name
from products
where product_id
not in
(select product_id
from inventory
where quantity>0)


--kendi maðazasýnýn ortalama satýþýndan düþük toplam
--satýþa sahip maðazalarýn þehir isimlerini listeyelim

select city
from locations
where location_id
in
(select store_id
from stores
where total_sales< (select avg(total_sales) from stores))



--2023 yýlýnda hiç satýþ yapmamýþ çalýþanlarý listeleyelim

select first_name,last_name
from employees
where employee_id
not in
(select employee_id
from sales
where sale_date between '2023-01-01' and '2023-12-31')


--2023  yýlýnda toplam satýþý 50 adetten fazla olan çalýþanlarý listele

select first_name,last_name
from employees
where employee_id
in
(select employee_id
from sales
where 
sale_date between '2023-01-01' and '2023-12-31'
group by employee_id
HAVING sum (quantity)>5)


--stoðu toplam 100 den az olan ürünleri listeleyelim

select product_name
from products p
where product_id
in
(select product_id
from inventory
group by product_id
having sum(quantity)<200)



--2.yol
select product_name
from products 
where exists
(select 1 
from inventory 
where products.product_id=inventory.product_id
group by product_id
having sum (quantity)<200)




