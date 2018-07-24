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
            <td class="lbbarer" onclick="showdrgs();">DRGS</td>
            <td class="lbbarer" onclick="c();">排班表</td>
            <td class="lbbarer" onclick="c();">查号易</td>
             <td></td>
            <td class="lbbarer" onclick="c();">⚪</td>
            </tr>
        </table>
            <script>
                function c() {
                    confirm('敬请期待');
                }
                function showdrgs() {
                    window.parent.window.frames["centerFrame"].window.location.href = '../mainpage/drgs.aspx';
                }
            </script>
    </form>
</body>
</html>
