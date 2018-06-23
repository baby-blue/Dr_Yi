<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="set.aspx.cs" Inherits="dr_yi.set" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div>
        <hr />
        请选择文件：<asp:FileUpload ID="fupfile" runat="server" />
        &nbsp;<asp:Button ID="btnSubmit" runat="server" Text="上传并分析"  onclick="btnSubmit_Click" />
        &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="fupfile"
            ErrorMessage="必须是xls文件" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.xls|.XLS|.Xls|.XLs|.XlS|.xlS)$"></asp:RegularExpressionValidator>
        &nbsp;<asp:Button ID="Button2" runat="server" Text="提交"  onclick="Button2_Click" />
        <hr />
        状态：<div id="divState" runat="server"></div>
    </div>
        <asp:GridView ID="excelview" runat="server"></asp:GridView>
    </form>
</body>
</html>
