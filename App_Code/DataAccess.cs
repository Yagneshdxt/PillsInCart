using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Net.Mail;
using System.Text;

/// <summary>
/// Summary description for DataAccess
/// </summary>
public class DataAccess
{
    SqlConnection PrconObj = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

    public DataAccess()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public SqlConnection conObj
    {
        get
        {
            if (PrconObj == null)
            {
                PrconObj = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            }
            return PrconObj;
        }
    }

    //Query to get data set .
    public DataSet getDataSetQuery(string sqlQuery)
    {
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sqlQuery;
            SqlDataAdapter dA = new SqlDataAdapter(cmd);
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            dA.Fill(ds);
        }
        catch (Exception)
        {
            ds = null;
        }
        finally
        {
            conObj.Close();
        }
        return ds;
    }

    //Parameterized Query to get data set .
    public DataSet getDataSetQuery(string sqlQuery, SqlParameter[] sqlParms, CommandType cmTyp = CommandType.Text)
    {
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = cmTyp;
            cmd.CommandText = sqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());
            SqlDataAdapter dA = new SqlDataAdapter(cmd);
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            dA.Fill(ds);
        }
        catch (Exception)
        {
            ds = null;
        }
        finally
        {
            conObj.Close();
        }
        return ds;
    }

    //Execute Stored procedure with output parameter.
    public string ExecSPWithOutPutPara(string sqlQuery, SqlParameter[] sqlParms, int OPParam, CommandType cmTyp = CommandType.Text)
    {
        int chkflag = 0;
        string OpParam = "";
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = cmTyp;
            cmd.CommandText = sqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());
            cmd.Parameters[OPParam].Direction = ParameterDirection.Output;
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkflag = cmd.ExecuteNonQuery();

            //if (chkflag > 0)
            OpParam = sqlParms[OPParam].Value.ToString();
        }
        catch (Exception)
        {
            chkflag = 0;
            OpParam = "";
        }
        finally
        {
            conObj.Close();
        }
        return OpParam;
    }



    //Execute non query with in transaction.
    public int DaExecNonQueryStrTrn(string SqlQuery, SqlParameter[] sqlParms, SqlTransaction trnSql, SqlConnection sqlCon)
    {
        int retNo = 0;
        try
        {
            //SqlTransaction trnabc = conObj.BeginTransaction();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = SqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());
            cmd.Transaction = trnSql;
            //if (conObj.State == ConnectionState.Closed)
            //    conObj.Open();
            retNo = cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            retNo = 0;
        }
        return retNo;

    }

    //Execute non query with parameter list 
    public int DaExecNonQueryStr(string SqlQuery, SqlParameter[] sqlParms, CommandType cmdTyp = CommandType.Text)
    {
        int retNo = 0;
        try
        {
            SqlCommand cmd = PrconObj.CreateCommand();
            cmd.CommandType = cmdTyp;
            cmd.CommandText = SqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            retNo = cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            retNo = 0;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return retNo;
    }

    public Int16 SelectScalar(string sqlQuery, SqlParameter[] sqlParms = null)
    {
        Int16 chkint = 0;
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sqlQuery;
            if (sqlParms != null)
                cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkint = Convert.ToInt16(cmd.ExecuteScalar());
        }
        catch (Exception)
        {
            chkint = 0;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return chkint;
    }


    public object SelectScalarRetObj(string sqlQuery, SqlParameter[] sqlParms = null)
    {
        object chkint = null;
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sqlQuery;
            if (sqlParms != null)
                cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkint = cmd.ExecuteScalar();
        }
        catch (Exception)
        {
            chkint = null;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return chkint;
    }


    public object SelectScalarRetObj(string sqlQuery, SqlParameter[] sqlParms = null, CommandType cmdTyp = CommandType.Text)
    {
        object chkint = null;
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = cmdTyp;
            cmd.CommandText = sqlQuery;
            if (sqlParms != null)
                cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkint = cmd.ExecuteScalar();
        }
        catch (Exception)
        {
            chkint = null;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return chkint;
    }

    public static string CreateUser(SqlParameter[] Param)
    {
        string ResStr = "", chkstring = "";
        try
        {
            DataAccess objDataAccess = new DataAccess();
            chkstring = objDataAccess.ExecSPWithOutPutPara("UserDetail_I", Param, 15, System.Data.CommandType.StoredProcedure);

            if ((chkstring != "Duplicate email Id") && (chkstring != "Error Inserting data") & (chkstring != ""))
                ResStr = "Thanks for registering with Pills in Cart\n";
            else
            {
                if (chkstring == "Duplicate email Id")
                {
                    ResStr = "User with this email Id already exists. Please provide other email Id.";
                }
                if ((chkstring == "Error Inserting data") || (chkstring != ""))
                {
                    ResStr = "Error Creating User";
                }
            }
        }
        catch (Exception)
        {

        }
        return ResStr;
    }

    public static int UpdateUser(SqlParameter[] Param)
    {
        int res = 0;
        try
        {
            DataAccess objDataAccess = new DataAccess();
            res = Convert.ToInt32(objDataAccess.DaExecNonQueryStr("UserDetail_U", Param, System.Data.CommandType.StoredProcedure));
        }
        catch (Exception)
        {
            res = 0;
        }
        return res;
    }

    public bool LoginUser(string EmailID, string Pasword, bool ClearSess = true)
    {

        bool chkFlag = false;
        try
        {
            SqlParameter[] parm = new SqlParameter[]{
                new SqlParameter("@EmailId",EmailID),
                new SqlParameter("@password",Pasword),
                new SqlParameter("@OrdId",(HttpContext.Current.Session["OrdId"] != null)?HttpContext.Current.Session["OrdId"].ToString():"0")
            };
            DataSet ds = new DataSet();
            ds = getDataSetQuery("UserLogIn", parm, CommandType.StoredProcedure);
            //ds = objDataAccess.getDataSetQuery("select userId,fName,lName,Gender,Dob,EmailID,password,Address1,Address2,Country,StateorProvince,City,Zipcode,phone,createdon,verificationFlag,ActiveFlag from userdetail where EmailID=@EmailId and password = @password and ActiveFlag = 1", parm);
            if ((ds != null) && (ds.Tables.Count > 0))
            {
                HttpContext.Current.Session["UserInfo"] = "";
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
                UserInfo.setUserInfo(objUserInfo, ClearSess);
                chkFlag = true;
            }
        }
        catch (Exception)
        {
            chkFlag = false;
        }
        return chkFlag;
    }


    public Object GetCartAmount(Int64? OrdId, Int64? userId)
    {
        Object retObj = 0.00;
        try
        {
            DataSet ds = new DataSet();
            ds = GetCartData(OrdId, userId);
            if ((ds != null) && (ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0))
            {
                retObj = ds.Tables[0].Rows[0]["crtAmt"];
            }
        }
        catch (Exception)
        {
            retObj = 0.00;
        }
        return retObj;
    }

    public DataTable GetCartItems(Int64? OrdId, Int64? userId)
    {
        DataTable dt = new DataTable();
        try
        {
            DataSet ds = new DataSet();
            ds = GetCartData(OrdId, userId);
            if ((ds != null) && (ds.Tables.Count > 0) && (ds.Tables[1].Rows.Count > 0))
            {
                dt = ds.Tables[1];
            }
        }
        catch (Exception)
        {
            dt = null;
        }
        return dt;
    }

    private DataSet GetCartData(Int64? OrdId, Int64? userId)
    {
        DataSet ds = new DataSet();
        try
        {
            DataAccess objDataAccess = new DataAccess();
            SqlParameter[] Param = new SqlParameter[]{
                ((OrdId != null) && (OrdId > 0))?new SqlParameter("@OrdId",OrdId) :new SqlParameter("@OrdId","0"),
                ((userId != null) && (userId > 0))?new SqlParameter("@UserID",userId):new SqlParameter("@UserID","0")
            };
            ds = objDataAccess.getDataSetQuery("Cart_GetDetail", Param, CommandType.StoredProcedure);
        }
        catch (Exception)
        {
            ds = null;
        }
        return ds;
    }

    public DataSet getRootCategory()
    {
        DataSet ds = new DataSet();
        try
        {
            ds = getDataSetQuery("select RootCateoryId,CatName from RootCategory_Mst where ActiveFlage=1 AND DeleteFlage = 'A'");
        }
        catch (Exception)
        {
            ds = null;
        }
        return ds;
    }

    public DataSet getSubCategory()
    {
        DataSet ds = new DataSet();
        try
        {
            ds = getDataSetQuery("select RootCateoryId,CatName from RootCategory_Mst where ActiveFlage=1");
        }
        catch (Exception)
        {
            ds = null;
        }
        return ds;
    }

}

