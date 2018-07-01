SELECT
 distinct fkb.jsrq as jsrq,vw.ZYYS as ysgh,vw.ZYYSXM as ysxm,fkb.hzxm ,vw.ZYHM as zyh,fkb.cyks,fkb.cwh,vw.RYZD as zdbm,vw.RYZDMC as zszd,vw.ssdm,vw.ssmc,fkb.fy,fkb.ybzyh
 FROM fkb
 LEFT JOIN
 (select 
       a.ZYYS,a.ZYYSXM,c.name,a.CYCW,a.HZXM,a.ZYHM,a.RYRQ,a.RYZD,a.RYZDMC,b.ssdm,b.ssmc
       from
       OPENDATASOURCE( 'SQLOLEDB','Data Source=172.16.1.2;User ID=sa;Password=sql2k5').CISDB.dbo.EMR_BRSYK as a
       LEFT JOIN
       OPENDATASOURCE( 'SQLOLEDB','Data Source=172.16.1.2;User ID=sa;Password=sql2k5').THIS4.dbo.SS_SSDJK as b
       on
       b.blh= a.zyhm
       ,OPENDATASOURCE( 'SQLOLEDB','Data Source=172.16.1.2;User ID=sa;Password=sql2k5').THIS4.dbo.YY_KSBMK as c  
       where
       a.CYKS=c.id
 ) as vw
 ON
    fkb.hzxm=vw.HZXM 
    and fkb.cwh=vw.CYCW
    and year(fkb.ryrq)=year(vw.RYRQ)
    and month(fkb.ryrq)=month(vw.RYRQ)
    and day(fkb.ryrq)=day(vw.RYRQ)
where
 fkb.jsrq between '2018-03-01' and '2018-03-10'
order by
 cyks,ysgh