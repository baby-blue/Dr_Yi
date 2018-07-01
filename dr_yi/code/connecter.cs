using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace connecter
{
    public class Sql_connecter
    {
        public Sql_connecter()
        {
        }


        public int getmaxid(string targettb)
        {
            string sql = string.Format("select max(id) from {0}", targettb);
            int id = 0;
            string conn = ConfigurationManager.ConnectionStrings["drgs_constr"].ConnectionString;
            SqlConnection sc = new SqlConnection(conn);
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            DataSet ds = new DataSet();
            try
            {   ///打开连接
                sc.Open();
                ///填充数据
                da.Fill(ds);
            }
            catch (Exception ex)
            {   ///抛出异常
                throw new Exception(ex.Message, ex);
            }
            finally
            {   ///关闭连接
                sc.Close();
            }
            if (ds.Tables[0].Rows[0][0] != DBNull.Value)
            {
                id = (int)ds.Tables[0].Rows[0][0];
            }
            return id;
        }

        public void writetoserver(DataTable dt, string targettb)
        {
            string conn = ConfigurationManager.ConnectionStrings["drgs_constr"].ConnectionString;
            SqlConnection sc = new SqlConnection(conn);
            sc.Open();
            SqlBulkCopy sbc = new SqlBulkCopy(sc);
            sbc.DestinationTableName = targettb;
            try
            {
                sbc.WriteToServer(dt);
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                sc.Close();
            }
        }
    }
}