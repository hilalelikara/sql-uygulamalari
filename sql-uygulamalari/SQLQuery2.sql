use magaza


select first_name,last_name
from employees
where employee_id
in
(select employee_id
from sales)


select first_name,last_name
from employees
where  salary>5000 and employee_id 
in
(select employee_id
from sales)


select product_name
from products
where product_id
in
(select product_id
from inventory
where quantity>0)


select city
from locations
where store_id
in
(select store_id
from stores
where total_sales>15000)


select first_name,last_name
from employees
where employee_id
in
(select employee_id
from departments
where department_name='Sales')


select first_name,last_name
from employees
where employee_id
in
(select employee_id
from sales
where sale_date between '2023-05-01' and '2023-05-01')




select first_name,last_name
from customers
where customer_id
in
(select customer_id
from orders)