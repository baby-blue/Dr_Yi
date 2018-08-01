<%@ Page Language="C#" AutoEventWireup="true" StylesheetTheme="yi_css"  CodeBehind="Top.aspx.cs" Inherits="dr_yi.mainpage.Top" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="headbar">
        </div>
        <table class="dhbar">
            <tr>
            <td class="lbbarer" onclick="d();"><img src="../ico.png" height="35" width="30"/></td>
            <td class="lbbarer" onclick="showdrgs();">DRGS助手</td>
            <td class="lbbarer" onclick="showtools();">工具易</td>
            <td class="lbbarer" onclick="c();">排班表</td>
            <td class="lbbarer" onclick="c();">查号易</td>
             <td></td>
            <td class="lbbarer" onclick="e();">欢迎</td>
            </tr>
        </table>
            <script>
                function c() {
                    confirm('敬请期待');
                }
                function e() {
                    confirm('欢迎');
                }
                function d() {
                    confirm('这是一个圆圈圈');
                }
                function showdrgs() {
                    window.parent.document.getElementById("ciframe").src = "../mainpage/drgs.aspx";
                }
                function showtools() {
                    window.parent.document.getElementById("ciframe").src = "../mainpage/tools.aspx";
                }
            </script>
    </form>
</body>
</html>
