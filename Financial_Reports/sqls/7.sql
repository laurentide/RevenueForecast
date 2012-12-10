declare @month int
declare @year int
declare @department varchar(25)

set @month = 11
set @year = 2007
set @Department = 'Engineering'

select * from vnomis NOMS, vbudget BUDG
where BUDG.YEAR = NOMS.YEAR
  AND BUDG.GL = NOMS.GL
  AND NOMS.DEPARTMENTID = BUDG.DEPARTMENTID
  AND MONTH = (SELECT MOISFY FROM YEARCONVERT WHERE MOIS = @Month)
  AND NOMS.YEAR  = @Year + (SELECT MULTI FROM YEARCONVERT WHERE MOIS = @Month)
  AND Department_Name = @Department
order by rptdesc