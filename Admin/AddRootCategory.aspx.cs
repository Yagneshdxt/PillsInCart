using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;

public partial class Admin_AddRootCategory : System.Web.UI.Page
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
                BindGrid("");
            }
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
    protected void ClearControl()
    {
        try
        {
            txtcategoryname.Text = "";
            txtcategorydesc.Text = "";
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
            sqlQuer.Append("SELECT RootCateoryId,CatName,catDescription,ActiveFlage, case when ActiveFlage= 1 then 'Active' else 'Inactive' end as actInac from RootCategory_Mst WHERE DeleteFlage='A'");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            grdRootcat.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdRootcat.DataBind();
        }
        catch (Exception)
        {

        }
    }

    protected string ValidateInsertCategory()
    {
        string errMsg = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@CatName",txtcategoryname.Text.Trim())
            };
            Int32 IfExistsChk = Convert.ToInt32(objDataAccess.SelectScalarRetObj("SELECT COUNT(1) FROM RootCategory_Mst WHERE CatName = @CatName AND DeleteFlage='A'", param));
            if (IfExistsChk > 0)
            {
                errMsg = "Category With this name already exists \n";
            }
        }
        catch (Exception)
        {
            errMsg = "Error Inserting the record \n";
        }
        return errMsg;
    }

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnRootCategorID = grRow.FindControl("hdnRootCategorID") as HiddenField;
            Label lblrootcatnmae = grRow.FindControl("lblrootcatnmae") as Label;
            Label lblcatedesc = grRow.FindControl("lblcatedesc") as Label;
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;

            txtcategoryname.Text = lblrootcatnmae.Text.Trim();
            txtcategorydesc.Text = lblcatedesc.Text.Trim();
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
            hdrootid.Value = hdnRootCategorID.Value;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
        }
        catch (Exception)
        {

        }
    }

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnRootCategorID = grRow.FindControl("hdnRootCategorID") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@DeleteFlage", 'D'),
                new SqlParameter("@ActiveFlage", Convert.ToInt32(0)),
                new SqlParameter("@Rootcatid", Convert.ToInt64(hdnRootCategorID.Value)),
                new SqlParameter("@UserID",UserInfo.GetUserInfo().userId)
                };
            string SqlQuery = "UPDATE RootCategory_Mst SET DeleteFlage=@DeleteFlage, ActiveFlage=@ActiveFlage,Modifiedby=@UserID,ModifiedDt=getdate() WHERE RootCateoryId=@Rootcatid";
            objDataAccess.DaExecNonQueryStr(SqlQuery, paras);
            BindGrid("");
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
            int chkflag = 1;
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
               new SqlParameter("@CatName", txtcategoryname.Text.Trim()),
                new SqlParameter("@catDescription", txtcategorydesc.Text.Trim()),
                new SqlParameter("@ActiveFlage", i),
                new SqlParameter("@Rootcatid", Convert.ToInt64(hdrootid.Value)),
                new SqlParameter("@UserID",UserInfo.GetUserInfo().userId)
                };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append("UPDATE RootCategory_Mst SET CatName=@CatName,catDescription=@catDescription,ActiveFlage=@ActiveFlage,Modifiedby=@UserID,ModifiedDt=getdate() WHERE RootCateoryId=@Rootcatid");
            chkflag = objDataAccess.DaExecNonQueryStrTrn(sqlQuer.ToString(), paras, sqlTrn, conObj);

            //Folder creation logic
            if (chkflag > 0)
            {
                if (chkflag == 0)
                {
                    sqlTrn.Rollback();
                    AlertMsg("Error updating the records");
                }
                else
                {
                    sqlTrn.Commit();
                    ResetContorl();
                    AlertMsg("Records updated successfuly");
                }
            }
            //close connnection
            if (conObj.State == System.Data.ConnectionState.Open)
                conObj.Close();
            BindGrid("");
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string errMsg = "";
            errMsg = ValidateInsertCategory();
            if (!String.IsNullOrEmpty(errMsg))
            {
                //lblErrMsg.Text = errMsg.Replace("\n", "<br/>");
                AlertMsg(errMsg.Replace("\n", "\\n"));
                //Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "errMsg", "alert('hi')",true);
                return;
            }

            //Data insert logic
            int chkflag = 1;
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
                new SqlParameter("@CatName", txtcategoryname.Text.Trim()),
                new SqlParameter("@catDescription", String.IsNullOrEmpty(txtcategorydesc.Text)? " ":txtcategorydesc.Text.Trim()),
                new SqlParameter("@ActiveFlage", i),
                new SqlParameter("@UserID",UserInfo.GetUserInfo().userId)
                };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            chkflag = objDataAccess.DaExecNonQueryStrTrn("insert into RootCategory_Mst(CatName,catDescription,createdby,createdDt,Modifiedby,ModifiedDt,ActiveFlage) values(@CatName,@catDescription,@UserID,getdate(),@UserID,getdate(),@ActiveFlage)", paras, sqlTrn, conObj);

            //Folder creation logic
            if (chkflag > 0)
            {
                if (chkflag == 0)
                {
                    sqlTrn.Rollback();
                }
                else
                {
                    sqlTrn.Commit();
                    ClearControl();
                    AlertMsg("Root Category saved successfuly");
                }
            }
            //close connnection
            if (conObj.State == System.Data.ConnectionState.Open)
                conObj.Close();
            BindGrid("");
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
                sqlWher.Append(" AND CatName LIKE '%")
                    .Append(txtProductID.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtnamefilter.Text))
            {
                sqlWher.Append(" AND catDescription LIKE '%")
                    .Append(txtnamefilter.Text + "%'");
            }
            if (ddlStatusFil.SelectedValue != "--Select--")
            {
                sqlWher.Append(" AND ActiveFlage ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }
            BindGrid(sqlWher.ToString());
        }
        catch (Exception)
        {

        }
    }
    protected void grdRootcat_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdRootcat.PageIndex = e.NewPageIndex;
        BindGrid("");
    }
}