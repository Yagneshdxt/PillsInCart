using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;

public partial class Admin_AddBlogTags : System.Web.UI.Page
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
            sqlQuer.Append("SELECT RootCategoryID,CategoryName,ActiveFlage, case when ActiveFlage= 1 then 'Active' else 'Inactive' end as actInac from BlogTagMaster WHERE DeleteFlage='A'");
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
            Int32 IfExistsChk = Convert.ToInt32(objDataAccess.SelectScalarRetObj("SELECT COUNT(1) FROM BlogTagMaster WHERE CategoryName = @CatName AND DeleteFlage='A'", param));
            if (IfExistsChk > 0)
            {
                errMsg = "Tag With this name already exists \n";
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
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;

            txtcategoryname.Text = lblrootcatnmae.Text.Trim();
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
                new SqlParameter("@Rootcatid", Convert.ToInt64(hdnRootCategorID.Value))
                };
            string SqlQuery = "UPDATE BlogTagMaster SET DeleteFlage=@DeleteFlage, ActiveFlage=@ActiveFlage WHERE RootCategoryID=@Rootcatid";
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
                new SqlParameter("@ActiveFlage", i),
                new SqlParameter("@Rootcatid", Convert.ToInt64(hdrootid.Value))
                };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append("UPDATE BlogTagMaster SET CategoryName=@CatName,ActiveFlage=@ActiveFlage WHERE RootCategoryID=@Rootcatid");
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
                new SqlParameter("@ActiveFlage", i)
                };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            chkflag = objDataAccess.DaExecNonQueryStrTrn("insert into BlogTagMaster(CategoryName,createdDt,ActiveFlage) values(@CatName,getdate(),@ActiveFlage)", paras, sqlTrn, conObj);

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
                    AlertMsg("Tag saved successfuly");
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
            sqlWher.Append(" WHERE 1=1 ");
            if (!String.IsNullOrEmpty(txtProductID.Text))
            {
                sqlWher.Append(" AND CategoryName LIKE '%")
                    .Append(txtProductID.Text + "%'");
            }
            //if (!String.IsNullOrEmpty(txtnamefilter.Text))
            //{
            //    sqlWher.Append(" AND catDescription LIKE '%")
            //        .Append(txtnamefilter.Text + "%'");
            //}
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
}