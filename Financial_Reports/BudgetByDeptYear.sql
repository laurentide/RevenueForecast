DECLARE @Year Int
DECLARe @Month Int
DECLARE @Department varchar(25)

SET @Year = 2007
Set @Month = 11
SET @Department  = 'Automation'

select CAT.description,
       GL.GL,
       GL.RPTDESC,
       GL.DESCRIPTION,        
       RPTCAT,
	case when gl.description = 'Training' then costofcourse + isnull(montant,0) 
            when gl.description = 'Car rental' then carrental + isnull(montant,0) 
            when gl.description = 'Travel  fares' then fares + isnull(montant,0) 
            when gl.description = 'Travel  hotel' then hotel + isnull(montant,0) 
            when gl.description = 'Meals & entertainment' then meals_entertainment + isnull(montant,0) 
       else isnull(montant,0) end TOTALPLANANNEE,
       case when gl.description = 'Training' then costofcourse + isnull(montant,0) / 12
            when gl.description = 'Car rental' then carrental + isnull(montant,0) /12 
            when gl.description = 'Travel  fares' then fares + isnull(montant,0) /12
            when gl.description = 'Travel  hotel' then hotel + isnull(montant,0)  /12
            when gl.description = 'Meals & entertainment' then meals_entertainment + isnull(montant,0) /12
       else isnull(montant,0) /12 end TOTALPLANAMOIS
       ,'AnneeFY' = dbo.fcGetAnneeTotaldept_DDN(GL.gl, @Year,@Month ,@Department)
       ,'MoisFY' = dbo.fcGetMoisTotaldept_DDN(GL.gl, @Year,@Month,@Department)
from tblgl gl,
     tblMaincat cat,
(select tb.budgetid,
	      sum(costofcourse) as costofcourse , 
              sum(carrental) as carrental, 
              sum(fares) as fares, 
              sum(hotel) as hotel, 
              sum(meals) + sum(entertainment) as meals_entertainment
	 from tbltravelbudget tb,
              tblbudget budg,
              tbldepartement dept
        where budg.budgetid = tb.budgetid
	  and budg.departmentid = dept.departmentid
          and dept.description = @Department
          and Year = @Year + (select multi from yearconvert where mois = @Month)
     group by tb.budgetid) TRAV,
      (select budg.budgetid, 
              nogl,
              sum(isnull(montant,0)) as montant
         from tblcomponents c,
              tblbudget budg,
              tblbudgetdetails dets,
              tbldepartement dept
        where c.detailid    = dets.detailid
          and dets.budgetid = budg.budgetid
          and budg.departmentid = dept.departmentid
          and dept.description = @Department
          and Year = @Year + (select multi from yearconvert where mois = @Month)
     group by budg.budgetid, nogl) BUDG
where   budg.budgetID     = TRAV.budgetid
  and   gl.gl             *= budg.nogl 
  and   gl.catid = cat.catid
  and   cat.catid between 1 and 6
