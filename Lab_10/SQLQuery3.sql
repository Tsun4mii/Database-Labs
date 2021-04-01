USE SHU_UNIVER

--1
exec sp_helpindex 'AUDITORIUM' 
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'
exec sp_helpindex 'TIMETABLE'

create table #temp_table
(	some_ind int, 
	some_field varchar(20)
)
SET nocount on;		--не вывод сообщения о вводе строк
DECLARE @i int = 0;
while @i < 1000
	begin
		insert #temp_table(some_ind, some_field)
			values(FLOOR(RAND()*10000), REPLICATE('test ',3));
		SET @i = @i + 1; 
	end

select * from #temp_table where some_ind between 1500 and 2000 order by some_ind 
	checkpoint;				--фиксация БД
	DBCC DROPCLEANBUFFERS;	--очистить буферный кэш
CREATE clustered index #temp_table_cl on #temp_table(some_ind asc)
drop table #temp_table

--2
create table #temp_table_1
(
	some_ind int, 
	some_field varchar(20),
	cc int identity(1,1)	
)
SET nocount on;
DECLARE @j int = 0;
while @j < 10000
begin
	insert #temp_table_1(some_ind, some_field)
		values(FLOOR(RAND()*10000), 'str' + cast(@j as nvarchar(1000)) );
	SET @j = @j + 1; 
end

select * from #temp_table_1 where cc >500 and some_ind between 1500 and 5000 

SELECT count(*)[количество строк] from #temp_table_1;
SELECT * from #temp_table_1
SELECT * from #temp_table_1 where some_field = 'str34' and cc>3
CREATE index #temp_table_1_nonclu on #temp_table_1(some_ind, cc)
drop table #temp_table_1

--3 
drop table #temp_table_2
create table #temp_table_2
(
	some_ind int, 
	some_field varchar(20),
	cc int identity(1,1)
)
SET nocount on;
DECLARE @k int = 0;
while @k < 20000
begin
	insert #temp_table_2(some_ind, some_field)
		values(FLOOR(RAND()*30000), REPLICATE('test2',3) );
	SET @k = @k + 1; 
end

select * from #temp_table_2 where cc >500 and some_ind between 1500 and 5000 
CREATE index #temp_table_2_nonclu_2 on #temp_table_2(some_ind) INCLUDE(cc)
select CC from #temp_table_2 where some_ind > 500
--drop table #temp_table_2

--4
SELECT some_ind from  #temp_table_2 where some_ind between 5000 and 19999; 
SELECT some_ind from  #temp_table_2 where some_ind>15000 and  some_ind < 20000  
SELECT some_ind from  #temp_table_2 where some_ind=16000

 CREATE  index #temp_table_WHERE on #temp_table_2(some_ind) where (some_ind>15000 and 
 some_ind  < 20000);
 drop index #temp_table_WHERE on #temp_table_2

 --5
 use tempdb
 CREATE index #temp_table_2_ind  on #temp_table_2(some_ind);

SELECT	name [Индекс],
		avg_fragmentation_in_percent [Фрагментация(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
  OBJECT_ID(N'#temp_table_2'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;

INSERT top(20000) #temp_table_2(some_ind, some_field) select some_ind, some_field from #temp_table_2;

ALTER index #temp_table_2_ind on #temp_table_2 reorganize; 
ALTER index #temp_table_2_ind  on #temp_table_2 rebuild with (online = off);

drop index #temp_table_2_ind on #temp_table_2

--6
CREATE index #temp_table_2_ind1  on #temp_table_2(some_ind)with (fillfactor = 65);

INSERT top(50)percent into #temp_table_2(some_ind, some_field) select some_ind, some_field  from #temp_table_2; 
use tempdb
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#temp_table_2'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
       where name is not null;

drop index #temp_table_2_ind1 on #temp_table_2