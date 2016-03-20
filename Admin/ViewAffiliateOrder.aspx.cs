using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Data;

public partial class Admin_ViewAffiliateOrder : System.Web.UI.Page
{
    public Int64 AffiliateId
    {
        get
        {
            Int64 AffId = 0;
            if (Request.QueryString["AffId"] != null && !String.IsNullOrEmpty(Convert.ToString(Request.QueryString["AffId"])))
            {
                AffId = Convert.ToInt64(Request.QueryString["AffId"]);
            }
            return AffId;
        }
    }

    public Int64 UserId
    {
        get
        {
            Int64 UserId = 0;
            if (Request.QueryString["UserId"] != null && !String.IsNullOrEmpty(Convert.ToString(Request.QueryString["UserId"])))
            {
                UserId = Convert.ToInt64(Request.QueryString["UserId"]);
            }
            return UserId;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }
        else
        {
            if (!objUserInfo.IsAdmin())
                Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }

        if (UserId <= 0)
        {
            Response.Redirect("~/Admin/ViewSetAffiliate.aspx");
        }

        if (!IsPostBack)
        {
            //BindPageControls();
            BindGridData();
        }
    }



    private void BindGridData()
    {

        try
        {

            //UserInfo objUserInfo = UserInfo.GetUserInfo();
            DataAccess objDatAcc = new DataAccess();
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[]{
            new SqlParameter("@userID",UserId)
           };

            string sqlQry = @"SELECT   a.OrderHeaderId,b.ordeDetailId, a.DisplayId,c.fName as AffName,e.fName as CustName, a.CreatedDate, SUM(b.Price) AS AfillTotal, c.commisonPer_aff, SUM(b.Price) * (c.commisonPer_aff / 100) AS youget
                            FROM       dbo.userdetail AS c INNER JOIN
                                       dbo.Affiliate AS d ON d.userId = c.userId INNER JOIN
                                       dbo.OrderDetail AS b ON b.affiliateId = d.affiliateId INNER JOIN
                                       dbo.OrderHeader AS a ON a.OrderHeaderId = b.OrderHeaderId INNER JOIN
                                       dbo.userdetail AS e ON a.UserId = e.userId
                            WHERE      (a.IsProcessessedByAdmin = 1) AND (c.userId = @userID) AND (d.activeFlag = 1)
                            GROUP BY   a.OrderHeaderId,b.ordeDetailId, a.DisplayId, e.fName, a.CreatedDate, c.commisonPer_aff,c.fName";

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
            else
            {
                grdshowAffiliateOrderDetial.DataSource = String.Empty;
                grdshowAffiliateOrderDetial.DataBind();
            }

            //BindLinkDetailsGrid("");
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


    private void BindPageControls()
    {

        try
        {
            DataAccess objDatAcc = new DataAccess();
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[]{
            new SqlParameter("@affiliateId",AffiliateId)
           };

            String sqlQry = @"SELECT a.OrderHeaderId,a.DisplayId,c.fName,a.CreatedDate, SUM(Price) AfillTotal, (select SUM(Price) from OrderDetail det where det.OrderHeaderId = a.OrderHeaderId) totalOrderPrice 
                            FROM OrderHeader a
                            JOIN OrderDetail b on a.OrderHeaderId = b.OrderHeaderId and b.affiliateId=@affiliateId
                            JOIN userdetail c on a.UserId = c.userId
                            WHERE a.IsProcessessedByAdmin = 1
                            group by a.OrderHeaderId,a.DisplayId,c.fName,a.CreatedDate";
            ds = objDatAcc.getDataSetQuery(sqlQry, param);

            if (ds != null && ds.Tables.Count > 0)
            {
                grdshowAffiliateOrderDetial.DataSource = ds;
                grdshowAffiliateOrderDetial.DataBind();
            }
        }
        catch (Exception)
        {

        }
    }

    protected void btnpayout_Click(object sender, EventArgs e)
    {
        try
        {
             GridViewRow gr = ((Button)sender).NamingContainer as GridViewRow;
             if (gr != null)
             {
                 HiddenField hdnorderDetailID = gr.FindControl("hdnorderDetailID") as HiddenField;
                 if (hdnorderDetailID != null && !String.IsNullOrEmpty(hdnorderDetailID.Value)) {
                     SqlParameter[] paramtrs = new SqlParameter[]{
                        new SqlParameter("@orderDetailID",Convert.ToInt64(hdnorderDetailID.Value))
                      };
                     string sqlQry = "update OrderDetail set affiliateId = 0 where OrdeDetailId = @orderDetailID";
                     DataAccess objDataAcc = new DataAccess();
                     objDataAcc.DaExecNonQueryStr(sqlQry, paramtrs);
                     BindGridData();
                 }
             }
        }
        catch (Exception)
        {
            AlertMsg("Error Updating the records");
        }
    }
    protected void grdshowAffiliateOrderDetial_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdshowAffiliateOrderDetial.PageIndex = e.NewPageIndex;
        BindGridData();
    }
}