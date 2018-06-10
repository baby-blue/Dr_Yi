CREATE DATABASE drgsdb 
GO

USE [drgsdb]
GO

--自定义数据类型
Exec sp_addtype bmchar,'char(20)','Not Null'
Exec sp_addtype mcvarchar,'varchar(100)','Not Null'
Exec sp_addtype pychar,'char(30)'
GO

CREATE TABLE pjfy(--平均费用表
	[id] [int] NOT NULL identity PRIMARY KEY,
	[fzbm] [bmchar],--分组编码
	[fzmc] [mcvarchar],--分组名称
	[jzds] [float],--基准点数
	[bfzbj] [varchar](100),--并发症标记
	[fzlx] [int],--分组类型,1外科，2内科
	[zjfy] [float],--组均费用
)

CREATE TABLE [dbo].[icd] (--ICD表
[id] [int] NOT NULL identity PRIMARY KEY,
[bm] [bmchar],--编码
[bmmc] [mcvarchar],--编码名称
[py] [pychar],--拼音码
)

CREATE TABLE [dbo].[icd9] (--ICD9表，手术操作
[id] [int] NOT NULL identity PRIMARY KEY,
[bm] [bmchar],--编码
[bmmc] [mcvarchar],--编码名称
[py] [pychar],--拼音码
)

CREATE TABLE [dbo].[ssdm] (--手术代码表，手术收费表
[id] [int] NOT NULL identity PRIMARY KEY,
[ssdm] [bmchar] ,--手术代码
[dmmc] [mcvarchar],--代码名称
[py] [pychar],--拼音码
)