using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Data;

public partial class Admin_Account_AdminLogin : System.Web.UI.Page
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

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        bool chkFlag = false;
        try
        {
            SqlParameter[] parm = new SqlParameter[]{
                new SqlParameter("@EmailId",txtEmail.Text),
                new SqlParameter("@password",txtPassword.Text),
               new SqlParameter("@OrdId",(HttpContext.Current.Session["OrdId"] != null)?HttpContext.Current.Session["OrdId"].ToString():"0"),
               new SqlParameter("@AdminLogin","Y")
            };
            StringBuilder sqlQuery = new StringBuilder();
            sqlQuery.Append("select a.userId,a.fName,a.lName,a.Gender,a.Dob,a.EmailID,a.password,a.Address1,a.Address2,a.Country,a.StateorProvince,a.City,a.Zipcode,a.phone,a.createdon,a.verificationFlag,a.ActiveFlag ")
            .Append(" from userdetail a ")
            .Append(" join UserRole_Mapping b on a.userId = b.UserId  ")
            .Append(" join Role_Mst c on b.RoleId = c.RoleID ")
            .Append(" where c.RoleName='Admin' and ")
            .Append(" a.EmailID=@EmailId and a.password = @password ")
            .Append(" and c.ActiveFlag = 1 and b.ActiveFlag = 1 and a.ActiveFlag = 1 ");
            DataSet ds = new DataSet();
            ds = objDataAccess.getDataSetQuery("UserLogIn", parm, CommandType.StoredProcedure);

            if ((ds != null) && (ds.Tables.Count > 0))
            {
                Session["UserInfo"] = "";
                UserInfo objUserInfo = new UserInfo()
                {
                    userId = Convert.ToInt64(ds.Tables[0].Rows[0]["userId"].ToString()),
                    fName = ds.Tables[0].Rows[0]["fName"].ToString(),
                    lName = ds.Tables[0].Rows[0]["lName"].ToString(),
                    Gender = ds.Tables[0].Rows[0]["Gender"].ToString(),
                    Dob = Convert.ToDateTime(ds.Tables[0].Rows[0]["Dob"].ToString()),
                    EmailID = ds.Tables[0].Rows[0]["EmailID"].ToString(),
                    password = ds.Tables[0].Rows[0]["password"].ToString(),
                    Address1 = ds.Tables[0].Rows[0]["Address1"].ToString(),
                    Address2 = ds.Tables[0].Rows[0]["Address2"].ToString(),
                    Country = ds.Tables[0].Rows[0]["Country"].ToString(),
                    StateorProvince = ds.Tables[0].Rows[0]["StateorProvince"].ToString(),
                    City = ds.Tables[0].Rows[0]["City"].ToString(),
                    Zipcode = ds.Tables[0].Rows[0]["Zipcode"].ToString(),
                    phone = ds.Tables[0].Rows[0]["phone"].ToString(),
                    createdon = Convert.ToDateTime(ds.Tables[0].Rows[0]["createdon"].ToString()),
                    verificationFlag = ds.Tables[0].Rows[0]["userId"].ToString()
                };

                if ((ds.Tables[1] != null) && (ds.Tables[1].Rows.Count > 0) && (ds.Tables[1].Rows[0][0] != null))
                {
                    if ((!String.IsNullOrEmpty(Convert.ToString(ds.Tables[1].Rows[0][0]))) && (ds.Tables[1].Rows[0][0].ToString() != "0"))
                    {
                        objUserInfo.OrdId = ds.Tables[1].Rows[0][0].ToString();
                    }

                }
                UserInfo.setUserInfo(objUserInfo);
                chkFlag = true;
            }
        }
        catch (Exception)
        {
            chkFlag = false;
        }

        if (chkFlag)
        {
            //lblMsg.Text = "Log in successfuly";
            Response.Redirect("~/Admin/ViewAndProcessesOrders.aspx");
        }
        else {
            lblMsg.Text = "Logg failed!!! invalid user name and/or password";
        }
    }

}