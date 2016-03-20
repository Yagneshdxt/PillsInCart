using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class ProductCreation_ProductRouting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataAccess objDataAccess = new DataAccess();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Drop table " + Request.QueryString["tablename"] + "", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
}