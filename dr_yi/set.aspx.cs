using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using analyzer;

namespace dr_yi
{
    public partial class set : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //如果以选择文件
            if (fupfile.HasFile)
            {
                //文件
                string fileName = "1.xls";
                //保存文件
                string filePath = Server.MapPath("~/Upfiles/" + fileName);
                fupfile.SaveAs(filePath);
                //提示
                divState.InnerHtml = "上传成功！";
                Excel_analyzer myana = new Excel_analyzer();
                DataSet myds = new DataSet();
                myds = myana.ExceltoDs(filePath);
                if (myds.Tables.Count > 0)
                {
                    excelview.DataSource = myds;
                    excelview.DataBind();
                }
            }
            else
            {
                //提示
                divState.InnerHtml = "<h5>请选择上传文件！</h5>";
            }
        }

    }
}