using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using analyzer;
using System.Data.SqlClient;
using System.Globalization;
using System.Configuration;
using connecter;

namespace dr_yi
{
    public partial class set : System.Web.UI.Page
    {
        public static DataSet myds;
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
               // DataSet myds = new DataSet();
                myds = myana.ExceltoDs(filePath);
                if (myds.Tables.Count > 0)
                {
                    Fixds();
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

        protected void Button2_Click(object sender, EventArgs e)
        {
            int maxid = 0;
            string target = "drgsdb.dbo.fkb";
            Sql_connecter mysc = new Sql_connecter();
            maxid = mysc.getmaxid(target);
            mysc.writetoserver(myds.Tables[0],target);
        }

        protected void Fixds()
        {
            myds.Tables[0].Columns.Remove("序号");
            myds.Tables[0].Columns.Remove("审核状态");
            myds.Tables[0].Columns.Remove("基金类型");
           // myds.Tables[0].Columns.Remove("分组名称");
            myds.Tables[0].Columns.Remove("基准点数");
            myds.Tables[0].Columns.Remove("成本系数");
            myds.Tables[0].Columns.Remove("重新反馈理由");
            myds.Tables[0].Columns.Remove("参保人ID");
            myds.Tables[0].Columns.Remove("病种规则扣款(元)");
            myds.Tables[0].Columns.Remove("扣除点数");
            myds.Tables[0].Columns.Remove("人员类别");
            myds.Tables[0].Columns.Remove("医生");
            myds.Tables[0].Columns.Remove("新技术分组");
            //myds.Tables[0].Columns.Remove("主手术名称");
            myds.Tables[0].Columns.Remove("分组调整原因");
            myds.Tables[0].Columns.Remove("期望主诊断");
            myds.Tables[0].Columns.Remove("期望主诊断名称");
            myds.Tables[0].Columns.Remove("期望主手术");
            myds.Tables[0].Columns.Remove("期望主手术名称");
            myds.Tables[0].Columns.Remove("期望分组");
            myds.Tables[0].Columns.Remove("期望分组名称");
            myds.Tables[0].Columns.Remove("RW");
            myds.Tables[0].Columns.Remove("病例类型");

            myds.Tables[0].Columns["分组编码"].ColumnName = "fzbm";
            myds.Tables[0].Columns["住院号"].ColumnName = "ybzyh";
            myds.Tables[0].Columns["参保人"].ColumnName = "hzxm";
            myds.Tables[0].Columns["主手术编码"].ColumnName = "ssbm";
            myds.Tables[0].Columns["床位号"].ColumnName = "cwh";
            myds.Tables[0].Columns["出院科室"].ColumnName = "cyks";
            myds.Tables[0].Columns["主手术名称"].ColumnName = "ssmc";
            myds.Tables[0].Columns["分组名称"].ColumnName = "fzmc";

            myds.Tables[0].Columns.Add("ryrq", Type.GetType("System.DateTime"));
            myds.Tables[0].Columns.Add("cyrq", Type.GetType("System.DateTime"));
            myds.Tables[0].Columns.Add("jsrq", Type.GetType("System.DateTime"));
            myds.Tables[0].Columns.Add("fy", Type.GetType("System.Decimal"));
            myds.Tables[0].Columns.Add("id");

            DateTimeFormatInfo dtFormat = new System.Globalization.DateTimeFormatInfo();
            for (int i = 0; i < myds.Tables[0].Rows.Count; i++)
            {
                myds.Tables[0].Rows[i]["ryrq"] = Convert.ToDateTime(myds.Tables[0].Rows[i]["入院日期"].ToString(), dtFormat);
                myds.Tables[0].Rows[i]["jsrq"] = Convert.ToDateTime(myds.Tables[0].Rows[i]["出院日期"].ToString(), dtFormat);
                myds.Tables[0].Rows[i]["cyrq"] = Convert.ToDateTime(myds.Tables[0].Rows[i]["出院结算日期"].ToString(), dtFormat);
                myds.Tables[0].Rows[i]["fy"] = decimal.Parse(myds.Tables[0].Rows[i]["医疗总费用(元)"].ToString());
                myds.Tables[0].Rows[i]["cwh"] = Fixstr(myds.Tables[0].Rows[i]["cwh"].ToString());
            }

            myds.Tables[0].Columns.Remove("入院日期");
            myds.Tables[0].Columns.Remove("出院日期");
            myds.Tables[0].Columns.Remove("出院结算日期");
            myds.Tables[0].Columns.Remove("医疗总费用(元)");
            myds.Tables[0].Columns["id"].SetOrdinal(0);
        }

        protected string Fixstr(string instr)
        {
            if (instr.Length == 1) {
                instr = "0" + instr;
            }
            return instr;
        }
    }
}