USE LCLADMIN


SET NOCOUNT ON



DROP VIEW  GetManager
DROP TABLE tblTravelBudget
DROP TABLE tblSalaries
DROP TABLE tblBudgetDetails
DROP TABLE tblBudget

drop table tblEmployee



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
		CONSTRAINT PK_Budget
		PRIMARY KEY,
Year		INT,
Creator		varchar(30),
Date		datetime,
DepartmentID	varchar(15)
		CONSTRAINT FK_BudgetDep
		FOREIGN KEY REFERENCES tblDepartement (DepartmentID),	
)


GO

CREATE TABLE tblBudgetDetails
(
BudgetID	INT
		CONSTRAINT FK_BudgetDetailsID
		FOREIGN KEY REFERENCES tblBudget (BudgetID),
NoGL		nvarchar(15) NOT NULL
		CONSTRAINT FK_BudgetDetailsGl
		FOREIGN KEY REFERENCES tblGL (GL)
		CONSTRAINT PK_BudgetDetails PRIMARY KEY(BudgetID, NoGL),
Montant		MONEY,
Flag		INT,
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
NoGL		nvarchar(15)
		CONSTRAINT FK_SalariesGL
		FOREIGN KEY REFERENCES tblGL (GL),
BaseSalary	MONEY,
		CONSTRAINT PK_Salaries PRIMARY KEY(BudgetID, EmployeeID),
points		INT,
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
		CONSTRAINT FK_TravelBudgetEmp
		FOREIGN KEY REFERENCES tblEmployee (EmployeeID),
Destination	VARCHAR(30),
CourseTitle	VARCHAR(30),
CostOfCourse	MONEY,
Price		MONEY,
Expenses	MONEY,
)
GO

INSERT INTO tblBudget VALUES(2007,'Francis',getdate(),2)
GO


GO
drop procedure prAjoutSalaire

GO
CREATE procedure prAjoutSalaire(@BudgetID INT,@nom varchar(30),@GL varchar(10),@salary money,@points int)
AS
	DECLARE @EMPID INT

	Select @EMPID=employeeID from tblEmployee Where name = @nom

	IF(@EMPID IS NOT NULL)
	BEGIN
	SELECT * FROM tblsalaries WHERE BudgetID=@BudgetID AND EmployeeID = @EMPID AND NoGL = @GL
	IF(@@ROWCOUNT = 0)
		INSERT INTO tblsalaries VALUES(@BudgetID,@EMPID,@GL,@salary,@points)
	ELSE
	BEGIN
		UPDATE tblsalaries
		SET BaseSalary = @salary,points = @points
		WHERE BudgetID=@BudgetID AND EmployeeID = @EMPID AND NoGL = @GL
	END
	END

GO
--EXEC dbo.prAjoutSalaire 1,'Gaulin, Denis','test',5111100.14,1451

GO


SELECT E.name, d.description from tblmanager AS A INNER JOIN tblEmployee AS E ON A.employeeID = E.EmployeeID INNER JOIN tbldepartement AS D ON A.departmentID = D.DepartmentID



SELECT E.name, D.description FROM tblmanager AS A INNER JOIN tbldepartement AS D ON A.departmentID = D.departmentID INNER JOIN tblemployee AS E ON A.employeeID = E.employeeID

select * from tblemployee Where name like '%Louis%'
select * from tbldepartement Where description like 'SSS'

INSERT INTO tblmanager VALUES(20,'7.0.000.000')
INSERT INTO tblmanager VALUES(23,'4.0.000.000')
INSERT INTO tblmanager VALUES(23,'4.0.000.000')

INSERT INTO tblmanager VALUES(20,'6.0.000.000')

delete from tblmanager where employeeID = 46

INSERT INTO tblmanager VALUES(162,'0.0.000.000')
INSERT INTO tblmanager VALUES(162,'2.1.000.000')
	

