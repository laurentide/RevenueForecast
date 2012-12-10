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
