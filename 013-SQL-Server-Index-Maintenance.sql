-- SQL Server Index Maintenance

select *
from sys.dm_db_index_physical_stats (db_id(),null,null,null,null)


Select *
From Sys.dm_db_index_usage_stats


Select *
From Sys.dm_db_index_usage_stats
Where database_id = db_id()


Select object_name (object_id),*
From Sys.dm_db_index_usage_stats
Where database_id = db_id()


Select object_name (object_id) as objName, *
From sys.dm_db_index_physical_stats  (db_id(),null,null,null,null)
Where database_id = db_id()

Select object_name (object_id) as objName, index_type_desc ,avg_fragmentation_in_percent
From sys.dm_db_index_physical_stats  (db_id(),null,null,null,null)
Where database_id = db_id()


Select table_name,column_name from INFORMATION_SCHEMA.COLUMNS
Where COLUMN_NAME like  '%ProductReview%'

Alter index all on  production.ProductReview
Rebuild
With (online = on)