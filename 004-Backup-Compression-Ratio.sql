-- Backup Compression Ratio
SELECT database_name, backup_size, compressed_backup_size,
backup_size/compressed_backup_size AS CompressedRatio
FROM msdb..backupset;