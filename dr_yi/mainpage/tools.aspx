<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tools.aspx.cs" Inherits="dr_yi.mainpage.tools" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>工具易</title>
    <script>
        function changeFrameHeight() {
            var ifm2 = document.getElementById("riframe");
            ifm2.height = document.documentElement.clientHeight;
            ifm2.width = document.documentElement.clientWidth - 200;

            var ifm = document.getElementById("liframe");
            ifm.height = ifm2.height;
        }
        window.onresize = function () { changeFrameHeight(); }
        $(function () { changeFrameHeight(); });
    </script>
</head>
<body style="margin: 0; padding: 0; overflow: hidden">
    <script type="text/javascript">
        window.parent.document.title = document.title;
    </script>
    <form id="form1" runat="server">
        <div style="width: 100%">
            <div style="width: 200px; float: left; display: inline">
                <iframe id="liframe" style="margin: 0; padding: 0; width: 200px; display: block; border: 0px; background-color: darkgray" src="../mainpage/left.aspx"></iframe>
            </div>
            <div style="float: left; display: inline">
                <iframe id="riframe" style="margin: 0; padding: 0; display: block; border: 0px" src="../mainpage/drgs.aspx"></iframe>
            </div>
        </div>
        <div style="clear: both"></div>
    </form>
    <script>
        var ifm2 = document.getElementById("riframe");
        ifm2.height = document.documentElement.clientHeight;
        ifm2.width = document.documentElement.clientWidth - 200;

        var ifm = document.getElementById("liframe");
        ifm.height = ifm2.height;

    </script>
</body>
</html>
