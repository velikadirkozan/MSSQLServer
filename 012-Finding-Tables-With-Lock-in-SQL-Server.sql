-- Finding tables with lock in SQL Server

select str(request_session_id, 4,0) as spid,
convert(varchar(12),db_name(resource_database_id)) As db_name,
case when resource_database_id = db_id() and resource_type ='OBJECT'
then convert(char(20),object_name(resource_Associated_Entity_id))
else convert(char(20), resource_Associated_Entity_id)
end as object,
convert(varchar(12), resource_type) as resrc_type,
convert(varchar(12), request_type) as req_type,
convert(char(1), request_mode) as mode,
convert(varchar(8), request_status) as status
from sys.dm_tran_locks
order by request_session_id, 3 desc
