update table tblNomisGlDEpt

select * from tblNomisGlDEpt

update tblNomisGlDEpt 
set nogl = (select b.nogl from tblnomis b where glnomis = substring(GL,1,11))
where 1=1