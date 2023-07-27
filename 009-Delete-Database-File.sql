-- Delete database file
DBCC SHRINKFILE ('B', EMPTYFILE);
ALTER DATABASE [A] REMOVE FILE [B]


B: silinecek dosya
A : ana veri tabani

(loglar için çalışmayabilir)