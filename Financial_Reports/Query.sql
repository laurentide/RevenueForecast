SELECT *
	FROM TBLGL GL,
	     TBLMAINCAT CAT,
	     TBLCOMPONENTS COMP, 
	     TBLBUDGETDETAILS DETS, 
	     TBLBUDGET BUDG, 
	     TBLTRAVELBUDGET TRAV,
	     VGLNOMISRAPPORTDEPT DEPT	
	WHERE GL.CATID = CAT.CATID
	AND GL.GL = DETS.NOGL
	AND COMP.DETAILID = DETS.DETAILID
	AND DEPT.RPTDESC = GL.RPTDESC
	AND DEPARTMENTID  = '3.0.000.000'
	AND CAT.CATID BETWEEN 1 AND 6


SELECT GL.GL, case when gl.description = 'Training' then costofcourse + montant 
		           when gl.description = 'Car rental' then carrental + montant 
		           when gl.description = 'Travel  fares' then fares + montant 
		           when gl.description = 'Travel  hotel' then hotel + montant 
		           when gl.description = 'Meals & entertainment' then meals+ entertainment + montant 
	               else montant end TOTALPLANANNEE