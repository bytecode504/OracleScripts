--Query para verificar el progreso de restauración de un Backup usando RMAN
--Elaborado por: ByteCodeSolutions

SELECT sid, serial#, context, sofar, totalwork,
 round(sofar/totalwork*100,2) "% Complete"
 FROM v$session_longops
 WHERE opname LIKE 'RMAN%'
 AND opname NOT LIKE '%aggregate%'
 AND totalwork != 0
 AND sofar != totalwork;