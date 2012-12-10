SELECT   GLDES,
         SUM(TOTALPLANMOIS)  AS MOIS,
         SUM(TOTALPLAN2007)  AS TOTAL,
         RPTCAT,
         RPTID,
         ANNEEFY,
         MOISFY
FROM     (SELECT G.RPTDESC                                                                                                 AS GLDES,
                 G.RPTID,
                 'TotalPlan2007' = DBO.FCGETMONTANTPLANDEPT(M.CATID,G.GL,2007,10,G.DESCRIPTION,'Engineering'),
                 'TotalPlanMois' = DBO.FCGETMONTANTPLANDEPT(M.CATID,G.GL,2007,10,G.DESCRIPTION,'Engineering') / 12,
                 G.RPTCAT,
                 M.CATID,
                 'AnneeFY' = DBO.FCGETANNEETOTALDEPT(G.RPTDESC,2007,10,'Engineering'),
                 'MoisFY' = DBO.FCGETMOISTOTALDEPT(G.RPTDESC,2007,10,'Engineering')
          FROM   DBO.TBLGL G
                 INNER JOIN DBO.TBLMAINCAT M
                   ON G.CATID = M.CATID
          WHERE  (M.CATID BETWEEN 1 AND 6)) K
GROUP BY RPTCAT,GLDES,RPTID,ANNEEFY,
         MOISFY
ORDER BY RPTID
