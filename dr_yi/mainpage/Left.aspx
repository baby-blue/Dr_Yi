<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Left.aspx.cs" StylesheetTheme="yi_css"  Inherits="dr_yi.mainpage.Left" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript"></script>
</head>
<body style="background-color:gray">
    <form>
        <table id="t" runat="server" cellpadding="0" cellspacing="0" style="width: 200px; text-align: center; margin: 0px;">
            <tr>
                <td onclick="c();">业务量查询</td>
            </tr>
            <tr>
                <td onclick="c();">用药预警</td>
            </tr>
            <tr>
                <td onclick="c();">出院回访</td>
            </tr>
        </table>
        <script>
            var t = document.getElementById('t').getElementsByTagName('tr'),
                len = t.length;
            for (var i = 0; i < len; i++) {
               // t[i].className = 'lbbarer';
            }
            function c() {
                confirm('敬请期待');
            }
        </script>
    </form>
</body>
</html>
