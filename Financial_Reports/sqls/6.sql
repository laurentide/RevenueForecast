SELECT     substring(BHBBTX,1,11) as GL,
	   SUBSTRING(BHBBTX, 12, 11) AS Department, 
           BHAGCD as year, 
           BHAFCD as month,
	   BHAQNA AS GL_Description,
	   SUM(BHBKVA) AS Amount
FROM       GLBHCPP NOMS,
	   tblNomis GL
where substring(BHBBTX,1,11) =* GL.GLNOMIS
group by   SUBSTRING(BHBBTX,1,11),
	   SUBSTRING(BHBBTX, 12, 11),
           BHAGCD,
           BHAFCD,
	   BHAQNA
ORDER BY YEAR,MONTH,DEPARTMENT