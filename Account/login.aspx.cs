using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class login : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnsign_Click(object sender, EventArgs e)
    {
        bool chkFlag = false;
        lblMsg.Text = "";
        try
        {
            chkFlag = objDataAccess.LoginUser(txtemailid.Text, txtpassword.Text);
        }
        catch (Exception)
        {
            chkFlag = false;
        }

        if (chkFlag)
        {
            if (Request.QueryString["RetUrl"] != null && !String.IsNullOrEmpty(Convert.ToString(Request.QueryString["RetUrl"])))
            {
                Response.Redirect(Request.QueryString["RetUrl"].ToString());
            }
            else
            {
                Response.Redirect("~/");
            }

        }
        else
        {
            lblMsg.Text = "Invalid User Name and/or Password";
        }
    }
    protected void btncreatenew_Click(object sender, EventArgs e)
    {
        Response.Redirect("createnewaccount.aspx");
    }
}