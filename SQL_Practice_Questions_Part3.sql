-- UDACITY
-- LIKE OPERATOR
-- QUESTION 1: USE THE ACCOUNTS TABLE TO FIND
-- a) All the companies whose names start with 'C'.
-- b) All companies whose names contain the string 'one' somewhere in the name.
-- c) All companies whose names end with 's'.

-- Query:

        a) SELECT name
           FROM accounts
           WHERE name LIKE 'C%';

        b) SELECT name
           FROM accounts
           WHERE name LIKE '%one%';

        c) SELECT name
           FROM accounts
           WHERE name LIKE '%s';
           

-- IN OPERATOR

-- QUESTION 2: a) Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
--             b) Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

-- Query:
        a) SELECT name, primary_poc, sales_rep_id
           FROM accounts
           WHERE name IN ('Walmart', 'Target', 'Nordstrom');

        b) SELECT *
           FROM web_events
           WHERE channel IN ('organic', 'adwords');


-- NOT OPERATOR
-- QUESTION 3: A) Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
--             B) Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
--             C) All the companies whose names do not start with 'C'.
--             D) All companies whose names do not contain the string 'one' somewhere in the name.
--             E) All companies whose names do not end with 's'.

-- QUERY:
        A) SELECT NAME,PRIMARY_POC,SALES_REP_ID 
          FROM ACCOUNTS
          WHERE NAME NOT IN ('Walmart', 'Target', 'Nordstrom');

        B) SELECT * 
           FROM WEB_EVENTS 
           WHERE CHANNEL NOT IN ('organic', 'adwords');
        C) SELECT name
           FROM accounts
           WHERE name NOT LIKE 'C%';
        D) SELECT name
           FROM accounts
           WHERE name NOT LIKE '%one%';
        E) SELECT name
           FROM accounts
           WHERE name NOT LIKE '%s';

-- AND and BETWEEN OPERATOR

-- QUESTION 4:A) Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
--            B) Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
--            C) Write a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. 
--            D) Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, 
--               and started their account at any point in 2016, sorted from newest to oldest.
-- QUERY:
      A) SELECT * 
         FROM ORDERS 
         WHERE STANDARD_QTY>1000 AND POSTER_QTY=0 AND GLOSS_QTY=0;
      B) SELECT * 
         FROM ACCOUNTS
         WHERE NAME NOT LIKE 'C%' AND NAME LIKE '%s';
     
      C) SELECT OCCURRED_AT,GLOSS_QTY 
         FROM ORDERS
         WHERE GLOSS_QTY BETWEEN 24 AND 29


      D) SELECT *
         FROM web_events
         WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
         ORDER BY occurred_at DESC;

-- OR OPERATOR

-- QUESTION 5: A) Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
--             B) Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
--             C) Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.

-- QUERY:
    A) SELECT ID FROM ORDERS
       WHERE GLOSS_QTY>4000 OR POSTER_QTY>4000;

    B) SELECT *
       FROM ORDERS
       WHERE STANDARD_QTY=0 AND (GLOSS_QTY>1000 OR POSTER_QTY>1000)

    C) SELECT NAME
       FROM ACCOUNTS
       WHERE (NAME LIKE 'C%' OR NAME LIKE 'W%') AND 
              ((PRIMARY_POC LIKE '%ana%' OR PRIMARY_POC LIKE '%Ana%')
              AND PRIMARY_POC NOT LIKE '%eana%')


-- JOINS

-- QUESTION 6:Provide a table for all web_events associated with account name of Walmart. 
-- There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. 
-- Additionally, you might choose to add a fourth column to assure only Walmart events were chosen

-- QUERY:

        SELECT ACC.PRIMARY_POC,
               WEB.OCCURRED_AT,
               WEB.CHANNEL,
               ACC.NAME
        FROM WEB_EVENTS AS WEB
             JOIN ACCOUNTS AS ACC
                ON WEB.ACCOUNT_ID=ACC.ID
        WHERE ACC.NAME='Walmart';


-- QUESTION 7: Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.

-- QUERY:
        SELECT REG.NAME AS REGION_NAME,
               SALES.NAME AS SALES_NAME,
               ACC.NAME AS ACC_NAME
        FROM REGION AS REG
             JOIN SALES_REPS AS SALES
               ON SALES.REGION_ID=REG.ID
             JOIN ACCOUNTS AS ACC
               ON ACC.SALES_REP_ID=SALES.ID
        ORDER BY ACC_NAME;

-- QUESTION 8:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
-- Your final table should have 3 columns: region name, account name, and unit price. 
-- A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

-- QUERY:
        SELECT REG.NAME AS REGION_NAME,
               ACC.NAME AS ACCOUNT_NAME,
               (ORD.TOTAL_AMT_USD/(ORD.TOTAL+0.01)) AS UNIT_PRICE
        FROM ORDERS AS ORD
             JOIN ACCOUNTS AS ACC
               ON ORD.ACCOUNT_ID=ACC.ID
             JOIN SALES_REPS AS SALES
               ON SALES.ID=ACC.SALES_REP_ID
             JOIN REGION AS REG
               ON REG.ID=SALES.REGION_ID;

-- QUESTION 9:Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.


-- QUERY:
        SELECT REG.NAME AS REGION_NAME,
               SALES.NAME AS SALES_NAME,
               ACC.NAME AS ACC_NAME
        FROM REGION AS REG
             JOIN SALES_REPS AS SALES 
               ON REG.ID=SALES.REGION_ID
             JOIN ACCOUNTS AS ACC
               ON ACC.SALES_REP_ID=SALES.ID
        WHERE REG.NAME='Midwest'
        ORDER BY ACC_NAME;

