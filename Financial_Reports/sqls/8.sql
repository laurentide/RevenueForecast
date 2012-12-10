declare @month int
declare @year int
declare @department varchar(25)

set @month = 11
set @year = 2007
set @Department = 'Engineering'


select * from vnomis
where departmentid = '4.0.000.000'
and month= 02
and year = 2008
and gl = '08.0800710.'