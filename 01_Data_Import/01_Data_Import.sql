--Create a database
create database SupplychainDB;

--using this as my current database for querying
use SupplychainDB

--imported Raw_supplychain_data.csv 


--verify import
select count(*) as TotalRows
from Raw_supplychain_data;

--preview data
select TOP 5 *
from Raw_supplychain_data;

