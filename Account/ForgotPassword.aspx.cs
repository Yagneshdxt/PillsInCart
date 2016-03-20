using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Account_ForgotPassword : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {

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

    protected void btnsign_Click(object sender, EventArgs e)
    {
        String PassWrd = "";
        try
        {
            if (Page.IsValid)
            {
                SqlParameter[] Param = new SqlParameter[]{
                new SqlParameter("@EmailId",txtEmailID.Text)
                };
                PassWrd = Convert.ToString(objDataAccess.SelectScalarRetObj(" select [password] from userdetail where EmailID = @EmailId ", Param));

                if (!String.IsNullOrEmpty(PassWrd))
                {
                    SendMail.sendForgotPasswordMail(PassWrd, txtEmailID.Text);
                    txtEmailID.Text = "";
                    AlertMsg("Your password is mailed to your registered email Id.");
                }
            }

        }
        catch (Exception)
        {
            PassWrd = "";
        }


    }
}