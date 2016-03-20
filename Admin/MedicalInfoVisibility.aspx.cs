using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_MedicalInfoVisibility : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ToString());
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
    protected void chkActivate_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)(((CheckBox)sender).Parent.NamingContainer);
            string ID = gvAdminMedical.DataKeys[row.RowIndex]["gconstantid"].ToString();
            SqlCommand cmd = new SqlCommand("update mstGeneralCnst set ActiveFlag=@ActiveFlag,ModifiedDate=@ModifiedDate where gconstantid=@gconstantid", conn);
            cmd.Parameters.AddWithValue("@ActiveFlag", (((CheckBox)sender).Checked)? "1":"0");
            cmd.Parameters.AddWithValue("@ModifiedDate",DateTime.Now);
            cmd.Parameters.AddWithValue("@gconstantid", ID);
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            cmd.ExecuteNonQuery();
            gvAdminMedical.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }
}