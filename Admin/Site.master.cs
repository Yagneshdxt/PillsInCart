using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUsrInfo = UserInfo.GetUserInfo();
        Page.Header.DataBind();
        if (objUsrInfo != null)
        {
            LoginDiv.Visible = true;
            lblUsreName.Text = "Welcome " + objUsrInfo.fName;
            LogOutdiv.Visible = false;
        }
        else {
            lblUsreName.Text = "";
            LoginDiv.Visible = false;
            LogOutdiv.Visible = true;
        }
    }
    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        try
        {
            UserInfo.LogOutUser();
            Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }
        catch (Exception)
        {

        }
    }
}
