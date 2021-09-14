# MYSQL 
  * Important things related to queries.
     * SQL queries are not case-sensitive so you can write a query in upper or lower-case.
     * Depending upon the environment you are using you will need to end the query woth semi colon.
     * Creating a new column from the combination of existing columns in the table is only for temporary duration.
     * While using math operation always remember to follow the PEMDAS (Parenthesis,Exponent,Multiplication,Division,Addition,Subtraction) for the order of arithmetic operations.
     * In WHERE clause you can't use the alias name created in the select query but you can those alias name with ORDER BY,GROUP BY.
  

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


# JOINS In SQL
   * Inner Join: It creates new table(not physical) by Pulling the rows that have matching values in two or more tables.
   * Left Join or Left Outer Join: To pull those rows present in both tables based on matching condition and all the rows from left table.
   * Right Join or Right Outer Join: To pull those rows present in both tables based on matching condition and all the rows from right table.
   * Full Outer Join or Outer Join: This will return the inner join results,as well as any unmatched rows from either of the two tables being joined.

# AGGREGATIONS  in SQL
   * Count
   * Sum
   * Min
   * Max
   * AVG
   
 
