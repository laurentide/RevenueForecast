declare @Year int
declare @Month int
declare @Department varchar(30)

set @year = 2007
set @month = 11
set @Department = 'Automation'

select YEAR,BUDG.DEPARTMENTID,CATID,BUDG.RPTDESC, sum(totalplanannee), sum(totalplanamois), sum(BHBKVA)
from vBUDGET budg,
     tblnomis gl,
     GLBHCPP NOMS 
where gl.glnomis = SUBSTRING(BHBBTX, 1, 11)
  and gl.nogl = budg.gl
  and SUBSTRING(BHBBTX, 12, 11) = BUDG.DEPARTMENTID
  and BUDG.DEPARTMENT_NAME = @Department
  AND year = @year + (select multi from yearconvert where mois = @Month)
  and noms.bhafcd = (select moisfy from yearconvert where mois = @Month)
  and noms.bhagcd = @year + (select multi from yearconvert where mois = @Month)
group by YEAR,BUDG.DEPARTMENTID,CATID,BUDG.RPTDESC
ORDER BY YEAR,BUDG.DEPARTMENTID,CATID,BUDG.RPTDESC
