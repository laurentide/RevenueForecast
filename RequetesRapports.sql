USE LCLADMIN

--===========================REQUETE RAPPORT================================================

SELECT     gldes, SUM(Month) AS Mois, SUM(Total) AS Total, rptcat, rptID
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, CASE WHEN M.CatID = 1 THEN ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) / 12 ELSE (ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) + CASE WHEN G.description LIKE 'Training' THEN
                                                  (SELECT     SUM(T .costofcourse)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Car rental' THEN
                                                  (SELECT     SUM(T .Carrental)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  fares' THEN
                                                  (SELECT     SUM(T .Fares)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  hotel' THEN
                                                  (SELECT     SUM(T .Hotel)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Meals & entertainment' THEN
                                                  (SELECT     SUM(T .Meals) + SUM(T .Entertainment)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) ELSE 0 END) / 12 * - 1 END AS Month, CASE WHEN M.CatID = 1 THEN ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) ELSE (ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) + CASE WHEN G.description LIKE 'Training' THEN
                                                  (SELECT     SUM(T .costofcourse)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Car rental' THEN
                                                  (SELECT     SUM(T .Carrental)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  fares' THEN
                                                  (SELECT     SUM(T .Fares)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  hotel' THEN
                                                  (SELECT     SUM(T .Hotel)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Meals & entertainment' THEN
                                                  (SELECT     SUM(T .Meals) + SUM(T .Entertainment)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) ELSE 0 END) * - 1 END AS Total, G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
GROUP BY rptcat, gldes, rptID
ORDER BY rptID

--===============================================

select sum(N.amount), g.rptdesc, N.mois
		from vglnomis AS N INNER JOIN tblnomis AS NN ON N.gl = NN.glnomis 
		INNER JOIN tblGL AS G ON NN.nogl = G.GL 
		where N.FY  = (2007 + (SELECT     multi * - 1 
					FROM   YearConvert 
					WHERE  Mois = 8)) group by g.rptdesc,N.mois


--==========================================================================================
SELECT     G.rptdesc, G.rptcat,dbo.fcGetAnneeTotal(G.rptdesc,year(getdate()),month(getdate())),dbo.fcGetMoisTotal(G.rptdesc,year(getdate()),month(getdate()))
FROM         dbo.tblGL G INNER JOIN
                      dbo.tblNomis NN ON G.GL = NN.NoGL INNER JOIN
                      dbo.vGLNOMIS N ON NN.GlNomis = N.GL
WHERE     (N.FY = YEAR(GETDATE()) +
                          (SELECT     multi * - 1
                            FROM          YearConvert
                            WHERE      Mois = month(getdate())))
GROUP BY G.rptcat, G.rptdesc, G.rptID
ORDER BY G.rptID

--===============================================================


SELECT     gldes, SUM(Month) AS Mois, SUM(Total) AS Total, rptcat, rptID,AnneeFY,MoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, CASE WHEN M.CatID = 1 THEN ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) / 12 ELSE (ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) + CASE WHEN G.description LIKE 'Training' THEN
                                                  (SELECT     SUM(T .costofcourse)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Car rental' THEN
                                                  (SELECT     SUM(T .Carrental)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  fares' THEN
                                                  (SELECT     SUM(T .Fares)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  hotel' THEN
                                                  (SELECT     SUM(T .Hotel)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Meals & entertainment' THEN
                                                  (SELECT     SUM(T .Meals) + SUM(T .Entertainment)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) ELSE 0 END) / 12 * - 1 END AS Month, CASE WHEN M.CatID = 1 THEN ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) ELSE (ISNULL
                                                  ((SELECT     SUM(montant)
                                                      FROM         tblComponents AS C INNER JOIN
                                                                            tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                                                            tblBudget AS B ON D .budgetID = B.budgetID
                                                      WHERE     D .NoGL = G.GL AND B.year = 1 + (year(getdate()) +
                                                                                (SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = month(getdate())))), 0) + CASE WHEN G.description LIKE 'Training' THEN
                                                  (SELECT     SUM(T .costofcourse)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Car rental' THEN
                                                  (SELECT     SUM(T .Carrental)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  fares' THEN
                                                  (SELECT     SUM(T .Fares)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Travel  hotel' THEN
                                                  (SELECT     SUM(T .Hotel)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) WHEN G.description LIKE 'Meals & entertainment' THEN
                                                  (SELECT     SUM(T .Meals) + SUM(T .Entertainment)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = 1 + (year(getdate()) +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = month(getdate())))) ELSE 0 END) * - 1 END AS Total, G.rptcat, M.CATID,'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc,year(getdate()),month(getdate())),'MoisFY' = dbo.fcGetMoisTotal(G.rptdesc,year(getdate()),month(getdate()))
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
GROUP BY rptcat, gldes, rptID,AnneeFY,MoisFY
ORDER BY rptID



SELECT     gldes, SUM(TotalPlanMois) AS Mois, dbo.fcGetMarginRapport1(SUM(TotalPlanMois),gldes,1,year(getdate()), month(getdate())) As gmMOISpLAN,SUM(TotalPlanYear) AS Total,dbo.fcGetMarginRapport1(SUM(TotalPlanYear),gldes,2,year(getdate()), month(getdate())) As gmYearpLAN, rptcat, rptID,AnneeFY,dbo.fcGetMarginRapport1(AnneeFY,gldes,3,year(getdate()), month(getdate())) AS GMYearFY,MoisFY,dbo.fcGetMarginRapport1(MoisFY,gldes,4,year(getdate()), month(getdate())) AS GMMoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'TotalPlanYear' = dbo.fcGetMontantPlan(M.CATID,G.GL,year(getdate()), month(getdate()),G.description),'TotalPlanMois' = dbo.fcGetMontantPlan(M.CATID,G.GL,year(getdate()), month(getdate()),G.description) /12, G.rptcat, M.CATID,'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc,year(getdate()),month(getdate())),'MoisFY' = dbo.fcGetMoisTotal(G.rptdesc,year(getdate()),month(getdate()))
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
GROUP BY rptcat, gldes, rptID,AnneeFY,MoisFY
ORDER BY rptID

--================================================RAPPORT QTD==========================================================





SELECT     gldes, SUM(TotalPlanMois) AS Mois, dbo.fcGetMarginRapport2(SUM(TotalPlanMois), gldes, 1, YEAR(GETDATE()), MONTH(GETDATE())) 
                      AS gmMOISpLAN, SUM(TotalPlanYear) AS Total, dbo.fcGetMarginRapport2(SUM(TotalPlanYear), gldes, 2, YEAR(GETDATE()), MONTH(GETDATE())) 
                      AS gmYearpLAN, rptcat, rptID, AnneeFY, dbo.fcGetMarginRapport2(AnneeFY, gldes, 3, YEAR(GETDATE()), MONTH(GETDATE())) AS GMYearFY, QuartierFY, 
                      dbo.fcGetMarginRapport2(QuartierFY, gldes, 4, YEAR(GETDATE()), MONTH(GETDATE())) AS GMMoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description), 
                                              'TotalPlanMois' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description) / 4, G.rptcat, M.CATID, 
                                              'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc, year(getdate()), month(getdate())), 'QuartierFY' = dbo.fcGetQuarterTotal(G.rptdesc, year(getdate()), 
                                              month(getdate()))
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
GROUP BY rptcat, gldes, rptID, AnneeFY, QuartierFY
ORDER BY rptID

--============================================================RAPPORT PAST YEAR===============================

SELECT     gldes, SUM(TotalPlanMois) AS Mois, dbo.fcGetMarginRapport2(SUM(TotalPlanMois), gldes, 1, YEAR(GETDATE()), MONTH(GETDATE())) 
                      AS gmMOISpLAN, SUM(TotalPlanYear) AS Total, dbo.fcGetMarginRapport2(SUM(TotalPlanYear), gldes, 2, YEAR(GETDATE()), MONTH(GETDATE())) 
                      AS gmYearpLAN, rptcat, rptID, AnneeFY, dbo.fcGetMarginRapport2(AnneeFY, gldes, 3, YEAR(GETDATE()), MONTH(GETDATE())) AS GMYearFY, QuartierFY, 
                      dbo.fcGetMarginRapport2(QuartierFY, gldes, 4, YEAR(GETDATE()), MONTH(GETDATE())) AS GMMoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description), 
                                              'TotalPlanMois' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description) / 4, G.rptcat, M.CATID, 
                                              'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc, year(getdate()), month(getdate())), 'QuartierFY' = dbo.fcGetQuarterTotal(G.rptdesc, year(getdate()), 
                                              month(getdate()))
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
GROUP BY rptcat, gldes, rptID, AnneeFY, QuartierFY
ORDER BY rptID



select gldes,rptID,TotalPlanMois,dbo.fcGetMarginRapport3(TotalPlanMois, gldes, 1, YEAR(GETDATE()), MONTH(GETDATE())) AS GMPastMonth,TotalPlanYear ,dbo.fcGetMarginRapport3(TotalPlanYear, gldes, 2, YEAR(GETDATE()), MONTH(GETDATE())) AS GMPastYear,rptcat,MoisFY,dbo.fcGetMarginRapport3(MoisFY, gldes, 4, YEAR(GETDATE()), MONTH(GETDATE())) AS GMFYmonth,AnneeFY,dbo.fcGetMarginRapport3(AnneeFY, gldes, 3, YEAR(GETDATE()), MONTH(GETDATE())) AS GMFYyear  FROM(
SELECT   DISTINCT  G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetAnneePastTotal(G.rptdesc,year(getdate()), month(getdate())), 
                                              'TotalPlanMois' = dbo.fcGetMoisTotal(G.rptdesc,year(getdate())-1,month(getdate())), G.rptcat, 
                                              'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc, year(getdate()), month(getdate())), 'MoisFY' = dbo.fcGetMoisTotal(G.rptdesc,year(getdate()),month(getdate()))
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6))K
ORDER BY rptID,gldes


dbo.fcGetMoisTotal('Professional',2007,8)


--======================================================Rapport Departement==================================


SELECT     gldes, SUM(TotalPlanMois) AS Mois, 
                       SUM(TotalPlanYear) AS Total,  rptcat, rptID, AnneeFY,  MoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlanDept(M.CATID, G.GL, year(getdate()), month(getdate()), G.description,'Finance'), 
                                              'TotalPlanMois' = dbo.fcGetMontantPlanDept(M.CATID, G.GL, year(getdate()), month(getdate()), G.description,'Finance') / 12, G.rptcat, M.CATID, 
                                              'AnneeFY' = dbo.fcGetAnneeTotaldept(G.rptdesc, year(getdate()), month(getdate()),'Finance'), 'MoisFY' = dbo.fcGetMoisTotaldept(G.rptdesc, year(getdate()), 
                                              month(getdate()),'Finance')
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
GROUP BY rptcat, gldes, rptID, AnneeFY, MoisFY
ORDER BY rptID



SELECT sum(Mois) AS Mois, sum(Total) AS Total, sum(AnneeFY) AS AnneeFY,sum(QuartierFY) AS QuartierFY from (SELECT     gldes, SUM(TotalPlanMois) AS Mois,SUM(TotalPlanYear) AS Total, rptcat, rptID, AnneeFY,  QuartierFY
                      FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description), 
                                              'TotalPlanMois' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description) / 4, G.rptcat, M.CATID, 
                                              'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc, year(getdate()), month(getdate())), 'QuartierFY' = dbo.fcGetQuarterTotal(G.rptdesc, year(getdate()), 
                                              month(getdate()))
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
Where rptID=1
GROUP BY rptcat, gldes, rptID, AnneeFY, QuartierFY)KK
GROUP BY rptcat


