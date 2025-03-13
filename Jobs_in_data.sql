create database db;

use db;

SHOW DATABASES;

show tables;

create table customers (
    work_year date,
    job_title VARCHAR(150),
    job_category VARCHAR(150),
    salary_currency VARCHAR(100),
    salary INT,
    salary_in_usd INT,
    employee_residence VARCHAR(100),
    experience_level VARCHAR(100),
    employment_type VARCHAR(100),
    work_setting VARCHAR(100),
    company_location VARCHAR(100),
    company_size VARCHAR(100)
);
ALTER TABLE customers MODIFY COLUMN work_year INT; 

SELECT * from customers limit 10;

-- Ques 1 write a query to find the top 3 highest paying jobs for each category
with ranked_salary as (select job_category, job_title, sum(salary_in_usd) as total_salary
, dense_rank() over (partition by job_category order by sum(salary_in_usd) desc) as ranks
from customers 
group by 1, 2
order by total_salary desc)

select job_category, job_title, total_salary
from ranked_salary
where ranks <= 3
order by job_category, total_salary desc;

-- Ques 2 Which job category has the highest demand?
with job_count as (Select job_category, count(job_title) as total_jobs 
from customers
group by 1 
)
select job_category, total_jobs,
round(total_jobs / (select sum(total_jobs) from job_count) *100.00, 2) as perc
from job_count
order by total_jobs desc;

-- Ques 3 What is the Average, MIN and MAX salaries for Data Scientist Roles?
select job_title, avg(salary_in_usd), min(salary_in_usd) as Min_Sal, max(salary_in_usd) as Max_Sal
from customers
where job_title = "Data Scientist"
group by 1;

-- Ques 4 How has the Average Salary in Data Science varied during the years?
with cte as (select work_year, count(job_title) as number_of_jobs
, count(job_title) - lag(count(job_title)) over(order by work_year) as job_YOY
, round(Avg(salary_in_usd),2) as avg_salary
, round(Avg(salary_in_usd) - lag(Avg(salary_in_usd)) over(order by work_year),2) as Avg_YOY
from customers 
where job_title = "Data Scientist"
group by 1
order by work_year)
select work_year, avg_salary
, round(((avg_salary / lag(avg_salary) over(order by work_year)) - 1) * 100.00,2) as AVG_YOY
from cte;

-- Ques 5 Are there particular job categories that dominate in certain company sizes?
with jobs as (Select company_size, job_category, count(job_title) as job_count
from customers 
group by 1, 2)

select company_size, job_category, round(job_count / (select sum(job_count) from jobs) * 100.00 ,2)as perc
from jobs
order by company_size, perc desc;

-- Ques 6 Do Bigger Companies tend to hire more Data Scientists?
select company_size, count(job_title) as job_count
from customers 
group by 1 
order by job_count desc;

-- What is the distribution of employment types among data science roles?
select employment_type, count(job_category)
from customers
where job_title = 'Data Scientist'
group by 1;





