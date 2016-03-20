using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Blog_Categories : System.Web.UI.UserControl
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCategories();
        }
    }

    private void BindCategories()
    {
        SqlDataAdapter da = new SqlDataAdapter("usp_BindCategoriesForBlogIndex", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lstallcategories.DataSource = ds;
                lstallcategories.DataBind();
            }
        }
    }
}