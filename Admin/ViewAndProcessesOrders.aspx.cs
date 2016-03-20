using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_Default : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
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
    }
    protected void btnAppove_Click(object sender, EventArgs e)
    {
        try
        {
            string Query = "";
            string EmailUsers = string.Empty;
            for (int i = 0; i < gvShowOrders.Rows.Count; i++)
            {
                GridViewRow row = (GridViewRow)gvShowOrders.Rows[i];
                CheckBox chk = (CheckBox)row.FindControl("chkApprove");
                CheckBox chkD = (CheckBox)row.FindControl("chkDecline");
                if ((chk != null) && (chk.Checked))
                {
                    string OrderHeaderID = gvShowOrders.DataKeys[i]["OrderHeaderId"].ToString();
                    Query = Query + " UPDATE OrderHeader SET IsProcessessedByAdmin=@IsProcessessedByAdmin,ProcessDate=@ProcessDate " +
                        " WHERE OrderHeaderId='" + OrderHeaderID.ToString() + "' ";
                    EmailUsers += gvShowOrders.DataKeys[0]["EmailID"].ToString() + ",";
                }
                else if ((chkD != null) && (chkD.Checked))
                {
                    string OrderHeaderID = gvShowOrders.DataKeys[i]["OrderHeaderId"].ToString();
                    Query = Query + " UPDATE OrderHeader SET IsProcessessedByAdmin=@IsProcessessedByAdminD,ProcessDate=@ProcessDate " +
                        " WHERE OrderHeaderId='" + OrderHeaderID.ToString() + "' ";
                }
            }
            if (Query != "")
            {
                SqlCommand cmd = new SqlCommand(Query, con);
                cmd.Parameters.AddWithValue("@IsProcessessedByAdmin", "1");
                cmd.Parameters.AddWithValue("@IsProcessessedByAdminD", "0");
                cmd.Parameters.AddWithValue("@ProcessDate", DateTime.Now);
                if (con.State == System.Data.ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.ExecuteNonQuery();
                gvShowOrders.DataBind();

                if (EmailUsers != string.Empty)
                {
                    SendMail.sendConfirmOrderMail(EmailUsers.TrimEnd(','));
                }
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
        finally
        {
            con.Close();
        }
    }
    protected void gvShowOrders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row is GridViewRow)
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridViewRow gvr = (GridViewRow)e.Row;
                    string OrderStatus = gvShowOrders.DataKeys[e.Row.RowIndex]["OrderStatus"].ToString();
                    if (OrderStatus == "Pending")
                    {
                        RadioButton chkApprove = (RadioButton)gvr.FindControl("chkApprove");
                        RadioButton chkDecline = (RadioButton)gvr.FindControl("chkDecline");
                        chkApprove.GroupName = "gname" + e.Row.RowIndex.ToString();
                        chkDecline.GroupName = "gname" + e.Row.RowIndex.ToString();
                    }
                }
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
    protected void gvShowOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvShowOrders.PageIndex = e.NewPageIndex;
        gvShowOrders.DataBind();
    }

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkbtn = sender as LinkButton;
            if (lnkbtn != null)
            {
                string OrderHeaderID = lnkbtn.CommandArgument;
                SqlCommand cmd = new SqlCommand("usp_DeleteOrders", con);
                cmd.Parameters.Add("@OrderHeaderId", SqlDbType.BigInt).Value = Convert.ToInt32(OrderHeaderID);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                {
                    AlertMsg("Order Deleted Sucessfully");
                    gvShowOrders.DataBind();
                }

            }
        }
        catch (Exception)
        {

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
}