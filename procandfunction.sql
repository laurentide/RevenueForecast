USE LCLADMIN


SET NOCOUNT ON


drop procedure prAjoutSalaire

GO
CREATE procedure prAjoutSalaire(@Budget INT,@nom varchar(30),@salary money,@points int, @Inc float, @RRSP money)
AS
	DECLARE @EMPID INT
	
	Select @EMPID=employeeID from tblEmployee Where name = @nom

	IF(@EMPID IS NOT NULL)
	BEGIN
		SELECT * FROM tblsalaries WHERE budgetID=@Budget AND EmployeeID = @EMPID
		IF(@@ROWCOUNT = 0)
			INSERT INTO tblsalaries VALUES(@Budget,@EMPID,@salary,@points,@Inc,@RRSP,0,0)
		ELSE
		BEGIN
			UPDATE tblsalaries
			SET BaseSalary = @salary,points = @points, Inc = @Inc, RRSP = @RRSP
			WHERE budgetid=@Budget AND EmployeeID = @EMPID
		END
	END


GO

drop procedure prAjoutBudgetDetail
GO
CREATE procedure prAjoutBudgetDetail(@BudgetID int,@NoGl varchar(15))
AS
	Select DetailID from tblBudgetDetails Where BudgetID = @BudgetID AND NoGl = @NoGl

	IF(@@ROWCOUNT = 0)
		INSERT INTO tblBudgetDetails VALUES(@BudgetID,@NoGl,0)
GO


drop procedure prAjoutDepenseSalaire
GO
CREATE procedure prAjoutDepenseSalaire(@DetailID int,@Salaires money,@Comment varchar(30))
AS

	SELECT * FROM tblComponents Where DetailID=@DetailID

	IF(@@ROWCOUNT = 0)
		INSERT INTO tblComponents VALUES(@DetailID,@Salaires,@Comment,0,0,0)
	ELSE
	BEGIN
		UPDATE tblComponents
		SET Montant = @Salaires
		WHERE DetailID = @DetailID
	END

GO

