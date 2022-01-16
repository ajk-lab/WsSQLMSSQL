-----------------------------------------------------------------
-- www.helloajk.xyz : MS SQL exercise with AdventureWorks Sample DB
-----------------------------------------------------------------

USE AdventureWorks2019
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
GO


/* get #SYSTEM information */
USE AdventureWorks2019
SELECT * FROM sys.databases 

SELECT suser_sname(owner_sid) FROM sys.databases

SELECT CAST(owner_sid as uniqueidentifier) AS Owner_SID
FROM sys.databases
WHERE name = 'AdventureWorks2019';

SELECT * FROM sys.sql_logins

SELECT d.name, d.owner_sid, sl.name
FROM sys.databases AS d
JOIN sys.sql_logins AS sl
ON d.owner_sid = sl.sid;
GO

USE AdventureWorks2019
ALTER AUTHORIZATION ON DATABASE:: AdventureWorks2019 TO sa

ALTER AUTHORIZATION ON DATABASE:: AdventureWorksDW2019 TO sa

SELECT * from AdventureWorks2019.Production.Product
GO


USE helloajk
select * from helloajk.helloajk.Table_1
GO

/*#DESCRIBE TABLE, #STRUCTURE, #TABLE STRUCTURE*/
USE AdventureWorks2019;  
EXEC sp_help 'Production.Product';

EXEC sp_help 'AdventureWorks2019.HumanResources.Employee';
GO


USE AdventureWorks2019
select * from AdventureWorks2019.Production.Product

select * from AdventureWorks2019.HumanResources.Employee

select * from AdventureWorks2019.Sales.SalesOrderHeader

GO

/** #DESCRIBE #HELP #TABLE STRUCTURE **/
USE AdventureWorks2019
EXEC sp_help 'AdventureWorks2019.Sales.SalesOrderHeader';
GO

/** #GROUP BY #ORDER BY #ALIAS #FUNCTION
SQL is implemented as if a query was executed in the following order
FROM clause
WHERE clause
GROUP BY clause
HAVING clause
SELECT clause
ORDER BY clause
For most relational database systems, this order explains which names (columns or aliases) are valid because they must have been introduced in a previous step
So in Oracle and SQL Server, you cannot use a term in the GROUP BY clause that you define in the SELECT clause because the GROUP BY is executed before the SELECT clause
There are exceptions though: MySQL and Postgres seem to have additional smartness that allows it.
**/
USE AdventureWorks2019
	/** this will work **/
	SELECT YEAR(S.OrderDate) AS Year , S.SubTotal FROM AdventureWorks2019.Sales.SalesOrderHeader S ORDER BY  Year DESC  ; /* Note: Alias Year can be used */
	SELECT YEAR(S.OrderDate) AS Year , SUM(S.SubTotal) FROM AdventureWorks2019.Sales.SalesOrderHeader S GROUP BY  S.OrderDate  ;

	/** this will not work **/
	SELECT YEAR(S.OrderDate) AS Year , SUM(S.SubTotal) FROM AdventureWorks2019.Sales.SalesOrderHeader S GROUP BY  Year  ; /* Note: Alias Year can NOT be used */

	/** this will work - using sub query **/
	SELECT Year, SUM(TotalAmount) 
	FROM (SELECT YEAR(S.OrderDate) AS Year , S.SubTotal AS 'TotalAmount' FROM AdventureWorks2019.Sales.SalesOrderHeader S) SalesOrderHeaderS 
	GROUP BY  Year  
GO


