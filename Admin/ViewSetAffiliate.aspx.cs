using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_ViewSetAffiliate : System.Web.UI.Page
{
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

        try
        {
            if (!IsPostBack)
            {
                BindGrid("");
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
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            DataAccess objDataAccess = new DataAccess();
            SqlParameter[] paramtrs = new SqlParameter[]{
                new SqlParameter("@userId", Convert.ToInt64(objUserInfo.userId))
            };
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(" SELECT a.userId, a.fName, a.EmailID, a.phone, a.Mobile, a.bankAccNo_aff,a.SwiftCode,a.RoutingNo,a.CorrespondentBankName,a.CorrespondentBankActNo, a.bankName_aff,a.Benificiaryname,a.BenificiaryAddress ,a.bankBranchName_aff, ISNULL(a.commisonPer_aff,0.00) as commisonPer_aff ")
                   .Append(" FROM   dbo.userdetail AS a INNER JOIN ")
                    .Append("  (SELECT DISTINCT userId ")
                    .Append("  FROM dbo.Affiliate ")
                    .Append("  WHERE (activeFlag = 1)) AS b ON a.userId = b.userId ");

           /* sqlQuer.Append(" SELECT        a.userId, a.fName, a.EmailID, a.phone, a.Mobile, a.bankAccNo_aff, a.bankName_aff, a.bankBranchName_aff, ISNULL(a.commisonPer_aff, 0.00)  ")
                    .Append("              AS commisonPer_aff ")
                    .Append(" FROM         dbo.userdetail AS a INNER JOIN ")
                    .Append("              (SELECT DISTINCT ia.userId ")
                    .Append("                FROM  dbo.Affiliate AS ia INNER JOIN ")
                    .Append("                      dbo.mproduct AS ib ON ia.productid = ib.productid AND ib.activeflag = 1 AND ib.DeleteFlage = 'A' INNER JOIN ")
                    .Append("                      dbo.mcategory AS ic ON ib.categoryId = ic.categoryid AND ic.activeflag = 1 AND ic.DeleteFlage = 'A' INNER JOIN ")
                    .Append("                      dbo.RootCategory_Mst AS id ON ic.type = id.RootCateoryId AND id.ActiveFlage = 1 AND id.DeleteFlage = 'A' ")
                    .Append("                      WHERE        (ia.activeFlag = 1)) AS b ON a.userId = b.userId ");*/


            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            //sqlQuer.Append("  ORDER by a.createdDt DESC ");  AND (userId = @userId)
            grdAffiliate.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
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

    protected void btnview_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE 1=1 ");
            if (!String.IsNullOrEmpty(txtAffiliate.Text))
            {
                sqlWher.Append(" AND a.fName LIKE '%")
                    .Append(txtAffiliate.Text + "%'");
            }
            BindGrid(sqlWher.ToString());
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

    protected void btnUpdtCommision_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gr = ((Button)sender).NamingContainer as GridViewRow;
            if (gr != null)
            {
                HiddenField hdnuserId = gr.FindControl("hdnuserId") as HiddenField;
                TextBox txtCommission = gr.FindControl("txtCommission") as TextBox;
                if (hdnuserId != null && txtCommission != null && !String.IsNullOrEmpty(txtCommission.Text) && !String.IsNullOrEmpty(hdnuserId.Value))
                {

                    SqlParameter[] paramtrs = new SqlParameter[]{
                        new SqlParameter("@userId", Convert.ToInt64(hdnuserId.Value)),
                        new SqlParameter("@commisonPer_aff", txtCommission.Text),
                        new SqlParameter("@UpdateType", "C")
                    };
                    DataAccess objDataAccess = new DataAccess();
                    objDataAccess.DaExecNonQueryStr("affiliateDetails", paramtrs, CommandType.StoredProcedure);
                    //btnview_Click(null, null);
                    AlertMsg("Updated Successfuly");
                }
            }
        }
        catch (Exception)
        {
            AlertMsg("Error updating the record");
        }
    }
}