public class UserInfo
{
    public Int64 userId;
    public string fName;
    public string lName;
    public string Gender;
    public DateTime? Dob;
    public string EmailID;
    public string password;
    public string Address1;
    public string Address2;
    public string Country;
    public string StateorProvince;
    public string City;
    public string Zipcode;
    public string phone;
    public DateTime? createdon;
    public string verificationFlag;
    public string OrdId;

    public static UserInfo GetUserInfo()
    {
        UserInfo objUserInfo = new UserInfo();
        if ((HttpContext.Current.Session != null) && (HttpContext.Current.Session["UserInfo"] != null))
        {
            objUserInfo = HttpContext.Current.Session["UserInfo"] as UserInfo;
        }
        else
        {
            objUserInfo = null;
        }
        return objUserInfo;
    }

    public static void setUserInfo(UserInfo ObjUserInfo, bool ClearSess = true)
    {
        try
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.RemoveAll();
            //HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session["UserInfo"] = ObjUserInfo;
            if (!String.IsNullOrEmpty(ObjUserInfo.OrdId))
                OrderID.SetOrderID(ObjUserInfo.OrdId);
        }
        catch (Exception)
        {

        }
    }

    public static string LogOutUser()
    {
        string chkString = "";
        try
        {
            HttpContext.Current.Session.Remove("UserInfo");
            HttpContext.Current.Session.RemoveAll();
            HttpContext.Current.Session.Abandon();
            chkString = "Success";
        }
        catch (Exception)
        {
            chkString = "";
        }
        return chkString;
    }

    public bool IsAdmin()
    {
        bool chkflag = false;
        int chkInt = 0;
        try
        {
            DataAccess objDataAccess = new DataAccess();
            SqlParameter[] Param = new SqlParameter[]{
                ((userId != null) && (userId > 0))?new SqlParameter("@UserID",userId):new SqlParameter("@UserID",DBNull.Value)
            };
            chkInt = objDataAccess.SelectScalar("select COUNT(1) from UserRole_Mapping a join Role_Mst b on b.RoleId = a.RoleID where a.UserId = @UserID and b.RoleName='Admin' and a.ActiveFlag = 1 and b.ActiveFlag = 1", Param);
            if (chkInt > 0)
                chkflag = true;
        }
        catch (Exception)
        {
            chkflag = false;
        }
        return chkflag;
    }

}

