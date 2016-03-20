using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Admin_ApproveComments : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }
        else
        {
            if (!objUserInfo.IsAdmin())
                Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }
        if (!IsPostBack)
        {
            BindGridData();
        }
    }

    private void BindGridData()
    {
        SqlDataAdapter da = new SqlDataAdapter("usp_ApproveBlogComments", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        gvComments.DataSource = ds;
        gvComments.DataBind();
    }



    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = UpdateComments();
            if (dt != null && dt.Rows.Count > 0)
            {
                SqlCommand cmd = new SqlCommand("usp_ApproveDeleteBlogComments", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@BlogCommentsModeration", SqlDbType.Structured).Value = dt;
                cmd.Parameters.Add("@UpdateDelete", SqlDbType.Bit).Value = true;
                con.Open();
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                {
                    AlertMsg("Comments updated successfuly");
                    BindGridData();
                }
            }
            else
            {
                AlertMsg("Please Select Some Record.");
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
    }

    protected void AlertMsg(string msg)
    {
        try
        {
            string scripfun = "alert('" + msg + "')";
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "keya", "alert('" + msg + "')", true);
        }
        catch (Exception)
        {

        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = UpdateComments();
            if (dt != null && dt.Rows.Count > 0)
            {
                SqlCommand cmd = new SqlCommand("usp_ApproveDeleteBlogComments", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@BlogCommentsModeration", SqlDbType.Structured).Value = dt;
                cmd.Parameters.Add("@UpdateDelete", SqlDbType.Bit).Value = false;
                con.Open();
                int res = cmd.ExecuteNonQuery();
                con.Close();
                if (res > 0)
                {
                    AlertMsg("Comments updated successfuly");
                    BindGridData();
                }
            }
            else
            {
                AlertMsg("Please Select Some Record.");
            }
        }
        catch (Exception ex)
        {

        }
    }

    private DataTable UpdateComments()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("CommentID");
        dt.Columns.Add("BlogID");
        DataRow dr = null;
        foreach (GridViewRow gvrow in gvComments.Rows)
        {
            CheckBox chk = (CheckBox)gvrow.FindControl("chkbox");
            if (chk.Checked)
            {
                dr = dt.NewRow();
                dr["CommentID"] = gvComments.DataKeys[gvrow.RowIndex]["commentId"];
                dr["BlogID"] = gvComments.DataKeys[gvrow.RowIndex]["BlogId"];
                dt.Rows.Add(dr);
            }
        }
        return dt;
    }
    protected void gvComments_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvComments.PageIndex = e.NewPageIndex;
        BindGridData();
    }
}