---LEETCODE____

--Q1 : Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of those people:

--Query: 
    Select FirstName, 
           LastName,
           City, 
           State 
    from Person p left join Address a 
    on p.PersonId=a.PersonId;


--Q2 : Write a SQL query to get the second highest salary from the Employee table.

--Query: 
    SELECT Max(salary) AS SecondHighestSalary
    FROM   employee
    WHERE  salary <> (SELECT Max(salary)
                    FROM   employee) ;



--Q3 : Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

--Query: 
       SELECT NAME AS Employee
        FROM   (SELECT e.NAME   AS NAME,
               e.salary AS emp_sal,
               m.salary AS man_sal
               FROM   employee e,
               employee m
               WHERE  m.id = e.managerid) AS temp
        WHERE  emp_sal > man_sal; 



--Q4 : Write a SQL query to find all duplicate emails in a table named Person.


--Query: 
        SELECT email
        FROM   person
        GROUP  BY email
        HAVING Count(email) > 1; 


--Q5: Suppose that a website contains two tables, the Customers table and the   Orders table. Write a SQL query to find all customers who never order anything.

--Query: 
        SELECT NAME AS Customers
        FROM   customers
        WHERE  id NOT IN(SELECT customerid
                         FROM   orders); 

--Q6: Write a SQL solution to output big countries' name, population and area. A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.

--Query:
        SELECT NAME,
               population,
               area
        FROM   world
        WHERE  area > 3000000
               OR population > 25000000;

--Q7. Classes More Than 5 Students.

--Query:
        SELECT class
        FROM   courses
        GROUP  BY class
        HAVING Count(DISTINCT student ) >= 5;

--Q8. Not Boring Movies,Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring".
        --Return the result table in descending order by rating. 

--Query:
        SELECT id,
               movie,
               description,
               rating
        FROM   cinema
        WHERE  id%2 !=0
               AND description !='boring'
        ORDER  BY rating DESC; 



--Q9. Swap Salary,Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temp table(s).

--Query:
        UPDATE salary
               SET    sex = CASE sex
                            WHEN 'm' THEN 'f'
                            ELSE 'm'
                            END; 
--Q10. Delete Duplicate Emails

--Query:
        DELETE p FROM Person p,
                      Person p2
                 WHERE
                      p.Email = p2.Email AND p.Id > p2.Id;

--Q11. Rising Temperature,Write an SQL query to find all dates' id with higher temperature compared to its previous dates (yesterday).

--Query:
        SELECT w.id as id
        FROM   Weather w,
               Weather w1
        WHERE  DATEDIFF(w.recorddate , w1.recorddate)=1 
               and  w.temperature>w1.temperature;



--Q12. Department Highest Salary,Write a SQL query to find employees who have the highest salary in each of the departments. 


--Query:
        SELECT d.NAME   AS Department,
               e.NAME   AS Employee,
               e.salary AS Salary
        FROM   employee e
               INNER JOIN department d
               ON e.departmentid = d.id
        WHERE  ( e.salary, e.departmentid ) IN (SELECT Max(salary),
                                                       departmentid
                                               FROM   employee
                                               GROUP  BY departmentid);


---HACKERANK-----

--Q13: Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

--Query:
        SELECT Sum(c1.population)
        FROM   city c1
               INNER JOIN country c2
                        ON c1.countrycode = c2.code
        WHERE  c2.continent = 'Asia'; 

--Q14: Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

--Query:
        SELECT c1.Name
        FROM   city c1
               INNER JOIN country c2
                        ON c1.countrycode = c2.code
        WHERE  c2.continent = 'Africa'; 


--Q15: Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

--Query: 
        SELECT c2.continent,
               Floor(Avg(c1.population))
        FROM   city c1
               INNER JOIN country c2
               ON c1.countrycode = c2.code
        GROUP  BY c2.continent; 


--Q16:P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
            -- * 
            -- * * 
            -- * * * 
            -- * * * * 
            -- * * * * *
            -- Write a query to print the pattern P(20).

--Query: 
        SET @NUMBER = 0;
        SELECT REPEAT('* ', @NUMBER := @NUMBER+1)
        FROM information_schema.tables LIMIT 20;


--Q17:You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
        -- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
        -- Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- 
        -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
        -- Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
        -- If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.


--Query: 
        SELECT  CASE
                WHEN grade>=8 THEN NAME
                             ELSE 'NULL' 
                             END,
                grade,
                marks
        FROM    (SELECT s.NAME  AS 'NAME', 
                         s.marks AS 'marks',
                         g.grade AS 'grade'
                FROM   students s,
                        grades g
                WHERE  s.marks BETWEEN g.min_mark AND  g.max_mark) 
                       AS tempdate
        ORDER BY grade desc, 
                (CASE WHEN grade>=8 THEN NAME
                ELSE marks
                END)



-- Q18:Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
        -- Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
        -- If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.


--Query: 
        SELECT tempdata.hacker_id,
               tempdata.NAME
        FROM   (SELECT h.hacker_id,
                       h.NAME,
                       Count(s.challenge_id)
                FROM   hackers h
                INNER JOIN submissions s
                       ON h.hacker_id = s.hacker_id
                INNER JOIN challenges c
                       ON c.challenge_id = s.challenge_id
                INNER JOIN difficulty d
                       ON d.difficulty_level = c.difficulty_level
                WHERE  s.score = d.score
                GROUP  BY h.hacker_id,h.NAME
                HAVING Count(s.challenge_id) > 1
                ORDER  BY Count(s.challenge_id) DESC,
                                          h.hacker_id) 
                AS tempdata 

--Q19:Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). 
    --For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
    --Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order


--Query:
        SELECT Concat(NAME, '(', Substring(occupation, 1, 1), ')')
        FROM   occupations
        ORDER  BY NAME; 

        SELECT Concat('There are a total of ', Count(occupation), ' ', Lower(occupation), 's.')
        FROM   occupations
        GROUP  BY occupation
        ORDER  BY Count(occupation),
                  occupation; 

--Q20:You are given a table, BST, containing two columns: 
     --N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

    --Root: If node is root node.
    --Leaf: If node is leaf node.
    --Inner: If node is neither root nor leaf node.


--Query:
        SELECT CASE
                WHEN p IS NULL THEN Concat(n, ' ', 'Root')
                WHEN p IS NOT NULL AND ( n IN (SELECT DISTINCT( p )
                                               FROM   bst) ) 
                                THEN Concat(n, ' ', 'Inner')
                ELSE Concat(n, ' ', 'Leaf')
                END
        FROM   bst
        ORDER  BY n;