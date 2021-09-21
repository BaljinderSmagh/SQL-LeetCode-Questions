-- Udacity

-- GROUP BY CLAUSE

-- QUESTION 1:For each account, determine the average amount of each type of paper they purchased across their orders. 
-- Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account

-- QUERY:
        SELECT ACC.NAME,
               AVG(standard_qty) AS STANDARD_QTY,
               AVG(gloss_qty) AS GLOSS_QTY,
               AVG(POSTER_QTY) AS POSTER_QTY
        FROM ORDERS ORD,
             ACCOUNTS ACC 
        WHERE ORD.ACCOUNT_ID=ACC.ID
        GROUP BY ACC.NAME;


-- QUESTION 2: For each account, determine the average amount spent per order on each paper type. 
-- Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

-- QUERY:
        SELECT ACC.NAME,
               AVG(standard_amt_usd ) AS STANDARD_QTY,
               AVG(gloss_amt_usd) AS GLOSS_QTY,
               AVG(poster_amt_usd ) AS POSTER_QTY
        FROM ORDERS ORD,
             ACCOUNTS ACC 
        WHERE ORD.ACCOUNT_ID=ACC.ID
        GROUP BY ACC.NAME;


-- QUESTION 3:Determine the number of times a particular channel was used in the web_events table for each sales rep. 
-- Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. 
-- Order your table with the highest number of occurrences first.

-- QUERY:
        SELECT 
               SALES.NAME,
               WEB.CHANNEL
               COUNT(WEB.CHANNEL) AS OCCURRENCES
        FROM
            WEB_EVENTS WEB JOIN
            ACCOUNTS ACC
            ON ACC.ID=WEB.ACCOUNT_ID
            JOIN SALES_REPS SALES
            ON SALES.ID=ACC.SALES_REP_ID
        GROUP BY SALES.NAME,WEB.CHANNEL
        ORDER BY OCCURRENCES DESC   


-- QUESTION 4:Determine the number of times a particular channel was used in the web_events table for each region. 
-- Your final table should have three columns - the region name, the channel, and the number of occurrences. 
-- Order your table with the highest number of occurrences first.

-- QUERY:
        SELECT REG.NAME,
               CHANNEL,
               COUNT(WEB.CHANNEL) AS OCCURRENCES
        FROM
            WEB_EVENTS WEB JOIN
            ACCOUNTS ACC
            ON ACC.ID=WEB.ACCOUNT_ID
            JOIN SALES_REPS SALES
            ON SALES.ID=ACC.SALES_REP_ID
            JOIN REGION REG
            ON REG.ID=SALES.REGION_ID
        GROUP BY REG.NAME,
                CHANNEL
        ORDER BY OCCURRENCES DESC


-- QUESTION 5:How many of the sales reps have more than 5 accounts that they manage?
-- QUERY:

        SELECT 
            SALES.ID,
            COUNT(ACC.ID)
        FROM ACCOUNTS ACC
            JOIN
            SALES_REPS SALES
            ON SALES.ID=ACC.SALES_REP_ID
        GROUP BY SALES.ID
        HAVING COUNT(ACC.ID) >5;

-- QUESTION 6:How many accounts have more than 20 orders?

-- QUERY:
        SELECT ACC.ID,
               COUNT(ORD.ID)
        FROM ACCOUNTS ACC,
             ORDERS ORD
        WHERE ACC.ID=ORD.ACCOUNT_ID
        GROUP BY ACC.ID
        HAVING COUNT(ORD.ID)>20
        ORDER BY COUNT(ORD.ID) DESC

-- QUESTION 7:Which account has the most orders?

-- QUERY:
        SELECT ACC.ID,
              COUNT(ORD.ID)
        FROM ACCOUNTS ACC,
             ORDERS ORD
        WHERE ACC.ID=ORD.ACCOUNT_ID
        GROUP BY ACC.ID
        ORDER BY COUNT(ORD.ID) DESC
        LIMIT 1

-- QUESTION 8:Which accounts spent more than 30,000 usd total across all orders?

-- QUERY:

        SELECT ACC.ID,
               SUM(TOTAL_AMT_USD) AS TOTAL 
        FROM ACCOUNTS ACC,
            ORDERS ORD
        WHERE ACC.ID=ORD.ACCOUNT_ID
        GROUP BY ACC.ID
        HAVING SUM(TOTAL_AMT_USD)>30000
        ORDER BY TOTAL

-- QUESTION 9:Which accounts spent less than 1,000 usd total across all orders?

