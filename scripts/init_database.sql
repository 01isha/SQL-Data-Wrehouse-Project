/* Create database and schemas 
Script purpose : it creates a new database 'Datawarehouse' after checking if exixts or not . 
the cripts setsup three shemas bronze , silver and gold. 
*/
USE master;
GO

  --Drop and recreate the 'DataWarehouse' database 
  IF EXIXTS (SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
  BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO 
  --create 'DataWarehouse'database 
    
CREATE DATABASE Datawarehouse;
GO
USE Datawarehouse; 

--Create Schemas -- 

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
Go
CREATE SCHEMA gold;
Go


