declare @month int
declare @year int
declare @department varchar(25)

set @month = 11
set @year = 2007
set @Department = 'Engineering'

SELECT rptcat, 
            rptdesc,
            department_name, 
	sum(totalplanannee) as totalplanannee , 
              sum(totalplanamois) as totalplanamois, 
              sum(month_amount) as month_amount ,
              sum(ytd) as ytd
from vnomis NOMS, vbudget BUDG
where BUDG.YEAR = NOMS.YEAR
  AND BUDG.GL = NOMS.GL
  AND NOMS.DEPARTMENTID = BUDG.DEPARTMENTID
  AND MONTH = (SELECT MOISFY FROM YEARCONVERT WHERE MOIS = @Month)
  AND NOMS.YEAR  = @Year + (SELECT MULTI FROM YEARCONVERT WHERE MOIS = @Month)
  AND Department_Name = @Department
group by  rptcat, rptdesc,department_name