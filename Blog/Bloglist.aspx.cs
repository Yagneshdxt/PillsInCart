using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Bloglist : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindlistview();
            BindRecentPost();
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

    protected void bindlistview()
    {
        try
        {
            DataTable dt = new DataTable();
            if (!string.IsNullOrEmpty(Convert.ToString(Page.RouteData.Values["CategoryID"])))
            {
                SqlCommand cmd = new SqlCommand("SELECT BlogId,BName,bImgOne,Introduction,CONVERT(varchar(12),CreatedDt,106) as Createddate from TrnBlog where Activeflag=1 and CategoryID=" + Convert.ToString(Page.RouteData.Values["CategoryID"]) + "", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(Page.RouteData.Values["month"])) && !string.IsNullOrEmpty(Convert.ToString(Page.RouteData.Values["year"])))
            {
                SqlCommand cmd = new SqlCommand("SELECT BlogId,BName,bImgOne,Introduction,CONVERT(varchar(12),CreatedDt,106) as Createddate from TrnBlog where Activeflag=1 and CreatedMonth=" + Convert.ToString(Page.RouteData.Values["month"]) + " and createdYear=" + Convert.ToString(Page.RouteData.Values["year"]) + "", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            if (!string.IsNullOrEmpty(Convert.ToString(Page.RouteData.Values["TagID"])))
            {
                SqlCommand cmd = new SqlCommand("SELECT Tb.BlogId,BName,bImgOne,Introduction,CONVERT(varchar(12),TB.CreatedDt,106) as Createddate from TrnBlog TB Inner Join TrnBlogTagMaping TBM on TB.BlogId=TBM.BlogId where TB.Activeflag=1 and TagId=" + Convert.ToString(Page.RouteData.Values["TagID"]) + "", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            if (dt != null && dt.Rows.Count > 0)
            {
                listblog.DataSource = dt;
                listblog.DataBind();
            }
            else
            {
                Response.Redirect("~/Blog/BlogIndex.aspx");
            }
        }
        catch (Exception)
        { }
    }
    protected void gotopage_Click(object sender, EventArgs e)
    {
        LinkButton editlinkbutton = sender as LinkButton;
        HiddenField myhiddenfield = editlinkbutton.NamingContainer.FindControl("hiddenblogid") as HiddenField;
        string myID = (myhiddenfield.Value);
        //Session["try"] = myID;
        //HiddenField hiddenblogid = FindControl("hlinkimg") as HiddenField;
        //Label1.Text = hiddenblogid.Value;
        Response.Redirect(GetRouteUrl("BlogDetails", new { BlogId = "" + myID + "", BName = "" + editlinkbutton.Text.ToString().Trim().Replace(" ", "-") + "" }));
        // Response.Redirect("../../Blog/" + myID + "/" + editlinkbutton.Text + "");
    }
}