create database Sale_store;
use Sale_store;
show databases;
select*from dim_customer;
select*from dim_date;

-- modifying the dataset
-- to change the datatype text to date

Alter table dim_date
modify column Date date;

-- to check the datatype
desc dim_date;

update sales_store_updated
set gender = 'Male'
where trim(upper(gender)) In('M','Male');

update sales_store_updated
set gender = 'Famale'
where trim(upper(gender))In('F','Female');

select*from sales_store_updated;

-- change the datatype
UPDATE sales_store_updated
SET purchase_date = STR_TO_DATE(purchase_date, '%d/%m/%Y');

ALTER TABLE sales_store_updated
MODIFY purchase_date DATE;

select*from sales_store_updated;

-- to change the datatype of time_of_purchase column text to time 

Alter table sales_store_updated
modify time_of_purchase time;

select*from sales_store_updated;

desc sales_store_updated;

-- change the column name 
Alter table sales_store_updated
Rename column prce to price;

select*from sales_store_updated;

-- 1. Data Cleanig
-- To check for Duplicates
select transaction_id,count(*) as repited_Transaction_id from sales_store_updated
group by transaction_id 
having count(transaction_id)>1;


-- Another way to find the duplicate
-- find the duplicates 
with CTE as(
select*,
row_number() over (partition by transaction_id order by transaction_id) as Row_num
from sales_store_updated
)
-- remove duplicates 
delete from sales_store_updated
where transaction_id IN(select transaction_id from CTE
where Row_num >1) ;

select*from sales_store_updated;

-- 2. Correct heder
Alter table sales_store_updated
Rename column prce to price;


Alter table sales_store_updated
Rename column quantiy to quantity;

-- 3.To check the datatype
desc sales_store_updated;

-- 4. to check the Null value
select count(*) as null_count 
from sales_store_updated
where transaction_id is null;

