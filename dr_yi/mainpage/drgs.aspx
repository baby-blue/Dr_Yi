<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="drgs.aspx.cs" StylesheetTheme="yi_css" Inherits="dr_yi.drgs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>DRGS助手</title>
</head>
<body class="centerframe">
    <form id="form1" runat="server">
        <div class="centerdiv">
            <div>
                <label>科室：</label>
                <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>
                <label>月份：</label>
                <asp:TextBox ID="TextBox1" runat="server"> </asp:TextBox>
                <label >医生工号：</label>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <label>   </label>
                <asp:Button ID="Button1" runat="server" Text="查询" OnClick="Button1_Click" />
            </div>
            <div style="height: 20px"></div>
            <div>
                <asp:GridView ID="GridView1" runat="server"></asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
