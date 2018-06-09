CREATE DATABASE drgsdb 
GO

USE [drgsdb]
GO

CREATE TABLE pjfy(--平均费用表
	[id] [int] NOT NULL identity PRIMARY KEY,
	[fxbm] [char](10) NOT NULL,--分组编码
	[fxmc] [varchar](100) NOT NULL,--分组名称
	[jzds] [float],--基准点数
	[bfzbj] [varchar](50),--并发症标记
	[fzlx] [varchar](8),--分组类型
	[zjfy] [float],--组均费用
)

CREATE TABLE [dbo].[icd] (--ICD表
[id] [int] NOT NULL identity PRIMARY KEY,
[bm] [char](16) ,--编码
[bmmc] varchar(100),--编码名称
[py] varchar(20),--拼音码
[wb] varchar(20)--五笔码
)