<%@ Page Language="C#" AutoEventWireup="true" StylesheetTheme="yi_css" CodeFile="pbwin.aspx.cs" Inherits="main_pbwin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新排班表</title>
    <script src="../js/WebCalendar.js" type="text/javascript"></script>
    <script type="text/javascript">
        var obj = new Object();
        obj = window.dialogArguments;
        function caldate() {
            if (document.getElementById("BegDateIpt").value.length > 6 && document.getElementById("OverDateIpt").value.length > 6) {
                var temper1 = document.getElementById("BegDateIpt").value;
                var dt1 = new Date(temper1.replace(/-/, "/"));
                var temper2 = document.getElementById("OverDateIpt").value;
                var dt2 = new Date(temper2.replace(/-/, "/"));
                day = (dt2 - dt1) / (24 * 60 * 60 * 1000)+1;
                if (day > 0) {
                    if (day < 30) {
                        document.getElementById("DaysIpt").value = day;
                    } else {
                        confirm("选择日期跨度过大，请小于30天");
                        document.getElementById("DaysIpt").value = '';
                    }
                } else {
                    confirm("选择日期错误");
                    document.getElementById("DaysIpt").value = '';
                }
            }
        }
        function chkdate() {
            var bd = document.getElementById("BegDateIpt").value;
            var od = document.getElementById("OverDateIpt").value;
            var dipt = document.getElementById("DaysIpt").value;
            if (bd.replace(/(^s*)|(s*$)/g, "").length != 0 && dipt.replace(/(^s*)|(s*$)/g, "").length != 0) {
                document.getElementById("BegPb").click();
            } else {
                confirm("请先正确选择排班开始及结束日期！");
            }
        }
        function issave() {
            var save = confirm("排班完成，现在提交排班吗？");
            if (save) {
                document.getElementById("SaveBut").click();
            }
        }
        function isclear() {
            var clear = confirm("确定还原本次排班操作吗？");
            if (clear) {
                document.getElementById("ClearBut").click();
            }
        }
        function isdel() {
            var del = confirm("确定删除这轮所有排班吗？\n此项操作将无法恢复！");
            if (del) {
                document.getElementById("DelBut").click();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-size: x-large">
            <center><label id="myTitle" runat="server">排班表</label></center>
        </div>
        <div></div>
        <div style="height: 10px"></div>
        <div>
            从
            <input id="BegDateIpt" runat="server" readonly="true" style="width: 80px; text-align: center;" onclick="SelectDate(this, 'yyyy-MM-dd') " onchange="caldate();" />
            到
            <input id="OverDateIpt" runat="server" readonly="true" style="width: 80px; text-align: center;" onclick="SelectDate(this, 'yyyy-MM-dd')" onchange="caldate();" />
            共
            <input id="DaysIpt" runat="server" readonly="true" style="width: 30px; text-align: center;" />
            天
            <input id="beg_pb" type="button" onclick="chkdate();" value="开始排班" />
            <asp:Button runat="server" ID="BegPb" Style="display: none;" OnClick="BegPb_Click" />
        </div>
        <div style="height: 10px"></div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        </div>
        <table id="pbtb" runat="server" style="table-layout: fixed; width: 100%; border-collapse: collapse; display: none; background-color: #d7f0fc">
            <tr style="background-image: url('../App_Themes/yi_css/gridbg.jpg')">
                <td style="width: 65px; margin: 0; border-width: 0px; padding: 0; vertical-align: top">
                    <div style="overflow-x: auto; overflow-y: auto; margin: 0">
                        <asp:GridView ID="NameGrid" runat="server" align="center" AutoGenerateColumns="False" CellPadding="4" EnableModelValidation="True" ForeColor="#333333" GridLines="None" Style="text-align: center; margin: 0" OnRowDataBound="NameGrid_RowDataBound">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate><%# Eval("name") %></ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        </asp:GridView>
                    </div>
                </td>
                <td style="margin: 0; border-width: 0px; padding: 0; vertical-align: top">
                    <div style="overflow-x: auto; overflow-y: auto; margin: 0">
                        <asp:GridView ID="PbGrid" runat="server" Style="text-align: center; margin: 0px" CellPadding="4" EnableModelValidation="True" ForeColor="#333333" GridLines="None" OnRowDataBound="PbGrid_RowDataBound">
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr><td>说明</td><td><asp:TextBox ID="TextBox1" runat="server" Height="68px" style="width:100% "></asp:TextBox></td></tr>
            <tr>
                <td></td>
                <td style="float: right">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <input type="button" style="float: right; margin: 5px;" value="删除！" onclick="isdel();" />
                            <input type="button" style="float: right; margin: 5px;" value="还原" onclick="isclear();" />
                            <input type="button" style="float: right; margin: 5px;" value="保存" onclick="issave();" />
                            <asp:Button ID="SaveBut" runat="server" Style="display: none;" OnClick="SaveBut_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="ClearBut" runat="server" Style="display: none;" OnClick="ClearBut_Click" />
                    <asp:Button ID="DelBut" runat="server" Style="display: none;" OnClick="DelBut_Click" />
                </td>
            </tr>
                
        </table>
        
    </form>
</body>
</html>
