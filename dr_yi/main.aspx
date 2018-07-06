<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="dr_yi.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<frameset rows="180,*,20" cols="*" framespacing="0" frameborder="no" border="0">
          <frame id="topFrame" src="../main/Top.aspx" name="topFrame" scrolling="No" title="topFrame"></frame>
          <frameset name="middleFrame" id="middleFrame" rows="*" cols="200,*" framespacing="0" border="0">
              <frame id="leftFrame" name="leftFrame" frameborder="no" style="position:absolute;display: inline;border: 2px solid #808080;border-top:none;border-bottom:none;border-left:none;" scrolling="No" title="leftFrame" src="../main/Left.aspx"></frame>
              <frame name="centerFrame" id="centerFrame" frameborder="no" style="position:absolute;" scrolling="No" title="centerFrame" src="../main/drgs.aspx"> </frame>
          </frameset>    
          <frame id="bottomFrame" src="../main/Bottom.aspx" name="bottomFrame" scrolling="No" title="bottomFrame"></frame>
    </frameset>
</html>