-- QUERY:
        SELECT ACC.ID,
               COUNT(ORD.ID),
               SUM(TOTAL_AMT_USD)
        FROM ACCOUNTS ACC,
            ORDERS ORD
        WHERE ACC.ID=ORD.ACCOUNT_ID
        GROUP BY ACC.ID
        HAVING SUM(TOTAL_AMT_USD)<1000
        ORDER BY COUNT(ORD.ID) DESC

-- QUESTION 10:Which account has spent the most with us?

-- QUERY:
        SELECT ACC.ID,
               COUNT(ORD.ID),
               SUM(TOTAL_AMT_USD)
        FROM ACCOUNTS ACC,
             ORDERS ORD
        WHERE ACC.ID=ORD.ACCOUNT_ID
        GROUP BY ACC.ID
        ORDER BY SUM(TOTAL_AMT_USD) DESC
        LIMIT 1

-- QUESTION 11:Which account has spent the least with us?

-- QUERY:
        SELECT ACC.ID,
               COUNT(ORD.ID),
               SUM(TOTAL_AMT_USD)
        FROM ACCOUNTS ACC,
             ORDERS ORD
        WHERE ACC.ID=ORD.ACCOUNT_ID
        GROUP BY ACC.ID
        ORDER BY SUM(TOTAL_AMT_USD) ASC
        LIMIT 1

-- QUESTION 12:Which accounts used facebook as a channel to contact customers more than 6 times?

-- QUERY:
        SELECT ACC.ID,
               COUNT(WEB.CHANNEL) as Channel
        FROM WEB_EVENTS WEB
            JOIN 
            ACCOUNTS ACC
        ON ACC.ID=WEB.ACCOUNT_ID
        WHERE WEB.CHANNEL='facebook'
        GROUP BY ACC.ID
        HAVING COUNT(WEB.CHANNEL)>6

-- QUESTION 13:Which account used facebook most as a channel?

-- QUERY:

        SELECT ACC.ID,
               COUNT(WEB.CHANNEL) as Channel
        FROM WEB_EVENTS WEB
             JOIN 
             ACCOUNTS ACC
        ON ACC.ID=WEB.ACCOUNT_ID
        WHERE WEB.CHANNEL='facebook'
        GROUP BY ACC.ID
        ORDER BY Channel DESC
        LIMIT 1


-- QUESTION 14:Which channel was most frequently used by most accounts?

-- QUERY:

        SELECT ACC.ID, 
               COUNT(WEB.CHANNEL) as Channel
        FROM WEB_EVENTS WEB
             JOIN 
             ACCOUNTS ACC
        ON ACC.ID=WEB.ACCOUNT_ID
        GROUP BY ACC.ID
        ORDER BY Channel DESC
        LIMIT 10

-- DATE

-- QUESTION 15:Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
-- Do you notice any trends in the yearly sales totals?

-- QUERY:
        SELECT Sum(total_amt_usd) AS total,
               Date_part('year', occurred_at) AS YEAR
        FROM   orders
        GROUP  BY year
        ORDER  BY year DESC 



-- QUESTION 16: Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

-- QUERY:
        SELECT Sum(total_amt_usd)   AS total,
               Date_part('month', occurred_at) AS MONTH
        FROM   orders
        GROUP  BY MONTH
        ORDER  BY total DESC 




-- QUESTION 17:Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

-- QUERY:
        SELECT COUNT(ID)   AS ORDERS,
               Date_part('YEAR', occurred_at) AS YEAR
        FROM   orders
        GROUP  BY YEAR
        ORDER  BY ORDERS DESC 


-- QUESTION 18:Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?

-- QUERY:
        SELECT COUNT(ID)   AS ORDERS,
               Date_part('MONTH', occurred_at) AS MONTH
        FROM   orders
        GROUP  BY MONTH
        ORDER  BY ORDERS DESC 


-- QUESTION 19:In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

-- QUERY:
        SELECT SUM(GLOSS_AMT_USD)   AS GLOSS_USD,
               Date_part('MONTH', occurred_at) AS MONTH,
               Date_part('YEAR', occurred_at) AS YEAR
        FROM   orders ORD
               JOIN
               ACCOUNTS ACC
        ON ACC.ID=ORD.ACCOUNT_ID
        WHERE ACC.NAME='Walmart'
        GROUP  BY MONTH,YEAR
        ORDER  BY GLOSS_USD DESC 
        LIMIT 1

-- CASE

-- QUESTION 20:Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. 
-- Limit the results to the first 10 orders, and include the id and account_id fields.

-- QUERY:
        SELECT ID,
               ACCOUNT_ID,
               CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                ELSE standard_amt_usd/standard_qty 
                END AS unit_price
        FROM orders
        LIMIT 10;