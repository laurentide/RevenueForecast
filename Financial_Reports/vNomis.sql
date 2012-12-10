drop view vNomis

CREATE VIEW vNomis
as
SELECT A.GL,
       A.DEPARTMENTID,
       A.MONTH,
       A.YEAR,
       MONTH_AMOUNT,
       YTD
FROM   (SELECT   CART_JOIN.NOGL          AS GL,
                 CART_JOIN.DEPARTMENTID,
                 CART_JOIN.BHAFCD        AS MONTH,
                 CART_JOIN.BHAGCD        AS YEAR,
                 ISNULL(SUM(BHBKVA),0)   AS MONTH_AMOUNT
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
                 AND NOMS.BHAFCD =* CART_JOIN.BHAFCD
                 AND NOMS.BHAGCD =* CART_JOIN.BHAGCD
        GROUP BY CART_JOIN.NOGL,CART_JOIN.DEPARTMENTID,CART_JOIN.BHAFCD,CART_JOIN.BHAGCD) A,
       (SELECT   CART_JOIN.NOGL          GL,
                 CART_JOIN.DEPARTMENTID,
                 CART_JOIN.BHAGCD        AS YEAR,
                 ISNULL(SUM(BHBKVA),0)   AS YTD
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
        GROUP BY CART_JOIN.NOGL,CART_JOIN.DEPARTMENTID,CART_JOIN.BHAGCD) B
WHERE  A.GL = B.GL
       AND A.DEPARTMENTID = B.DEPARTMENTID
       AND A.YEAR = B.YEAR