SELECT sum(Mois) AS Mois, sum(Total) AS Total, sum(AnneeFY) AS AnneeFY,sum(MoisFY) AS MoisFY from (SELECT     gldes, SUM(TotalPlanMois) AS Mois,SUM(TotalPlanYear) AS Total, rptcat, rptID, AnneeFY, MoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description), 
                                              'TotalPlanMois' = dbo.fcGetMontantPlan(M.CATID, G.GL, year(getdate()), month(getdate()), G.description) / 12, G.rptcat, M.CATID, 
                                              'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc, year(getdate()), month(getdate())), 'MoisFY' = dbo.fcGetMoisTotal(G.rptdesc, year(getdate()), 
                                              month(getdate()))
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
Where rptID=1
GROUP BY rptcat, gldes, rptID, AnneeFY, MoisFY)KK
GROUP BY rptcat


declare @departement varchar(30)

set @departement = 'test'
select sum(Mois) AS Mois ,sum(Total) AS Total,sum(AnneeFY) AS AnneeFY,sum(MoisFY) AS MoisFY FROM(SELECT     gldes, SUM(TotalPlanMois) AS Mois, 
                       SUM(TotalPlanYear) AS Total,  rptcat, rptID, AnneeFY,  MoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlanDept(M.CATID, G.GL, year(getdate()), month(getdate()), G.description,@departement), 
                                              'TotalPlanMois' = dbo.fcGetMontantPlanDept(M.CATID, G.GL, year(getdate()), month(getdate()), G.description,@departement) / 12, G.rptcat, M.CATID, 
                                              'AnneeFY' = dbo.fcGetAnneeTotaldept(G.rptdesc, year(getdate()), month(getdate()),@departement), 'MoisFY' = dbo.fcGetMoisTotaldept(G.rptdesc, year(getdate()), 
                                              month(getdate()),@departement)
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
where rptID >2
GROUP BY rptcat, gldes, rptID, AnneeFY, MoisFY) KK


select sum(Mois) AS Mois, SUM(Total) as Total, sum(AnneeFY), sum(MoisFY) FROM
(SELECT     gldes, SUM(TotalPlanMois) AS Mois, 
                       SUM(TotalPlanYear) AS Total,  rptcat, rptID, AnneeFY,  MoisFY
FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlanDept(M.CATID, G.GL, year(getdate()), month(getdate()), G.description,'Finance'), 
                                              'TotalPlanMois' = dbo.fcGetMontantPlanDept(M.CATID, G.GL, year(getdate()), month(getdate()), G.description,'Finance') / 12, G.rptcat, M.CATID, 
                                              'AnneeFY' = dbo.fcGetAnneeTotaldept(G.rptdesc, year(getdate()), month(getdate()),'Finance'), 'MoisFY' = dbo.fcGetMoisTotaldept(G.rptdesc, year(getdate()), 
                                              month(getdate()),'Finance')
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
GROUP BY rptcat, gldes, rptID, AnneeFY, MoisFY) KK


--=Details
select d.description,RD.GL,RD. from tbldepartement AS D INNER JOIN vRapportDetails AS RD ON d.departmentID = RD.Department group by d.description