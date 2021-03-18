use SHU_UNIVER
--1
drop view Преподаватель2
go
create view Преподаватель2
		as select TEACHER.TEACHER [код],
			TEACHER.TEACHER_NAME [имя],
			TEACHER.GENDER [пол],
			TEACHER.PULPIT [кафедра]
		from TEACHER
go
select * from Преподаватель2 order by кафедра
--2
drop view Количество_кафедр
go
create view Количество_кафедр
		as select FACULTY.FACULTY_NAME [факультет],
			count(PULPIT.FACULTY) [количество]
		from FACULTY inner join PULPIT
			on FACULTY.FACULTY = PULPIT.FACULTY
		group by FACULTY.FACULTY_NAME
go
select * from Количество_кафедр
--3
drop view Аудитории
go 
create view Аудитории
		as select AUDITORIUM [Код], AUDITORIUM_TYPE [Наименование]
		from AUDITORIUM 
		where AUDITORIUM_TYPE like 'ЛК%'
go 
select * from Аудитории

--insert into Аудитории values('200-3a','ЛК')
--select * from Аудитории
--4
drop view Аудитории_2
go
create view Аудитории_2
		as select AUDITORIUM [Код], AUDITORIUM_TYPE [Наименование]
		from AUDITORIUM 
		where AUDITORIUM_TYPE like 'ЛК%' with check option
go 
--insert into Аудитории_2 values ('test', 'ЛБ-К')
select * from Аудитории_2
--5
drop view Дисциплины
go
create view Дисциплины
		as select top(3) SUBJECT, SUBJECT_NAME, PULPIT
		from SUBJECT
		order by SUBJECT
go
select * from Дисциплины
--6
go
alter view Количество_кафедр with schemabinding
		as select FACULTY.FACULTY_NAME [факультет],
			count(PULPIT.FACULTY) [количество]
		from dbo.FACULTY join dbo.PULPIT
			on FACULTY.FACULTY = PULPIT.FACULTY
		group by FACULTY.FACULTY_NAME
go
select * from Количество_кафедр