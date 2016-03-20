using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class blogdisplay : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        lblstatus.Text = string.Empty;
        lblstatus.Visible = false;
        if (!IsPostBack)
        {
            try
            {
                if (!string.IsNullOrEmpty(Convert.ToString(Page.RouteData.Values["BlogID"])))
                {
                    SqlCommand cmd = new SqlCommand("SELECT BlogId,BName,Introduction,Description,CreatedMonth,createdYear,bImgOne,bImgTwo,IscommentActive,CONVERT(varchar(20),CreatedDt,107) as CreatedDt,dbo.GetCommaSeperatedTagName(BlogId) as TagNames from TrnBlog where BlogId=" + Convert.ToInt32(Page.RouteData.Values["BlogID"]), con);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    this.Page.Title = Convert.ToString(dt.Rows[0]["BName"]);
                    lblblogname.Text = Convert.ToString(dt.Rows[0]["BName"]);
                    lblposteddate.Text = Convert.ToString(dt.Rows[0]["CreatedDt"]);
                    blogimage.ImageUrl = Convert.ToString(dt.Rows[0]["bImgOne"]);
                    blogdescription.InnerHtml = Server.HtmlDecode(Convert.ToString(dt.Rows[0]["Description"]));
                    Page.MetaDescription = Server.HtmlDecode(Convert.ToString(dt.Rows[0]["Introduction"]));
                    divblogcomments.Visible = Convert.ToBoolean(dt.Rows[0]["IscommentActive"]);

                    if (Convert.ToString(dt.Rows[0]["TagNames"]) != string.Empty)
                    {
                        btags.Visible = true;
                        lblTags.Text = Convert.ToString(dt.Rows[0]["TagNames"]).Replace(",", ", ");
                        Page.MetaKeywords = Convert.ToString(dt.Rows[0]["TagNames"]);
                    }
                    else
                    {
                        btags.Visible = false;
                        lblTags.Text = string.Empty;
                    }
                    bindComments();
                    BindRelatedPost();
                    BindRecentPost();
                }
                else
                {
                    Response.Redirect("../Blog/Bloglist.aspx");
                }


            }
            catch (Exception ex)
            { }
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
    private void BindRelatedPost()
    {
        SqlCommand cmd = new SqlCommand("usp_getRelatedPost", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@BlogID", SqlDbType.Int).Value = Page.RouteData.Values["BlogID"];
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt != null && dt.Rows.Count > 0)
        {
            rptrelatedpost.DataSource = dt;
            rptrelatedpost.DataBind();
        }
        else
        {
            lblrelatedpost.Visible = false;
        }
    }

    private void bindComments()
    {
        SqlCommand cmd1 = new SqlCommand("usp_GetBlogComments", con);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.Add("@BlogID", SqlDbType.Int).Value = Convert.ToInt32(Page.RouteData.Values["BlogID"]);
        SqlDataAdapter dacomments = new SqlDataAdapter(cmd1);
        DataTable dtcomments = new DataTable();
        dacomments.Fill(dtcomments);
        if (dtcomments != null && dtcomments.Rows.Count > 0)
        {
            rptcomments.DataSource = dtcomments;
            rptcomments.DataBind();
        }
        else
        {
            blogcomments.Visible = false;
        }

    }
    protected void commentblog_Click(object sender, EventArgs e)
    {
        txtBlogComment.Visible = true;
        btnBlogCommentSubmit.Visible = true;

    }
    protected void btnBlogCommentSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("usp_InsertBlogComments", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BlogID", SqlDbType.Int).Value = Convert.ToInt32(Page.RouteData.Values["BlogID"]);
            cmd.Parameters.Add("@bcomments", SqlDbType.VarChar).Value = txtBlogComment.Text;
            cmd.Parameters.Add("@UserName", SqlDbType.VarChar).Value = txtName.Text;
            cmd.Parameters.Add("@EmailId", SqlDbType.VarChar).Value = txtEmail.Text;
            con.Open();
            int res = cmd.ExecuteNonQuery();
            if (res > 0)
            {
                lblstatus.Visible = true;
                lblstatus.Text = "You comment is awaiting moderation.";
                lblstatus.Focus();
                txtBlogComment.Text = txtName.Text = txtEmail.Text = string.Empty;
                bindComments();
            }
            con.Close();
        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
    }
    protected void lnk_BlogDetails(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        if (lnkbtn != null)
        {
            string BlogID = lnkbtn.CommandArgument;
            //Response.Redirect("../Blog/" + BlogID + "/" + lnkbtn.Text + "");
            Response.Redirect(GetRouteUrl("BlogDetails", new { BlogId = "" + BlogID + "", BName = "" + lnkbtn.Text.ToString().Trim().Replace(" ", "-") + "" }));
        }
    }
}