declare @month int
declare @year int
declare @department varchar(25)

set @month = 11
set @year = 2007
set @Department = 'Engineering'

SELECT rptcat, 
       rptdesc,
       department_name,
       BUDG.YEAR,
       NOMS.YEAR,
       NOMS.MONTH, 
       sum(month_amount)   MONTH_ACTUAL,
       sum(totalplanamois) MONTH_PLAN,
       sum(ytd)            YEAR_ACTUAL,
       sum(totalplanamois) * convert(money,NOMS.MONTH)  YEAR_PLAN
from vnomis NOMS, vbudget BUDG
where BUDG.YEAR = NOMS.YEAR
  AND BUDG.GL = NOMS.GL
  AND NOMS.DEPARTMENTID = BUDG.DEPARTMENTID
  AND MONTH = (SELECT MOISFY FROM YEARCONVERT WHERE MOIS = @Month)
  AND NOMS.YEAR  = @Year + (SELECT MULTI FROM YEARCONVERT WHERE MOIS = @Month)
  AND Department_Name = @Department
group by  rptcat, 
       rptdesc,
       department_name,
       BUDG.YEAR,
       NOMS.YEAR,
       NOMS.MONTH
order by rptcat, rptdesc,department_name
