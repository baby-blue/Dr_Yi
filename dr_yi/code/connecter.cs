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

        public int createljb(int begid)
        {
            int rtn = 0;
            string conn = ConfigurationManager.ConnectionStrings["this_constr"].ConnectionString;
            string strsql = ConfigurationManager.ConnectionStrings["drgs_constr"].ConnectionString;
            string sql = "writetoljb";//要调用的存储过程名  
            SqlConnection conStr = new SqlConnection(strsql);//SQL数据库连接对象，以数据库链接字符串为参数  
            SqlCommand comStr = new SqlCommand(sql, conStr);//SQL语句执行对象，第一个参数是要执行的语句，第二个是数据库连接对象  
            comStr.CommandType = CommandType.StoredProcedure;//因为要使用的是存储过程，所以设置执行类型为存储过程  
            //依次设定存储过程的参数  
            comStr.Parameters.Add("@begid", SqlDbType.Int).Value = begid;
            comStr.Parameters.Add("@conn", SqlDbType.Text).Value = conn;
            SqlDataAdapter SqlDataAdapter1 = new SqlDataAdapter(comStr);
            DataTable DT = new DataTable();

            try
            {   ///打开连接
                conStr.Open();
                SqlDataAdapter1.Fill(DT);
            }
            catch (Exception ex)
            {   ///抛出异常
                throw new Exception(ex.Message, ex);
            }
            finally
            {   ///关闭连接
                rtn = comStr.ExecuteNonQuery();
                conStr.Close();//关闭连接
            }
            return rtn;
        }

        public int writetozb(int begid)
        {
            int rtn = 0;
            string conn = ConfigurationManager.ConnectionStrings["this_constr"].ConnectionString;
            string strsql = ConfigurationManager.ConnectionStrings["drgs_constr"].ConnectionString;
            string sql = "lhcx";//要调用的存储过程名  
            SqlConnection conStr = new SqlConnection(strsql);//SQL数据库连接对象，以数据库链接字符串为参数  
            SqlCommand comStr = new SqlCommand(sql, conStr);//SQL语句执行对象，第一个参数是要执行的语句，第二个是数据库连接对象  
            comStr.CommandType = CommandType.StoredProcedure;//因为要使用的是存储过程，所以设置执行类型为存储过程  
            //依次设定存储过程的参数  
            comStr.Parameters.Add("@num", SqlDbType.Int).Value = begid;
            comStr.Parameters.Add("@conn", SqlDbType.Text).Value = conn;
            SqlDataAdapter SqlDataAdapter1 = new SqlDataAdapter(comStr);
            DataTable DT = new DataTable();

            try
            {   ///打开连接
                conStr.Open();
                SqlDataAdapter1.Fill(DT);
            }
            catch (Exception ex)
            {   ///抛出异常
                throw new Exception(ex.Message, ex);
            }
            finally
            {   ///关闭连接
                rtn = comStr.ExecuteNonQuery();
                conStr.Close();//关闭连接
            }
            return rtn;
        }

        public DataSet getks()
        {
            string sql ="select cyks from zb where cyks IS NOT NULL group by cyks";
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
            return ds;
        }

        public DataSet getzb(string sql1)
        {
            string sql2 = " where " + sql1;
            string conn = ConfigurationManager.ConnectionStrings["drgs_constr"].ConnectionString;
            string sql = "zbcx";//要调用的存储过程名  

            
            SqlConnection conStr = new SqlConnection(conn);//SQL数据库连接对象，以数据库链接字符串为参数  
            SqlCommand comStr = new SqlCommand(sql, conStr);//SQL语句执行对象，第一个参数是要执行的语句，第二个是数据库连接对象  
            comStr.CommandType = CommandType.StoredProcedure;//因为要使用的是存储过程，所以设置执行类型为存储过程  
            //依次设定存储过程的参数  
            comStr.Parameters.Add("@where", SqlDbType.Text).Value = sql2;
            SqlDataAdapter da = new SqlDataAdapter(comStr);
            DataSet ds = new DataSet();

            try
            {   ///打开连接
                conStr.Open();
                da.Fill(ds);
            }
            catch (Exception ex)
            {   ///抛出异常
                throw new Exception(ex.Message, ex);
            }
            finally
            {   ///关闭连接
                conStr.Close();//关闭连接
            }

            return ds;
        }
    }
}