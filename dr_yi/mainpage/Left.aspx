<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Left.aspx.cs" StylesheetTheme="yi_css" Inherits="main_leftFrame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript"></script>
</head>
<body>
    <form>
        <table id="t" runat="server" cellpadding="0" cellspacing="0" style="width: 200px; text-align: center; margin: 0px;">
            <tr>
                <td onclick="showdrgs();">DRGS</td>
            </tr>
            <tr>
                <td onclick="c();">排班表</td>
            </tr>
            <tr>
                <td onclick="c();">查号易</td>
            </tr>
        </table>
        <script>
            var t = document.getElementById('t').getElementsByTagName('tr'),
                len = t.length;
            for (var i = 0; i < len; i++) {
                t[i].className = 'lbbarer';
            }
            function c() {
                confirm('敬请期待');
            }
            function showdrgs() {
                window.parent.window.frames["centerFrame"].window.location.href = '../main/drgs.aspx';
            }
        </script>
    </form>
</body>
</html>
