<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" StylesheetTheme="yi_css" Inherits="dr_yi.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <script>
        function changeFrameHeight() {
            var ifm = document.getElementById("ciframe");
            ifm.height = document.documentElement.clientHeight - 75;
        }
        window.onresize = function () { changeFrameHeight(); }
        $(function () { changeFrameHeight(); });
    </script>
</head>
<body style="margin: 0; padding: 0; overflow: hidden">
    <form id="form1" runat="server">
        <div style="width: 100%">
            <iframe id="tiframe" style="margin: 0; padding: 0; width: 100%; height: 50px; display:block;border:0px" src="../mainpage/top.aspx"></iframe>
            <iframe id="ciframe" style="margin: 0; padding: 0; width: 100%; display:block;border:0px" src="../mainpage/drgs.aspx"></iframe>
            <iframe id="biframe" style="margin: 0; padding: 0; width: 100%; height: 25px; display:block;border:0px" src="../mainpage/bottom.aspx"></iframe>
        </div>
    </form>
    
    <script>
        var ifm = document.getElementById("ciframe");
        ifm.height = document.documentElement.clientHeight - 75
    </script>
</body>
</html>
