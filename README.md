# Jobs_in_data

## Goal
The goal of this project was to provide insights into the current data science job market, discovering the factors that influence salaries and job opportunities in the field of data.

## Targeted Audience
The goal of this project to target the job seekers to get some usefull insights particularly in the Data Science and Research category.

## Process
This project was created in MySQLWorkbench. The file containing the Dataset is a .csv, which I then added to a database.
Before digging into the data, these were the clean processes i did:
- **Understanding the dataset**
    We are working with a dataset from [`Kaggle`](https://www.kaggle.com/datasets/hummaamqaasim/jobs-in-data/data) that has information on Data Science Salaries and Jobs with the following columns:
    
    **work_year**: The year in which the data was recorded.
    **job_title**: The specific title of the job role, like 'Data Scientist', 'Data Engineer', or 'Data Analyst'.
    **job_category**: A classification of the job role into broader categories like ‘Data Analysis’, ‘Data Engineering’
    **salary_currency**: The currency in which the salary is paid, such as USD, EUR, etc.
    **salary**: The annual gross salary of the role in the local currency.    
    **salary_in_usd**: The annual gross salary converted to United States Dollars (USD).    
    **employee_residence**: The country of residence of the employee.   
    **experience_level**: Classifies the professional experience level of the employee. Common categories might include 'Entry-level', 'Mid-level', 'Senior', and 'Executive'.    
    **employment_type**: Specifies the type of employment, such as 'Full-time', 'Part-time', 'Contract'.    
    **work_setting**: The work setting or environment, like 'Remote', 'In-person', or 'Hybrid'.    
    **company_location**: The country where the company is located.   
    **company_size**: The size of the employer company, often categorized into small (S), medium (M), and large (L) sizes.
    
- **What is the size of the dataset?**
- **What are the potential issues and how I dealt with them?**
    - **Same numbers, different format**   
        Since we have `salary_currency` , `salary` and `salary_in_usd`, we will only use `salary_in_usd` because it’s an effective way to analyze the data and compare salaries.
        
- **Checking data in Work_year** 
    ```
    SELECT
    	work_year,
    	COUNT(*) as number_of_records,
    	SUM(COUNT(*)) OVER(ORDER BY work_year ASC) as running_total
    FROM jobs_in_data
    GROUP BY work_year
    ORDER BY work_year ASC
    
    ```
    
    We have substantially more records in 2023 than in 2020, but we’ll use all of them.
    
- **Checking for Missing Values deal**
    
    
    ```
    SELECT
    	COUNT(*) as Null_values
    FROM jobs_in_data
    WHERE salary_in_usd IS NULL
    OR employee_residence IS NULL
    OR company_location IS NULL
    OR work_setting IS NULL;
    ```
    There are 0 null values in Key categories
    
- **Checking for inconsistencies and outliers**
    
    I want to ensure that the data I work with is relevant for analysis. To achieve this, I must check for job titles with at least ten entries. Such entries could skew the data during the exploratory data analysis (EDA), such as when calculating averages. By identifying and excluding such possible outliers, we can obtain more accurate insights from the data.
    
    ```
    SELECT
    	company_location,
    	employee_residence
    FROM jobs_in_data
    GROUP BY company_location, employee_residence
    HAVING COUNT(company_location) >= 10 AND COUNT(employee_residence) >= 10
    
    ```
    We can see that there are 13 Countries where both company_location and employee_residence results are ≥= 10
    
- **Setting up the final dataset**
    
    To work with my data:
    
    - DROPPED `salary_currency` and `salary`;
    - Altered `salary_in_usd` to `salary`;
    - Created `CTE` to filter the dataset;
 
# Analysis

I divided my analysis in results to a variety of questions. Feel free to check the ones you want to see:

- Which job category has the highest demand? 
- What is the Average, MIN and MAX salaries for Data Scientist Roles?
- How has the Average Salary in Data Science varied during the years?   
- What is the distribution of employment types among data science roles?   
- Do Bigger Companies tend to hire more Data Scientists?
- Are there particular job categories that dominate in certain company sizes?   
- What is the distribution of salaries for different experience levels?
- Which job category has the highest average salary?
- What is the most common experience level among data science professionals?
- In which location do Data Analysts receive the highest average salary?

    Review the SQL File for Queries and deep understanding

  # Conclusion
  
