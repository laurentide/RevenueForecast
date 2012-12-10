/* Powered by General SQL Parser (www.sqlparser.com) */

DECLARE  @Year INT

DECLARE  @Month INT

DECLARE  @Department VARCHAR(30)
                     
SET @year = 2007

SET @month = 11

SET @Department = 'Engineering'
                  
SELECT DEPARTMENT_NAME,
       CATID,
       RPTCAT,
       RPTID,
       RPTDESC,
       SUM(TOTALPLANANNEE),
       SUM(TOTALPLANAMOIS),
       SUM(CASE 
             WHEN AMOUNT IS NULL THEN 0
             ELSE AMOUNT
           END) AS NOMIS_AMOUNT
FROM   (SELECT   YEAR,
                 DEPT.DEPARTMENTID,
                 DEPT.DESCRIPTION         AS DEPARTMENT_NAME,
                 CATID,
                 RPTCAT,
                 RPTDESC,
                 RPTID,
                 GL,
                 A.DESCRIPTION,
                 SUM(TOTALPLANANNEE)      AS TOTALPLANANNEE,
                 SUM(TOTALPLANAMOIS)      AS TOTALPLANAMOIS
        FROM     (SELECT GL.RPTDESC,
                         GL.RPTID,
                         CAT.CATID,
                         RPTCAT,
                         GL.GL,
                         GL.DESCRIPTION,
                         TRAV.DEPARTMENTID,
                         TRAV.YEAR,
                         CASE 
                           WHEN GL.DESCRIPTION = 'Training' THEN COSTOFCOURSE + ISNULL(MONTANT,0)
                           WHEN GL.DESCRIPTION = 'Car rental' THEN CARRENTAL + ISNULL(MONTANT,0)
                           WHEN GL.DESCRIPTION = 'Travel  fares' THEN FARES + ISNULL(MONTANT,0)
                           WHEN GL.DESCRIPTION = 'Travel  hotel' THEN HOTEL + ISNULL(MONTANT,0)
                           WHEN GL.DESCRIPTION = 'Meals & entertainment' THEN MEALS_ENTERTAINMENT + ISNULL(MONTANT,0)
                           ELSE ISNULL(MONTANT,0)
                         END TOTALPLANANNEE,
                         CASE 
                           WHEN GL.DESCRIPTION = 'Training' THEN COSTOFCOURSE + ISNULL(MONTANT,0) / 12
                           WHEN GL.DESCRIPTION = 'Car rental' THEN CARRENTAL + ISNULL(MONTANT,0) / 12
                           WHEN GL.DESCRIPTION = 'Travel  fares' THEN FARES + ISNULL(MONTANT,0) / 12
                           WHEN GL.DESCRIPTION = 'Travel  hotel' THEN HOTEL + ISNULL(MONTANT,0) / 12
                           WHEN GL.DESCRIPTION = 'Meals & entertainment' THEN MEALS_ENTERTAINMENT + ISNULL(MONTANT,0) / 12
                           ELSE ISNULL(MONTANT,0) / 12
                         END TOTALPLANAMOIS
                  FROM   TBLGL GL,
                         TBLMAINCAT CAT,
                         (SELECT   TB.BUDGETID,
                                   DEPT.DEPARTMENTID,
                                   YEAR,
                                   SUM(COSTOFCOURSE)                    AS COSTOFCOURSE,
                                   SUM(CARRENTAL)                       AS CARRENTAL,
                                   SUM(FARES)                           AS FARES,
                                   SUM(HOTEL)                           AS HOTEL,
                                   SUM(MEALS) + SUM(ENTERTAINMENT)      AS MEALS_ENTERTAINMENT
                          FROM     TBLTRAVELBUDGET TB,
                                   TBLBUDGET BUDG,
                                   TBLDEPARTEMENT DEPT
                          WHERE    BUDG.BUDGETID = TB.BUDGETID
                                   AND BUDG.DEPARTMENTID = DEPT.DEPARTMENTID
                          GROUP BY TB.BUDGETID,DEPT.DEPARTMENTID,YEAR) TRAV,
                         (SELECT   BUDG.BUDGETID,
                                   DEPT.DEPARTMENTID,
                                   NOGL,
                                   YEAR,
                                   SUM(ISNULL(MONTANT,0))        AS MONTANT
                          FROM     TBLCOMPONENTS C,
                                   TBLBUDGET BUDG,
                                   TBLBUDGETDETAILS DETS,
                                   TBLDEPARTEMENT DEPT
                          WHERE    C.DETAILID = DETS.DETAILID
                                   AND DETS.BUDGETID = BUDG.BUDGETID
                                   AND BUDG.DEPARTMENTID = DEPT.DEPARTMENTID
                          GROUP BY BUDG.BUDGETID,DEPT.DEPARTMENTID,YEAR,DETS.NOGL) BUDG
                  WHERE  BUDG.BUDGETID = TRAV.BUDGETID
                         AND GL.GL *= BUDG.NOGL
                         AND GL.CATID = CAT.CATID
                         AND CAT.CATID BETWEEN 1 AND 6
                         AND BUDG.DEPARTMENTID = TRAV.DEPARTMENTID) A,
                 TBLDEPARTEMENT DEPT
        WHERE    A.DEPARTMENTID = DEPT.DEPARTMENTID
        GROUP BY CATID,RPTCAT,RPTDESC,DEPT.DEPARTMENTID,
                 RPTID,DEPT.DESCRIPTION,YEAR,GL,
                 A.DESCRIPTION) BUDG,
       (SELECT   NOGL.NOGL,
                 SUBSTRING(BHBBTX,12,11)    AS DEPARTMENTID,
                 BHAFCD,
                 BHAGCD,
                 SUM(BHBKVA)                AS AMOUNT
        FROM     GLBHCPP NOMS,
                 TBLNOMIS NOGL
        WHERE    SUBSTRING(BHBBTX,1,11) = NOGL.GLNOMIS
        GROUP BY NOGL.NOGL,SUBSTRING(BHBBTX,12,11),BHAFCD,BHAGCD) NOMIS
WHERE  NOMIS.DEPARTMENTID = BUDG.DEPARTMENTID
       AND NOMIS.NOGL =* BUDG.GL
       AND BUDG.DEPARTMENT_NAME = @Department
       AND YEAR = @year + (SELECT MULTI
                           FROM   YEARCONVERT
                           WHERE  MOIS = @Month)
       AND BHAFCD = (SELECT MOISFY
                     FROM   YEARCONVERT
                     WHERE  MOIS = @Month)
       AND BHAGCD = @year + (SELECT MULTI
                             FROM   YEARCONVERT
                             WHERE  MOIS = @Month)
GROUP BY DEPARTMENT_NAME,CATID,RPTCAT,RPTID,RPTDESC
ORDER BY CATID,RPTID