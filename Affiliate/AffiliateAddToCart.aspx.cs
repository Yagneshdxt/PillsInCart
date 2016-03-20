using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Affiliate_AffiliateAddToCart : System.Web.UI.Page
{
    public string AffiliateID
    {
        get
        {
            string AffID = "";
            if (Request.QueryString["AffId"] != null && !String.IsNullOrEmpty(Convert.ToString(Request.QueryString["AffId"])))
            {
                AffID = Request.QueryString["AffId"].ToString();
            }
            return AffID;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(AffiliateID))
        {
            Response.Redirect("~/");
        }

        if (!IsPostBack)
        {
            BindPageControls();
        }

    }

    private void BindPageControls()
    {
        Boolean ChkFlag = false;
        try
        {
            hdnPrPriceIdSer.Value = "";
            DataAccess objDataAcc = new DataAccess();
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@affiliateId",Convert.ToInt64(AffiliateID)),
                new SqlParameter("@type","S")
            };
            ds = objDataAcc.getDataSetQuery("Affiliate_IUD", param, CommandType.StoredProcedure);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["AffActiveFlag"] != null && Convert.ToBoolean(ds.Tables[0].Rows[0]["AffActiveFlag"]))
                {
                    OrderID.SetAffId(AffiliateID);
                    hdnPrPriceIdSer.Value = ds.Tables[0].Rows[0]["prodPricseID"].ToString();
                    ChkFlag = true;
                }
            }

        }
        catch (Exception)
        {
            ChkFlag = false;
        }

        if (!ChkFlag)
        {
            Response.Redirect("~/", true);
            //Response.Redirect("~/BuyProduct/viewcart.aspx", true);
        }
    }


}