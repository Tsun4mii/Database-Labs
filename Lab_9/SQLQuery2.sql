use SHU_UNIVER

--1
print '---------------1-------------'
DECLARE @c char ='a',
		@v varchar(4)='����',
		@d datetime,
		@t time,
		@i int,			
		@s smallint,
		@ti tinyint,
		@n numeric(12,5);
SET @d=GETDATE();
SELECT @t='12:59:34.21';
SELECT @c c, @v v, @d d, @t t;
SELECT @s=345, @ti=1, @n=1234567.12345;
print @s;print @ti;print @n;

--2
DECLARE @var1 int 
DECLARE @var2 int 
DECLARE @var3 int 
DECLARE @var4 int 
SELECT @var1 = SUM(AUDITORIUM_CAPACITY) FROM AUDITORIUM 
if @var1 > 200 
begin 
	select	@var2 = (select COUNT(*) as [���-��] from AUDITORIUM), 
			@var3 = (select AVG(AUDITORIUM_CAPACITY) as [�����������] FROM AUDITORIUM) 
	set		@var4 = (select COUNT(*) as [���-��] from AUDITORIUM 
					where AUDITORIUM_CAPACITY < @var3) 
	select @var2 '���-�� ���.', @var3 '������� �����������',
			@var4 '������ �������� ���.< AVR',			
			100*(cast(@var4 as float)/cast(@var2 as float)) '% ���.< AVR'			
end 
else select @var1;

--3
print '-------------3------------'
print '����� ������������ �����: ' +										cast(@@ROWCOUNT as varchar);
print '������ SQL Server: ' +												@@VERSION  ;
print '��������� ������������� �������� ' +
	  '����������� �������� �������� �����������: ' +						cast(@@SPID  as varchar);
print '��� ��������� ������: ' +											cast(@@ERROR as varchar);	
print '��� �������: ' +														@@SERVERNAME  ;
print '������� ����������� ����������: ' +									cast(@@TRANCOUNT as varchar);
print '�������� ���������� ���������� ����� ��������������� ������: ' +		cast(@@FETCH_STATUS as varchar);
print '������� ����������� ������� ���������: ' +							cast(@@NESTLEVEL as varchar);

--4
print '------------4----------'
declare @tt int=3, @x float=4, @z float;
if (@tt>@x) set @z=power(SIN(@tt),2);
if (@tt<@x) set @z=4*(@tt+@x);
if (@tt=@x) set @z=1-exp(@x-2);
print 'z='+cast(@z as varchar(10));

declare @ss varchar(100)=(select top 1 NAME from STUDENT) --?????????
select substring(@ss, 1, charindex(' ', @ss))
		+substring(@ss, charindex(' ', @ss)+1,1)+'.'
		+substring(@ss, charindex(' ', @ss, charindex(' ', @ss)+1)+1,1)+'.'

select NAME as '���', DATEDIFF(YEAR,BDAY,GETDATE()) as '�������'		
	from STUDENT
	where MONTH(BDAY)=MONTH(getdate())+1;

select * from (select *,
						(CASE 
							when DATEPART(weekday,PDATE) = 1 then '�����������'
							when DATEPART(weekday,PDATE) = 2 then '�������'
							when DATEPART(weekday,PDATE) = 3 then '�����'
							when DATEPART(weekday,PDATE) = 4 then '�������'
							when DATEPART(weekday,PDATE) = 5 then '�������'
							when DATEPART(weekday,PDATE) = 6 then '�������'
							when DATEPART(weekday,PDATE) = 7 then '�����������'
						end) [���� ������] from PROGRESS where [SUBJECT] like '%����%') as tr;

--5


--6
SELECT IDSTUDENT,
		CASE 
			WHEN avg (PROGRESS.NOTE) = 4 then '��������� �� ��������' 
			WHEN avg (PROGRESS.NOTE) between 5 and 6 then '����������� 1.2' 
			WHEN avg (PROGRESS.NOTE) between 7 and 8 then '����������� 1.3' 
			WHEN avg (PROGRESS.NOTE) between 9 and 10 then '����������� 1.4' 
			else '��� ���������'
		end [��������� ���������]
		FROM PROGRESS
		GROUP BY IDSTUDENT 

--7
DROP TABLE #temp;
CREATE TABLE #temp
		(
			ID int identity(1,1),
			RANDOM_NUMBER int,
			WORD varchar(50) default '�������� ��-���������'
		);

DECLARE  @iter int = 0;
WHILE @iter < 10
	begin
	INSERT #temp(RANDOM_NUMBER)
			values(rand() * 1000);
	SET @iter = @iter + 1;
	end
SELECT * from #temp;

--9
print '-------------9------------'
begin TRY
	declare @sdfsd int = 3
	Select * from STUDENT where STUDENT.BDAY =  @sdfsd;
end TRY
begin CATCH
	print ERROR_NUMBER()	
	print ERROR_MESSAGE()	
	print ERROR_LINE()		
	print ERROR_PROCEDURE()	
	print ERROR_SEVERITY()	
	print ERROR_STATE()		
end CATCH


--8
print '-------------8--------------'
declare @xx int=1;
print @xx+1
print @xx+2
RETURN
print @xx+3