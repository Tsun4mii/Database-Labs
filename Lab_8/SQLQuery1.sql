use SHU_UNIVER
--1
drop view �������������2
go
create view �������������2
		as select TEACHER.TEACHER [���],
			TEACHER.TEACHER_NAME [���],
			TEACHER.GENDER [���],
			TEACHER.PULPIT [�������]
		from TEACHER
go
select * from �������������2 order by �������
--2
drop view ����������_������
go
create view ����������_������
		as select FACULTY.FACULTY_NAME [���������],
			count(PULPIT.FACULTY) [����������]
		from FACULTY inner join PULPIT
			on FACULTY.FACULTY = PULPIT.FACULTY
		group by FACULTY.FACULTY_NAME
go
select * from ����������_������
--3
drop view ���������
go 
create view ���������
		as select AUDITORIUM [���], AUDITORIUM_TYPE [������������]
		from AUDITORIUM 
		where AUDITORIUM_TYPE like '��%'
go 
select * from ���������

--insert into ��������� values('200-3a','��')
--select * from ���������
--4
drop view ���������_2
go
create view ���������_2
		as select AUDITORIUM [���], AUDITORIUM_TYPE [������������]
		from AUDITORIUM 
		where AUDITORIUM_TYPE like '��%' with check option
go 
--insert into ���������_2 values ('test', '��-�')
select * from ���������_2
--5
drop view ����������
go
create view ����������
		as select top(3) SUBJECT, SUBJECT_NAME, PULPIT
		from SUBJECT
		order by SUBJECT
go
select * from ����������
--6
go
alter view ����������_������ with schemabinding
		as select FACULTY.FACULTY_NAME [���������],
			count(PULPIT.FACULTY) [����������]
		from dbo.FACULTY join dbo.PULPIT
			on FACULTY.FACULTY = PULPIT.FACULTY
		group by FACULTY.FACULTY_NAME
go
select * from ����������_������