-- QUESTION 10:Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.

-- QUERY:
        SELECT REG.NAME   AS REGION_NAME,
               SALES.NAME AS SALES_NAME,
               ACC.NAME   AS ACC_NAME
        FROM   region AS REG
               JOIN sales_reps AS SALES
                 ON REG.id = SALES.region_id
               JOIN accounts AS ACC
                 ON ACC.sales_rep_id = SALES.id
        WHERE  REG.NAME = 'Midwest'
               AND SALES.NAME LIKE 'S%'
        ORDER  BY acc_name; 


-- QUESTION 11:Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.

-- QUERY:

        SELECT REG.NAME AS REGION_NAME,
SALES.NAME AS SALES_NAME,
         ACC.NAME AS ACC_NAME
FROM REGION AS REG
JOIN SALES_REPS AS SALES 
ON REG.ID=SALES.REGION_ID
JOIN ACCOUNTS AS ACC
ON ACC.SALES_REP_ID=SALES.ID
WHERE REG.NAME='Midwest' AND SALES.NAME LIKE '% K%'
ORDER BY ACC_NAME;


-- QUESTION 12:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
-- However, you should only provide the results if the standard order quantity exceeds 100. 
-- Your final table should have 3 columns: region name, account name, and unit price. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

-- QUERY:
        SELECT REG.NAME AS REGION_NAME,
               ACC.NAME AS ACCOUNT_NAME,
               (ORD.TOTAL_AMT_USD/(ORD.TOTAL+0.01)) AS UNIT_PRICE
        FROM ORDERS AS ORD
             JOIN ACCOUNTS AS ACC
               ON ORD.ACCOUNT_ID=ACC.ID
             JOIN SALES_REPS AS SALES
               ON SALES.ID=ACC.SALES_REP_ID
             JOIN REGION AS REG
               ON REG.ID=SALES.REGION_ID
        WHERE ORD.STANDARD_QTY>100;



-- QUESTION 13:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
-- However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
-- Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

-- QUERY:

        SELECT REG.NAME AS REGION_NAME,
               ACC.NAME AS ACCOUNT_NAME,
               (ORD.TOTAL_AMT_USD/(ORD.TOTAL+0.01)) AS UNIT_PRICE
        FROM ORDERS AS ORD
             JOIN ACCOUNTS AS ACC
               ON ORD.ACCOUNT_ID=ACC.ID
             JOIN SALES_REPS AS SALES
               ON SALES.ID=ACC.SALES_REP_ID
             JOIN REGION AS REG
               ON REG.ID=SALES.REGION_ID
        WHERE ORD.STANDARD_QTY>100 AND ORD.POSTER_QTY>50
        ORDER BY UNIT_PRICE


-- QUESTION 14:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
-- However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
-- Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).


-- QUERY:
      SELECT REG.NAME AS REGION_NAME,
               ACC.NAME AS ACCOUNT_NAME,
               (ORD.TOTAL_AMT_USD/(ORD.TOTAL+0.01)) AS UNIT_PRICE
        FROM ORDERS AS ORD
             JOIN ACCOUNTS AS ACC
               ON ORD.ACCOUNT_ID=ACC.ID
             JOIN SALES_REPS AS SALES
               ON SALES.ID=ACC.SALES_REP_ID
             JOIN REGION AS REG
               ON REG.ID=SALES.REGION_ID
        WHERE ORD.STANDARD_QTY>100 AND ORD.POSTER_QTY>50
        ORDER BY UNIT_PRICE DESC;  



-- QUESTION 15:What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. 
-- You can try SELECT DISTINCT to narrow down the results to only the unique values.

-- QUERY:
        SELECT DISTINCT web.channel,
                        acc.NAME
        FROM   accounts AS acc
               JOIN web_events AS web
              ON acc.id = web.account_id
        WHERE  acc.id = 1001 
        
-- QUESTION 16:Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.

-- QUERY:
        select ORD.OCCURRED_AT,
               ACC.NAME,
               ORD.TOTAL,
               ORD.TOTAL_AMT_USD
        FROM ORDERS  AS ORD
             JOIN ACCOUNTS AS ACC
               ON ORD.ACCOUNT_ID=ACC.ID
        WHERE ORD.OCCURRED_AT BETWEEN '2015-01-01' AND '2016-01-01'
        ORDER BY ORD.OCCURRED_AT DESC


-- QUESTION 17: Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.

-- QUERY:
        SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
        FROM orders;




-- QUESTION 18:Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. 
-- Order from fewest reps to most reps.


-- QUERY:
        SELECT Count(sales.id),
                reg.NAME
        FROM   region AS reg
               JOIN sales_reps AS sales
                 ON sales.region_id = reg.id
        GROUP  BY reg.NAME
        ORDER  BY Count(sales.id) 


-- QUESTION 19:What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. 
-- Order from smallest dollar amounts to largest.

-- QUERY:
        SELECT MIN(total_amt_usd) AS TOTAL_USD,ACC.NAME
        FROM ORDERS AS ORD
            JOIN ACCOUNTS AS ACC
              ON ACC.ID=ORD.ACCOUNT_ID
        GROUP BY ACC.NAME
        ORDER BY TOTAL_USD;

-- QUESTION 20:Find the total number of times each type of channel from the web_events was used. 
-- Your final table should have two columns - the channel and the number of times the channel was used.

-- QUERY:
        SELECT COUNT(CHANNEL) AS COUNT,CHANNEL
        FROM WEB_EVENTS
        GROUP BY CHANNEL
        ORDER BY COUNT DESC

