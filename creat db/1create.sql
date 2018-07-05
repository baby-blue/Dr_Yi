CREATE DATABASE drgsdb 
GO

USE [drgsdb]
GO

--自定义数据类型
Exec sp_addtype bmchar,'char(20)','NULL';
Exec sp_addtype mcvarchar,'varchar(100)','NULL';
Exec sp_addtype pychar,'char(30)','NULL';
Exec sp_addtype xmchar,'char(40)','NULL';
Exec sp_addtype zyhchar,'char(20)','NULL';
GO

CREATE TABLE pjfy(--平均费用表
	[id] [int] NOT NULL identity PRIMARY KEY,
	[fzbm] [bmchar],--分组编码
	[fzmc] [mcvarchar],--分组名称
	[jzds] [float]  NULL,--基准点数
	[bfzbj] [varchar](100)  NULL,--并发症标记
	[fzlx] [int],--分组类型,1外科，2内科
	[zjfy] [float],--组均费用
)

CREATE TABLE [dbo].[icd] (--ICD表
[id] [int] NOT NULL identity PRIMARY KEY,
[bm] [bmchar] NOT NULL,--编码
[bmmc] [mcvarchar] NOT NULL,--编码名称
[py] [pychar] NOT NULL,--拼音码
)

CREATE TABLE [dbo].[icd9] (--ICD9表，手术操作
[id] [int] NOT NULL identity PRIMARY KEY,
[bm] [bmchar] NOT NULL,--编码
[bmmc] [mcvarchar] NOT NULL,--编码名称
[py] [pychar] NOT NULL,--拼音码
)

CREATE TABLE [dbo].[ssdm] (--手术代码表，手术收费表
[id] [int] NOT NULL identity PRIMARY KEY,
[ssdm] [bmchar]  NOT NULL,--手术代码
[dmmc] [mcvarchar] NOT NULL,--代码名称
[py] [pychar] NOT NULL,--拼音码
)

CREATE TABLE [dbo].[fkb] (--反馈表，excel上传表
[id] [int] NOT NULL identity PRIMARY KEY,
[fzbm] [bmchar],--分组编码
[fzmc] [mcvarchar],--分组名称
[ybzyh] [zyhchar],--医保住院号
[hzxm] [xmchar],--姓名字段
[cyks] [xmchar],--出院科室
[ssbm] [bmchar],--手术及操作编码，icd9
[ssmc] [mcvarchar],--手术名称
[cwh] [char](6) NULL,--床位
[ryrq] [datetime] NULL,--入院日期
[cyrq] [datetime] NULL,--出院日期
[jsrq] [datetime] NULL,--结算日期
[fy] [money],--医疗费用
[rw] [numeric](5,2),--rw
[jzds] [numeric](10,2),--基准点数
[cbxs] [numeric](5,2),--成本系数

--[cyksid] [int],--出院科室id
)


CREATE TABLE [dbo].[zb] (--主表，上传表后生成
[id] [int] NOT NULL identity PRIMARY KEY,
[jsrq] [varchar](7) NULL, 
[cyks][xmchar] NULL,
[ysgh][xmchar] NULL,--医师工号
[ysxm][xmchar] NULL,--医师姓名
[ybzyh] [zyhchar],--医保住院号
[sjzyh] [zyhchar],--实际住院号
[hzxm][xmchar],--姓名字段
[zjfy][money] null,--基准费用
[sjfy][money] null,--实际费用
[bl] [decimal](18,2) null,
[fzbm][bmchar],
[fzmc][mcvarchar],
[sjzdbm][bmchar],
[sjzd][mcvarchar],
[ssbm][bmchar],
[ssmc][mcvarchar],
[sjssmc][mcvarchar],
[rw] [numeric](5,2) null,--rw
[jzds] [numeric](10,2) null,--基准点数
[cbxs] [numeric](5,2) null,--成本系数
)


CREATE TABLE [dbo].[ljb](--链接表，医保住院号、首页序号索引
[id] [int] NOT NULL identity PRIMARY KEY,
[hissyxh] [int] NULL,--首页序号
[ybzyh] [zyhchar] Null,--医保住院号
)

CREATE TABLE [dbo].[ksbmb](--床位编码，来自医院数据库
[id] [int] NOT NULL ,
[name] [xmchar] NULL,--科室名称
)

go

--写入数据
/*
insert into ksbmb select id,name from OPENDATASOURCE( 'SQLOLEDB','Data Source=172.16.1.2;User ID=sa;Password=sql2k5').THIS4.dbo.YY_KSBMK 

go
*/
--创建过程

create procedure writetoljb
as

go

create procedure lhcx
as