public class ValidateImage
{
    public enum ImageType
    {
        AddImage,
        LogoImage,
        BigImage
    }

    public int LogImgWidth = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthLogoImg"].ToString().Split('|')[1]);
    public int LogImgHeight = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthLogoImg"].ToString().Split('|')[0]);
    public int BigImgWidth = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthBigImg"].ToString().Split('|')[1]);
    public int BigImgHeight = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthBigImg"].ToString().Split('|')[0]);
    public int AddImgWidth = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthAddImg"].ToString().Split('|')[1]);
    public int AddImgHeight = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthAddImg"].ToString().Split('|')[0]);

    public string valTypestr = ConfigurationManager.AppSettings["ValidImageType"].ToString();

    public string CheckImage(FileUpload filUp, ImageType imgType)
    {
        string errMsg = "";
        try
        {
            if ((filUp.HasFile) && (filUp.PostedFile.ContentLength > 0))
            {

                string filext = Path.GetExtension(filUp.PostedFile.FileName).ToString();
                string[] valType = valTypestr.Split('|');
                bool chkType = true;

                //Bitmap img = new Bitmap(filUp.PostedFile.FileName);
                Bitmap img = new Bitmap(filUp.PostedFile.InputStream, false);
                //System.Drawing.Image img = System.Drawing.Image.FromFile(filUp.PostedFile.FileName);
                int ImgHeight = img.Height;
                int ImgWidth = img.Width;
                if (imgType == ImageType.LogoImage)
                {
                    for (int i = 0; i < valType.Length; i++)
                    {
                        if (filext.Equals("." + valType[i], StringComparison.InvariantCultureIgnoreCase))
                        {
                            chkType = false;
                            break;
                        }
                    }
                    if (chkType)
                    {

                        errMsg = errMsg + "Logo Image of Invalid type\n";
                        chkType = true;
                    }

                    if ((LogImgWidth < ImgWidth) || (LogImgHeight < ImgHeight))
                    {
                        errMsg = errMsg + "Logo Image should have max height " + LogImgHeight + " and max Width " + LogImgWidth + " \n";
                        chkType = false;
                    }
                }
                if (imgType == ImageType.AddImage)
                {
                    for (int i = 0; i < valType.Length; i++)
                    {
                        if (filext.Equals(valType[i], StringComparison.InvariantCultureIgnoreCase))
                        {
                            chkType = false;
                            break;
                        }
                    }
                    if (chkType)
                    {

                        errMsg = errMsg + "Addvertise Image of Invalid type\n";
                        chkType = true;
                    }

                    if ((AddImgWidth < ImgWidth) || (AddImgHeight < ImgHeight))
                    {
                        errMsg = errMsg + "Addvertise Image should have max height " + AddImgHeight + " and max Width " + AddImgWidth + " \n";
                        chkType = false;
                    }
                }
                if (imgType == ImageType.BigImage)
                {
                    for (int i = 0; i < valType.Length; i++)
                    {
                        if (filext.Equals(valType[i], StringComparison.InvariantCultureIgnoreCase))
                        {
                            chkType = false;
                            break;
                        }
                    }
                    if (chkType)
                    {

                        errMsg = errMsg + "Big Image of Invalid type\n";
                        chkType = true;
                    }

                    if ((BigImgWidth < ImgWidth) || (BigImgHeight < ImgHeight))
                    {
                        errMsg = errMsg + "Big Image should have max height " + BigImgHeight + " and max Width " + BigImgWidth + " \n";
                        chkType = false;
                    }
                }
            }
        }
        catch (Exception)
        {
            errMsg = errMsg + "Error Inserting data\n";
        }
        return errMsg;
    }


