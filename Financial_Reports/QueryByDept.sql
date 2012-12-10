select GL.GL,
       GL.RPTDESC,
       GL.DESCRIPTION, 
       DEPT.description,
       RPTCAT, 
       case when gl.description = 'Training' then costofcourse + montant 
            when gl.description = 'Car rental' then carrental + montant 
            when gl.description = 'Travel  fares' then fares + montant 
            when gl.description = 'Travel  hotel' then hotel + montant 
            when gl.description = 'Meals & entertainment' then meals_entertainment + montant 
       else montant end TOTALPLANANNEE,
       case when gl.description = 'Training' then costofcourse + montant / 12
            when gl.description = 'Car rental' then carrental + montant /12 
            when gl.description = 'Travel  fares' then fares + montant /12
            when gl.description = 'Travel  hotel' then hotel + montant  /12
            when gl.description = 'Meals & entertainment' then meals_entertainment + montant /12
       else montant /12 end TOTALPLANAMOIS
       ,'AnneeFY' = dbo.fcGetAnneeTotaldept(GL.rptdesc, 2008,01 ,'Engineering')
       ,'MoisFY' = dbo.fcGetMoisTotaldept(GL.rptdesc, 2008,01,'Engineering') 
 from tblGL            GL,
      tblMainCat       CAT,
      tbldepartement   DEPT,
      (select budgetid,
	      sum(costofcourse) as costofcourse , 
              sum(carrental) as carrental, 
              sum(fares) as fares, 
              sum(hotel) as hotel, 
              sum(meals) + sum(entertainment) as meals_entertainment
	 from tbltravelbudget
     group by budgetid) TRAV,
      (select departmentid,
              budg.budgetid, 
              nogl, 
              sum(montant) as montant
         from tblcomponents c,
              tblbudget budg,
              tblbudgetdetails dets
        where c.detailid    = dets.detailid
          and dets.budgetid = budg.budgetid
          and budg.year     = 2008 + (select multi * -1 from yearconvert where mois = 01)
     group by departmentid, budg.budgetid, nogl) BUDG
--,      (select department,
--              gl,
--              isnull(sum(total),0) as totalnomisannee   
--         from VglNomisRapportDept Nomis
--        where fy = 2007 + (Select multi * - 1 from yearconvert where mois = 9)
--          and mois <= (select moisfy from yearconvert where mois = 9)
-- 	group by department,gl) Nomis
where GL.catID          = CAT.CatID
  and GL.GL             *= budg.nogl 
  and BUDG.departmentid = DEPT.departmentid
  and budg.budgetID     = TRAV.budgetid
  and CAT.CatID between 1 and 6  
  and DEPT.description  = 'Engineering'
--   and DEPT.departmentid = NOMIS.department
--  and  GL.GL             = NOMIS.gl
order by GL.GL
		
 
