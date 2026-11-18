-- Reset the project database. Re-running this script deletes its existing data.
USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = N'datawarehouse')
BEGIN
    ALTER DATABASE datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE datawarehouse;
END;
GO

CREATE DATABASE datawarehouse;
GO

USE datawarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
