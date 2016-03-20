using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Data;

public partial class Admin_discountpage : System.Web.UI.Page
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
                fillControl();
            }
        }
        catch (Exception)
        {

        }
    }
    protected void fillControl()
    {
        try
        {
            //discount On
            DataSet ds = new DataSet();
            ds = objDataAccess.getDataSetQuery("select gconstantid,name from mstGeneralCnst where typename='DiscountAppliedOn' and activeflag= 1");
            ddlDiscounton.DataSource = ds;
            ddlDiscounton.DataValueField = "gconstantid";
            ddlDiscounton.DataTextField = "name";
            ddlDiscounton.DataBind();
            ddlDiscounton.Items.Insert(0, new ListItem("--Select--", "0"));

            //ddlmaincategory 
            ds = new DataSet();
            ds = objDataAccess.getDataSetQuery("select RootCateoryId,CatName from RootCategory_Mst where ActiveFlage=1");
            if (ds != null)
            {
                ddlProductCat.DataSource = ds;
                ddlProductCat.DataValueField = "RootCateoryId";
                ddlProductCat.DataTextField = "CatName";
                ddlProductCat.DataBind();
                ddlProductCat.Items.Insert(0, new ListItem("--Select--", "0"));

                //ddlProductCat1.DataSource = ds;
                //ddlProductCat1.DataValueField = "RootCateoryId";
                //ddlProductCat1.DataTextField = "CatName";
                //ddlProductCat1.DataBind();
                //ddlProductCat1.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            ds = new DataSet();
            ds = objDataAccess.getDataSetQuery("select gconstantid,name from mstGeneralCnst where activeflag=1 and typename='discount'");
            ddlDiscounttype.DataSource = ds;
            ddlDiscounttype.DataValueField = "gconstantid";
            ddlDiscounttype.DataTextField = "name";
            ddlDiscounttype.DataBind();
            ddlDiscounttype.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlDiscounttype1.DataSource = ds;
            ddlDiscounttype1.DataValueField = "gconstantid";
            ddlDiscounttype1.DataTextField = "name";
            ddlDiscounttype1.DataBind();
            ddlDiscounttype1.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlSubCat.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddlSubCat1.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddlProduct1.Items.Insert(0, new ListItem("--Select--", "0"));

            //Disable all the product selection drop down
            ddlProductCat.ClearSelection();
            ddlProductCat.SelectedIndex = 0;
            ddlProductCat.Enabled = false;
            rfvRootCategory.Enabled = false;

            ddlSubCat.ClearSelection();
            ddlSubCat.SelectedIndex = 0;
            ddlSubCat.Enabled = false;
            rfvSubCategory.Enabled = false;

            ddlProduct.ClearSelection();
            ddlProduct.SelectedIndex = 0;
            ddlProduct.Enabled = false;
            rfvProduct.Enabled = false;

            BindGrid("");
        }
        catch (Exception)
        {

        }
    }
    protected void ddlDiscounton_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlDiscounton.SelectedValue != "0")
            {
                ddlProductCat.ClearSelection();
                ddlProductCat.SelectedIndex = 0;
                ddlProductCat.Enabled = false;
                rfvRootCategory.Enabled = false;

                ddlSubCat.ClearSelection();
                ddlSubCat.SelectedIndex = 0;
                ddlSubCat.Enabled = false;
                rfvSubCategory.Enabled = false;

                ddlProduct.ClearSelection();
                ddlProduct.SelectedIndex = 0;
                ddlProduct.Enabled = false;
                rfvProduct.Enabled = false;

                if (ddlDiscounton.SelectedItem.Text.ToLower() == "root category")
                {
                    ddlProductCat.ClearSelection();
                    ddlProductCat.SelectedIndex = 0;
                    ddlProductCat.Enabled = true;
                    rfvRootCategory.Enabled = true;

                    ddlSubCat.ClearSelection();
                    ddlSubCat.SelectedIndex = 0;
                    ddlSubCat.Enabled = false;
                    rfvSubCategory.Enabled = false;

                    ddlProduct.ClearSelection();
                    ddlProduct.SelectedIndex = 0;
                    ddlProduct.Enabled = false;
                    rfvProduct.Enabled = false;
                }
                if (ddlDiscounton.SelectedItem.Text.ToLower() == "category")
                {
                    ddlProductCat.ClearSelection();
                    ddlProductCat.SelectedIndex = 0;
                    ddlProductCat.Enabled = true;
                    rfvRootCategory.Enabled = true;

                    ddlSubCat.ClearSelection();
                    ddlSubCat.SelectedIndex = 0;
                    ddlSubCat.Enabled = true;
                    rfvSubCategory.Enabled = true;

                    ddlProduct.ClearSelection();
                    ddlProduct.SelectedIndex = 0;
                    ddlProduct.Enabled = false;
                    rfvProduct.Enabled = false;
                }
                if (ddlDiscounton.SelectedItem.Text.ToLower() == "product")
                {
                    ddlProductCat.ClearSelection();
                    ddlProductCat.SelectedIndex = 0;
                    ddlProductCat.Enabled = true;
                    rfvRootCategory.Enabled = true;

                    ddlSubCat.ClearSelection();
                    ddlSubCat.SelectedIndex = 0;
                    ddlSubCat.Enabled = true;
                    rfvSubCategory.Enabled = true;

                    ddlProduct.ClearSelection();
                    ddlProduct.SelectedIndex = 0;
                    ddlProduct.Enabled = true;
                    rfvProduct.Enabled = true;
                }
            }
        }
        catch (Exception)
        {

        }
    }
    protected void ddlProductCat_SelectedIndexChanged1(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlProductCat.SelectedValue);
        ddlSubCat.DataSource = objDataAccess.getDataSetQuery("select categoryid,name from mcategory where DeleteFlage='A' AND activeflag=1 AND type=" + ID);
        ddlSubCat.DataValueField = "categoryid";
        ddlSubCat.DataTextField = "name";
        ddlSubCat.DataBind();
        ddlSubCat.Items.Insert(0, new ListItem("--Select--", "0"));
        ddlProduct.Items.Clear();
        ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));

    }
    protected void ddlSubCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlSubCat.SelectedValue);
        ddlProduct.DataSource = objDataAccess.getDataSetQuery("select productid,name from mproduct where activeflag=1 and categoryId=" + ID);
        ddlProduct.DataValueField = "productid";
        ddlProduct.DataTextField = "name";
        ddlProduct.DataBind();
        ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
    }

    //filter
    /*
    protected void ddlProductCat1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlProductCat1.SelectedValue);
        ddlSubCat1.DataSource = objDataAccess.getDataSetQuery("select categoryid,name from mcategory where activeflag=1 and type=" + ID);
        ddlSubCat1.DataValueField = "categoryid";
        ddlSubCat1.DataTextField = "name";
        ddlSubCat1.DataBind();
        ddlSubCat1.Items.Insert(0, new ListItem("--Select--", "0"));
    }
    protected void ddlSubCat1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlSubCat1.SelectedValue);
        ddlProduct1.DataSource = objDataAccess.getDataSetQuery("select productid,name from mproduct where activeflag=1 and categoryId=" + ID);
        ddlProduct1.DataValueField = "productid";
        ddlProduct1.DataTextField = "name";
        ddlProduct1.DataBind();
        ddlProduct1.Items.Insert(0, new ListItem("--Select--", "0"));
    }*/

    protected void BindGrid(string sqlWhere = "")
    {
        try
        {

            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(" SELECT a.DiscountID, Discountcode, a.DiscountAppliedOnType,a.DiscountAppliedOnId, a.DiscountType,a.ActiveFlag, ")
                    .Append(" b.name +' - '+ case a.DiscountAppliedOnType when 24 then d.CatName when 25 then sc.name when 26 then mp.name end AppliedOn, ")
                    .Append(" DiscountAmt,dt.[name] as discType, a.DiscntDayLimit,a.DiscntMaxLimit,a.DisValidfrom, ")
                    .Append(" case when a.ActiveFlag= 1 then 'Active' else 'Inactive' end as actInac ")
                    .Append(" from TDiscount a ")
                    .Append(" JOIN mstGeneralCnst b on a.DiscountAppliedOnType = b.gconstantid ")
                    .Append(" LEFT JOIN mstGeneralCnst dt on dt.gconstantid = a.DiscountType ")
                    .Append(" LEFT join RootCategory_Mst d on d.RootCateoryId =  case a.DiscountAppliedOnType when 24 then a.DiscountAppliedOnId else 0 end  ")
                    .Append(" LEFT join mcategory sc on sc.categoryid =  case a.DiscountAppliedOnType when 25 then a.DiscountAppliedOnId else 0 end ")
                    .Append(" LEFT join mproduct mp on mp.productid =  case a.DiscountAppliedOnType when 26 then a.DiscountAppliedOnId else 0 end ");
            if (!String.IsNullOrEmpty(sqlWhere))
            {
                sqlQuer.Append(sqlWhere);
                sqlQuer.Append(" and a.IsDelete=0 ");
            }
            else
            {
                sqlQuer.Append(" where a.IsDelete=0 ");
            }
            sqlQuer.Append(" order by a.CreatedDate desc ");
            grdCategory.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdCategory.DataBind();
        }
        catch (Exception)
        {

        }
    }

    protected void ClearControl()
    {
        try
        {
            ddlProductCat.ClearSelection();
            ddlDiscounttype.ClearSelection();
            ddlSubCat.SelectedIndex = 0;
            ddlProduct.SelectedIndex = 0;
            txtDiscountAm.Text = "";
            txtMaxPeople.Text = "";
            txtValiditydays.Text = "";
            txtValidfrom.Text = "";
            txtValidto.Text = "";
            radioactive.Checked = true;
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
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            ddlDiscounttype.Enabled = true;
            ddlProduct.Enabled = true;
            ddlProductCat.Enabled = true;
            ddlSubCat.Enabled = true;
            txtDiscountAm.Enabled = true;
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


    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        //try
        //{
        GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);

        HiddenField hdnDisAppOn = grRow.FindControl("hdnDisAppOn") as HiddenField;
        ddlDiscounton.ClearSelection();
        ddlDiscounton.SelectedValue = hdnDisAppOn.Value;
        ddlDiscounton_SelectedIndexChanged(null, null);


        /*
        HiddenField hdnCategoryID = grRow.FindControl("hdnCategoryID") as HiddenField;
        HiddenField hdnProductId = grRow.FindControl("hdnProductId") as HiddenField;
        HiddenField hdnDiscounttype = grRow.FindControl("hdnDiscounttype") as HiddenField;
        HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;
        HiddenField hdnDiscountID = grRow.FindControl("hdnDiscountID") as HiddenField;

        Label lblproductcat = grRow.FindControl("lblproductcat") as Label;
        Label lblsubcat = grRow.FindControl("lblsubcat") as Label;
        Label lblproduct = grRow.FindControl("lblproduct") as Label;
        Label lbldiscountamt = grRow.FindControl("lbldiscountamt") as Label;
        Label lbldiscounttype = grRow.FindControl("lbldiscounttype") as Label;
        Label lblmaxpeopledis = grRow.FindControl("lblmaxpeopledis") as Label;
        Label lbldisvalfrom = grRow.FindControl("lbldisvalfrom") as Label;
        Label lbldisvaldays = grRow.FindControl("lbldisvaldays") as Label;
        Label lbldisvalto = grRow.FindControl("lbldisvalto") as Label;

        hdnDiscountIDT.Value = hdnDiscountID.Value;
        ddlProductCat.ClearSelection();
        ddlProductCat.SelectedValue = hdnMcategory.Value;
        ddlProductCat_SelectedIndexChanged1(null, null);
        ddlSubCat.ClearSelection();
        ddlSubCat.SelectedValue = String.IsNullOrEmpty(hdnCategoryID.Value) ? "0" : hdnCategoryID.Value;
        ddlSubCat_SelectedIndexChanged(null, null);
        ddlProduct.ClearSelection();
        ddlProduct.SelectedValue = String.IsNullOrEmpty(hdnProductId.Value) ? "0" : hdnProductId.Value;
        ddlDiscounttype.SelectedValue = hdnDiscounttype.Value;
        txtDiscountAm.Text = lbldiscountamt.Text.Trim();
        txtMaxPeople.Text = lblmaxpeopledis.Text.Trim();
        txtValiditydays.Text = lbldisvalfrom.Text.Trim();
        txtValidfrom.Text = lbldisvaldays.Text.Trim();
        txtValidto.Text = lbldisvalto.Text.Trim();
        radioactive.Checked = false;
        radiodeactive.Checked = false;
        if (hdnactiveflag.Value == "True")
        {
            radioactive.Checked = true;
        }
        else
        {
            radiodeactive.Checked = true;
        }
        btnSubmit.Visible = false;
        btnUpdate.Visible = true;
        btnCancel.Visible = true;
        ddlDiscounttype.Enabled = false;
        ddlProduct.Enabled = false;
        ddlProductCat.Enabled = false;
        ddlSubCat.Enabled = false;
        txtDiscountAm.Enabled = false;*/
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            //Data insert logic
            string chkflag = "";

            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@DiscountOn",Convert.ToInt32(ddlDiscounton.SelectedValue)),
                    new SqlParameter("@MCategoryID",Convert.ToInt32(ddlProductCat.SelectedValue)),
                    (ddlSubCat.SelectedValue == "0")?new SqlParameter("@CategoryID", DBNull.Value) : new SqlParameter("@CategoryID", Convert.ToInt32(ddlSubCat.SelectedValue)),
                    (ddlProduct.SelectedValue == "0")?new SqlParameter("@ProductId",DBNull.Value) : new SqlParameter("@ProductId",Convert.ToInt32(ddlProduct.SelectedValue)),
                    new SqlParameter("@DiscountAmt",txtDiscountAm.Text.Trim()),
                    new SqlParameter("@DiscountType",Convert.ToInt32(ddlDiscounttype.SelectedValue)),
                    String.IsNullOrEmpty(txtValiditydays.Text)? new SqlParameter("@DiscntDayLimit", DBNull.Value) : new SqlParameter("@DiscntDayLimit",Convert.ToInt32(txtValiditydays.Text.Trim())),
                    String.IsNullOrEmpty(txtMaxPeople.Text)?new SqlParameter("@DiscntMaxLimit",DBNull.Value) : new SqlParameter("@DiscntMaxLimit",Convert.ToInt32(txtMaxPeople.Text.Trim())),
                    String.IsNullOrEmpty(txtValidfrom.Text)?new SqlParameter("@DisValidfrom",DBNull.Value) :  new SqlParameter("@DisValidfrom",txtValidfrom.Text.Trim()),
                    String.IsNullOrEmpty(txtValidto.Text)?new SqlParameter("@DisValidTo",DBNull.Value): new SqlParameter("@DisValidTo",txtValidto.Text.Trim()),
                    new SqlParameter("@ActiveFlag", i),
                    new SqlParameter("@UserId",UserInfo.GetUserInfo().userId),
                    new SqlParameter("@FunType","I"),
                    new SqlParameter("@ErrMsg",SqlDbType.VarChar,2000)
                };

            //chkflag = objDataAccess.DaExecNonQueryStrTrn("insert into TDiscount([MCategoryID],[CategoryID],[ProductId],[DiscountAmt],[DiscountType],[Discountcode],[DiscntDayLimit],[DiscntMaxLimit],[DisValidfrom],[DisValidTo],[Createdby],[CreatedDate],[Modifiedby],[ModifiedDate],[ActiveFlag]) values(@MCategoryID,@CategoryID,@ProductId,@DiscountAmt,@DiscountType,'empty',@DiscntDayLimit,@DiscntMaxLimit,@DisValidfrom,@DisValidTo,'admin',getdate(),'admin',getdate(),@ActiveFlag)", paras, sqlTrn, conObj);
            chkflag = objDataAccess.ExecSPWithOutPutPara("Discount_IU", paras, 13, CommandType.StoredProcedure);

            if (!String.IsNullOrEmpty(chkflag) && (chkflag == "Success"))
            {
                ResetContorl();
                AlertMsg("Record Create Successfuly");
            }
            if (String.IsNullOrEmpty(chkflag) || (chkflag == "Error"))
            {
                AlertMsg("Error Inserting record.");
            }

        }
        catch (Exception)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //Data insert logic
            string chkflag = "";
            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@DiscountOn",Convert.ToInt32(ddlDiscounton.SelectedValue)),    
                    new SqlParameter("@MCategoryID",Convert.ToInt32(ddlProductCat.SelectedValue)),
                    (ddlSubCat.SelectedValue == "0")?new SqlParameter("@CategoryID", DBNull.Value) : new SqlParameter("@CategoryID", Convert.ToInt32(ddlSubCat.SelectedValue)),
                    (ddlProduct.SelectedValue == "0")?new SqlParameter("@ProductId",DBNull.Value) : new SqlParameter("@ProductId",Convert.ToInt32(ddlProduct.SelectedValue)),
                    new SqlParameter("@DiscountAmt",txtDiscountAm.Text.Trim()),
                    new SqlParameter("@DiscountType",Convert.ToInt32(ddlDiscounttype.SelectedValue)),
                    String.IsNullOrEmpty(txtValiditydays.Text)? new SqlParameter("@DiscntDayLimit", DBNull.Value) : new SqlParameter("@DiscntDayLimit",Convert.ToInt32(txtValiditydays.Text.Trim())),
                    String.IsNullOrEmpty(txtMaxPeople.Text)?new SqlParameter("@DiscntMaxLimit",DBNull.Value) : new SqlParameter("@DiscntMaxLimit",Convert.ToInt32(txtMaxPeople.Text.Trim())),
                    String.IsNullOrEmpty(txtValidfrom.Text)?new SqlParameter("@DisValidfrom",DBNull.Value) :  new SqlParameter("@DisValidfrom",txtValidfrom.Text),
                    new SqlParameter("@ActiveFlag", i),
                    new SqlParameter("@DiscountID",Convert.ToInt32(hdnDiscountIDT.Value)),
                    new SqlParameter("@UserId","1"),
                    new SqlParameter("@FunType","U"),
                    new SqlParameter("@ErrMsg",SqlDbType.VarChar,2000)
                };
            //String.IsNullOrEmpty(txtValidto.Text)?new SqlParameter("@DisValidTo",DBNull.Value): new SqlParameter("@DisValidTo",txtValidto.Text.Trim()),
            //sqlQuer.Append("UPDATE TDiscount set [MCategoryID]=@MCategoryID,[CategoryID]=@CategoryID,[ProductId]=@ProductId,[DiscountAmt]=@DiscountAmt,[DiscountType]=@DiscountType,[DiscntDayLimit]=@DiscntDayLimit,[DiscntMaxLimit]=@DiscntMaxLimit,[DisValidfrom]=@DisValidfrom,[DisValidTo]=@DisValidTo,[ActiveFlag]=@ActiveFlag WHERE DiscountID=@DiscountID");
            chkflag = objDataAccess.ExecSPWithOutPutPara("Discount_IU", paras, 13, CommandType.StoredProcedure);
            if (!String.IsNullOrEmpty(chkflag) && (chkflag == "Success"))
            {
                ResetContorl();
                AlertMsg("Record Updated Successfuly");
            }
            if (String.IsNullOrEmpty(chkflag) || (chkflag == "Error"))
            {
                AlertMsg("Error while updating record.");
            }
        }
        catch (Exception)
        {
            AlertMsg("Error while updating record.");
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
    protected void btnview_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE 1=1 ");
            if (!String.IsNullOrEmpty(txtDisCode.Text))
            {
                sqlWher.Append(" AND a.Discountcode LIKE '%")
                    .Append(txtDisCode.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtfilterDiscountAmt.Text))
            {
                sqlWher.Append(" AND a.DiscountAmt = '")
                    .Append(txtfilterDiscountAmt.Text + "'");
            }
            if (!String.IsNullOrEmpty(ddlDiscounttype1.SelectedValue) && (ddlDiscounttype1.SelectedValue != "0"))
            {
                sqlWher.Append(" AND dt.gconstantid = '")
                    .Append(ddlDiscounttype1.SelectedValue + "'");
            }
            if (ddlStatusFil.SelectedValue != "00")
            {
                sqlWher.Append(" AND c.ActiveFlag ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }
            BindGrid(sqlWher.ToString());
        }
        catch (Exception)
        {

        }
    }



    protected void grdCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            GridViewRow gvr = grdCategory.Rows[e.RowIndex] as GridViewRow;
            HiddenField hdnDiscountID = gvr.FindControl("hdnDiscountID") as HiddenField;
            TextBox txtmaxpeopleDis = gvr.FindControl("txtmaxpeopleDis") as TextBox;
            TextBox txtdisDayLimit = gvr.FindControl("txtdisDayLimit") as TextBox;
            RadioButtonList rdbStatus = gvr.FindControl("rdbStatus") as RadioButtonList;
            string chkflag = "";
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@DiscntMaxLimit",txtmaxpeopleDis.Text),  
                    new SqlParameter("@DiscntDayLimit",txtdisDayLimit.Text),  
                    new SqlParameter("@DiscountID",Convert.ToInt32(hdnDiscountID.Value)),
                    new SqlParameter("@ActiveFlag", rdbStatus.SelectedValue),
                    new SqlParameter("@UserId", UserInfo.GetUserInfo().userId),
                    new SqlParameter("@FunType","U"),
                    new SqlParameter("@ErrMsg",SqlDbType.VarChar,2000)
                };
            chkflag = objDataAccess.ExecSPWithOutPutPara("Discount_IU", paras, 6, CommandType.StoredProcedure);
            if (!String.IsNullOrEmpty(chkflag) && (chkflag == "Success"))
            {

            }
            grdCategory.EditIndex = -1;
            btnview_Click(null, null);

        }
        catch (Exception)
        {

        }
    }
    protected void grdCategory_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            grdCategory.EditIndex = e.NewEditIndex;
            btnview_Click(null, null);
        }
        catch (Exception)
        {

        }
    }

    protected void grdCategory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            grdCategory.EditIndex = -1;
            btnview_Click(null, null);
        }
        catch (Exception)
        {

        }
    }
    protected void grdCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdCategory.PageIndex = e.NewPageIndex;
        BindGrid("");
    }
    protected void grdCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridViewRow gvr = grdCategory.Rows[e.RowIndex] as GridViewRow;
            HiddenField hdnDiscountID = gvr.FindControl("hdnDiscountID") as HiddenField;
            RadioButtonList rdbStatus = gvr.FindControl("rdbStatus") as RadioButtonList;
            string chkflag = "";
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@DiscountID",Convert.ToInt32(hdnDiscountID.Value)),
                    new SqlParameter("@UserId", UserInfo.GetUserInfo().userId),
                    new SqlParameter("@ErrMsg",SqlDbType.VarChar,2000)
                };
            chkflag = objDataAccess.ExecSPWithOutPutPara("usp_DeleteDiscount", paras, 2, CommandType.StoredProcedure);
            if (!String.IsNullOrEmpty(chkflag) && (chkflag == "Success"))
            {
                AlertMsg("Record Deleted Successfuly");
                BindGrid("");
            }
            if (String.IsNullOrEmpty(chkflag) || (chkflag == "Error"))
            {
                AlertMsg("Error while Deleting record.");
            }
        }
        catch (Exception)
        {
            AlertMsg("Error while Deleting record.");
        }
    }
}