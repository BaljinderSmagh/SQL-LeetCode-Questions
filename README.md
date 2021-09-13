# MYSQL-Practice-Questions
  * Important things related to queries.
     * SQL queries are not case-sensitive so you can write a query in upper or lower-case.
     * Depending upon the environment you are using you will need to end the query woth semi colon.
  

# SQL Basic Commands
  * To **SELECT** all the columns from the table.
      * SELECT * FROM TABLE.
  * To select particular columns from the tables,mention their names.
      * SELECT COL1,COL2 FROM TABLE.
  * To view only few rows you can use **LIMIT** by specifying the number of rows you want to display.
      * SELECT * FROM TABLE LIMIT 10;
  * To sort your results using the column name you can use **ORDER BY**,by default the order will be shown in ascending order. if you want the order in descending order you can specify **DESC**.
      * SELECT * FROM TABLE ORDER BY COL1;
      * SELECT * FROM TABLE ORDER BY COL1 DESC;
   * To specify more than column in order by to avoid same items values first column values.
      * SELECT * FROM TABLE ORDER BY COL1 ,COL2 DESC;
