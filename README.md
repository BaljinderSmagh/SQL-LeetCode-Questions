# MYSQL 
  * Important things related to queries.
     * SQL queries are not case-sensitive so you can write a query in upper or lower-case.
     * Depending upon the environment you are using you will need to end the query with semi colon.
     * Creating a new column from the combination of existing columns in the table is only for temporary duration.
     * While using math operation always remember to follow the PEMDAS (Parenthesis,Exponent,Multiplication,Division,Addition,Subtraction) for the order of arithmetic operations.
     * In WHERE clause you can't use the alias name created in the select query but you can those alias name with ORDER BY,GROUP BY.
     * Null values are different than zero or a space.It imporatant to know why there are Null values.You can check null values by using IS NULL or IS NOT NULL.
     * While using subquery use alias name after enclosing the query in parenthesis.
  

# SQL Basic Commands
  * To **SELECT** all the columns from the table.
      * SELECT * FROM TABLE.
  * To select particular columns from the tables,mention their names.
      * SELECT COL1,COL2 FROM TABLE.
  * To filter the dataset, we can use **WHERE** clause with operators like (>,<,>=,<=,=,!=) for numeric data and for non-numeric data operators like (LIKE,NOT,IN,AND,BETWEEN,OR).
      * SELECT COL1,COL2 FROM TABLE WHERE COL1>10;
  * To view only few rows you can use **LIMIT** by specifying the number of rows you want to display.
      * SELECT * FROM TABLE LIMIT 10;
  * To sort your results using the column name you can use **ORDER BY**,by default the order will be shown in ascending order. if you want the order in descending order you can specify **DESC**.
      * SELECT * FROM TABLE ORDER BY COL1;
      * SELECT * FROM TABLE ORDER BY COL1 DESC;
   * To specify more than column in order by to avoid same items values first column values.
      * SELECT * FROM TABLE ORDER BY COL1 ,COL2 DESC;
   * Use of **GROUP BY**, when any column in SELECT statment that is not within an aggregator must be in the group by clause.it always goes between where and order by clause if they are present.Group by clause is evaluated before LIMIT clause.
      *  SELECT COL2,COUNT(COL1) FROM TABLE GROUP BY COL2
   * DISTINCT Clause is always used in SELECT statements.it is used to provide the unqiue rows for all columns written in the select statement.So it is used just after SELECT clause,so it is used only once.
      * SELECT DISTINCT COL1,COL2,COL3 FROM TABLE.
      * This above query will provide unique rows across all columns provided in the select statement.
   * HAVING Clause helps to filter the aggregated columns.
      * SELECT COL1,SUM(COL2) FROM TABLE HAVING SUM(COL1)>10; 
   * DATE_TRUNC Function.
      * DATE_TRUNC('second',date), will provide the date along with time upto seconds.
      * DATE_TRUNC('day',date),will provided only date truncating the time part.
      * DATE_TRUNC('month',date),will provided only date truncating the time part.
      * DATE_TRUNC('year',date),will provided only date truncating the time part.
   * DATE_PART Function to pull the part of the date you are interested:-
      * DATA_PART('second',date),will provide seconds value in date.
      * DATA_PART('day',date), will provide only number of day present in the date.
      * DATA_PART('month',date),will provide only number of month present in the date.
      * DATA_PART('year',date),will provide only number of year present in the date.
      * DATA_PART('dow',date),will provide only number of  day in the week present in the date.
   * CASE STATEMENT is used in select Clause. It has the following components WHEN,THEN,END, AND ELSE(OPTIONAL). You can include as many when statemenst you want to include.
      * CASE WHEN COL1>100 THEN 'HIGH'
        ELSE 'LOW' 
        END AS RANK
         
# JOINS In SQL
   * Inner Join: It creates new table(not physical) by Pulling the rows that have matching values in two or more tables.
   * Left Join or Left Outer Join: To pull those rows present in both tables based on matching condition and all the rows from left table.
   * Right Join or Right Outer Join: To pull those rows present in both tables based on matching condition and all the rows from right table.
   * Full Outer Join or Outer Join: This will return the inner join results,as well as any unmatched rows from either of the two tables being joined.

# AGGREGATIONS  in SQL
   * Count: Can be used count values for both numerical and non-numerical.
   * Sum
   * Min
   * Max
   * AVG
# ORDER of Execution In SQL Query
   * FROM AND JOINS
   * WHERE
   * GROUP BY 
   * HAVING
   * SELECT
   * DISTINCT
   * ORDER BY
   * LIMIT / OFFSET
 
