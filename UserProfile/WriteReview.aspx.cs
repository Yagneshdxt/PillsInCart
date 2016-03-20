using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class UserProfile_WriteReview : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Account/login.aspx", true);
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

    protected void btnSubTestM_Click(object sender, EventArgs e)
    {
        int chkFlag = 0;
        try
        {
            if (Page.IsValid)
            {

                UserInfo objUserInfo = UserInfo.GetUserInfo();
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@TstMonial",txtTestimonial.Text),
                new SqlParameter("@UserID",objUserInfo.userId),
                };
                chkFlag = objDataAccess.DaExecNonQueryStr(" INSERT INTO Testimonials(Testimonial,CreatedBy,ModifiedBy) values(@TstMonial,@UserID,@UserID) ", param);
                if (chkFlag > 0)
                {
                    txtTestimonial.Text = "";
                    AlertMsg("Testimonial Submitted successfuly");
                }
            }
        }
        catch (Exception)
        {
            chkFlag = 0;
        }
    }
}