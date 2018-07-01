USE drgsdb
GO

ALTER proc [dbo].[writetoljb]  
@begid int,
@conn [varchar](128)
as  

begin

if OBJECT_ID('tempdb..#Tmp') is not null
drop table #Tmp

create table #Tmp --������ʱ��#Tmp
(
   [hissyxh] [int] NULL,--��ҳ���
   [ybzyh] [char](20) null,--ҽ��סԺ��
)
declare @sql varchar(8000)

select @sql='
insert #Tmp
SELECT
 vw.HISSYXH as hissyxh,fkb.ybzyh
 FROM fkb
 LEFT JOIN
 OPENDATASOURCE( ''SQLOLEDB'','''+@conn+''').CISDB.dbo.EMR_BRSYK as vw
 ON
    fkb.hzxm=vw.HZXM 
    and fkb.cwh=vw.CYCW
    and year(fkb.ryrq)=year(vw.RYRQ)
    and month(fkb.ryrq)=month(vw.RYRQ)
    and day(fkb.ryrq)=day(vw.RYRQ)
where
 fkb.id >'+convert(varchar(20),@begid)+'
 group by 
 hissyxh,ybzyh'

 exec(@sql)

 insert into ljb(hissyxh,ybzyh) select * from #Tmp

end

go

ALTER proc [dbo].[lhcx]  
@ksrq char(10),--��ʼ��ѯ����
@jsrq char(10),--������ѯ����
@conn char(128)--�����ַ���
as  

begin
--�÷���exec lhcx '2018-02-01','2018-03-01','Data Source=172.16.1.2;User ID=sa;Password=sql2k5'
--select @conn='Data Source=172.16.1.2;User ID=sa;Password=sql2k5'
--select @ksrq='2018-02-01'
--select @jsrq='2018-03-01'

if OBJECT_ID('tempdb..#tmp_ljb') is not null
drop table #tmp_ljb

if OBJECT_ID('tempdb..#tmp_ssb') is not null
drop table #tmp_ssb

if OBJECT_ID('tempdb..#tmp_brb') is not null
drop table #tmp_brb

create table #tmp_ljb --
(
   [hissyxh] [int] ,--his��ҳ���
   [ybzyh] [char](20) null,--ҽ��סԺ��
)

create table #tmp_ssb --
(
   [ybzyh] [char](20) null,--ҽ��סԺ��
   [ssdm] [char](20)  NULL,--��������
   [ssmc] [varchar](100) NULL,--��������
)

create table #tmp_brb --
(
   [ybzyh] [char](20) null,--ҽ��סԺ��
   --[hissyxh] [int]  NULL,--his��ҳ���
   [sjzyh] [char](20)  NULL,--ʵ��סԺ��
   [ysgh]  [char](20) NULL,--ҽʦ����
   [ysxm] [char](20)  NULL,--ҽʦ����
   --[ksmc] [char](20)  NULL,--��������
   --[cw] [char](20)  NULL,--��λ
   [sjzdbm] [char](20)  NULL,--ʵ����ϱ���
   [sjzd] [varchar](100) NULL,--ʵ�����
)


insert #tmp_ljb
select ljb.hissyxh as hissyxh,ljb.ybzyh as ybzyb from fkb,ljb
 where
 ljb.ybzyh=fkb.ybzyh
 and fkb.jsrq between @ksrq and @jsrq
 and hissyxh is not null
group by ljb.hissyxh,ljb.ybzyh


declare @sql varchar(8000)
select @sql='insert #tmp_ssb
 select ljb2.ybzyh as ybzyh ,left(vw.ssdm,20) as ssdm ,left(vw.ssmc,100) as ssmc from
 OPENDATASOURCE(''SQLOLEDB'','''+'Data Source=172.16.1.2;User ID=sa;Password=sql2k5'+''').THIS4.dbo.SS_SSDJK as vw,
 #tmp_ljb as ljb2
 where vw.syxh=ljb2.hissyxh'
exec(@sql) 

declare @sql2 varchar(8000)
select @sql2='insert #tmp_brb
select 
 ljb.ybzyh as ybzyh,a.ZYHM as sjzyh,a.ZYYS as ysgh,a.ZYYSXM as ysxm, a.RYZD as sjzdbm,left(a.RYZDMC,100) as sjzd
 from
 OPENDATASOURCE(''SQLOLEDB'','''+'Data Source=172.16.1.2;User ID=sa;Password=sql2k5'+''').CISDB.dbo.EMR_BRSYK as a
 ,#tmp_ljb as ljb
 where
 a.HISSYXH = ljb.hissyxh'
exec(@sql2) 
/*
select * from #tmp_ljb
select * from #tmp_ssb
select * from #tmp_brb
*/
select DISTINCT CONVERT(varchar(7), fkb.jsrq, 20) as jsrq,fkb.cyks,brb.ysgh,brb.ysxm,fkb.ybzyh,brb.sjzyh,fkb.hzxm,pjfy.zjfy,fkb.fy as sjfy,cast((pjfy.zjfy/fkb.fy) as decimal(18,2))as bl,fkb.fzbm,fkb.fzmc as fzmc,brb.sjzdbm,brb.sjzd,fkb.ssbm,fkb.ssmc as ssmc,ssb.ssmc as sjssmc
 from fkb 
 left join
 #tmp_brb brb
 on
 fkb.ybzyh=brb.ybzyh 
 left join
 #tmp_ssb ssb
 on
 fkb.ybzyh=ssb.ybzyh
 left join
 pjfy pjfy
 on
 fkb.fzbm=pjfy.fzbm
 where
 fkb.jsrq between @ksrq and @jsrq
 order by jsrq,cyks,ysgh

end