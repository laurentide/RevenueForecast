       (SELECT   CART_JOIN.NOGL          GL,
                 CART_JOIN.DEPARTMENTID,
                 CART_JOIN.BHAGCD        AS YEAR,
                 CART_JOIN.BHAFCD        AS MONTH,
                 --ISNULL(SUM(BHBKVA),0)   AS YTD
		 BHBKVA
        FROM     GLBHCPP NOMS,
                 (SELECT GLNOMIS,
                         NOGL,
                         DEPARTMENTID,
                         BHAFCD,
                         BHAGCD
                  FROM   (SELECT DISTINCT BHAFCD,
                                          BHAGCD
                          FROM   GLBHCPP) A,
                         TBLNOMIS NOGL,
                         TBLDEPARTEMENT DEPT) CART_JOIN
        WHERE    SUBSTRING(BHBBTX,1,11) =* CART_JOIN.GLNOMIS
                 AND SUBSTRING(BHBBTX,12,11) =* CART_JOIN.DEPARTMENTID
                 AND NOMS.BHAGCD =* CART_JOIN.BHAGCD
		 AND NOMS.BHAFCD =* CART_JOIN.BHAFCD
		 and departmentid = '4.0.000.000'
		-- and NOMS.BHAFCD= 02
	         and NOMS.BHAGCD = 2008
	         and NOGL = '08.0800710.')
--        GROUP BY CART_JOIN.NOGL,CART_JOIN.DEPARTMENTID,CART_JOIN.BHAGCD)