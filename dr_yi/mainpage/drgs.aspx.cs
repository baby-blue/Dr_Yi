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
            loadks();
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
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}