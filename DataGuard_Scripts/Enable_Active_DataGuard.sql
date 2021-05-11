--Habilitar Active DataGuard
--Elaborado por: ByteCode Solutions

--<Step-1: Cancelar el Media Recovery en la Physical Standby>--
alter database recover managed standby database cancel;

--<Step-2: Apertura de la base de datos [PHYSICAL STANDBY]>--
alter database open;

--<Step-3: Iniciar el media recovery en RealTime Log Apply [PHYSICAL STANDBY]>--
alter database recover managed standby database using current logfile disconnect from session;

--<Step-4: Revisar el estado de la base de datos:[PHYSICAL STANDBY]>--
select name,open_mode from v$database;
select process,status,sequence# from v$managed_standby;

