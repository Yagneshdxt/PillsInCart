using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;

public partial class Admin_ViewProduct : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
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
                BindGridData();
            }
        }
        catch (Exception)
        {

        }
    }

    protected void BindGridData(string sqlWhere = "")
    {
        try
        {
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(" SELECT productid,prdiddisplay,p.categoryId, p.name pName,ShortName,p.[description], ")
                    .Append(" c.name SubCatName,Rc.CatName catName, case p.activeflag when 1 then 'Active' when 0 then 'Inactive' end ActiveState ")
                    .Append(" FROM mproduct p ")
                    .Append(" JOIN mcategory c on p.categoryId=c.categoryid AND c.activeflag = 1 AND c.DeleteFlage = 'A' ")
                    .Append(" JOIN RootCategory_Mst Rc ON Rc.RootCateoryId = c.[type]  where p.activeflag=1 AND p.DeleteFlage='A'");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append(" order by c.name ");
            grdProdLst.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdProdLst.DataBind();
        }
        catch (Exception)
        {

        }
    }

    public string Cutdesc(object s)
    {
        string strlength = s.ToString();
        if (strlength.Length > 100)//checking the length of the string
        {
            strlength = strlength.Substring(0, 150);
            strlength += "....";
        }
        //HttpUtility.HtmlDecode("asd");
        return HttpUtility.HtmlDecode(strlength);
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
            //sqlWher.Append(" WHERE 1=1 ");
            if (!String.IsNullOrEmpty(txtProductID.Text))
            {
                sqlWher.Append(" AND p.prdiddisplay LIKE '%")
                    .Append(txtProductID.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtnamefilter.Text))
            {
                sqlWher.Append(" AND p.name LIKE '%")
                    .Append(txtnamefilter.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtCategory.Text))
            {
                sqlWher.Append(" AND gc.name LIKE '%")
                    .Append(txtCategory.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtSubCategory.Text))
            {
                sqlWher.Append(" AND c.name LIKE '%")
                    .Append(txtSubCategory.Text + "%'");
            }
            if (ddlStatusFil.SelectedValue != "--Select--")
            {
                sqlWher.Append(" AND p.activeflag ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }
            BindGridData(sqlWher.ToString());
        }
        catch (Exception)
        {

        }
    }

    protected void lnkDelet_Click(object sender, EventArgs e)
    {
        int chkInt = 0;
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnProdID = grRow.FindControl("hdnProdID") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@DeleteFlage", 'D'),
                new SqlParameter("@ActiveFlage", Convert.ToInt32(0)),
                new SqlParameter("@productid",hdnProdID.Value.Trim()),
                new SqlParameter("@UserId",UserInfo.GetUserInfo().userId)
            };
            string SqlQry = "UPDATE mproduct SET activeflag=@ActiveFlage, DeleteFlage=@DeleteFlage, modifiedby = @UserId,modifieddate = getdate()  WHERE productid=@productid";
            chkInt = objDataAccess.DaExecNonQueryStr(SqlQry.ToString(), paras);
            btnview_Click(null, null);
        }
        catch (Exception)
        {

        }
    }
    protected void grdProdLst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdProdLst.PageIndex = e.NewPageIndex;
        BindGridData();
    }
}