--Create the linked server



/*
GO

SELECT * INTO tblEmployee2 FROM
(select * from openquery
(
ADSI,'SELECT cn, name , sAMaccountname,department, company
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
WHERE objectCategory = ''Person'' AND objectClass = ''user'' AND department = ''System & Service''
')) AS K

ALTER TABLE tblEmployee2
ADD  NoEMP INT IDENTITY(1,1) PRIMARY KEY

select * from openquery
(
ADSI,'SELECT cn
FROM ''LDAP://DC=ADC,DC=laurentidecontrols, DC=COM''
WHERE objectClass = ''group'' and cn = ''LCL_Manager''
') 



select * from openquery
(
ADSI,'SELECT name
FROM ''LDAP://OU=LCL_USER,DC=ADC,DC=laurentidecontrols, DC=COM''
where objectClass = ''user''and objectCategory = ''Person'' and memberof = ''cn=LCL_Manager,OU=Global Security Group,DC=adc,dc=laurentidecontrols,dc=com''
')



--AND memberOf=''adc.laurentidecontrols.com/Global Security Group/LCL_Manager''
--GO
--WHERE objectCategory = ''Person'' AND objectClass = ''user''


--Drop linked server


--'sp_tables_ex ADSI'

--'sp_tables ADSI'

--'delete from tblEmployee2'

*/