drop procedure prAfficherSalaire
GO
CREATE procedure prAfficherSalaire(@BudgetID int,@department varchar(100))
AS
	DECLARE @OldBudgetID INT
	DECLARE @departmentID varchar(15)

	SELECT @departmentID=departmentID from tbldepartement where description = @department
	SELECT @OldBudgetID=BudgetID FROM tblBudget Where departmentid  = (Select departmentid from tblBudget Where budgetid = @BudgetID ) AND Year = (SELECT (year-1) FROM tblbudget Where BudgetID = @BudgetID)
	
	IF (@OldBudgetID IS NULL)
	BEGIN
		SELECT E.name,
		ISNULL((SELECT EE.baseSalary FROM tblemployee AS EE Where EE.EmployeeID = E.EmployeeID),0) 'Base salary',
		ISNULL((SELECT EE.RRSP FROM tblemployee AS EE Where EE.EmployeeID = E.EmployeeID),0) 'RRSP',
		ISNULL((SELECT EE.Points FROM tblemployee AS EE Where EE.EmployeeID = E.EmployeeID),0) 'POINTS',
		ISNULL((SELECT ISNULL(S.Inc,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'Inc',
		ISNULL((SELECT S.baseSalary FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'BaseSalary',
		ISNULL((SELECT ISNULL(S.RRSP,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'RRSP',
		ISNULL((SELECT ISNULL(S.points,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'Points'
		FROM tblEmployee AS E WHERE departmentid = @departmentID AND e.name not like '(Projected employees)' ORDER BY name
	END
	ELSE
	BEGIN
	SELECT E.name,
		ISNULL((SELECT S.baseSalary FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @OldBudgetID),0) 'Base salary',
		ISNULL((SELECT ISNULL(S.RRSP,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @OldBudgetID),0) 'RRSP',
		ISNULL((SELECT ISNULL(S.Points,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @OldBudgetID),0) 'POINTS',
		ISNULL((SELECT ISNULL(S.Inc,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'Inc',
		ISNULL((SELECT S.baseSalary FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'BaseSalary',
		ISNULL((SELECT ISNULL(S.RRSP,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'RRSP',
		ISNULL((SELECT ISNULL(S.points,0) FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = @BudgetID),0) 'Points'
		FROM tblEmployee AS E WHERE departmentid = @departmentID AND e.name not like '(Projected employees)' ORDER BY name
	END

GO


drop procedure prManagers
GO
CREATE procedure prManagers(@name varchar(30),@department varchar(100),@operation varchar(10))
AS
	DECLARE @departmentID varchar(15)
	DECLARE @NoEmp int

	SELECT 	@departmentID=departmentID from tblDepartement where description = @department
	SELECT 	@NoEmp=employeeID from tblEmployee where name = @name
	if @operation = 'insert'
		INSERT INTO tblManager VALUES(@NoEmp,@departmentID)
	ELSE IF @operation = 'delete'
		DELETE FROM tblManager WHERE employeeid = @NoEmp And departmentID = @departmentID

GO

drop function fcGetEmployee

GO
Create function fcGetEmployee(@name varchar(30))
RETURNS int
AS
BEGIN
	DECLARE @empID INT
	SELECT @empID=employeeID FROM tblemployee Where name = @name
	RETURN @empID
END

GO


drop procedure prCellularCarExpense
GO
CREATE procedure prCellularCarExpense(@budget INT,@nom varchar(30),@Montant money,@operation varchar(10),@departement varchar(30))
AS
	
	DECLARE @EMPID INT

	
	Select @EMPID=E.employeeID from tblEmployee AS E INNER JOIN tbldepartement AS D ON e.departmentID=D.departmentID Where E.name = @nom AND d.description = @departement

	IF(@EMPID IS NOT NULL)
	BEGIN
		SELECT * FROM tblsalaries WHERE budgetID=@Budget AND EmployeeID = @EMPID
		IF(@@ROWCOUNT = 0)
		BEGIN
			IF @operation = 'cell'
				INSERT INTO tblsalaries VALUES(@Budget,@EMPID,0,0,0,0,@Montant,0)
			ELSE IF @operation = 'car'
				INSERT INTO tblsalaries VALUES(@Budget,@EMPID,0,0,0,0,0,@Montant)
		END
		ELSE
		BEGIN
			IF @operation = 'cell'
			BEGIN
				UPDATE tblsalaries
				SET Cellularamount= @Montant
				WHERE budgetid=@Budget AND EmployeeID = @EMPID
			END
			ELSE IF @operation = 'car'
			BEGIN
				UPDATE tblsalaries
				SET CarExpense = @Montant
				WHERE budgetid=@Budget AND EmployeeID = @EMPID
			END
		END
	END

GO
drop procedure prCurseur
GO

Create Procedure prCurseur(@BudgetID INT)
AS
DECLARE testcurseur2 CURSOR
for select catID from tblMainCat where catid between 1 and 6 order by catid

DECLARE @ID INTEGER
DECLARE @departmentID varchar(15)
DECLARE @Year INT
SELECT @departmentID=departmentID,@Year=Year FROM tblBudget Where BudgetID = @BudgetID

OPEN testcurseur2
FETCH NEXT from testcurseur2
	INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN


IF NOT (@ID = 6 AND NOT @departmentID='5.0.000.000')
begin
SELECT catID ,description, '0','0' FROM tblMainCAt Where catID = @ID
SELECT G.gl,G.description, ISNULL((SELECT sum(montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.detailID = D.DetailID Where D.NoGL = G.GL AND d.BudgetID = @BudgetID),0),G.CATID from tblGL AS G Where G.CATID = @ID
end

FETCH NEXT from testcurseur2
	INTO @ID
END

Close testcurseur2
deallocate testcurseur2
GO
EXEC prCurseur 41

GO
--Requete pour DTS
SELECT SamAccountName 'UserName',name,department  FROM
(select SamAccountName ,name,DistinguishedName,SUBSTRING(SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 + (charindex('=',SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 ,LEN(DistinguishedName)))) ,LEN(DistinguishedName)),0,charindex(',',SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 + (charindex('=',SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 ,LEN(DistinguishedName)))) ,LEN(DistinguishedName)))) 'department'  from openquery
(
ADSI,'SELECT DistinguishedName,SamAccountName, name
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
WHERE objectCategory = ''Person'' AND objectClass = ''user''
') Where SamAccountName NOT IN (select SamAccountName from openquery
(
ADSI,'SELECT SamAccountName
FROM ''LDAP://OU=NO_EMR,OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
WHERE objectCategory = ''Person'' AND objectClass = ''user''
'))) AS K ORDER BY SamAccountName

--Plus les updates pour les départements

GO
drop procedure prGeneral
GO

Create Procedure prGeneral(@Year INT)
AS
DECLARE testcurseur CURSOR
for select catID from tblMainCat where catid between 1 and 6 order by catid

DECLARE @ID INTEGER

OPEN testcurseur
FETCH NEXT from testcurseur
	INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN


IF @Year IS NULL
	BEGIN
	SELECT catID ,description, '...' FROM tblMainCAt Where catID = @ID
	Select GL, Description, LEFT(help,20) FROM tblGL Where catID = @ID
	END
ELSE
	BEGIN
	SELECT catID ,description,'$0' ,'$0' FROM tblMainCAt Where catID = @ID
	Select G.GL, G.Description, '$' + cast(ISNULL((SELECT sum(montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.detailID = D.DetailID INNER JOIN tblBudget AS B ON D.budgetID = B.budgetID Where D.NoGL = G.GL AND B.year = @Year)/12,0) as varchar(100)) 'Per Month','$' + cast(ISNULL((SELECT sum(montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.detailID = D.DetailID INNER JOIN tblBudget AS B ON D.budgetID = B.budgetID Where D.NoGL = G.GL AND B.year = @Year),0) as varchar(100)) 'Total' FROM tblGL AS G Where G.catID = @ID
	END

FETCH NEXT from testcurseur
	INTO @ID
END

Close testcurseur
deallocate testcurseur
GO
EXEC prGeneral 2008

--====================================================

drop procedure prGetDetails
GO

Create Procedure prGetDetails(@BudgetID INT, @DetailID INT)
AS
DECLARE @GL varchar(15)
DECLARE @departmentID varchar(15)
DECLARE @Year INT
DECLARE @CatID INT

SELECT @GL=D.NOGL,@CatID=G.catID FROM tblBudgetDetails AS D INNER JOIN tblGL AS G ON d.nogl = G.GL Where D.DetailID = @DetailID AND D.BudgetID = @BudgetID

SELECT @departmentID=departmentID,@Year=Year FROM tblBudget Where BudgetID = @BudgetID

IF @CatID=6  Or @GL like 'VARIOUS'
SELECT description, ISNULL(amount,0) FROM vGLNomis WHERE GL IN(SELECT glnomis from tblnomis Where nogl = @GL) AND FY = (@Year-1) ORDER BY ISNULL(amount,0) desc
else
SELECT description, ISNULL(amount,0) FROM vGLNomisWithDescription WHERE GL IN(SELECT glnomis from tblnomis Where nogl = @GL) AND FY = (@Year-1) AND department = @departmentID ORDER BY ISNULL(amount,0) desc

GO


drop procedure prTauxSalaire

GO
CREATE procedure prTauxSalaire(@Budget INT,@TauxGroup varchar(50), @MontantGroup Money, @TauxPayroll varchar(50), @MontantPayroll Money)
AS
	DECLARE @detailID INT
	DECLARE @montantnewSalaries MONEY

	
	SELECT @montantnewSalaries = isnull(C.montant,0) from tblcomponents AS C INNER JOIN tblbudgetdetails as D on C.detailID = D.detailID WHere d.budgetID = @Budget AND d.nogl = '08.0800111.' AND C.basesalary IS NULL AND C.RRSP IS NULL AND C.POINTS IS NULL
	if @montantnewSalaries IS NULL
		set @montantnewSalaries = 0
	set @MontantGroup = @MontantGroup + (@montantnewSalaries * cast(@TauxGroup as float) * 0.01)

	Select @detailID=detailID from tblbudgetdetails Where budgetID = @Budget AND nogl like '09.0900310.'
	UPDATE tblcomponents SET montant=@MontantGroup,description = @TauxGroup where detailID = @detailID

	set @detailID=null

	set @MontantPayroll = @MontantPayroll + (@montantnewSalaries * cast(@TauxPayroll as float) * 0.01)

	Select @detailID=detailID from tblbudgetdetails Where budgetID = @Budget AND nogl like '09.0900400.'
	UPDATE tblcomponents SET montant=@MontantPayroll,description = @TauxPayroll where detailID = @detailID

	
go


drop procedure prAjoutDepenseSalaireNew
GO
CREATE procedure prAjoutDepenseSalaireNew(@DetailID int,@Salaires money,@Comment varchar(30))
AS
	DECLARE @montantSalairenormal MONEY
	declare @TauxGroup FLOAT
	DECLARE @TauxPayroll FLOAT
	declare @Budget int
	DECLARE @detailID2 INT 

	select @Budget=budgetID from tblbudgetdetails where detailid= @DetailID

	SELECT * FROM tblComponents Where DetailID=@DetailID AND basesalary IS NULL AND RRSP IS NULL AND POINTS IS NULL
	IF(@@ROWCOUNT = 0)
		INSERT INTO tblComponents VALUES(@DetailID,@Salaires,@Comment,null,null,null)
	ELSE
	BEGIN
		UPDATE tblComponents
		SET Montant = @Salaires
		WHERE DetailID = @DetailID AND basesalary IS NULL AND RRSP IS NULL AND POINTS IS NULL
	END

	select @montantSalairenormal = isnull(C.montant,0) from tblcomponents as C INNER JOIN tblbudgetdetails as D ON C.detailid = d.detailid where d.budgetid = @Budget and d.noGL = '08.0800110.' AND c.description = 'Total employee salaries'
	select @TauxGroup=cast(c.description as FLOAT) from tblcomponents as C INNER JOIN tblbudgetdetails as D ON C.detailid = d.detailid where d.budgetid = @Budget and d.noGL = '09.0900310.'
	select @TauxPayroll=cast(c.description as FLOAT) from tblcomponents as C INNER JOIN tblbudgetdetails as D ON C.detailid = d.detailid where d.budgetid = @Budget and d.noGL = '09.0900400.'
	
	if @montantSalairenormal is null
		set @montantSalairenormal = 0

	set @Salaires = @Salaires + @montantSalairenormal
	
	Select @detailID2=detailID from tblbudgetdetails Where budgetID = @Budget AND nogl like '09.0900310.'
	UPDATE tblcomponents SET montant=(@Salaires * @TauxGroup * 0.01) where detailID = @detailID2

	Select @detailID2=detailID from tblbudgetdetails Where budgetID = @Budget AND nogl like '09.0900400.'
	UPDATE tblcomponents SET montant=(@Salaires * @TauxPayroll * 0.01) where detailID = @detailID2
	



GO
drop procedure prAjoutBudget
GO
CREATE procedure prAjoutBudget(@year INT,@username varchar(30),@department varchar(100))
AS
	DECLARE @BudgetID INT
	DECLARE @EMPID INT
	DECLARE @departmentid varchar(15)

	SELECT @departmentid = departmentID FROM tbldepartement where description = @department

	Select @EMPID=M.employeeID from tblmanager AS M INNER JOIN tblEmployee AS E ON M.employeeID = E.employeeID Where E.Username = @username

	IF(@EMPID IS NOT NULL)
	BEGIN
		DECLARE @detail INT 
		INSERT INTO tblBudget VALUES(@year,@EMPID,getdate(),@departmentid,'Insert comments here...')
		Select @BudgetID=IDENT_CURRENT('tblBudget')
		
		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'09.0900310.',0)
		Select @detail=IDENT_CURRENT('tblBudgetDetails')
		INSERT INTO tblcomponents VALUES(@detail,0,0,0,0,0)

		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'09.0900400.',0)
		Select @detail=IDENT_CURRENT('tblBudgetDetails')
		INSERT INTO tblcomponents VALUES(@detail,0,0,0,0,0)
		
		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'EXCEPTION1',20)
		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'EXCEPTION2',30)
		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'EXCEPTION3',30)
		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'EXCEPTION4',10)
		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'EXCEPTION5',5)
		INSERT INTO tblbudgetdetails VALUES(@BudgetID,'EXCEPTION6',null)

		INSERT INTO tblSummary VALUES(@BudgetID,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
	END

GO



drop procedure prAdjustments
GO

Create Procedure prAdjustments(@Department varchar(30))
AS
DECLARE curseurAdjustments CURSOR
for select rptID from tblgl Where rptID IS NOT NULL  group by rptID ORDER BY rptID

DECLARE @ID INTEGER
DECLARE @IDprev INTEGER

set @IDprev = 0
OPEN curseurAdjustments
FETCH NEXT from curseurAdjustments
	INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN

IF @IDprev = 2 AND @ID = 3
BEGIN
select 'GM',departmentID,description,'0' from tbldepartement where description =@Department

set @IDprev = @ID
END
ELSE
BEGIN
select rptcat,'0','0', '0' from tblgl Where rptID = @ID group by rptcat
SELECT     gldes, SUM(TotalPlanYear) AS Total, AnneeFY,rptID FROM (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = dbo.fcGetMontantPlanDept(M.CATID, G.GL, year(getdate()), month(getdate()), G.description,@Department), G.rptcat, M.CATID,  'AnneeFY' = dbo.fcGetAnneeTotaldept(G.rptdesc, year(getdate()), month(getdate()),@Department) FROM  dbo.tblGL G INNER JOIN  dbo.tblMainCat M ON G.catID = M.CatID WHERE      (M.CatID BETWEEN 1 AND 6)) K  Where rptID = @ID GROUP BY rptcat, gldes, rptID, AnneeFY ORDER BY rptID

set @IDprev = @ID
FETCH NEXT from curseurAdjustments
	INTO @ID
END
END
select 'Total expense',departmentID,description,'0' from tbldepartement where description =@Department
Close curseurAdjustments
deallocate curseurAdjustments
GO
EXEC dbo.prAdjustments 'test'

GO


drop procedure prSaveAdjustments
GO

Create Procedure prSaveAdjustments(@BudgetID INT,@description varchar(30), @Montant Money)
AS
	select @Montant FROM tblAdjustments Where budgetID = @BudgetID AND Description = @description
	
	IF @@ROWCOUNT = 0
		INSERT INTO tblAdjustments VALUES(@BudgetID,@description,@Montant)
	else
		UPDATE tblAdjustments SET Adjustment = @Montant Where budgetID = @BudgetID AND Description = @description

GO

EXEC dbo.prSaveAdjustments

--=============================RAPPORT==========================================================

drop function fcGetMoisTotal

GO
Create function fcGetMoisTotal(@description varchar(100), @Year INT, @Month INT)
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money
	 SELECT @REPONSE = ISNULL(sum(Total),0)
		from vGLNomisMoisRapport 
		where FY  = (@Year + (SELECT     multi * - 1 
					FROM   YearConvert 
					WHERE  Mois = @Month)) AND rptdesc = @description AND mois = (SELECT moisFY from yearconvert where mois = @Month)
	if @REPONSE IS NULL
		set @REPONSE = 0
	
	return @REPONSE
END
GO

drop function fcGetAnneeTotal

GO
Create function fcGetAnneeTotal(@description varchar(100), @Year INT, @Month INT)
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money
	 SELECT @REPONSE = ISNULL(sum(Total),0)
		from vGLNomisMoisRapport
		where FY  = (@Year + (SELECT     multi * - 1 
					FROM   YearConvert 
					WHERE  Mois = @Month)) AND mois <= (SELECT moisFY from yearconvert where mois = @Month) group by rptdesc HAVING rptdesc = @description
	if @REPONSE IS NULL
		set @REPONSE = 0
	return @REPONSE
END

GO
drop function fcGetMontantPlan

GO
Create function fcGetMontantPlan(@CatID INT, @GL VARCHAR(15),@Year INT, @Month INT,@GLdescription varchar(100))
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money
	DECLARE @sommeTravel money
	
	
		SELECT    @REPONSE=SUM(montant)
                         FROM         tblComponents AS C INNER JOIN
                                      tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                      tblBudget AS B ON D .budgetID = B.budgetID
                                       WHERE     D .NoGL = @GL AND B.year = @Year +
                                                                           	(SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = @Month)

	IF @GLdescription like 'Training'
	BEGIN
		SELECT     @sommeTravel =SUM(T.costofcourse)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)

	end
	ELSE IF @GLdescription like 'Car rental'
	BEGIN
		SELECT     @sommeTravel =SUM(T.CarRental)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)

	END 
	ELSE IF @GLdescription like 'Travel  fares'
	BEGIN
		SELECT     @sommeTravel =SUM(T.fares)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois =@Month)

	END
	ELSE IF @GLdescription like 'Travel  hotel'
	BEGIN
		SELECT     @sommeTravel =SUM(T .hotel)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)
 
	END
	ELSE IF @GLdescription like 'Meals & entertainment'
	BEGIN
		SELECT     @sommeTravel =SUM(T .Meals) + SUM(T .Entertainment)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)

	END
	ELSE
		set @sommeTravel = 0


	if @REPONSE IS NULL
		set @REPONSE = 0
	if @sommeTravel IS NULL
		set @sommeTravel = 0

	set @REPONSE = @REPONSE + @sommeTravel
	
	
	return @REPONSE
END
GO

drop function fcGetMarginRapport1

GO
Create function fcGetMarginRapport1(@Montant Money,@GLdescription varchar(100),@Type INT,@Year INT,@Mois INT)
RETURNS money
AS
BEGIN
	 DECLARE @Sales Money
	DECLARE @description varchar(100)
	DECLARE @reponse money

	If @GLdescription like 'Commission Expense'
		set @description = 'Commission'
	ELSE If @GLdescription like 'Control Devices COGS'
		set @description = 'Control Devices'
	ELSE If @GLdescription like 'Freight COGS'
		set @description = 'Freight'
	ELSE If @GLdescription like 'Service Costs'
		set @description = 'Service Revenues'


	if @Type = 1
	BEGIN
		SELECT     @Sales=SUM(TotalPlanMois)
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'TotalPlanMois' = dbo.fcGetMontantPlan(M.CATID,G.GL,@Year, @Mois,G.description)  /12, G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
		GROUP BY rptcat, gldes, rptID

		set @Montant = @Montant * -1
	END
	ELSE if @Type = 2
	BEGIN
		SELECT     @Sales=SUM(TotalPlanYear)
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'TotalPlanYear' = dbo.fcGetMontantPlan(M.CATID,G.GL,@Year,@Mois,G.description), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
		GROUP BY rptcat, gldes, rptID

		set @Montant = @Montant * -1
	END
	ELSE IF @Type = 3
	BEGIN

		SELECT     @Sales=AnneeFY
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc,@Year,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
	END
	ELSE IF @Type = 4
	BEGIN
		SELECT     @Sales=MoisFY
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'MoisFY' = dbo.fcGetMoisTotal(G.rptdesc,@Year,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
	END

	if @Sales IS NULL
		set @Sales = 0
	if NOT @Sales = 0
		set @reponse = (@Sales + @Montant) / @Sales
	else
		set @reponse = 0

	return @reponse

end

--============================================================Rapport QTD==================================


GO
drop function fcGetQuarterTotal

GO
Create function fcGetQuarterTotal(@description varchar(100), @Year INT, @Month INT)
RETURNS money
AS
BEGIN

	DECLARE @REPONSE money
	 SELECT @REPONSE = ISNULL(sum(Total),0)
		from vGLNomisMoisRapport 
		where FY  = (@Year + (SELECT     multi * - 1 
					FROM   YearConvert 
					WHERE  Mois = @Month)) AND rptdesc = @description AND mois between (SELECT min(moisFY) from yearconvert where Quartier = (SELECT quartier from yearconvert where mois = @Month)) AND (Select moisFY from yearconvert where mois = @Month)
	if @REPONSE IS NULL
		set @REPONSE = 0
	return @REPONSE
END
GO


drop function fcGetMarginRapport2

GO
Create function fcGetMarginRapport2(@Montant Money,@GLdescription varchar(100),@Type INT,@Year INT,@Mois INT)
RETURNS money
AS
BEGIN
	 DECLARE @Sales Money
	DECLARE @description varchar(100)
	DECLARE @reponse money

	If @GLdescription like 'Commission Expense'
		set @description = 'Commission'
	ELSE If @GLdescription like 'Control Devices COGS'
		set @description = 'Control Devices'
	ELSE If @GLdescription like 'Freight COGS'
		set @description = 'Freight'
	ELSE If @GLdescription like 'Service Costs'
		set @description = 'Service Revenues'


	if @Type = 1
	BEGIN
		SELECT     @Sales=SUM(TotalPlanMois)
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'TotalPlanMois' = dbo.fcGetMontantPlan(M.CATID,G.GL,@Year, @Mois,G.description)  /4, G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
		GROUP BY rptcat, gldes, rptID

		set @Montant = @Montant * -1
	END
	ELSE if @Type = 2
	BEGIN
		SELECT     @Sales=SUM(TotalPlanYear)
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'TotalPlanYear' = dbo.fcGetMontantPlan(M.CATID,G.GL,@Year,@Mois,G.description), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
		GROUP BY rptcat, gldes, rptID
		set @Montant = @Montant * -1
	END
	ELSE IF @Type = 3
	BEGIN

		SELECT     @Sales=AnneeFY
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc,@Year,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
	END
	ELSE IF @Type = 4
	BEGIN
		SELECT     @Sales=MoisFY
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'MoisFY' = dbo.fcGetQuarterTotal(G.rptdesc,@Year,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
	END

	if @Sales IS NULL
		set @Sales = 0
	if NOT @Sales = 0
		set @reponse = (@Sales + @Montant) / @Sales
	else
		set @reponse = 0

	return @reponse

end

--======================================RAPPORT PAST YEAR===============================

drop function fcGetAnneePastTotal

GO
Create function fcGetAnneePastTotal(@description varchar(100), @Year INT, @Month INT)
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money
	DECLARE @MoisFY INT
	
	SELECT @MoisFY=moisFY from yearconvert where mois = @Month

	 SELECT @REPONSE = ISNULL(sum(Total),0)
		from vGLNomisMoisRapport
		where FY  = (@Year + (SELECT     multi - 1
					FROM   YearConvert 
					WHERE  Mois = @Month)) AND mois between 1 and @MoisFY group by rptdesc HAVING rptdesc = @description
	if @REPONSE IS NULL
		set @REPONSE = 0
	return @REPONSE
END

go

drop function fcGetMarginRapport3

GO
Create function fcGetMarginRapport3(@Montant Money,@GLdescription varchar(100),@Type INT,@Year INT,@Mois INT)
RETURNS money
AS
BEGIN
	 DECLARE @Sales Money
	DECLARE @description varchar(100)
	DECLARE @reponse money

	If @GLdescription like 'Commission Expense'
		set @description = 'Commission'
	ELSE If @GLdescription like 'Control Devices COGS'
		set @description = 'Control Devices'
	ELSE If @GLdescription like 'Freight COGS'
		set @description = 'Freight'
	ELSE If @GLdescription like 'Service Costs'
		set @description = 'Service Revenues'


	if @Type = 1
	BEGIN
		SELECT     @Sales=MoisPasT
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'MoisPasT' = dbo.fcGetMoisTotal(G.rptdesc,@Year-1,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
	END
	ELSE if @Type = 2
	BEGIN
		SELECT     @Sales=SUM(TotalPastYear)
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'TotalPastYear' = dbo.fcGetAnneePastTotal(G.rptdesc,@Year,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
		GROUP BY rptcat, gldes, rptID
	END
	ELSE IF @Type = 3
	BEGIN

		SELECT     @Sales=AnneeFY
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'AnneeFY' = dbo.fcGetAnneeTotal(G.rptdesc,@Year,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
	END
	ELSE IF @Type = 4
	BEGIN
		SELECT     @Sales=MoisFY
		FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'MoisFY' = dbo.fcGetMoisTotal(G.rptdesc,@Year,@Mois), G.rptcat, M.CATID
                       FROM          dbo.tblGL G INNER JOIN
                                              dbo.tblMainCat M ON G.catID = M.CatID
                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
		Where gldes = @description
	END

	if @Sales IS NULL
		set @Sales = 0
	if NOT @Sales = 0
		set @reponse = (@Sales + @Montant) / @Sales
	else
		set @reponse = 0

	return @reponse

end

--=====================================================Rapport department======================================

drop function fcGetMoisTotalDept

GO
Create function fcGetMoisTotalDept(@description varchar(100), @Year INT, @Month INT,@deptdesc varchar(30))
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money
	DECLARE @departement varchar(15)
	
	SELECT @departement=departmentid from tbldepartement where description = @deptdesc

	 SELECT @REPONSE = ISNULL(sum(Total),0)
		from vGlnomisRapportDept 
		where FY  = (@Year + (SELECT     multi * - 1 
					FROM   YearConvert 
					WHERE  Mois = @Month)) AND rptdesc = @description AND department=@departement AND mois = (SELECT moisFY from yearconvert where mois = @Month)
	if @REPONSE IS NULL
		set @REPONSE = 0

	return @REPONSE
END
GO

print cast(dbo.fcGetMoisTotalDept('Professional',2007,8) as varchar(100))

drop function fcGetAnneeTotalDept

GO
Create function fcGetAnneeTotalDept(@description varchar(100), @Year INT, @Month INT,@deptdesc varchar(30))
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money
	DECLARE @departement varchar(15)
	
	SELECT @departement=departmentid from tbldepartement where description = @deptdesc

	 SELECT @REPONSE = ISNULL(sum(Total),0)
		from vGlnomisRapportDept
		where FY  = (@Year + (SELECT     multi * - 1 
					FROM   YearConvert 
					WHERE  Mois = @Month)) AND department = @departement AND mois <= (SELECT moisFY from yearconvert where mois = @Month) group by rptdesc HAVING rptdesc = @description
	if @REPONSE IS NULL
		set @REPONSE = 0

	return @REPONSE
END




drop function fcGetMontantPlanDept

GO
Create function fcGetMontantPlanDept(@CatID INT, @GL VARCHAR(15),@Year INT, @Month INT,@GLdescription varchar(100),@DescDept varchar(30))
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money
	DECLARE @sommeTravel money
	DECLARE @departement varchar(15)
	
	SELECT @departement=departmentid from tbldepartement where description = @DescDept
	
	
		SELECT    @REPONSE=SUM(montant)
                         FROM         tblComponents AS C INNER JOIN
                                      tblBudgetDetails AS D ON C.detailID = D .DetailID INNER JOIN
                                      tblBudget AS B ON D .budgetID = B.budgetID
                                       WHERE     D .NoGL = @GL AND B.year = @Year +
                                                                           	(SELECT     multi * - 1
                                                                                  FROM          YearConvert
                                                                                  WHERE      Mois = @Month) AND B.departmentID = @departement

	IF @GLdescription like 'Training'
	BEGIN
		SELECT     @sommeTravel =SUM(T.costofcourse)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)AND B.departmentID=@departement

	end
	ELSE IF @GLdescription like 'Car rental'
	BEGIN
		SELECT     @sommeTravel =SUM(T.CarRental)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)AND B.departmentID=@departement

	END 
	ELSE IF @GLdescription like 'Travel  fares'
	BEGIN
		SELECT     @sommeTravel =SUM(T.fares)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois =@Month) AND B.departmentID=@departement

	END
	ELSE IF @GLdescription like 'Travel  hotel'
	BEGIN
		SELECT     @sommeTravel =SUM(T .hotel)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)AND B.departmentID=@departement
 
	END
	ELSE IF @GLdescription like 'Meals & entertainment'
	BEGIN
		SELECT     @sommeTravel =SUM(T .Meals) + SUM(T .Entertainment)
                                                    FROM          tbltravelbudget AS T INNER JOIN
                                                                           tblBudget AS B ON T .budgetID = B.budgetID
                                                    WHERE      B.year = @Year +
                                                                               (SELECT     multi * - 1
                                                                                 FROM          YearConvert
                                                                                 WHERE      Mois = @Month)AND B.departmentID=@departement

	END
	ELSE
		set @sommeTravel = 0


	if @REPONSE IS NULL
		set @REPONSE = 0
	if @sommeTravel IS NULL
		set @sommeTravel = 0

	set @REPONSE = @REPONSE + @sommeTravel
	

	return @REPONSE
END

GO

--=========================================Affichage des somme départements=================
GO

drop function dbo.fcGetDeptTotalMois
Go
Create function fcGetDeptTotalMois(@DescDept varchar(30),@Year Int, @Mois INT)
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money

	select @REPONSE = sum(Mois) FROM
	(SELECT     gldes, SUM(TotalPlanMois) AS Mois, rptcat, rptID
	FROM         (SELECT     G.rptdesc AS gldes, G.rptID,'TotalPlanMois' = CASE WHEN G.rptID = 1 then  (dbo.fcGetMontantPlanDept(M.CATID, G.GL, @Year, @Mois, G.description,@DescDept) / 12) * -1 ELSE dbo.fcGetMontantPlanDept(M.CATID, G.GL, @Year, @Mois, G.description,@DescDept) / 12 END, G.rptcat, M.CATID
	                       FROM          dbo.tblGL G INNER JOIN
	                                              dbo.tblMainCat M ON G.catID = M.CatID
	                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
	GROUP BY rptcat, gldes, rptID) KK

	return @REPONSE
END

GO

drop function dbo.fcGetDeptTotalAnnee
GO
Create function fcGetDeptTotalAnnee(@DescDept varchar(30),@Year Int, @Mois INT)
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money

	select @REPONSE=SUM(Total) FROM
	(SELECT     gldes,SUM(TotalPlanYear) AS Total,  rptcat, rptID
	FROM         (SELECT     G.rptdesc AS gldes, G.rptID, 'TotalPlanYear' = CASE WHEN G.rptID = 1 then dbo.fcGetMontantPlanDept(M.CATID, G.GL, @Year,@Mois, G.description,@DescDept) * -1 ELSE dbo.fcGetMontantPlanDept(M.CATID, G.GL, @Year,@Mois, G.description,@DescDept) END, G.rptcat, M.CATID
	                       FROM          dbo.tblGL G INNER JOIN
	                                              dbo.tblMainCat M ON G.catID = M.CatID
	                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
	GROUP BY rptcat, gldes, rptID) KK


	return @REPONSE
END

GO

drop function dbo.fcGetDeptTotalMoisFY

GO
Create function fcGetDeptTotalMoisFY(@DescDept varchar(30),@Year Int, @Mois INT)
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money

	select @REPONSE=sum(MoisFY) FROM
	(SELECT     gldes,  rptcat, rptID, MoisFY
	FROM         (SELECT     G.rptdesc AS gldes, G.rptID, G.rptcat, M.CATID, 'MoisFY' = dbo.fcGetMoisTotaldept(G.rptdesc, @Year,@Mois,@DescDept)
	                       FROM          dbo.tblGL G INNER JOIN
	                                              dbo.tblMainCat M ON G.catID = M.CatID
	                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
	GROUP BY rptcat, gldes, rptID,MoisFY) KK



	return @REPONSE
END
GO

drop function dbo.fcGetDeptTotalAnneeFY
GO
Create function fcGetDeptTotalAnneeFY(@DescDept varchar(30),@Year Int, @Mois INT)
RETURNS money
AS
BEGIN
	DECLARE @REPONSE money

	select @REPONSE = sum(AnneeFY) FROM
	(SELECT     gldes, AnneeFY
	FROM         (SELECT     G.rptdesc AS gldes, G.rptID, G.rptcat, M.CATID, 
	                                              'AnneeFY' = dbo.fcGetAnneeTotaldept(G.rptdesc,@Year,@Mois,@DescDept)
	                       FROM          dbo.tblGL G INNER JOIN
	                                              dbo.tblMainCat M ON G.catID = M.CatID
	                       WHERE      (M.CatID BETWEEN 1 AND 6)) K
	GROUP BY rptcat, gldes, rptID, AnneeFY) KK



	return @REPONSE
END

GO
