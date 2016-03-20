using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class pageMethods : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string LogOutUser()
    {
        string reStr = "";
        try
        {
            reStr = UserInfo.LogOutUser();
        }
        catch (Exception)
        {
            reStr = "";
        }
        return reStr;
    }
}