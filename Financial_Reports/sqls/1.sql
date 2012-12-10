select * from tblgl, tblmaincat where rptdesc = 'Warehouse Materials'
and tblgl.catid = tblmaincat.catid

select * from tblgl
order by rptdesc

select * from tblmaincat

update tblgl
set catid = 2
where gl = '08.0801360.'

commit