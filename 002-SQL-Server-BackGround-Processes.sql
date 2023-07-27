-- see background processes
SELECT(r.total_elapsed_time / 1000.0) AS total_elapsed_s,
percent_complete,
s.host_name,
r.blocking_session_id,
r.last_wait_type,
s.login_name,
('kill '+CAST(r.session_id AS VARCHAR)) AS SESSIONKILL,
DB_NAME(r.database_id) AS DatabaseName,
r.database_id,
command,
SUBSTRING(t.text, (r.statement_start_offset/2)+1, ((CASE statement_end_offset
WHEN-1
THEN DATALENGTH(t.text)
ELSE r.statement_end_offset
END-r.statement_start_offset)/2)+1) AS statement_text,
r.status,
wait_time,
wait_type,
wait_resource,
text,
start_time,
s.program_name,
(r.granted_query_memory * 8 / 1024) AS memory_mb,
(r.logical_reads * 8 / 1024) AS logicalread,
s.memory_usage,
r.session_id
FROM sys.dm_exec_requests r
INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.session_id != @@SPID
AND s.login_name != 'NT AUTHORITY\SYSTEM';