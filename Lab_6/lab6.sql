use SHU_UNIVER
--1
SELECT PULPIT.PULPIT_NAME as 'Кафедра', FACULTY_NAME as 'Факультет'
FROM FACULTY, PULPIT
WHERE PULPIT.FACULTY = FACULTY.FACULTY
and PULPIT.FACULTY In (SELECT PROFESSION.FACULTY FROM PROFESSION
							  WHERE PROFESSION_NAME like '%технология%' or PROFESSION_NAME like '%технологии%' )
--2
SELECT PULPIT.PULPIT_NAME as 'Кафедра', FACULTY_NAME as 'Факультет'
from PULPIT inner join FACULTY 
	on PULPIT.FACULTY = FACULTY.FACULTY 
	and 
	PULPIT.FACULTY In (SELECT PROFESSION.FACULTY FROM PROFESSION
							  WHERE PROFESSION_NAME like '%технологии%' or PROFESSION_NAME like '%технология%' )
--3
SELECT distinct PULPIT.PULPIT_NAME as 'Кафедра', FACULTY_NAME as 'Факультет'
	FROM PULPIT
	inner join PROFESSION 
		on  (PROFESSION.PROFESSION_NAME like '%технологии%' or PROFESSION.PROFESSION_NAME like '%технология%')
	inner join FACULTY
		on PROFESSION.FACULTY = FACULTY.FACULTY and PROFESSION.FACULTY = PULPIT.FACULTY 
--4
select	AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY
from AUDITORIUM a	
	where AUDITORIUM_NAME = (select top(1) AUDITORIUM_NAME from AUDITORIUM aa
		where aa.AUDITORIUM_TYPE= a.AUDITORIUM_TYPE
			order by AUDITORIUM_CAPACITY desc) order by AUDITORIUM_CAPACITY desc
--5
SELECT FACULTY.FACULTY_NAME as 'Факультет'
FROM FACULTY
	WHERE  NOT EXISTS (SELECT * FROM PULPIT
						WHERE PULPIT.FACULTY = FACULTY.FACULTY);
--6
select top 1
(select avg(NOTE) from PROGRESS
	where SUBJECT like 'ОАиП')[ОАиП],
(select avg(NOTE) from PROGRESS
	where SUBJECT like 'КГ')[КГиГ], 
(select avg(NOTE) from PROGRESS
	where SUBJECT like 'СУБД')[СУБД]
from PROGRESS
--7
select SUBJECT, NOTE from PROGRESS
	where NOTE >=all (select NOTE from PROGRESS
		where SUBJECT like 'c%')
--8
select SUBJECT, NOTE from PROGRESS
	where NOTE >any (select NOTE from PROGRESS
		where SUBJECT like 'С%')
--10
select IDSTUDENT, IDGROUP, NAME, BDAY from STUDENT a
	where BDAY in ( select BDAY from STUDENT aa
		group by BDAY
		having count(BDAY)>=2)