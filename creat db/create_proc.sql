USE drgsdb
GO

ALTER proc [dbo].[writetoljb]  
@begid int,
@conn [varchar](128)
as  

begin

if OBJECT_ID('tempdb..#Tmp') is not null
drop table #Tmp

create table #Tmp --创建临时表#Tmp
(
   [hissyxh] [int] NULL,--首页序号
   [ybzyh] [char](20) null,--医保住院号
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
@ksrq char(10),--开始查询日期
@jsrq char(10),--结束查询日期
@conn char(128)--连接字符串
as  

begin
--用法：exec lhcx '2018-02-01','2018-03-01','Data Source=172.16.1.2;User ID=sa;Password=sql2k5'
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
   [hissyxh] [int] ,--his首页序号
   [ybzyh] [char](20) null,--医保住院号
)

create table #tmp_ssb --
(
   [ybzyh] [char](20) null,--医保住院号
   [ssdm] [char](20)  NULL,--手术代码
   [ssmc] [varchar](100) NULL,--手术名称
)

create table #tmp_brb --
(
   [ybzyh] [char](20) null,--医保住院号
   --[hissyxh] [int]  NULL,--his首页序号
   [sjzyh] [char](20)  NULL,--实际住院号
   [ysgh]  [char](20) NULL,--医师工号
   [ysxm] [char](20)  NULL,--医师姓名
   --[ksmc] [char](20)  NULL,--科室名称
   --[cw] [char](20)  NULL,--床位
   [sjzdbm] [char](20)  NULL,--实际诊断编码
   [sjzd] [varchar](100) NULL,--实际诊断
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