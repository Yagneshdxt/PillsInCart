using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

public partial class Affiliate_BecomeAnAffiliate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Account/login.aspx?RetUrl=~/Affiliate/BecomeAnAffiliate.aspx");
        }
        try
        {
            if (!IsPostBack)
            {
                Bindcontrols();
            }
        }
        catch (Exception)
        {

        }
    }

    protected void Bindcontrols()
    {
        try
        {
            DataAccess objDataAccess = new DataAccess();
            ddlrootCategory.DataSource = objDataAccess.getRootCategory();
            ddlrootCategory.DataValueField = "RootCateoryId";
            ddlrootCategory.DataTextField = "CatName";
            ddlrootCategory.DataBind();
            ddlrootCategory.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlCategory.Items.Clear();
            ddlCategory.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlProduct.Items.Clear();
            ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));

            bindBankDetails();

            //BindGrid("");
        }
        catch (Exception)
        {

        }
    }

    protected void bindBankDetails()
    {

        try
        {
            DataAccess objDataAccess = new DataAccess();
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            SqlParameter[] paramtrs = new SqlParameter[]{
                new SqlParameter("@userId", Convert.ToInt64(objUserInfo.userId)),
                new SqlParameter("@UpdateType", "S")
            };
            DataSet BnkDetais_Ds = objDataAccess.getDataSetQuery("affiliateDetails", paramtrs, CommandType.StoredProcedure);
            if (BnkDetais_Ds != null && BnkDetais_Ds.Tables.Count > 0 && BnkDetais_Ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = BnkDetais_Ds.Tables[0].Rows[0];
                if (dr != null)
                {

                    txtAccountNo.Text = String.IsNullOrEmpty(Convert.ToString(dr["bankAccNo_aff"])) ? " " : Convert.ToString(dr["bankAccNo_aff"]);
                    txtbankName.Text = String.IsNullOrEmpty(Convert.ToString(dr["bankName_aff"])) ? " " : Convert.ToString(dr["bankName_aff"]);
                    txtBranchName.Text = String.IsNullOrEmpty(Convert.ToString(dr["bankBranchName_aff"])) ? " " : Convert.ToString(dr["bankBranchName_aff"]);
                    lblCommission.Text = String.IsNullOrEmpty(Convert.ToString(dr["commisonPer_aff"])) ? "0.00" : Convert.ToString(dr["commisonPer_aff"]);

                    txtswiftcode.Text = String.IsNullOrEmpty(Convert.ToString(dr["SwiftCode"])) ? " " : Convert.ToString(dr["SwiftCode"]);
                    txtRoutingno.Text = String.IsNullOrEmpty(Convert.ToString(dr["RoutingNo"])) ? " " : Convert.ToString(dr["RoutingNo"]);
                    txtcorrbankname.Text = String.IsNullOrEmpty(Convert.ToString(dr["CorrespondentBankName"])) ? " " : Convert.ToString(dr["CorrespondentBankName"]);
                    txtcorracctno.Text = String.IsNullOrEmpty(Convert.ToString(dr["CorrespondentBankActNo"])) ? " " : Convert.ToString(dr["CorrespondentBankActNo"]);
                    txtbenname.Text = String.IsNullOrEmpty(Convert.ToString(dr["Benificiaryname"])) ? " " : Convert.ToString(dr["Benificiaryname"]);
                    txtbeneaddress.Text = String.IsNullOrEmpty(Convert.ToString(dr["BenificiaryAddress"])) ? " " : Convert.ToString(dr["BenificiaryAddress"]);

                }
            }
        }
        catch (Exception)
        {

        }
    }

    protected void BindGrid(string sqlWhere)
    {
        try
        {

            DataAccess objDataAccess = new DataAccess();
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            SqlParameter[] paramtrs = new SqlParameter[]{
                new SqlParameter("@userId", Convert.ToInt64(objUserInfo.userId))
            };
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append("  SELECT a.affiliateId, b.fName,b.EmailID,b.Mobile,c.prdiddisplay productId, c.name productName ,a.createdDt, a.activeFlag,")
                   .Append("  CASE a.activeFlag  when 0 then 'Inactive' when 1 then 'Active' end ActiveInactive,c.logoimgPath,c.ShortName  ")
                   .Append("  FROM Affiliate a ")
                   .Append("  JOIN userdetail b on a.userId = b.userId and a.userId = @userId")
                   .Append("  JOIN mproduct c on a.productid = c.productid and c.activeflag= 1 and c.DeleteFlage = 'A' ");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append("  ORDER by a.createdDt DESC ");
            grdAffiliate.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString(), paramtrs);
            grdAffiliate.DataBind();
        }
        catch (Exception)
        {

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

    protected void ClearControls()
    {
        try
        {
            ddlrootCategory.ClearSelection();
            ddlrootCategory.SelectedIndex = 0;

            ddlCategory.Items.Clear();
            ddlCategory.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlProduct.Items.Clear();
            ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception)
        {

        }
    }

    protected void ddlrootCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlrootCategory.SelectedValue != "0")
            {
                DataAccess objDataAccess = new DataAccess();
                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@Type",ddlrootCategory.SelectedValue)
                };
                ds = objDataAccess.getDataSetQuery("SELECT name,categoryid FROM mcategory WHERE activeflag=1 AND DeleteFlage='A' AND type=@Type", param);
                ddlCategory.Items.Clear();
                ddlCategory.DataSource = ds;
                ddlCategory.DataValueField = "categoryid";
                ddlCategory.DataTextField = "name";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlProduct.Items.Clear();
                ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
            }

        }
        catch (Exception)
        {

        }
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCategory.SelectedValue != "0")
            {
                DataAccess objDataAccess = new DataAccess();
                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@categoryId",ddlCategory.SelectedValue)
                };
                ds = objDataAccess.getDataSetQuery("select productid,name from mproduct where categoryId=@categoryId AND activeflag=1 AND DeleteFlage = 'A' AND categoryId=@categoryId", param);
                ddlProduct.Items.Clear();
                ddlProduct.DataSource = ds;
                ddlProduct.DataValueField = "productid";
                ddlProduct.DataTextField = "name";
                ddlProduct.DataBind();
                ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));

                //LnkAddtoCart.Attributes.Add("onClick", "return false");
            }
        }
        catch (Exception)
        {

        }
    }
    protected void btngetLink_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        try
        {
            DataAccess objDataAccess = new DataAccess();
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@userId",objUserInfo.userId),
                new SqlParameter("@productid", Convert.ToInt64(ddlProduct.SelectedValue)),
                new SqlParameter("@activeFlag",true),
                new SqlParameter("@type","I")
            };
            String sqlQuery = "Affiliate_IUD";// @"insert into Affiliate(userId,productid,createdBy,modifiedBy,activeFlag) values(@userId,@productid,@userId,@userId,@activeFlag); SELECT SCOPE_IDENTITY()";
            ds = objDataAccess.getDataSetQuery(sqlQuery, param, CommandType.StoredProcedure);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                String DomainName = ConfigurationManager.AppSettings["DomainName"].ToString();
                StringBuilder LinkStr = new StringBuilder();
                LinkStr.Append("<a href=\"")
                   .Append(DomainName)
                   .Append("/Affiliate/AffiliateAddToCart.aspx?AffId=")
                   .Append(ds.Tables[0].Rows[0][0].ToString()).Append("\">")
                   .Append("<image src=\"")
                   .Append(DomainName)
                   .Append(ds.Tables[1].Rows[0]["logoimgpath"].ToString().Replace("~/", "/"))
                   .Append("\"")
                   .Append(" alt=\"")
                   .Append(ds.Tables[1].Rows[0]["ShortName"].ToString())
                   .Append("\"></image></a>");
                //lnkAffiliate.Text = "<b> Image Link: </b>" + HttpUtility.HtmlEncode(LinkStr.ToString());
                lnkAffiliate.Text = "<b> Image Link: </b>" + HttpUtility.HtmlEncode(LinkStr.ToString()) + "<br/><br/> <b> Empty Link: </b>" + HttpUtility.HtmlEncode(DomainName + "/Affiliate/AffiliateAddToCart.aspx?AffId=" + ds.Tables[0].Rows[0][0].ToString());
                ClearControls();
            }
        }
        catch (Exception)
        {
            ds = null;
        }
    }

    protected void btnUpdtBnkDtais_Click(object sender, EventArgs e)
    {
        try
        {
            DataAccess objDataAccess = new DataAccess();
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            SqlParameter[] paramtrs = new SqlParameter[]{
                new SqlParameter("@userId", Convert.ToInt64(objUserInfo.userId)),
                new SqlParameter("@bankAccNo_aff", String.IsNullOrEmpty(txtAccountNo.Text)?" ":txtAccountNo.Text),
                new SqlParameter("@bankName_aff", String.IsNullOrEmpty(txtbankName.Text)?" ":txtbankName.Text),
                new SqlParameter("@bankBranchName_aff", String.IsNullOrEmpty(txtBranchName.Text)?" ":txtBranchName.Text),

                 new SqlParameter("@CorrespondentBankName", String.IsNullOrEmpty(txtcorrbankname.Text)?" ":txtcorrbankname.Text),
                  new SqlParameter("@CorrespondentBankActNo", String.IsNullOrEmpty(txtcorracctno.Text)?" ":txtcorracctno.Text),
                   new SqlParameter("@SwiftCode", String.IsNullOrEmpty(txtswiftcode.Text)?" ":txtswiftcode.Text),
                    new SqlParameter("@RoutingNo", String.IsNullOrEmpty(txtRoutingno.Text)?" ":txtRoutingno.Text),
                      new SqlParameter("@Benificiaryname", String.IsNullOrEmpty(txtbenname.Text)?" ":txtbenname.Text),
                        new SqlParameter("@BenificiaryAddress", String.IsNullOrEmpty(txtbeneaddress.Text)?" ":txtbeneaddress.Text),
                new SqlParameter("@UpdateType", "B")
            };
            DataSet BnkDetais_Ds = objDataAccess.getDataSetQuery("affiliateDetails", paramtrs, CommandType.StoredProcedure);
            AlertMsg("Updated Successfuly");
            //bindBankDetails();
        }
        catch (Exception ex)
        {
            AlertMsg("Error Updating record");
        }
    }

    protected void grdAffiliate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdAffiliate.PageIndex = e.NewPageIndex;
            BindGrid("");
        }
        catch (Exception)
        {

        }
    }

    public string createAffiliateLink(object AffiliatId, object logoImgPath, object shortName)
    {
        //string strlength = s.ToString();
        String DomainName = ConfigurationManager.AppSettings["DomainName"].ToString();
        string strAffiliateLnk = "<a href=\"" + DomainName + "/Affiliate/AffiliateAddToCart.aspx?AffId=" + AffiliatId.ToString() + "\">" + "<image src=\"" + DomainName + logoImgPath.ToString().Replace("~/", "/") + "\"" + " alt=\"" + shortName.ToString() + "\"></image></a>";

        //HttpUtility.HtmlDecode("asd");
        return "<b> Image Link: </b>" + HttpUtility.HtmlEncode(strAffiliateLnk) + "<br/><br/>" + "<b> Empty Link: </b>" + HttpUtility.HtmlEncode(DomainName + "/Affiliate/AffiliateAddToCart.aspx?AffId=" + AffiliatId.ToString());
    }
}