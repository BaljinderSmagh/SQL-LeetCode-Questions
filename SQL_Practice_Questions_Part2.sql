--Easy type
--Dropbox interview Questions--
--Q1:Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. 
   --Output just the difference in salaries.
   -- Given employee table ad department table.

--Query:
        SELECT (SELECT Max(salary)
                FROM   db_employee e
                INNER JOIN db_dept dep
                       ON e.department_id = dep.id
                WHERE  dep.department = 'marketing') - 
                (SELECT Max(salary)
                FROM   db_employee e
                INNER JOIN db_dept dep
                ON e.department_id = dep.id
                WHERE dep.department = 'engineering')
            AS Salary_difference; 


-- Microsoft Interview Question
--Q2:Finding Updated Records.We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. 
   --Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, and current salary. 
   --Order your list by employee ID in ascending order.

--Query:
        SELECT  id,
                first_name,
                last_name,
                department_id,
                Max(salary) AS Current_Salary
        FROM   ms_employee_salary
        GROUP  BY id,
                  first_name,
                  last_name,
                  department_id
        ORDER  BY id; 
-- Airbnb
-- Q3:Find the average number of bathrooms and bedrooms for each city’s property types. Output the result along with the city name and the property type.

-- Query:
        SELECT Avg(bathrooms) AS avg_bathrooms,
               Avg(bedrooms)  AS avg_bedrooms,
               property_type,
               city
        FROM   airbnb_search_details
        GROUP  BY city,property_type; 


-- Facebook
-- Q4:Popularity of Hack
--     Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. Luckily the user IDs of employees completing the surveys were stored.
--     Based on the above, find the average popularity of the Hack per office location.
--     Output the location along with the average popularity.

-- Query:
        SELECT Avg(popularity) AS Avg_popularity,
               location
        FROM   facebook_hack_survey AS survey,
               facebook_employees emp
        WHERE  survey.employee_id = emp.id
        GROUP  BY location;


-- Amazon
-- Q5:Customer Details
--     Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, and the city along with the order details.
--     Your output should be listing the customer's orders not necessarily listing the customers. 
--     This means that you may have duplicate rows in your results due to a customer ordering several of the same items. 
--     Sort records based on the customer's first name and the order details in ascending order.


-- Query:
        SELECT first_name,
               last_name,
               city,
               order_details
        FROM   customers cust
        LEFT JOIN orders ord
              ON cust.id = ord.cust_id
        ORDER  BY first_name,order_details;


-- Salesforce
-- Q6:Compare each employee's salary with the average salary of the corresponding department.
--    Output the department, first name, and salary of employees along with the average salary of that department.

-- Query:
       WITH cte AS 
                (SELECT Avg(e1.salary) AS Depart_Salary,
                        e1.department
                FROM   employee e1
                GROUP  BY e1.department)

        SELECT e2.department,
               e2.first_name,
               e2.salary,
               depart_salary
        FROM   employee e2,
               cte
        WHERE  cte.department = e2.department; 


-- Amazon
-- Q7:Total Cost Of Orders
--     Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.

-- Query:
        SELECT cust.id,
               first_name,
               Sum(total_order_cost)
        FROM   customers cust,
               orders ord
        WHERE  cust.id = ord.cust_id
        GROUP  BY cust.id,
                  first_name
        ORDER  BY first_name; 


-- leetCode
-- Q8: Rank Scores,Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. 
--       Note that after a tie, the next ranking number should be the next consecutive integer value. 
--       In other words, there should be no "holes" between ranks.

--Query:
        -- Dense rank-This function will assign rank to each row within a partition without gaps. Basically, 
        -- the ranks are assigned in a consecutive manner i.e if there is a tie between values then they will be assigned the same rank, 
        -- and next rank value will be one greater then the previous rank assigned.
        SELECT score,Dense_rank() OVER( ORDER BY score DESC ) 
        AS 'Rank'
        FROM   scores; 



-- leetcode
-- Q9:A company's executives are interested in seeing who earns the most money in each of the company's departments. 
-- A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

-- Write an SQL query to find the employees who are high earners in each of the departments.