    public void saveimage(FileUpload fileupload, out string SaveAsName)
    {
        string fileNa = "";
        try
        {
            fileNa = Path.GetFileName(fileupload.PostedFile.FileName);
            string filExt = Path.GetExtension(fileupload.PostedFile.FileName);
            string folderPath = ConfigurationManager.AppSettings["ImageFolder"].ToString();
            while (File.Exists(HttpContext.Current.Server.MapPath(folderPath + fileNa)))
            {
                fileNa = Guid.NewGuid().ToString() + filExt;
            }
            fileupload.SaveAs(HttpContext.Current.Server.MapPath(folderPath + fileNa));
            SaveAsName = fileNa;
        }
        catch (Exception)
        {
            SaveAsName = "";
        }
    }

}

public class discountClass
{
    public string discountid;
    public string discountamt;
    public string dismessage;
}

public class OrderID
{

    public string OrdId = "";

    public static string GetOrderId()
    {
        string ordIdret = "";
        try
        {
            if ((HttpContext.Current.Session != null) && (HttpContext.Current.Session["OrdId"] != null))
            {
                ordIdret = HttpContext.Current.Session["OrdId"].ToString();
            }
        }
        catch (Exception)
        {
            ordIdret = "";
        }
        return ordIdret;
    }

    public static void SetOrderID(string OrdID)
    {
        try
        {
            HttpContext.Current.Session["OrdId"] = OrdID;
        }
        catch (Exception)
        {

        }
    }

