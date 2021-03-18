Use SHU_UNIVER
--1
select min(AUDITORIUM_CAPACITY)[����������],
		max(AUDITORIUM_CAPACITY)[������������], 
		avg(AUDITORIUM_CAPACITY)[�������],
		count(*)[�������], 
		sum(AUDITORIUM_CAPACITY)[�����]from AUDITORIUM;
--2
select	AUDITORIUM.AUDITORIUM_TYPE,
		min(AUDITORIUM_CAPACITY)[����������],
		max(AUDITORIUM_CAPACITY)[������������], 
		avg(AUDITORIUM_CAPACITY)[�������],
		count(*)[�������], 
		sum(AUDITORIUM_CAPACITY)[�����]from AUDITORIUM join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
		group by AUDITORIUM.AUDITORIUM_TYPE;
--3 
SELECT *
	FROM(SELECT CASE 
		WHEN NOTE = 10 then '10'
		WHEN NOTE between 8 and 9 then '8-9'
		WHEN NOTE between 6 and 7 then '6-7'
		WHEN NOTE between 4 and 5 then '4-5'
	END [��������],
	COUNT(*) as [���-��]
	FROM PROGRESS GROUP BY CASE
		WHEN NOTE = 10 then '10'
		WHEN NOTE between 8 and 9 then '8-9'
		WHEN NOTE between 6 and 7 then '6-7'
		WHEN NOTE between 4 and 5 then '4-5'
	END) AS T
ORDER BY Case [��������]
	WHEN '10' then 4
	WHEN '8-9' then 3
	WHEN '6-7' then 2
	WHEN '4-5' then 1
	ELSE 0
	END;
--4
select f.FACULTY,
	   g.PROFESSION,
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) [AVG NOTE]
from ((FACULTY f inner join GROUPS g on f.FACULTY = g.FACULTY)
inner join STUDENT on g.IDGROUP = STUDENT.IDGROUP) 
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.SUBJECT = '����' or PROGRESS.SUBJECT = '����'
group by f.FACULTY,
		 g.PROFESSION
--5
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY ROLLUP (GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT);
--6
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY CUBE (GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT)
--7
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
UNION
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
--7.2
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
UNION ALL
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
--8
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
INTERSECT
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
--9
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('���')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
EXCEPT
SELECT	GROUPS.FACULTY [���������],
		GROUPS.PROFESSION [�������������],
		PROGRESS.SUBJECT [�������],
		round(avg(cast(PROGRESS.NOTE AS float(4))), 2) [������� ����]
	FROM GROUPS, STUDENT, PROFESSION, PROGRESS
	WHERE GROUPS.FACULTY in ('����')
	GROUP BY GROUPS.FACULTY,
			 GROUPS.PROFESSION, 
			 PROGRESS.SUBJECT
--10
select p1.SUBJECT as '�������', 
	p1.NOTE as '������', 
	(select count(*) from PROGRESS p2
	where p2.SUBJECT = p1.SUBJECT and p2.NOTE = p1.NOTE) as '���-�� ����������'
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE in (8, 9)