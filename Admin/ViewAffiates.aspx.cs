﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ViewAffiates : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Admin/Account/AdminLogin.aspx", true);
        }
        else
        {
            if (!objUserInfo.IsAdmin())
                Response.Redirect("~/Admin/Account/AdminLogin.aspx", true);
        }

        try
        {
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["UserID"]))
                {
                    Response.Redirect("~/Admin/Account/AcDeAffiliate.aspx", true);
                }
                StringBuilder sqlWher = new StringBuilder();
                sqlWher.Append(" WHERE a.userID=" + Convert.ToInt32(Request.QueryString["UserID"]) + " ");
                BindGrid(sqlWher.ToString());

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

            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append("  SELECT a.affiliateId, b.fName,b.EmailID,b.Mobile,c.prdiddisplay productId, c.name productName ,a.createdDt, a.activeFlag,")
                   .Append("  CASE a.activeFlag  when 0 then 'Inactive' when 1 then 'Active' end ActiveInactive,c.logoimgPath,c.ShortName  ")
                   .Append("  FROM Affiliate a ")
                   .Append("  JOIN userdetail b on a.userId = b.userId ")
                   .Append("  JOIN mproduct c on a.productid = c.productid ");//and c.activeflag= 1 and c.DeleteFlage = 'A' ");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append("  ORDER by a.createdDt DESC ");
            grdAffiliate.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdAffiliate.DataBind();
        }
        catch (Exception)
        {

        }
    }

    protected void btnview_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE a.userID=" + Convert.ToInt32(Request.QueryString["UserID"]) + " ");
            if (!String.IsNullOrEmpty(txtProductId.Text))
            {
                sqlWher.Append(" AND c.prdiddisplay LIKE '%")
                    .Append(txtProductId.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtProductName.Text))
            {
                sqlWher.Append(" AND c.name LIKE '%")
                    .Append(txtProductName.Text + "%'");
            }
            if (ddlStatusFil.SelectedValue != "00")
            {
                sqlWher.Append(" AND a.activeFlag ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }
            BindGrid(sqlWher.ToString());
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

    protected void lnkupdate_Click(object sender, EventArgs e)
    {
        int chkFlage = 0;
        try
        {
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            LinkButton lnkupdate = sender as LinkButton;
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnAffiliateId = grRow.FindControl("hdnAffiliateId") as HiddenField;
            if (lnkupdate.CommandArgument.Trim() == "True")
            {
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ModifiedBy",objUserInfo.userId),
                new SqlParameter("@ActiveFlag","0"),
                new SqlParameter("@affiliateId",hdnAffiliateId.Value)
            };

                chkFlage = objDataAccess.DaExecNonQueryStr(" update Affiliate set activeFlag = @ActiveFlag,modifiedBy=@ModifiedBy,modifiedDt=getdate() where affiliateId=@affiliateId ", param);
            }
            if (lnkupdate.CommandArgument.Trim() == "False")
            {
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ModifiedBy",objUserInfo.userId),
                new SqlParameter("@ActiveFlag","1"),
                new SqlParameter("@affiliateId",hdnAffiliateId.Value)
                };
                chkFlage = objDataAccess.DaExecNonQueryStr(" update Affiliate set activeFlag = @ActiveFlag,modifiedBy=@ModifiedBy,modifiedDt=getdate() where affiliateId=@affiliateId ", param);
            }

            BindGrid("");
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
            BindGrid("");
        }
        catch (Exception)
        {

        }
    }

}