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

public partial class Affiliate_AffiliateDetails : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {

        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/", true);
        }

        try
        {
            if (!IsPostBack)
            {
                BindGridData();
            }
        }
        catch (Exception)
        {

        }
    }

    private void BindGridData()
    {

        try
        {

            UserInfo objUserInfo = UserInfo.GetUserInfo();
            DataAccess objDatAcc = new DataAccess();
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[]{
            new SqlParameter("@userID",objUserInfo.userId)
           };

            string sqlQry = @"SELECT   a.OrderHeaderId, a.DisplayId, e.fName, a.CreatedDate, SUM(b.Price) AS AfillTotal, c.commisonPer_aff, SUM(b.Price) * (c.commisonPer_aff / 100) AS youget
                            FROM       dbo.userdetail AS c INNER JOIN
                                       dbo.Affiliate AS d ON d.userId = c.userId INNER JOIN
                                       dbo.OrderDetail AS b ON b.affiliateId = d.affiliateId INNER JOIN
                                       dbo.OrderHeader AS a ON a.OrderHeaderId = b.OrderHeaderId INNER JOIN
                                       dbo.userdetail AS e ON a.UserId = e.userId
                            WHERE      (a.IsProcessessedByAdmin = 1) AND (c.userId = @userID) AND (d.activeFlag = 1)
                            GROUP BY   a.OrderHeaderId, a.DisplayId, e.fName, a.CreatedDate, c.commisonPer_aff";

            /*
            String sqlQry = @"SELECT a.OrderHeaderId, a.DisplayId, c.fName, a.CreatedDate, SUM(b.Price) AS AfillTotal, c.commisonPer_aff, SUM(b.Price) * (c.commisonPer_aff / 100) AS youget
                            FROM     dbo.OrderHeader AS a INNER JOIN
                                     dbo.userdetail AS c ON a.UserId = c.userId INNER JOIN
                                     dbo.Affiliate AS d ON d.userId = c.userId INNER JOIN
                                     dbo.OrderDetail AS b ON a.OrderHeaderId = b.OrderHeaderId AND b.affiliateId = d.affiliateId
                            WHERE    (a.IsProcessessedByAdmin = 1) AND (c.userId = @userID) AND (d.activeFlag = 1)
                            GROUP BY a.OrderHeaderId, a.DisplayId, c.fName, a.CreatedDate, c.commisonPer_aff";*/
            ds = objDatAcc.getDataSetQuery(sqlQry, param);

            if (ds != null && ds.Tables.Count > 0)
            {
                grdshowAffiliateOrderDetial.DataSource = ds;
                grdshowAffiliateOrderDetial.DataBind();

                Label lblFooterAfillTotal = grdshowAffiliateOrderDetial.FooterRow.FindControl("lblFooterAfillTotal") as Label;
                lblFooterAfillTotal.Text = String.Format("{0:0.00}", ds.Tables[0].Compute("SUM(AfillTotal)", "1=1"));

                Label lblFooteryouGet = grdshowAffiliateOrderDetial.FooterRow.FindControl("lblFooteryouGet") as Label;
                lblFooteryouGet.Text = String.Format("{0:0.00}", ds.Tables[0].Compute("SUM(youget)", "1=1")); 
            }
            else {
                grdshowAffiliateOrderDetial.DataSource = String.Empty;
                grdshowAffiliateOrderDetial.DataBind();
            }

            BindLinkDetailsGrid("");
        }
        catch (Exception)
        {


        }
    }

    protected void BindLinkDetailsGrid(string sqlWhere)
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
                   .Append("  JOIN mproduct c on a.productid = c.productid ");//and c.activeflag= 1 and c.DeleteFlage = 'A' ");
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

    protected void grdAffiliate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdAffiliate.PageIndex = e.NewPageIndex;
            BindLinkDetailsGrid("");
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