using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_FlatDiscount : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/Account/AdminLogin.aspx");
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
                BindControl();
            }
        }
        catch (Exception)
        {

        }
    }

    protected void BindControl()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = objDataAccess.getDataSetQuery("select gconstantid,name from mstGeneralCnst where activeflag=1 and typename='discount'  select gconstantid,name from mstGeneralCnst where activeflag=1 and typename='UserType'");
            if ((ds != null) && (ds.Tables.Count > 0))
            {
                ddlDiscounttype.DataSource = ds.Tables[0];
                ddlDiscounttype.DataValueField = "gconstantid";
                ddlDiscounttype.DataTextField = "name";
                ddlDiscounttype.DataBind();
                ddlDiscounttype.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlUserType.DataSource = ds.Tables[1];
                ddlUserType.DataValueField = "gconstantid";
                ddlUserType.DataTextField = "name";
                ddlUserType.DataBind();
                ddlUserType.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            BindGrid("");
        }
        catch (Exception)
        {

        }
    }

    protected void ClearControl()
    {
        try
        {
            txtAmt.Text = "";
            ddlDiscounttype.ClearSelection();
            ddlUserType.ClearSelection();
            rdActiveDeactive.ClearSelection();
            rdActiveDeactive.SelectedValue = "1";
            BindGrid("");
        }
        catch (Exception)
        {

        }
    }
    protected void ResetContorl()
    {
        try
        {
            ClearControl();
            btnSubmit.Visible = true;
            btnSubmit.Text = "Add";
            btnCancel.Visible = false;
            ddlUserType.Enabled = true;
            BindGrid("");
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

    protected void BindGrid(string sqlWhere = "")
    {
        try
        {

            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(" select a.FlatDiscountId,a.DiscountAmt,a.UserType,a.DiscountType,a.ActiveFlag,useType.name UseType ,DisType.name DisType ")
                .Append(" ,case a.ActiveFlag when 1 then 'Active' when 0 then 'Inactive' end ActStatus ")
                .Append(" from FlatDiscount a ")
                .Append(" join mstGeneralCnst useType on useType.gconstantid = a.UserType ")
                .Append(" join mstGeneralCnst DisType on DisType.gconstantid = a.DiscountType ")
                .Append(" Where a.ActiveFlag=1 ");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            grdFlatDiscount.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdFlatDiscount.DataBind();
        }
        catch (Exception)
        {

        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int chkflag = 0;
        try
        {

            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@UserType",ddlUserType.SelectedValue)
            };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            try
            {
                chkflag = objDataAccess.DaExecNonQueryStrTrn("update FlatDiscount set ActiveFlag = 0 where UserType = @UserType", paras, sqlTrn, conObj);

                chkflag = 0;

                SqlParameter[] parasIn = new SqlParameter[]{
                    new SqlParameter("@DiscountAmt",txtAmt.Text),
                    new SqlParameter("@UserType",ddlUserType.SelectedValue),
                    new SqlParameter("@DiscountType",ddlDiscounttype.SelectedValue),
                    new SqlParameter("@CreatedBy",1),
                    new SqlParameter("@ModifiedBy",1),
                    new SqlParameter("@ActiveFlag",rdActiveDeactive.SelectedValue)
                };
                chkflag = objDataAccess.DaExecNonQueryStrTrn("insert into FlatDiscount(DiscountAmt,UserType,DiscountType,CreatedBy,ModifiedBy,ActiveFlag)values(@DiscountAmt,@UserType,@DiscountType,@CreatedBy,@ModifiedBy,@ActiveFlag)", parasIn, sqlTrn, conObj);

                if (chkflag == 0)
                {
                    sqlTrn.Rollback();
                }
                else
                {
                    sqlTrn.Commit();
                    ResetContorl();
                    AlertMsg("Records saved successfuly");

                }
            }
            catch (Exception)
            {
                sqlTrn.Dispose();
            }

            //close connnection
            if (conObj.State == System.Data.ConnectionState.Open)
                conObj.Close();
        }
        catch (Exception)
        {
        }
    }

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnUserType = grRow.FindControl("hdnUserType") as HiddenField;
            Label lblDisAmt = grRow.FindControl("lblDisAmt") as Label;
            HiddenField hdnDisType = grRow.FindControl("hdnDisType") as HiddenField;
            ddlUserType.ClearSelection();
            ddlUserType.SelectedValue = hdnUserType.Value;
            ddlUserType.Enabled = false;
            txtAmt.Text = lblDisAmt.Text;
            ddlDiscounttype.ClearSelection();
            ddlDiscounttype.SelectedValue = hdnDisType.Value;
            btnCancel.Visible = true;
            btnSubmit.Text = "Update";
        }
        catch (Exception)
        {

        }
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            ResetContorl();
        }
        catch (Exception)
        {

        }
    }
    protected void grdFlatDiscount_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdFlatDiscount.PageIndex = e.NewPageIndex;
        BindGrid("");
    }
}