--Scripts para monitorear Oracle DataGuard
--Elaborado por: ByteCode Solutions
--https://www.fatihacar.com/blog/oracle-19c-r3-active-data-guard-installation-on-oracle-linux-7-7/
--Enable Active DataGuard DML Redirection in Oracle 19c --> https://smarttechways.com/2020/11/27/enable-active-dataguard-dml-redirection-in-oracle-19c/



--<Información de la Base de Dato>--
SELECT DATABASE_ROLE, DB_UNIQUE_NAME INSTANCE, OPEN_MODE, PROTECTION_MODE, PROTECTION_LEVEL, SWITCHOVER_STATUS FROM V$DATABASE;

--<Monitorear la aplicación de REDO DATA>--
SELECT PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS FROM V$MANAGED_STANDBY;

--<Revisar si RealTime Apply is ENABLE>--
SELECT RECOVERY_MODE FROM V$ARCHIVE_DEST_STATUS;

--<Revisión de Mensajes del estado del Dataguard>--
column message format a66
SELECT timestamp, facility, message FROM v$dataguard_status ORDER by timestamp;

--<Determinar que Archivelogs no han sido recibidos por el Standby>--
SELECT LOCAL.THREAD#, LOCAL.SEQUENCE# FROM (SELECT THREAD#, SEQUENCE# FROM V$ARCHIVED_LOG WHERE DEST_ID=1) LOCAL WHERE LOCAL.SEQUENCE# NOT IN (SELECT SEQUENCE# FROM V$ARCHIVED_LOG WHERE DEST_ID=2 AND THREAD# = LOCAL.THREAD#);

--<Revisar el Lag en DataGuard>--
set linesize 9000
column name format a25
column value format a20
column time_computed format a25
SELECT name, value, time_computed FROM v$dataguard_stats;

--<Monitorear el Redo Transport>--
column group# format a10
SELECT process, status, group#, thread#, sequence# FROM v$managed_standby order by process, group#, thread#, sequence#;

--<Monitorear el Redo Apply>--
column group# format a10
SELECT process, status, group#, thread#, sequence# FROM v$managed_standby order by process, group#, thread#, sequence#;

--PL/SQL para monitorear DataGuard
--https://www.ludovicocaldara.net/dba/script-to-check-data-guard-status-from-sql/

