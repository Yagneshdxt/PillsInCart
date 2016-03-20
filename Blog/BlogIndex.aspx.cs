using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Blog_BlogIndex : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindpostCategories();
            BindRecentPost();
            BindArchives();
        }
    }

    private void BindpostCategories()
    {
        SqlDataAdapter da = new SqlDataAdapter("usp_BindBlogPostOnIndexPage", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lstBlogs.DataSource = ds;
                lstBlogs.DataBind();
            }
        }
    }

    private void BindRecentPost()
    {
        SqlDataAdapter da = new SqlDataAdapter("usp_GetRecentPost", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lstvwrecentpost.DataSource = ds;
                lstvwrecentpost.DataBind();
            }
        }
    }

    private void BindArchives()
    {
        SqlDataAdapter da = new SqlDataAdapter("usp_getArchive", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lstvwArchives.DataSource = ds;
                lstvwArchives.DataBind();
            }
        }
    }

    protected void lnkbtnArchive_Click(object sender, EventArgs e)
    {
        LinkButton linkbutton = sender as LinkButton;
        if (linkbutton != null)
        {
            //Response.Redirect("../Blog/" + linkbutton.CommandArgument + "/" + linkbutton.CommandName + "");
            Response.Redirect(GetRouteUrl("BlogListYear", new { year = "" + linkbutton.CommandArgument + "", month = "" + linkbutton.CommandName + "" }));
        }
    }
}