    public static string getAffiliateId()
    {
        string AffIdret = "";
        try
        {
            if ((HttpContext.Current.Session != null) && (HttpContext.Current.Session["AffId"] != null))
            {
                AffIdret = HttpContext.Current.Session["AffId"].ToString();
            }
        }
        catch (Exception)
        {
            AffIdret = "";
        }
        return AffIdret;
    }

    public static void SetAffId(string AffId)
    {
        try
        {
            HttpContext.Current.Session["AffId"] = AffId;
        }
        catch (Exception)
        {

        }
    }

    public static void RemoveAffId()
    {

        try
        {
            if (HttpContext.Current != null && HttpContext.Current.Session != null && HttpContext.Current.Session["AffId"] != null)
            {
                HttpContext.Current.Session["AffId"] = "";
                HttpContext.Current.Session.Remove("AffId");
            }
        }
        catch (Exception)
        {

        }
    }

}






public class SendMail
{


    public static void sendForgotPasswordMail(string password, string SendToEmailId)
    {

        MailMessage m = new MailMessage();
        SmtpClient sc = new SmtpClient();
        String MailFrom = "", MailCredentials = "";
        MailFrom = ConfigurationManager.AppSettings["MailFromId"].ToString();
        MailCredentials = ConfigurationManager.AppSettings["MailFromCredentials"].ToString();
        if ((!String.IsNullOrEmpty(MailFrom)) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[0])) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[1])))
        {
            try
            {
                m.From = new MailAddress(MailFrom, "Pills in Cart Support");
                m.To.Add(new MailAddress(SendToEmailId, "Dear PillsInCart user"));
                // m.CC.Add(new MailAddress("CC@yahoo.com", "Display name CC"));
                //similarly BCC


                m.Subject = "Password for PillsInCart Login";
                m.IsBodyHtml = true;
                m.Body = "Your Password is - " + password;

                sc.Host = "smtp.gmail.com";
                sc.Port = 587;
                sc.Credentials = new
                System.Net.NetworkCredential(MailCredentials.Split('|')[0].ToString(), MailCredentials.Split('|')[1].ToString());
                sc.EnableSsl = true;
                sc.Send(m);
            }
            catch (Exception)
            {

            }
        }

    }


    public static void sendConfirmOrderMail(string SendToEmailId)
    {

        MailMessage m = new MailMessage();
        SmtpClient sc = new SmtpClient();
        String MailFrom = "", MailCredentials = "";
        MailFrom = ConfigurationManager.AppSettings["MailFromId"].ToString();
        MailCredentials = ConfigurationManager.AppSettings["MailFromCredentials"].ToString();
        if ((!String.IsNullOrEmpty(MailFrom)) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[0])) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[1])))
        {
            try
            {
                m.From = new MailAddress(MailFrom, "Pills in Cart Support");
                m.To.Add(new MailAddress(SendToEmailId, "Dear PillsInCart user"));
                // m.CC.Add(new MailAddress("CC@yahoo.com", "Display name CC"));
                //similarly BCC


                m.Subject = "Order Confirmation.";
                m.IsBodyHtml = true;

                StringBuilder Body_Message2 = new StringBuilder();

                Body_Message2.Append("Dear User");
                Body_Message2.AppendLine("<br/>");
                Body_Message2.AppendLine("Your Order has been approved by admin.");
                Body_Message2.AppendLine("<br/>");

                m.Body = Body_Message2.ToString();
                sc.Host = "smtp.gmail.com";
                sc.Port = 587;
                sc.Credentials = new
                System.Net.NetworkCredential(MailCredentials.Split('|')[0].ToString(), MailCredentials.Split('|')[1].ToString());
                sc.EnableSsl = true;
                sc.Send(m);
            }
            catch (Exception)
            {

            }
        }

    }

    public static void sendNewUserMail(string password, string SendToEmailId, string UserName)
    {

        MailMessage m = new MailMessage();
        SmtpClient sc = new SmtpClient();
        String MailFrom = "", MailCredentials = "";
        MailFrom = ConfigurationManager.AppSettings["MailFromId"].ToString();
        MailCredentials = ConfigurationManager.AppSettings["MailFromCredentials"].ToString();
        if ((!String.IsNullOrEmpty(MailFrom)) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[0])) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[1])))
        {
            try
            {
                m.From = new MailAddress(MailFrom, "Pills in Cart Support");
                m.To.Add(new MailAddress(SendToEmailId, "Dear Pills in Cart user"));
                // m.CC.Add(new MailAddress("CC@yahoo.com", "Display name CC"));
                //similarly BCC


                m.Subject = "Login Details for Pills in Cart. ";
                m.IsBodyHtml = true;
                //  m.Body = "Your Password is - " + password;

                StringBuilder Body_Message2 = new StringBuilder();

                Body_Message2.Append("Dear " + UserName + "");
                Body_Message2.AppendLine("<br/>");
                Body_Message2.AppendLine("Thank You for Registering with Pills in Cart.");
                Body_Message2.AppendLine("<br/>");
                Body_Message2.AppendLine("Your Login Details are: ");
                Body_Message2.AppendLine("<br/>");
                Body_Message2.AppendLine("Email ID: " + SendToEmailId + "");
                Body_Message2.AppendLine("Password: " + password + "");

                m.Body = Body_Message2.ToString();
                sc.Host = "smtp.gmail.com";
                sc.Port = 587;
                sc.Credentials = new
                System.Net.NetworkCredential(MailCredentials.Split('|')[0].ToString(), MailCredentials.Split('|')[1].ToString());
                sc.EnableSsl = true;
                sc.Send(m);
            }
            catch (Exception)
            {

            }
        }
    }

    public static void sendOrderConfirmed(string SendToEmailId, string UserName)
    {

        MailMessage m = new MailMessage();
        SmtpClient sc = new SmtpClient();
        String MailFrom = "", MailCredentials = "";
        MailFrom = ConfigurationManager.AppSettings["MailFromId"].ToString();
        MailCredentials = ConfigurationManager.AppSettings["MailFromCredentials"].ToString();
        if ((!String.IsNullOrEmpty(MailFrom)) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[0])) && (!String.IsNullOrEmpty(MailCredentials.Split('|')[1])))
        {
            try
            {
                m.From = new MailAddress(MailFrom, "Pills in Cart Support");
                m.To.Add(new MailAddress(SendToEmailId, "Dear Pills in Cart user"));
                // m.CC.Add(new MailAddress("CC@yahoo.com", "Display name CC"));
                //similarly BCC


                m.Subject = "Login Details for Pills in Cart. ";


                StringBuilder Body_Message2 = new StringBuilder();

                Body_Message2.Append("Dear " + UserName + "");
                Body_Message2.AppendLine("<br/>");
                Body_Message2.AppendLine("Thank You for Placing an Order with Pills in Cart.");

                m.Body = Body_Message2.ToString();
                m.IsBodyHtml = true;
                sc.Host = "smtp.gmail.com";
                sc.Port = 587;
                sc.Credentials = new
                System.Net.NetworkCredential(MailCredentials.Split('|')[0].ToString(), MailCredentials.Split('|')[1].ToString());
                sc.EnableSsl = true;
                sc.Send(m);
            }
            catch (Exception)
            {

            }
        }
    }
}