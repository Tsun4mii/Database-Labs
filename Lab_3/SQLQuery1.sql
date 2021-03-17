Use master 
Create database Shust_Univer;

Use Shust_Univer;

Create table Student
(
	�����_������� nvarchar(10) primary key,
	�������_�������� nvarchar(20) not null, 
	�����_������ int
);

ALTER Table Student ADD ����_�������� date;
Alter table Student add ��� nchar(1) default '�'check (��� in ('�','�'));
Alter table Student add ����_����������� date;

INSERT into Student(�����_�������, �������_��������, �����_������, ����_��������, ���, ����_�����������)
Values(7654903, '����', 4, '2002-5-17', '�', '2019-8-6'),
(7340533, '��������', 4, '2001-3-12', '�', '2019-7-30'), 
(2349854, '�����', 7, '2001-6-24', '�', '2019-7-30'),
(5643234, '������', 4, '2000-4-7', '�', '2019-7-30'),
(5784634, '��������', 4, '2001-3-6', '�', '2019-8-6');

Select * From Student;
Select COUNT(*) [����� ���������] From Student;
Select distinct top(5) �������_�������� [�� �����������] From Student;

Update Student Set �����_������ = 5; 
Delete from Student Where �����_������� = 7340533;
Select * From Student;

Select �������_��������, ����_�������� From Student Where (����_�������� < CONVERT(date, '2001-06-30')) And ����_�������� > CONVERT(date, '2000-04-08');

CREATE Table RESULTS
(	�������_ID int primary key identity(1, 1),
     ���_�������� nvarchar(20),
     �����_��� int,
     ������_���������� int,
     ������_���� int,
     �������_���� as (�����_��� + ������_���������� + ������_����)/3
)

INSERT into RESULTS(���_��������, �����_���, ������_����������, ������_����)
Values('����', 7 , 8, 8),
('�������', 5, 4, 3)

SELECT * from RESULTS;
