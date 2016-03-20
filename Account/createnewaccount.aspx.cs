using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Data;

public partial class createnewaccoumt : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                ddlcountry.DataSource = objDataAccess.getDataSetQuery("select ID,Country from MstCountry where ActiveFlag=1");
                ddlcountry.DataValueField = "ID";
                ddlcountry.DataTextField = "Country";
                ddlcountry.DataBind();
                ddlcountry.Items.Insert(0, new ListItem("select One....", "0"));
                txtdob.Attributes.Add("readonly", "readonly");
            }
            lblsucessmsg.Text = string.Empty;
        }
        catch (Exception)
        {

        }
    }
    public List<string> GetCountryInfo()
    {
        List<string> list = new List<string>();
        foreach (CultureInfo info in CultureInfo.GetCultures(CultureTypes.SpecificCultures))
        {
            RegionInfo inforeg = new RegionInfo(info.LCID);
            if (!list.Contains(inforeg.EnglishName))
            {
                list.Add(inforeg.EnglishName);
                list.Sort();

            }
        }
        return list;
    }
    private string Encryptdata(string password)
    {
        string strmsg = string.Empty;
        byte[] encode = new byte[password.Length];
        encode = Encoding.UTF8.GetBytes(password);
        strmsg = Convert.ToBase64String(encode);
        return strmsg;
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


    protected void ClearControls()
    {
        try
        {
            txtfname.Text = "";
            txtlname.Text = "";
            radiomale.Checked = false;
            radiofemale.Checked = false;
            radiomale.Checked = true;
            txtdob.Text = "";
            txtemail.Text = "";
            txtpassword.Text = "";
            txtconpassword.Text = "";
            txtadd1.Text = "";
            txtadd2.Text = "";
            ddlcountry.ClearSelection();
            ddlcountry.SelectedIndex = 0;
            txtstate.Text = "";
            txtcity.Text = "";
            txtzipcode.Text = "";
            txtphone.Text = "";
            txtMobile.Text = "";
        }
        catch (Exception)
        {

        }
    }

    protected void btncreatenew_Click(object sender, EventArgs e)
    {
        //string enpassword = Encryptdata(txtpassword.Text);
        string chkstring = "", ResStr = "";
        try
        {
            string gender;
            if (radiomale.Checked)
            {
                gender = "male";
            }
            else
            {
                gender = "female";
            }
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@fName", txtfname.Text),
                new SqlParameter("@lName", txtlname.Text),
                new SqlParameter("@Gender", gender),
                new SqlParameter("@Dob", txtdob.Text),
                new SqlParameter("@EmailID", txtemail.Text),
                new SqlParameter("@password", txtpassword.Text),
                new SqlParameter("@Address1", txtadd1.Text),
                new SqlParameter("@Address2", txtadd2.Text),
                new SqlParameter("@Country", ddlcountry.SelectedValue),
                new SqlParameter("@StateorProvince", txtstate.Text),
                new SqlParameter("@City", txtcity.Text),
                new SqlParameter("@Zipcode", txtzipcode.Text),
                new SqlParameter("@phone", txtphone.Text),
                new SqlParameter("@Mobile", txtMobile.Text),            
                new SqlParameter("@verificationFlag", 'P'),
                new SqlParameter("@mesOut", SqlDbType.VarChar,500),
            };

            ResStr = DataAccess.CreateUser(param);
            //ResStr = ResStr + "\n UserID :" + txtemail.Text + "\n Password: " + txtpassword.Text;
            lblsucessmsg.Text = ResStr;
            string pswd = txtpassword.Text;
            string email = txtemail.Text.Trim();
            string fnamelname = txtfname.Text + " " + txtlname.Text;
            ClearControls();
            SendMail.sendNewUserMail(pswd, email, fnamelname);

        }
        catch (Exception)
        {
            ResStr = "Error Creating User";
            lblsucessmsg.Text = ResStr;
            //Response.Redirect("createnewaccount.aspx");
        }

        //AlertMsg(ResStr);


    }
    protected void btnbacklogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("login.aspx");
    }

    [WebMethod]
    public static string CheckDuplicateEmaiId(string emailID)
    {
        Int16 chckFlag = 0;
        try
        {
            DataAccess objDataAccess = new DataAccess();
            chckFlag = objDataAccess.SelectScalar("SELECT COUNT(1) from userdetail where EmailID='" + emailID + "'");
        }
        catch (Exception)
        {
            chckFlag = 0;
        }
        return (chckFlag > 0) ? "fail" : "success";
    }
}