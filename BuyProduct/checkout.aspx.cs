using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class checkout : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    Decimal Total = 0;
    DataAccess objDataAccess = new DataAccess();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            if ((Session["OrdId"] == null)) //|| (objUserInfo == null)
                Response.Redirect("~/");
            txtdob.Attributes.Add("readonly", "true");
            dsProducts.SelectCommand = "select B.* ,D.name + ' ' + C.quantity + ' of ' +  C.strength as Product,C.quantity from OrderHeader A inner join OrderDetail B on A.OrderHeaderId = B.OrderHeaderId inner join mstProductPrice C ON B.ProdPriceId = C.ProdPriceId inner join mproduct D on C.productid = D.productid where A.OrderHeaderId =  '" + Session["OrdId"].ToString() + "'";
            //radiopayment1.SelectedValue = "11";
            ddlshipinginfo.SelectedValue = "8";
            DataAccess objDataAccess = new DataAccess();
            hdnFreeShipmentLimit.Value = objDataAccess.SelectScalar("select name from mstGeneralCnst where typename = 'FreeShippingLimit' and activeflag = 1").ToString();
            Boolean MedicalVisibility = checkForMedicalInfoMaster();
            trMEdicalHeader.Visible = MedicalVisibility;
            trMedicalDetaila.Visible = MedicalVisibility;

            if (objUserInfo == null)
            {
                hdnRegistered.Value = "N";

            }
            else
            {
                hdnRegistered.Value = "Y";
                DataAccess DAL = new DataAccess();
                DataSet ds = new DataSet();
                ds = DAL.getDataSetQuery("select A.*,convert(varchar,dob,103) as ddob,DATEDIFF(year,dob,getdate()) as age,B.Country as Countryname from userdetail A inner join MstCountry B on A.Country = B.ID where A.userid = '" + objUserInfo.userId + "'");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ofname.Text = ds.Tables[0].Rows[0]["fname"].ToString();
                    olname.Text = ds.Tables[0].Rows[0]["lname"].ToString();
                    odob.Text = ds.Tables[0].Rows[0]["ddob"].ToString();
                    oAddress1.Text = ds.Tables[0].Rows[0]["Address1"].ToString();
                    oaddress2.Text = ds.Tables[0].Rows[0]["Address2"].ToString();
                    ostate.Text = ds.Tables[0].Rows[0]["StateOrProvince"].ToString();
                    ocity.Text = ds.Tables[0].Rows[0]["city"].ToString();
                    ozipcode.Text = ds.Tables[0].Rows[0]["zipcode"].ToString();
                    ophone.Text = ds.Tables[0].Rows[0]["phone"].ToString();
                    omobile.Text = ds.Tables[0].Rows[0]["mobile"].ToString();
                    ofname.Text = ds.Tables[0].Rows[0]["fname"].ToString();
                    ocountry.Text = ds.Tables[0].Rows[0]["Countryname"].ToString();
                    oGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                    oEmail.Text = ds.Tables[0].Rows[0]["EmailID"].ToString();

                    lblgetdbname.Text = ds.Tables[0].Rows[0]["fname"].ToString() + " " + ds.Tables[0].Rows[0]["lname"].ToString();
                    lblgetdbage.Text = ds.Tables[0].Rows[0]["age"].ToString();
                    lblgetdbsex.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                    radioregister.Checked = false;
                    radioregister.Attributes.Add("onClick", "return false;");
                    //radioregister.Enabled = false;
                }
            }
        }
    }

    protected Boolean checkForMedicalInfoMaster()
    {
        Boolean ret = false;
        string ActiveFlag = objDataAccess.SelectScalar("SELECT activeflag FROM mstGeneralCnst WHERE typename  = 'DisplayMedicalInfo'").ToString();
        if (ActiveFlag == "1")
        {
            ret = true;
        }
        return ret;
    }

    public void disableRequireFieldValidator(Control ctr)
    {
        foreach (Control frmctrl in ctr.Controls)
        {
            if (frmctrl.GetType() == typeof(RequiredFieldValidator))
            {
                ((RequiredFieldValidator)frmctrl).Enabled = false;
            }
            if (frmctrl.HasControls())
                disableRequireFieldValidator(frmctrl);
        }
    }

    public override void Validate()
    {
        if (rblMedical.SelectedValue == "14")
        {
            //disableRequireFieldValidator(tblMedicalPres);
        }
        base.Validate();
    }

    protected void ListView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridViewRow row = (GridViewRow)e.Row;
                Total = Total + Convert.ToDecimal(ListView1.DataKeys[row.RowIndex]["Price"].ToString());
                lblBillingAmount.Text = Total.ToString();
            }
        }
        catch (Exception)
        {

        }
    }
    [WebMethod(EnableSession = true)]
    public static discountClass discountChk(string code)
    {
        discountClass objdiscountClass = new discountClass();
        try
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            SqlDataAdapter da = new SqlDataAdapter("CheckAndApplyDiscount", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@OrderHeaderID", HttpContext.Current.Session["OrdId"].ToString());
            da.SelectCommand.Parameters.AddWithValue("@DiscountCode", code);
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            if (objUserInfo != null)
            {
                da.SelectCommand.Parameters.AddWithValue("@UserID", objUserInfo.userId);
            }
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                objdiscountClass.discountid = dt.Rows[0]["DiscountId"].ToString();
                objdiscountClass.discountamt = dt.Rows[0]["DiscountVal"].ToString();
                objdiscountClass.dismessage = dt.Rows[0]["Msg"].ToString();
            }
        }
        catch (Exception)
        {

        }
        return objdiscountClass;
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
    [WebMethod]
    public static string getFlatDiscount(string BillAmount)
    {
        Decimal Discount = 0;
        try
        {
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            long? userid = null;
            if (objUserInfo != null)
            {
                userid = objUserInfo.userId;
            }
            SqlParameter[] param = {
                              new SqlParameter("@UserId",userid),
                              new SqlParameter ("@BilledAmount",BillAmount)
                                  };

            DataAccess objDataAccess = new DataAccess();
            Discount = Convert.ToDecimal(objDataAccess.SelectScalarRetObj("getFlatDiscount", param, CommandType.StoredProcedure));
        }
        catch (Exception)
        {
            Discount = 0;
        }
        return Discount.ToString();
    }

    protected void btnmodifycart_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BuyProduct/viewcart.aspx");
    }

    protected void btnregistersubmit_Click(object sender, EventArgs e)
    {
        bool chkFlag = false;
        try
        {
            chkFlag = objDataAccess.LoginUser(txtregistereemail.Text, txtregisterpassword.Text, false);
        }
        catch (Exception)
        {
            chkFlag = false;
        }
        if (chkFlag)
            Response.Redirect(Request.Url.ToString(), true);
    }

    protected void btnsubmitorder_Click(object sender, EventArgs e)
    {
        try
        {
            //Page.Validate();
            /*
            foreach (object o in Validators)
            {
                if (!((IValidator)o).IsValid)
                {
                    Response.Write(((Control)o).ID + "<br/>");
                }
            }
            RequiredFieldValidator2 RequiredFieldValidator3 rfvfname fvlname rfvDOB rfvaddress rfvaddress2 rfvcity rfvcountry rfvState rfvzip fvphnno rfvMobile rfvEmailID rfvPassword rfvrepassword */
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("insertorder", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OrderHeaderID", Session["OrdId"].ToString());
            cmd.Parameters.AddWithValue("@RegisteredUserFlag", (objUserInfo == null) ? "0" : "1");  //yagnesh 
            cmd.Parameters.AddWithValue("@ShippingTypeFlag", ddlshipinginfo.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@MedicalInfoFlag", rblMedical.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@PaymentMode", radiopayment1.SelectedValue.ToString());
            // LOGIN DETAILS
            if (objUserInfo != null)
            {
                cmd.Parameters.AddWithValue("@LoggedUser", objUserInfo.userId); //yagnesh
            }
            cmd.Parameters.AddWithValue("@fName", txtfname.Text.ToString());
            cmd.Parameters.AddWithValue("@lName", txtlname.Text.ToString());
            cmd.Parameters.AddWithValue("@Gender", radiomale.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@Dob", txtdob.Text.ToString());
            cmd.Parameters.AddWithValue("@EmailID", txtemailid.Text.ToString());
            cmd.Parameters.AddWithValue("@password", txtpassword.Text.ToString());
            cmd.Parameters.AddWithValue("@Address1", txtaddress.Text.ToString());
            cmd.Parameters.AddWithValue("@Address2", txtaddress2.Text.ToString());
            cmd.Parameters.AddWithValue("@Country", ddlcountry.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@StateorProvince", txtstate.Text.ToString());
            cmd.Parameters.AddWithValue("@City", txtcity.Text.ToString());
            cmd.Parameters.AddWithValue("@Zipcode", txtzipcode.Text.ToString());
            cmd.Parameters.AddWithValue("@Phone", txtphoneno.Text.ToString());
            cmd.Parameters.AddWithValue("@Mobile", txtmobile.Text.ToString());

            cmd.Parameters.AddWithValue("@Dfname", shiptxtfname.Text.ToString());
            cmd.Parameters.AddWithValue("@Dlname", shiptxtlname.Text.ToString());
            cmd.Parameters.AddWithValue("@DAddress1", shiptxtaddress.Text.ToString());
            cmd.Parameters.AddWithValue("@DAddress2", shiptxtaddress2.Text.ToString());
            cmd.Parameters.AddWithValue("@DCountry", shipddlcountry.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@DStateorProvince", shiptxtstate.Text.ToString());
            cmd.Parameters.AddWithValue("@DCity", shiptxtcity.Text.ToString());
            cmd.Parameters.AddWithValue("@DZipcode", shiptxtzipcode.Text.ToString());
            cmd.Parameters.AddWithValue("@DPhone", shiptxtphoneno.Text.ToString());
            cmd.Parameters.AddWithValue("@DMobile", shiptxtmobile.Text.ToString());

            cmd.Parameters.AddWithValue("@ShippingID", hdnShippID.Value.ToString());
            if (hdnDiscountID.Value.ToString() != "")
            {
                cmd.Parameters.AddWithValue("@DiscountID", hdnDiscountID.Value.ToString());
            }
            cmd.Parameters.AddWithValue("@FlatDiscount", Convert.ToDecimal(hdnFlatDiscount.Value.ToString()));
            cmd.Parameters.AddWithValue("@ShippingCharge", Convert.ToDecimal(hdnShippCharge.Value.ToString()));
            cmd.Parameters.AddWithValue("@echeque_RoutingNo", txtChequeNo.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_AccountNo", txtAccNo.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_ChequeNo", txtChequeNo.Text.ToString());
            cmd.Parameters.AddWithValue("@creditcard_TypeId", ddlCCType.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@ceditcard_CreditCardNo", txtCreditCardNo.Text.ToString());
            cmd.Parameters.AddWithValue("@creditcard_ExpiryMonth", ddlMonth.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@creditcard_ExpityYear", ddlYear.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@creditcard_CVV2", txtCVV2.Text.ToString());
            cmd.Parameters.AddWithValue("@creditcard_Name", txtCCName.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_accholder", txtAccHolder.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_accaddress", txtAccAddress.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_acccity", txtAccCity.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_accstate", txtAccState.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_acczip", txtZip.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_accphoneno", txtAccPhone.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_bankname", txtBankName.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_bankcity", txtBankCity.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_bankstate", txtBankState.Text.ToString());
            cmd.Parameters.AddWithValue("@echeque_bankphone", txtBankPhone.Text.ToString());

            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionId");
            dt.Columns.Add("Answer");
            dt.Columns.Add("DisagreeReason");
            DataRow dr;
            if (rblMedical.SelectedValue == "15")//Do not have Medical Prescription
            {
                cmd.Parameters.AddWithValue("@Height", txtPersonalheight.Text.ToString());
                cmd.Parameters.AddWithValue("@HeightUnitID", ddlPersonalheight.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@Weight", Convert.ToDecimal(txtPersonalweight.Text.ToString()));
                cmd.Parameters.AddWithValue("@MedicalCondition", txtPersonalmedicalcondition.Text.ToString());
                cmd.Parameters.AddWithValue("@AnyOtherHabits", txtOtherHabbits.Text.ToString());

                for (int i = 0; i < gvPastMedicalHistory.Items.Count; i++)
                {
                    dr = dt.NewRow();
                    dr["QuestionId"] = ((HiddenField)(gvPastMedicalHistory.Items[i].FindControl("hdnQuestionID"))).Value.ToString();
                    dr["Answer"] = ((RadioButtonList)(gvPastMedicalHistory.Items[i].FindControl("rblHistory"))).SelectedValue.ToString();
                    dr["DisagreeReason"] = ((TextBox)(gvPastMedicalHistory.Items[i].FindControl("txtReason"))).Text.ToString();
                    dt.Rows.Add(dr);
                }
                for (int i = 0; i < gvHAbbits.Items.Count; i++)
                {
                    dr = dt.NewRow();
                    dr["QuestionId"] = ((HiddenField)(gvHAbbits.Items[i].FindControl("hdnQuestionID"))).Value.ToString();
                    dr["Answer"] = ((RadioButtonList)(gvHAbbits.Items[i].FindControl("rblHistory"))).SelectedValue.ToString();
                    dr["DisagreeReason"] = ((TextBox)(gvHAbbits.Items[i].FindControl("txtReason"))).Text.ToString();
                    dt.Rows.Add(dr);
                }
            }
            for (int i = 0; i < rptAgreement.Items.Count; i++)
            {
                dr = dt.NewRow();
                dr["QuestionId"] = ((HiddenField)(rptAgreement.Items[i].FindControl("hdnQuestionID"))).Value.ToString();
                dr["Answer"] = ((RadioButtonList)(rptAgreement.Items[i].FindControl("rblHistory"))).SelectedValue.ToString();
                dr["DisagreeReason"] = ((TextBox)(rptAgreement.Items[i].FindControl("txtReason"))).Text.ToString();
                dt.Rows.Add(dr);
            }
            cmd.Parameters.AddWithValue("@PrescriptionDetails", dt);
            SqlParameter param = new SqlParameter("@Ret", SqlDbType.Int, 400);
            param.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(param);
            cmd.ExecuteNonQuery();

            pnlAll.Visible = false;
            pnlMsg.Visible = true;
            if (cmd.Parameters["@Ret"].Value.ToString() == "1")
            {
                Session.Remove("OrdId");
                if (objUserInfo == null)
                {
                    objDataAccess.LoginUser(txtemailid.Text, txtpassword.Text);
                }
                pnlMsg.Visible = true;
                //lblMsg.Text = "ORDER HAS BEEN SUBMITTED SUCCESSFULLY !";
                SendMail.sendOrderConfirmed(objUserInfo.EmailID, objUserInfo.fName + " " + objUserInfo.lName);
            }
            else
            {
                pnlMsg.Visible = false;
                //lblMsg.Text = "ERROR OCCURED. PLEASE TRY AGAIN LATER !";
            }

        }
        catch (Exception ex)
        {
            // Response.Write(ex.ToString());
        }
        finally
        {
            con.Close();
        }
    }
}
