USE drgsdb
GO
ALTER proc [dbo].[writetoljb]  
@begid int
as  
begin
create table #Tmp --������ʱ��#Tmp
(
   [cissyxh] [int] NULL,--��ҳ���
   [ybzyh] [zyhchar],--ҽ��סԺ��
)

insert #Tmp
SELECT
 vw.SYXH as cissyxh,fkb.ybzyh
 FROM fkb
 LEFT JOIN
 OPENDATASOURCE( 'SQLOLEDB','Data Source=172.16.1.2;User ID=sa;Password=sql2k5').CISDB.dbo.EMR_BRSYK as vw
 ON
    fkb.hzxm=vw.HZXM 
    and fkb.cwh=vw.CYCW
    and year(fkb.ryrq)=year(vw.RYRQ)
    and month(fkb.ryrq)=month(vw.RYRQ)
    and day(fkb.ryrq)=day(vw.RYRQ)
where
 fkb.id >@begid

end