USE LCLADMIN


SET NOCOUNT ON


/*
DROP VIEW  GetManager
DROP TABLE tblTravelBudget
DROP TABLE tblSalaries
DROP TABLE tblComponents
DROP TABLE tblBudgetDetails
DROP TABLE tblBudget
*/



GO
--Ne pas toucher!
SELECT SamAccountName 'UserName',name,department INTO tblEmployee FROM
(select SamAccountName ,name,DistinguishedName,SUBSTRING(SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 + (charindex('=',SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 ,LEN(DistinguishedName)))) ,LEN(DistinguishedName)),0,charindex(',',SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 + (charindex('=',SUBSTRING(DistinguishedName,len(RTRIM(LTRIM(name)))+7 ,LEN(DistinguishedName)))) ,LEN(DistinguishedName)))) 'department'  from openquery
(
ADSI,'SELECT DistinguishedName,SamAccountName, name
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
WHERE objectCategory = ''Person'' AND objectClass = ''user''
')) AS K

GO

DELETE FROM tblemployee
Where username IN (select SamAccountName  from openquery
(
ADSI,'SELECT DistinguishedName,SamAccountName, name
FROM ''LDAP://OU=NO_EMR,OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
WHERE objectCategory = ''Person'' AND objectClass = ''user''
'))
GO
ALTER TABLE tblEmployee
ADD departmentID varchar(15) FOREIGN KEY REFERENCES tblDepartement (DepartmentID)

GO
UPDATE    tblEmployee
SET department = 'Finance'
WHERE department = 'Admin'

UPDATE    tblEmployee
SET department = 'SalesOps'
WHERE department = 'CSR' Or department = 'AE'

UPDATE    tblEmployee
SET department = 'Sales mtl'
WHERE department = 'Marketing' Or department = 'OS'

UPDATE    tblEmployee
SET department = 'Engineering'
WHERE department = 'System'

UPDATE    tblEmployee
SET department = 'Warehouse'
WHERE department = 'WOPT'

UPDATE tblEmployee
SET department = 'SSS'
WHERE name like 'Donnini, Michael' or name like 'Martin, Michel'

DELETE FROM tblEmployee
WHERE department NOT IN(SELECT Description FROM tblDepartement)

GO
UPDATE    tblEmployee
SET   departmentID = tblDepartement.DepartmentID
FROM         tblDepartement, tblEmployee
WHERE     tblEmployee.department=tblDepartement.description

GO
ALTER TABLE tblEmployee
DROP COLUMN department


GO
ALTER TABLE tblEmployee
ADD  EmployeeID INT IDENTITY(1,1) PRIMARY KEY

GO

--INSERT INTO tblEmployee VALUES('Gauthier, Francis','FrancisG','0.0.000.000')

CREATE VIEW GetManager AS
SELECT EmployeeID, departmentID
FROM tblEmployee
WHERE name IN(
select name 'Manager' from openquery
(
ADSI,'SELECT name
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
where objectClass = ''user''and objectCategory = ''Person'' and memberof = ''cn=LCL_Manager,OU=Global Security Group,DC=adc,dc=laurentidecontrols,dc=com''
'))
GO

SELECT * INTO tblManager FROM GetManager

GO
ALTER TABLE tblManager
ADD  ManagerID INT IDENTITY(1,1) PRIMARY KEY

GO

CREATE TABLE tblBudget
(
BudgetID	INT
		IDENTITY (1,1)
		PRIMARY KEY,
Year		INT,
Creator		INT
		CONSTRAINT FK_TravelBudgetEmp
		FOREIGN KEY REFERENCES tblEmployee (EmployeeID),
Date		datetime,
DepartmentID	varchar(15)
		CONSTRAINT FK_BudgetDep
		FOREIGN KEY REFERENCES tblDepartement (DepartmentID),
		CONSTRAINT UK_yeardept UNIQUE(Year,DepartmentID)
)


GO

CREATE TABLE tblBudgetDetails
(
DetailID	INT
		IDENTITY (1,1) PRIMARY KEY,
BudgetID	INT
		CONSTRAINT FK_BudgetDetailsID
		FOREIGN KEY REFERENCES tblBudget (BudgetID),
NoGL		varchar(15) NOT NULL
		CONSTRAINT FK_BudgetDetailsGl
		FOREIGN KEY REFERENCES tblGL (GL),
		CONSTRAINT UK_detailsGL UNIQUE(BudgetID,NoGL)
)
GO
CREATE TABLE tblComponents
(
ComponentID	INT
		IDENTITY (1,1) PRIMARY KEY,
DetailID	INT
		CONSTRAINT FK_BudgetComponentID
		FOREIGN KEY REFERENCES tblBudgetDetails (DetailID),
Montant		Money,
Description	varchar(50),
)

GO

CREATE TABLE tblSalaries
(
BudgetID	INT
		CONSTRAINT FK_SalariesID
		FOREIGN KEY REFERENCES tblBudget (BudgetID),
EmployeeID	INT
		CONSTRAINT FK_SalariesEmp
		FOREIGN KEY REFERENCES tblEmployee (EmployeeID),
BaseSalary	MONEY,
		CONSTRAINT PK_Salaries PRIMARY KEY(BudgetID, EmployeeID),
points		INT,
Inc		Float,
RRSP		MONEY,
)

GO

CREATE TABLE tblTravelBudget
(
TravelBudgetID	INT
		IDENTITY (0,1)
		CONSTRAINT PK_TravelBudget PRIMARY KEY,
BudgetID	INT
		CONSTRAINT FK_TravelBudgetID
		FOREIGN KEY REFERENCES tblBudget(BudgetID),
EmployeeID	INT
		CONSTRAINT FK_TravelBudgetEmp2
		FOREIGN KEY REFERENCES tblEmployee (EmployeeID),
Type 		VARCHAR(15),
Destination	VARCHAR(30),
CourseTitle	VARCHAR(30),
CostOfCourse	MONEY,
Fares		MONEY,
	Hotel	MONEY,
	Meals	MONEY,
	Entertainment	MONEY,
date	datetime,
)
GO

ALTER TABLE tblMainCat ADD CatID INT IDENTITY

ALTER TABLE tblCapExp ADD CapID INT IDENTITY

go
INSERT INTO tblBudget VALUES(2007,2,getdate(),'1.0.000.000')
GO


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
		INSERT INTO tblBudget VALUES(@year,@EMPID,getdate(),@departmentid,'Insert comments here...')
		Select @BudgetID=BudgetID FROM tblBudget Where year = @year AND departmentid = @departmentid
		INSERT INTO tblCapExp VALUES(@BudgetID,20,0,30,0,30,0,10,0,5,0)
		INSERT INTO tblSummary VALUES(@BudgetID,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
	END
GO

EXEC dbo.prAjoutBudget 2008,'FrancisG','0.0.000.000'

drop procedure prAjoutBudgetDetail
GO
CREATE procedure prAjoutBudgetDetail(@BudgetID int,@NoGl varchar(15))
AS
	Select DetailID from tblBudgetDetails Where BudgetID = @BudgetID AND NoGl = @NoGl

	IF(@@ROWCOUNT = 0)
		INSERT INTO tblBudgetDetails VALUES(@BudgetID,@NoGl)
GO


drop procedure prAjoutDepenseSalaire
GO
CREATE procedure prAjoutDepenseSalaire(@DetailID int,@Salaires money,@Comment varchar(30))
AS

	SELECT * FROM tblComponents Where DetailID=@DetailID
	IF(@@ROWCOUNT = 0)
		INSERT INTO tblComponents VALUES(@DetailID,@Salaires,@Comment)
	ELSE
	BEGIN
		UPDATE tblComponents
		SET Montant = @Salaires
		WHERE DetailID = @DetailID
	END


/*
delete FROM tblGL
Where F2 IS NULL Or LCL IS NULL

SELECT * FROM TBLGL
WHERE GL IN(SELECT GL from tblGL
GROUP BY GL
HAVING COUNT(GL) > 1)
ORDER BY GL

SELECT GL, substring(GL,0,3) + '.' + GL + '.' 'hi'
FROM TBLGL

UPDATE tblGL
SET GL = substring(GL,0,3) + '.' + GL + '.'

UPDATE tblemployee
SET BaseSalary=0
*/

--Select ISNULL(sum(C.Montant),0), D.NoGl, D.detailId FROM tblBudgetDetails AS D FULL JOIN tblComponents AS C ON C.DetailId = D.DetailID Where D.DetailID = 115 GROUP BY D.NoGl,D.detailId


--Select G.GL, G.Description, ISNULL((SELECT sum(montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.detailID = D.DetailID Where D.NoGL = G.GL AND d.BudgetID = 27),0) FROM tblGL AS G

--Select E.name,B.Year,D.description, B.date, ISNULL((SELECT sum(C.Montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS DD ON C.detailID = DD.detailID Where DD.BudgetID = B.budgetID),0) 'Total' from tblBudget AS B INNER JOIN tblemployee AS E ON B.creator = E.employeeid INNER JOIN tblDepartement AS D ON B.departmentid = D.departmentid where B.departmentid IN (SELECT M.departmentid FROM tblManager AS M INNER JOIN tblemployee AS E ON M.employeeId = E.employeeID  Where E.username like 'FrancisG') ORDER BY 'Total'

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
		FROM tblEmployee AS E WHERE departmentid = @departmentID ORDER BY name
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
		FROM tblEmployee AS E WHERE departmentid = @departmentID ORDER BY name
	END

GO

EXEC dbo.prAfficherSalaire 37,'5.0.000.000'

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
CREATE procedure prCellularCarExpense(@budget INT,@nom varchar(30),@Montant money,@operation varchar(10))
AS
	
	DECLARE @EMPID INT

	
	Select @EMPID=employeeID from tblEmployee Where name = @nom

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
DECLARE testcurseur CURSOR
for select catID from tblMainCat order by catid

DECLARE @ID INTEGER
DECLARE @departmentID varchar(15)
DECLARE @Year INT
SELECT @departmentID=departmentID,@Year=Year FROM tblBudget Where BudgetID = @BudgetID

OPEN testcurseur
FETCH NEXT from testcurseur
	INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN

SELECT catID,description,'0','0' FROM tblMainCAt Where catID = @ID
SELECT G.gl,G.description, ISNULL((SELECT sum(montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.detailID = D.DetailID Where D.NoGL = G.GL AND d.BudgetID = @BudgetID),0),CAST(ISNULL((SELECT sum(ISNULL(amount,0)) FROM vGLNOMIS WHERE FY = (@Year - 1) AND department = @departmentID GROUP BY GL, department HAVING GL= G.GL),0) AS MONEY) FROM tblGL AS G Where G.catID = @ID

FETCH NEXT from testcurseur
	INTO @ID
END

Close testcurseur
deallocate testcurseur
GO
EXEC prCurseur 41


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
'))) AS K

--Plus les updates pour les départements

GO
drop procedure prGeneral
GO

Create Procedure prGeneral(@Year INT)
AS
DECLARE testcurseur CURSOR
for select catID from tblMainCat order by catid

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
	Select G.GL, G.Description, '$' + cast(ISNULL((SELECT sum(montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.detailID = D.DetailID INNER JOIN tblBudget AS B ON D.budgetID = B.budgetID Where D.NoGL = G.GL AND B.year = @Year)/12,0) as varchar(100)) 'Per Months','$' + cast(ISNULL((SELECT sum(montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.detailID = D.DetailID INNER JOIN tblBudget AS B ON D.budgetID = B.budgetID Where D.NoGL = G.GL AND B.year = @Year),0) as varchar(100)) 'Total' FROM tblGL AS G Where G.catID = @ID
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
DECLARE testcurseur CURSOR
for select catID from tblMainCat order by catid

DECLARE @GL varchar(15)
DECLARE @departmentID varchar(15)
DECLARE @Year INT

SELECT @GL=NOGL FROM tblBudgetDetails Where DetailID = @DetailID AND BudgetID = @BudgetID

SELECT @departmentID=departmentID,@Year=Year FROM tblBudget Where BudgetID = @BudgetID

SELECT description,ISNULL(amount,0) FROM vGLNomisWithDescription
WHERE GL =@GL AND FY = (@Year-1) AND department = @departmentID

GO

EXEC prGetDetails 54, 78

