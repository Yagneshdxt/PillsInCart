using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_ViewOrder : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ToString());
    Decimal Total = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                dsProducts.SelectCommand = "select B.* ,D.name + ' ' + C.quantity + ' of ' +  C.strength as Product,C.quantity from OrderHeader A inner join OrderDetail B on A.OrderHeaderId = B.OrderHeaderId inner join mstProductPrice C ON B.ProdPriceId = C.ProdPriceId inner join mproduct D on C.productid = D.productid where A.OrderHeaderId =  '" + Request.QueryString["OrderHeaderId"] + "'";
                SqlDataAdapter da = new SqlDataAdapter("getOrderDetails", conn);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@pOrderHeaderId", Request.QueryString["OrderHeaderId"]);
                DataSet ds = new DataSet();
                da.Fill(ds);
                string DeliveyAddressType = "", PescriptionType = "", PaymentType = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["isProcessessedByAdmin"].ToString() == "True")
                    {
                        btnApprove.Visible = false;
                    }
                    else
                    {
                        btnApprove.Visible = true;
                    }
                    DeliveyAddressType = ds.Tables[0].Rows[0]["AddressTypeName"].ToString();
                    PescriptionType = ds.Tables[0].Rows[0]["PrescriptionTypeName"].ToString();
                    PaymentType = ds.Tables[0].Rows[0]["PaymentTypeName"].ToString();

                    lblDiscountCode.Text = ds.Tables[0].Rows[0]["DiscountCode"].ToString();
                    lblShippingType.Text = ds.Tables[0].Rows[0]["Shippname"].ToString();
                    lblShippingAmount.Text = ds.Tables[0].Rows[0]["ShippingCharge"].ToString();
                    lblFlatDiscount.Text = ds.Tables[0].Rows[0]["FlatDiscount"].ToString();
                    hdnDiscountType.Value = ds.Tables[0].Rows[0]["DiscountTYpe"].ToString();
                    hdnDiscountAmount.Value = ds.Tables[0].Rows[0]["DiscountAmt"].ToString();
                    hdnPaymentModeId.Value = ds.Tables[0].Rows[0]["PaymentTypeId"].ToString();
                    lblPaymentMode.Text = PaymentType;
                    lblPrescription.Text = ds.Tables[0].Rows[0]["PrescriptionTypeName"].ToString();
                    hdnPrescriptionTypeId.Value = ds.Tables[0].Rows[0]["PrescriptionTypeId"].ToString();
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        lblfname.Text = ds.Tables[1].Rows[0]["fname"].ToString();
                        lbllname.Text = ds.Tables[1].Rows[0]["lname"].ToString();
                        lblMName.Text = ds.Tables[1].Rows[0]["fname"].ToString() + " " + ds.Tables[1].Rows[0]["lname"].ToString();
                        lblGende.Text = ds.Tables[1].Rows[0]["gender"].ToString();
                        lblSex.Text = ds.Tables[1].Rows[0]["gender"].ToString();
                        lblDOB.Text = ds.Tables[1].Rows[0]["dob"].ToString();
                        lblEmail.Text = ds.Tables[1].Rows[0]["emailid"].ToString();
                        lblAddress.Text = ds.Tables[1].Rows[0]["address1"].ToString();
                        lblAddress2.Text = ds.Tables[1].Rows[0]["address2"].ToString();
                        lblCountry.Text = ds.Tables[1].Rows[0]["country"].ToString();
                        lblState.Text = ds.Tables[1].Rows[0]["stateorprovince"].ToString();
                        lblCity.Text = ds.Tables[1].Rows[0]["city"].ToString();
                        lblMobile.Text = ds.Tables[1].Rows[0]["mobile"].ToString();
                        lblPhone.Text = ds.Tables[1].Rows[0]["phone"].ToString();
                        lblZipCode.Text = ds.Tables[1].Rows[0]["zipcode"].ToString();
                        lblShippingInfo.Text = DeliveyAddressType;
                    }

                    if (ds.Tables[0].Rows[0]["AddressTypeId"].ToString() == "10")
                    {
                        tbDeliveryAddress.Visible = true;
                        lblDFname.Text = ds.Tables[2].Rows[0]["fname"].ToString();
                        lblDLname.Text = ds.Tables[2].Rows[0]["lname"].ToString();
                        lblDAddress.Text = ds.Tables[2].Rows[0]["Address"].ToString();
                        lblDAddress2.Text = ds.Tables[2].Rows[0]["addressline2"].ToString();
                        lblDCity.Text = ds.Tables[2].Rows[0]["city"].ToString();
                        lblDCountry.Text = ds.Tables[2].Rows[0]["country"].ToString();
                        lblDState.Text = ds.Tables[2].Rows[0]["state"].ToString();
                        lblDPhone.Text = ds.Tables[2].Rows[0]["phoneno"].ToString();
                        lblDMobile.Text = ds.Tables[2].Rows[0]["mobileno"].ToString();
                        lblDZipCode.Text = ds.Tables[2].Rows[0]["zipcode"].ToString();
                    }
                    if (ds.Tables[3].Rows.Count > 0)
                    {
                        lblChequeno.Text = ds.Tables[3].Rows[0]["echeque_ChequeNo"].ToString();
                        lblAccNo.Text = ds.Tables[3].Rows[0]["echeque_AccountNo"].ToString();
                        lblRoutingNo.Text = ds.Tables[3].Rows[0]["echeque_RoutingNo"].ToString();

                        lblCCTYpe.Text = ds.Tables[3].Rows[0]["CeditCardType"].ToString();
                        lblCCName.Text = ds.Tables[3].Rows[0]["creditcard_Name"].ToString();
                        lblCCNo.Text = ds.Tables[3].Rows[0]["ceditcard_CreditCardNo"].ToString();
                        lblExpiryDate.Text = ds.Tables[3].Rows[0]["creditcard_ExpiryMonth"].ToString() + " " +
                            ds.Tables[3].Rows[0]["creditcard_ExpityYear"].ToString();
                        lblCVV2.Text = ds.Tables[3].Rows[0]["creditcard_CVV2"].ToString();

                        txtAccHolder.Text = ds.Tables[3].Rows[0]["echeque_accholder"].ToString();
                        txtAccAddress.Text = ds.Tables[3].Rows[0]["echeque_accaddress"].ToString();
                        txtAccCity.Text = ds.Tables[3].Rows[0]["echeque_acccity"].ToString();
                        txtAccState.Text = ds.Tables[3].Rows[0]["echeque_accstate"].ToString();
                        txtZip.Text = ds.Tables[3].Rows[0]["echeque_acczip"].ToString();
                        txtAccPhone.Text = ds.Tables[3].Rows[0]["echeque_accphoneno"].ToString();
                        txtBankName.Text = ds.Tables[3].Rows[0]["echeque_bankname"].ToString();
                        txtBankCity.Text = ds.Tables[3].Rows[0]["echeque_bankcity"].ToString();
                        txtBankState.Text = ds.Tables[3].Rows[0]["echeque_bankstate"].ToString();
                        txtBankPhone.Text = ds.Tables[3].Rows[0]["echeque_bankphone"].ToString();
                    }
                    if (ds.Tables[4].Rows.Count > 0)
                    {
                        lblAge.Text = ds.Tables[4].Rows[0]["age"].ToString();
                        lblHeight.Text = ds.Tables[4].Rows[0]["height"].ToString() + " " + ds.Tables[4].Rows[0]["name"].ToString();
                        lblMedicalCondition.Text = ds.Tables[4].Rows[0]["MedicalCondition"].ToString();
                        lblOtherHabits.Text = ds.Tables[4].Rows[0]["AnyOtherHabits"].ToString();
                    }

                    gvPastMedicalHistory.DataSource = ds.Tables[5];
                    gvPastMedicalHistory.DataBind();

                    gvPesonalHabits.DataSource = ds.Tables[6];
                    gvPesonalHabits.DataBind();

                    gvTermsnConditions.DataSource = ds.Tables[7];
                    gvTermsnConditions.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
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
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("update OrderHEader set IsProcessessedByAdmin=1,ProcessDate=GETDATE() where OrderHeaderId = @pOrderHeaderId", conn);
        cmd.Parameters.AddWithValue("@pOrderHeaderId", Request.QueryString["OrderHeaderId"]);
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        cmd.ExecuteNonQuery();
        lblMsg.Text = "Order procesessed sucessfully !";
        pnlAll.Visible = false;
    }
}