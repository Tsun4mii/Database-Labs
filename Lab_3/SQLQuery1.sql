Use master 
Create database Shust_Univer;

Use Shust_Univer;

Create table Student
(
	Номер_зачетки nvarchar(10) primary key,
	Фамилия_студента nvarchar(20) not null, 
	Номер_группы int
);

ALTER Table Student ADD Дата_Рождения date;
Alter table Student add Пол nchar(1) default 'м'check (Пол in ('м','ж'));
Alter table Student add Дата_поступления date;

INSERT into Student(Номер_зачетки, Фамилия_студента, Номер_группы, Дата_Рождения, Пол, Дата_поступления)
Values(7654903, 'Шуст', 4, '2002-5-17', 'м', '2019-8-6'),
(7340533, 'Батурель', 4, '2001-3-12', 'м', '2019-7-30'), 
(2349854, 'Авдей', 7, '2001-6-24', 'м', '2019-7-30'),
(5643234, 'Губарь', 4, '2000-4-7', 'ж', '2019-7-30'),
(5784634, 'Качанова', 4, '2001-3-6', 'ж', '2019-8-6');

Select * From Student;
Select COUNT(*) [Всего студентов] From Student;
Select distinct top(5) Фамилия_студента [По возрастанию] From Student;

Update Student Set Номер_группы = 5; 
Delete from Student Where Номер_зачетки = 7340533;
Select * From Student;

Select Фамилия_студента, Дата_Рождения From Student Where (Дата_Рождения < CONVERT(date, '2001-06-30')) And Дата_Рождения > CONVERT(date, '2000-04-08');

CREATE Table RESULTS
(	Студент_ID int primary key identity(1, 1),
     Имя_студента nvarchar(20),
     Оцена_ООП int,
     Оценка_Математика int,
     Оценка_КСИС int,
     Средний_балл as (Оцена_ООП + Оценка_Математика + Оценка_КСИС)/3
)

INSERT into RESULTS(Имя_студента, Оцена_ООП, Оценка_Математика, Оценка_КСИС)
Values('Юрий', 7 , 8, 8),
('Алексей', 5, 4, 3)

SELECT * from RESULTS;
