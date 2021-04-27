use SHU_UNIVER

declare Subs cursor
		for select SUBJECT from SUBJECT
		where SUBJECT.PULPIT = 'ИСиТ'
declare @sub char(4),
		@str char(100) = ' ';

open Subs;
		fetch Subs into @sub;
		print 'Предметы на кафедре ИСиТ: ';
		while @@FETCH_STATUS = 0
		begin 
			set @str = rtrim(@sub) + ', ' + @str;
			fetch Subs into @sub;
		end;
	print @str;
close Subs;
deallocate Subs;
go
--2
use SHU_UNIVER
DECLARE Teacher_cursor CURSOR LOCAL for select TEACHER.TEACHER_NAME from TEACHER where TEACHER.PULPIT = 'ИСиТ';
DECLARE @teacher char(50), @teacher_ot char(100) ='';
OPEN Teacher_cursor;
print 'Преподаватели ИСиТ';
FETCH  Teacher_cursor into @teacher;
	set @teacher_ot ='1. ' + RTRIM(@teacher);	
	print @teacher_ot;
CLOSE Teacher_cursor;

go
DECLARE @teacher char(50), @teacher_ot char(100) ='';
OPEN Teacher_cursor;
FETCH  Teacher_cursor into @teacher;
	set @teacher_ot ='2. ' + RTRIM(@teacher);	
	print @teacher_ot;
CLOSE Teacher_cursor

go
DECLARE Teacher_cursor_2 CURSOR GLOBAL for select TEACHER.TEACHER_NAME from TEACHER where TEACHER.PULPIT = 'ИСиТ';
DECLARE @teacher char(50), @teacher_ot char(100) ='';
OPEN Teacher_cursor_2;
print 'Преподаватели ИСиТ';
FETCH  Teacher_cursor_2 into @teacher;
	set @teacher_ot ='1. ' + RTRIM(@teacher);	
	print @teacher_ot;
CLOSE Teacher_cursor_2;

go
DECLARE @teacher char(50), @teacher_ot char(100) ='';
OPEN Teacher_cursor_2;
print 'Преподаватели ИСиТ';
FETCH  Teacher_cursor_2 into @teacher;
	set @teacher_ot ='1. ' + RTRIM(@teacher);	
	print @teacher_ot;
CLOSE Teacher_cursor_2;
deallocate Teacher_cursor_2
go
--3
DECLARE Studs CURSOR Local DYNAMIC  --Динамический возвращает -1, тк добавление записей может в любое время изменить кол-во записей 
	for SELECT NAME from STUDENT
	where IDGROUP = 3;		
		   
OPEN Studs;
print 'Кол-во строк: '+cast(@@CURSOR_ROWS as varchar(5)); 

DECLARE @name char(50);  
UPDATE STUDENT set IDGROUP=24 where IDGROUP=3;  
fetch  Studs into @name;     
while @@fetch_status = 0                                    
begin 
   print @name + ' ';      
   fetch Studs into @name; 
end;      
CLOSE  Studs;


UPDATE STUDENT set IDGROUP=3 where IDGROUP=24;
DEALLOCATE Studs 
go
--4
DECLARE @number varchar(100), @sub varchar(10), @idstudent varchar(6), @pdate varchar (11), @note varchar (2);
DECLARE PROGRESS_CURSOR_SCROLL CURSOR LOCAL DYNAMIC SCROLL --Scroll позволяет переходить по записям в различном порядке 
	for select ROW_NUMBER() over (order by IDSTUDENT) Номер,
	* from PROGRESS;

OPEN PROGRESS_CURSOR_SCROLL
FETCH PROGRESS_CURSOR_SCROLL into @number, @sub ,@idstudent ,@pdate,@note;
print 'Первая выбранная строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number)  +
'. Дисциплина: '+ rtrim(@sub) +
'. ID студента: ' + rtrim(@idstudent) +
'. Дата экзамена: '  + rtrim(@pdate) + 
'. Оценка: ' + rtrim(@note);

FETCH LAST from PROGRESS_CURSOR_SCROLL into @number, @sub ,@idstudent ,@pdate,@note;
print 'Последняя строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number)  +
'. Дисциплина: '+ rtrim(@sub) +
'. ID студента: ' + rtrim(@idstudent) +
'. Дата экзамена: '  + rtrim(@pdate) + 
'. Оценка: ' + rtrim(@note);
close PROGRESS_CURSOR_SCROLL
go 
--5 
use master;
CREATE TABLE #EXAMPLE
(
	ID int identity(1,1),
	WORD varchar(100)
);

INSERT INTO #EXAMPLE values ('Яблоко'),('Груша'),('Апельсин'),('Мандарин'),('Вишня'),('Клубника'),('Клюква');

go
DECLARE @id varchar(10), @word varchar(100);
DECLARE CURRENT_OF_CURSROR CURSOR LOCAL DYNAMIC
	for SELECT * from #EXAMPLE FOR UPDATE;
OPEN CURRENT_OF_CURSROR
fetch CURRENT_OF_CURSROR into @id,@word;
print @id + '-' + @word;
DELETE #EXAMPLE where CURRENT OF CURRENT_OF_CURSROR;
fetch  CURRENT_OF_CURSROR into @id,@word;
UPDATE #EXAMPLE set WORD += ' - updated' where CURRENT OF CURRENT_OF_CURSROR;
close CURRENT_OF_CURSROR;

OPEN CURRENT_OF_CURSROR
while(@@FETCH_STATUS = 0)
	begin
		fetch CURRENT_OF_CURSROR into @id,@word;
		print @id + '-' + @word;
	end;
close CURRENT_OF_CURSROR;

DROP TABLE #EXAMPLE;
go 
--6
use SHU_UNIVER
DECLARE @id varchar(10), @name varchar(100), @subj varchar(50), @note varchar(2);
DECLARE PROGRESS_DELETE_CURSOR CURSOR LOCAL DYNAMIC
	for SELECT STUDENT.IDSTUDENT, STUDENT.NAME, PROGRESS.SUBJECT, PROGRESS.NOTE from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT FOR UPDATE;
OPEN PROGRESS_DELETE_CURSOR
fetch PROGRESS_DELETE_CURSOR into @id,@name,@subj,@note;
if(@note < 4)
			begin
				DELETE PROGRESS where CURRENT OF PROGRESS_DELETE_CURSOR;
			end;
print @id + ' - ' + @name + ' - '+ @subj + ' - ' + @note ;
While (@@FETCH_STATUS = 0)
	begin
		fetch PROGRESS_DELETE_CURSOR into @id,@name,@subj,@note;
		print @id + ' - ' + @name + ' - '+ @subj + ' - ' + @note ;
		if(@note < 4)
			begin
				DELETE PROGRESS where CURRENT OF PROGRESS_DELETE_CURSOR;
			end;
	end;
close PROGRESS_DELETE_CURSOR;

insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
values ('КГ', 1001, '2013-10-01', 2)
go

