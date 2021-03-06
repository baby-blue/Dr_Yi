USE drgsdb
GO

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[writetoljb]  
@begid int,
@conn [varchar](128)
as  

begin
--用法：exec writetoljb 0,'Data Source=172.16.1.2;User ID=sa;Password=sql2k5'

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
 vw.SYXH as hissyxh,fkb.ybzyh
 FROM fkb
 LEFT JOIN
 OPENDATASOURCE( ''SQLOLEDB'','''+@conn+''').CISDB.dbo.CPOE_BRSYK as vw
 ON
    fkb.hzxm=vw.HZXM 
    and year(fkb.ryrq)=SUBSTRING(vw.RYRQ,1,4)
    and month(fkb.ryrq)=SUBSTRING(vw.RYRQ,5,2)
    and day(fkb.ryrq)=SUBSTRING(vw.RYRQ,7,2)
    and fkb.cyks=vw.KSMC
where
 fkb.id >'+convert(varchar(20),@begid)+'
 group by 
 syxh,ybzyh'

 exec(@sql)

 insert into ljb(hissyxh,ybzyh) select * from #Tmp

end



go

ALTER proc [dbo].[lhcx]  
--@ksrq char(10),--开始查询日期
--@jsrq char(10),--结束查询日期
@num int,--查询条数（从ljb更新数获取）
@conn char(128)--连接字符串
as  

begin
--用法：exec lhcx 100,'Data Source=172.16.1.2;User ID=sa;Password=sql2k5'
--select @conn='Data Source=172.16.1.2;User ID=sa;Password=sql2k5'
--select @ksrq='2018-02-01'
--select @jsrq='2018-03-01'

if OBJECT_ID('tempdb..#tmp_ljb') is not null
drop table #tmp_ljb

if OBJECT_ID('tempdb..#tmp_ssb') is not null
drop table #tmp_ssb

if OBJECT_ID('tempdb..#tmp_brb') is not null
drop table #tmp_brb

if OBJECT_ID('tempdb..#tmp_zb') is not null
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

CREATE TABLE #tmp_zb (--
[jsrq] [varchar](7) NULL, 
[cyks][char](40) NULL,
[ysgh][char](40) NULL,--医师工号
[ysxm][char](40) NULL,--医师姓名
[ybzyh] [char](20)  NULL,--医保住院号
[sjzyh] [char](20)  NULL,--实际住院号
[hzxm][char](40) NULL,--姓名字段
[zjfy][money] null,--基准费用
[sjfy][money] null,--实际费用
[bl] [decimal](18,2) null,
[fzbm] [char](20) null,
[fzmc][varchar](100) null,
[sjzdbm][char](20) null,
[sjzd][varchar](100) null,
[ssbm][char](20) null,
[ssmc][varchar](100) null,
[sjssmc][varchar](100) null,
[rw] [numeric](5,2) null,--rw
[jzds] [numeric](10,2) null,--基准点数
[cbxs] [numeric](5,2) null,--成本系数
)


insert #tmp_ljb
select top (@num) ljb.hissyxh as hissyxh,ljb.ybzyh as ybzyb from ljb
group by ljb.id,ljb.hissyxh,ljb.ybzyh
order by ljb.id desc
declare @sql3 varchar(8000)



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

insert #tmp_zb
select 
DISTINCT CONVERT(varchar(7), fkb.jsrq, 20) as jsrq,
fkb.cyks,
brb.ysgh,
brb.ysxm,
fkb.ybzyh,
brb.sjzyh,
fkb.hzxm,
pjfy.zjfy,
fkb.fy as sjfy,
cast((pjfy.zjfy/fkb.fy) as decimal(18,2))as bl,
fkb.fzbm,
fkb.fzmc as fzmc,
brb.sjzdbm,
brb.sjzd,
fkb.ssbm,
fkb.ssmc as ssmc,
ssb.ssmc as sjssmc,
fkb.rw,
fkb.jzds,
fkb.cbxs
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
 fkb.ybzyh in (select #tmp_ljb.ybzyh from #tmp_ljb)
 order by jsrq,cyks,ysgh

insert into zb(jsrq,cyks,ysgh,ysxm,ybzyh,sjzyh,hzxm,zjfy,sjfy, bl,fzbm,fzmc,sjzdbm,sjzd,ssbm,ssmc,sjssmc,rw,jzds,cbxs) select * from #tmp_zb

end


go

ALTER proc [dbo].[zbcx]  
@where char(3000)--查询条件字符串
as  

begin
--用法：exec zbcx ''


declare @sql varchar(8000)
select @sql='
select DISTINCT jsrq as 结算日期,
cyks as 出院科室,
ysgh as 工号,
ysxm as 医生,
ybzyh as 医保住院号,
sjzyh as 住院号,
hzxm as 患者姓名,
zjfy as 基准费用,
sjfy  as 实际费用,
bl as 倍率,
fzbm as 分组编码,
fzmc as 分组名称,
sjzdbm as 实际诊断编码,
sjzd as 实际诊断,
ssbm as 手术编码,
ssmc as 手术名称,
sjssmc as 实际手术,
rw as rw,
jzds as 基准点数,
cbxs as 成本系数
 from zb'+@where
exec(@sql) 
end