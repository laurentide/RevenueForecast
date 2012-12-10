/* Powered by General SQL Parser (www.sqlparser.com) */

SELECT A.GL,
       A.DEPARTMENTID,
       A.MOIS,
       A.YEAR,
       A.AMOUT        AS MONTHLY_AMOUNT,
       B.AMOUNT       AS YTD
FROM   (SELECT   CART_JOIN.NOGL              AS GL,
                 CART_JOIN.DEPARTMENTID,
                 CART_JOIN.BHAFCD            AS MOIS,
                 CART_JOIN.BHAGCD            AS [YEAR],
                 ISNULL(SUM(NOMS.BHBKVA),0)  AS AMOUNT
        FROM     DBO.GLBHCPP NOMS
                 RIGHT OUTER JOIN (SELECT GLNOMIS,
                                          NOGL,
                                          DEPARTMENTID,
                                          BHAFCD,
                                          BHAGCD
                                   FROM   (SELECT DISTINCT BHAFCD,
                                                           BHAGCD
                                           FROM   GLBHCPP) A,
                                          TBLNOMIS NOGL,
                                          TBLDEPARTEMENT DEPT) CART_JOIN
                   ON SUBSTRING(NOMS.BHBBTX,1,11) = CART_JOIN.GLNOMIS
                      AND SUBSTRING(NOMS.BHBBTX,12,11) = CART_JOIN.DEPARTMENTID
                      AND NOMS.BHAFCD = CART_JOIN.BHAFCD
                      AND NOMS.BHAGCD = CART_JOIN.BHAGCD
        GROUP BY CART_JOIN.NOGL,CART_JOIN.DEPARTMENTID,CART_JOIN.BHAFCD,CART_JOIN.BHAGCD) A,
       (SELECT   CART_JOIN.NOGL          GL,
                 CART_JOIN.DEPARTMENTID,
                 CART_JOIN.BHAGCD        AS YEAR,
                 ISNULL(SUM(BHBKVA),0)   AS AMOUNT
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
        GROUP BY CART_JOIN.NOGL,CART_JOIN.DEPARTMENTID,CART_JOIN.BHAGCD) B
WHERE  A.GL = B.GL
       AND A.DEPARTMENTID = B.DEPARTMENTID
       AND A.YEAR = B.YEAR