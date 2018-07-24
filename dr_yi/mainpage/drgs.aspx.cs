using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using connecter;

namespace dr_yi
{
    public partial class drgs : System.Web.UI.Page
    {
        public static Sql_connecter mycon;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadks();
            }
        }

        protected void loadks() {
            mycon = new Sql_connecter();
            DataSet ds = mycon.getks();
            if (ds != null) {
                DataTable dt = ds.Tables[0];
                DropDownList1.DataSource = dt.DefaultView;
                DropDownList1.DataValueField = dt.Columns[0].ColumnName;
                DropDownList1.DataTextField = dt.Columns[0].ColumnName;
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("", ""));
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Label1.Text = "";
            string rq = rqBox1.Text.Trim();
            string ks = DropDownList1.Text.Trim();
            string gh = ghBox2.Text.Trim();
            string sql = "";
            if (rq == "") {
                Label1.Text = "请选择月份！" ;
            }
            else
            {
                if (gh == "")
                {
                    if (ks == "")
                    {
                        sql = "jsrq='" + rq + "'";
                    }
                    else
                    {
                        sql = "jsrq='" + rq + "' and cyks='" + ks + "'";
                    }
                }
                else
                {
                    sql = "jsrq = '" + rq + "' and ysgh = '" + gh + "'";
                }
                mycon = new Sql_connecter();
                DataSet ds = mycon.getzb(sql);
                GridView1.DataSource = ds.Tables[0];
                GridView1.DataBind();
            }
        }
    }
}