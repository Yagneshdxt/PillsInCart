using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class Blog_Blogmaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.DataBind();
        Img6.Src = "http://www.pillsincart.com/images/logo.png";
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