-- Query:

        WITH combo
            AS (SELECT dep.NAME AS Department,
                       emp.NAME AS Employee,
                       salary,
                       departmentid
                FROM   employee emp,
                       department dep
                WHERE  emp.departmentid = dep.id),
        new_cte
            AS (SELECT department,
                       employee,
                       salary,
                       Dense_rank() OVER ( partition BY department
                                           ORDER BY salary DESC) AS 'Salary_rank'
                FROM   combo)
        SELECT department,
               employee,
               salary
        FROM   new_cte
        WHERE  salary_rank <= 3
        ORDER  BY department; 

-- leetCode
-- Q10:Write a SQL query to get the nth highest salary from the Employee table.

-- Query:
        CREATE FUNCTION getnthhighestsalary(n int) returns int
        BEGIN
          RETURN ( WITH employeecte AS
               (
                SELECT DISTINCT salary,
                                  dense_rank() OVER(ORDER BY salary DESC) AS 'salary_rank'
                FROM employee)
                SELECT salary
                FROM   employeecte
                WHERE  salary_rank=n );
        end


-- Q11.Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

-- Query:
        SELECT id,
               account_id,
               total_amt_usd
        FROM   orders
        ORDER  BY total_amt_usd
        LIMIT  20; 

-- Google
-- Q12:Find the total AdWords earnings for each business type. Output the business types along with the total earnings.

-- Query:
    SELECT business_type,
       Sum(adwords_earnings) AS total_earnings
    FROM   google_adwords_earnings
    GROUP  BY business_type; 

-- Q13:From the following tables write a SQL query to find the salesperson and customer who belongs to same city. Return Salesman, cust_name and city.

-- Query:
        SELECT sales.NAME AS 'Salesman',
             cust_name,
             sales.city
        FROM   salesman sales,
             customer cust
        WHERE  sales.city = cust.city; 

-- Q14:From the following tables write a SQL query to find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.

-- Query:
        SELECT ord_no,
             purch_amt,
             cust_name,
             city
        FROM   orders ord,
               customer cust
        WHERE  ord. customer_id = cust. customer_id
               AND purch_amt BETWEEN 500 AND 2000; 


-- Q15:write a SQL query to find the salesperson(s) and the customer(s) he handle. Return Customer Name, city, Salesman, commission.

-- Query:
        SELECT cust_name  AS Customer,
               cust.city,
               sales.NAME AS Salesman,
               commission
        FROM   customer cust,
               salesman sales
        WHERE  cust.salesman_id = sales.salesman_id;
      

-- Q16:write a SQL query to find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission.

-- Query:
        SELECT cust_name  AS Customer,
               cust.city,
               sales.NAME AS Salesman,
               commission
        FROM   customer cust,
               salesman sales
        WHERE  cust.salesman_id = sales.salesman_id
               AND commission > 0.12; 


-- Q17:write a SQL query to find those salespersons do not live in the same city where their customers live 
-- and received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, salesman city, commission. 

-- Query:
        SELECT cust_name  AS Customer,
               cust.city  AS customer_city,
               sales.NAME AS Salesman,
               sales.city AS salesman_city,
               commission
        FROM   customer cust,
               salesman sales
        WHERE  cust.salesman_id = sales.salesman_id
               AND commission > 0.12
               AND sales.city <> cust.city; 


-- Q18:write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.

-- Query:
        SELECT ord.ord_no,
               ord.ord_date,
               ord.purch_amt,
               cust.cust_name AS Customer_name,
               cust.grade,
               sales.NAME     AS Salesman,
               sales.commission
        FROM   orders ord
               INNER JOIN customer cust
               ON ord.customer_id = cust. customer_id
               INNER JOIN salesman sales
               ON sales.salesman_id = cust.salesman_id; 

-- Q19: Write a SQL statement to make a join on the tables salesman, customer 
-- and orders in such a form that the same column of each table will appear once and only the relational rows will come.

-- The SQL NATURAL JOIN is a type of EQUI JOIN and is structured in such a way that, columns with the same name of associated tables will appear once only.

-- Query:
        SELECT *
        FROM   orders
               natural JOIN customer
               natural JOIN salesman; 

-- Q20:write a SQL query to display the cust_name, customer city, grade, Salesman, salesman city. The result should be ordered by ascending on customer_id. 

-- Query:
        SELECT cust_name,
               cust.city  AS Customer_city,
               cust.grade,
               sales.NAME AS Salesman,
               sales.city AS Salesman_city
        FROM   customer cust,
               salesman sales
        WHERE  cust.salesman_id = sales.salesman_id
        ORDER  BY cust.customer_id; 