-- View the CPU usage of databases
DECLARE @DML nvarchar(MAX)
 
DECLARE @SQLShackCPUStats TABLE (
[row_num] [bigint] NULL,
[DatabaseName] [nvarchar](128) NULL,
[CPU_Time_Ms] [bigint] NULL,
[CPUPercent] [decimal](5, 2) NULL,
[RowsReturned] bigint,
ExecutionCount bigint
)
 
SET @DML='WITH DBCPUStats
AS
(SELECT DatabaseID, DB_Name(DatabaseID) AS [DatabaseName], SUM(total_worker_time) AS [CPU_Time_Ms],  SUM(execution_count)  AS [ExecutionCount],
SUM(total_rows)  AS [RowsReturned]
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY (SELECT CONVERT(int, value) AS [DatabaseID]
FROM sys.dm_exec_plan_attributes(qs.plan_handle)
WHERE attribute = N''dbid'') AS F_DB
GROUP BY DatabaseID)
SELECT ROW_NUMBER() OVER(ORDER BY [CPU_Time_Ms] DESC) AS [row_num],
DatabaseName, [CPU_Time_Ms],
CAST([CPU_Time_Ms] * 1.0 / SUM([CPU_Time_Ms]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [CPUPercent],
[RowsReturned],
[ExecutionCount]
FROM DBCPUStats
WHERE DatabaseID > 4 -- system databases
AND DatabaseID <> 32767 -- ResourceDB
ORDER BY row_num OPTION (RECOMPILE)'
 
--How many Virtual Log Files or VLFs are present in your log file.
INSERT INTO @SQLShackCPUStats
EXEC sp_executesql @DML
 
 
SELECT * FROM @SQLShackCPUStats