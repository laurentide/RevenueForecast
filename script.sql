USE LCLADMIN


SET NOCOUNT ON




DROP TABLE tblTravelBudget
DROP TABLE tblSalaries
DROP TABLE tblBudgetDetails
DROP TABLE tblBudget

drop table tblEmployee
DROP TABLE tblDepartment
DROP TABLE tblGL

CREATE TABLE tblGL
(NoGL	varchar(15)
	CONSTRAINT PK_GL
	PRIMARY KEY,
Description varchar(50) NOT NULL,
)



SELECT * INTO tblDepartment FROM (select department from openquery
				(
				ADSI,'SELECT department, company
				FROM ''LDAP://OU=LCL_user,DC=ADC,DC=laurentidecontrols, DC=COM''
				WHERE objectCategory = ''Person'' AND objectClass = ''user''')
				GROUP BY department, company 
				HAVING company='Laurentide Controls Ltd.' and department IS NOT NULL )AS K

ALTER TABLE tblDepartment
ADD  DepartmentID INT IDENTITY(1,1) PRIMARY KEY



SELECT * INTO tblEmployee FROM
(select name ,department from openquery
(
ADSI,'SELECT name ,department
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
WHERE objectCategory = ''Person'' AND objectClass = ''user'' AND company=''Laurentide Controls Ltd.''
') WHERE department IS NOT NULL) AS K

GO
ALTER TABLE tblEmployee
ADD  EmployeeID INT IDENTITY(1,1) PRIMARY KEY

GO
ALTER TABLE tblEmployee
ADD departmentID INT FOREIGN KEY REFERENCES tblDepartment (DepartmentID)

GO
UPDATE    tblEmployee
SET   departmentID = tblDepartment.DepartmentID
FROM         tblDepartment, tblEmployee
WHERE     tblEmployee.department=tblDepartment.department

GO
ALTER TABLE tblEmployee
DROP COLUMN department

GO
ALTER TABLE tblEmployee
ADD Manager bit DEFAULT 0

GO
UPDATE tblEmployee
SET Manager = 0

GO
UPDATE tblEmployee
SET Manager = 1
WHERE name IN(select * from openquery
(
ADSI,'SELECT name
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
where objectClass = ''user''and objectCategory = ''Person'' and memberof = ''cn=LCL_Manager,OU=Global Security Group,DC=adc,dc=laurentidecontrols,dc=com''
'))

GO

CREATE TABLE tblBudget
(
BudgetID	INT
		IDENTITY (0,1)
		CONSTRAINT PK_Budget
		PRIMARY KEY,
Year		INT,
Creator		varchar(30),
Date		datetime,
DepartmentID	INT
		CONSTRAINT FK_BudgetDep
		FOREIGN KEY REFERENCES tblDepartment (DepartmentID),	
)


GO

CREATE TABLE tblBudgetDetails
(
BudgetID	INT
		CONSTRAINT FK_BudgetDetailsID
		FOREIGN KEY REFERENCES tblBudget (BudgetID),
NoGL		varchar(15) NOT NULL
		CONSTRAINT FK_BudgetDetailsGl
		FOREIGN KEY REFERENCES tblGL (NoGL)
		CONSTRAINT PK_BudgetDetails PRIMARY KEY(BudgetID, NoGl),
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
NoGL		varchar(15)
		CONSTRAINT FK_SalariesGL
		FOREIGN KEY REFERENCES tblGL (NoGL),
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


INSERT INTO tblBudget VALUES(2007,'Francis',getdate(),11)

INSERT INTO tblGL VALUES('test','test')

drop procedure prAjoutSalaire

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


EXEC dbo.prAjoutSalaire 0,'Gauthier, Francis','test',5111100.14,1455


declare @test varchar(30)

-----YOUPI!!!!!!
CREATE VIEW GetOU AS
select * from openquery
(
ADSI,'SELECT name
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
where objectCategory = ''organizationalUnit'' AND members = ''Whitelaw, Dean''
')


CREATE VIEW GetManagerDepartment AS
select name 'Manager', SUBSTRING(DistinguishedName,len(name)+9,charindex(',',SUBSTRING(DistinguishedName,len(name)+9,LEN(DistinguishedName)))-1)'Department' from openquery
(
ADSI,'SELECT name, DistinguishedName
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
where objectClass = ''user''and objectCategory = ''Person'' and memberof = ''cn=LCL_Manager,OU=Global Security Group,DC=adc,dc=laurentidecontrols,dc=com''
')

	

