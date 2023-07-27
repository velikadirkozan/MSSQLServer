-- Backup of active databases 
DECLARE @DatabaseName sysname;

SELECT @DatabaseName = name
FROM sys.databases
WHERE state_desc = 'ONLINE';

WHILE @DatabaseName IS NOT NULL
BEGIN
    BACKUP DATABASE @DatabaseName
    TO DISK = 'C:\Backups\' + @DatabaseName + '.bak'
    WITH INIT, COMPRESSION, STATS = 10;

    SELECT @DatabaseName = name
    FROM sys.databases
    WHERE name > @DatabaseName
    AND state_desc = 'ONLINE';
END;