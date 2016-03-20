using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Data;
using System.Text.RegularExpressions;

public partial class Admin_AddCategory : System.Web.UI.Page
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
            //ddlmaincategory 
            ddlmaincategory.DataSource = objDataAccess.getRootCategory();// objDataAccess.getDataSetQuery("select RootCateoryId,CatName from RootCategory_Mst where ActiveFlage=1");
            ddlmaincategory.DataValueField = "RootCateoryId";
            ddlmaincategory.DataTextField = "CatName";
            ddlmaincategory.DataBind();
            ddlmaincategory.Items.Insert(0, new ListItem("--Select--", "0"));

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
            ddlmaincategory.ClearSelection();
            ddlmaincategory.SelectedIndex = 0;
            txtcategory.Text = "";
            txtcategorydesc.Text = "";
            radioactive.Checked = true;
            hdnCateId.Value = "";
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

    protected void BindGrid(string sqlWhere)
    {
        try
        {

            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append("SELECT c.name,Rc.CatName categorytype ,c.[description],c.activeflag, case when c.activeflag= 1 then 'Active' else 'Inactive' end as actInac,c.categoryid,c.type as catType,c.folderName ")
                .Append(" FROM mcategory c JOIN RootCategory_Mst Rc ON Rc.RootCateoryId = c.[type] WHERE c.DeleteFlage = 'A' ");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            grdCategory.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdCategory.DataBind();
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

    protected bool ValidateInsertCate(string valFor)
    {
        bool chkflag = true;
        try
        {
            Page.Validate("valAddCat");
            chkflag = Page.IsValid;
            if (chkflag)
            {

                SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@name",txtcategory.Text.Trim()),
                    new SqlParameter("@type", Convert.ToInt32(ddlmaincategory.SelectedValue))
                    };
                StringBuilder sqlQuer = new StringBuilder();
                sqlQuer.Append("SELECT COUNT(1) FROM mcategory where name=@name and [type]=@type AND DeleteFlage = 'A'");
                Int16 ckInt = objDataAccess.SelectScalar(sqlQuer.ToString(), paras);

                if (valFor == "Insert")
                {
                    if (ckInt > 0)
                    {
                        AlertMsg("Category of this type and name already exists!");
                        chkflag = false;
                    }
                }
                if (chkflag)
                {
                    var regexItem = new Regex("^[a-zA-Z''_'\\s]{1,100}$");
                    if (!regexItem.IsMatch(txtcategory.Text))
                    {
                        AlertMsg("Please do not enter special character in category name.");
                        chkflag = false;
                    }
                }

                if (valFor == "Update")
                {
                    if (ckInt > 1)
                    {
                        AlertMsg("Duplicate Category name!!");
                        chkflag = false;
                    }    
                    
                    if (String.IsNullOrEmpty(hdnCateId.Value) || String.IsNullOrEmpty(hdnfolderName.Value))
                    {
                        AlertMsg("Error in your page Please chek your entries.!");
                        chkflag = false;
                    }
                }
            }
            else
            {
                AlertMsg("Error in your page Please chek your entries.!");
            }
        }
        catch (Exception)
        {
            chkflag = false;
        }
        return chkflag;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            if (ValidateInsertCate("Insert"))
            {
                //Data insert logic
                int chkflag = 1;
                string subPath = txtcategory.Text.Trim().Replace(" ", "-");
                UserInfo objUserInfo = UserInfo.GetUserInfo();
                int id = Convert.ToInt32(ddlmaincategory.SelectedValue);
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
                new SqlParameter("@name",txtcategory.Text.Trim()),
                new SqlParameter("@type", id),
                new SqlParameter("@folderName",subPath),
                String.IsNullOrEmpty(txtcategorydesc.Text)?new SqlParameter("@description", " "):new SqlParameter("@description", txtcategorydesc.Text.ToString()),
                new SqlParameter("@activeflag", i.ToString()),
                new SqlParameter("@UserID",objUserInfo.userId)
                };

                SqlConnection conObj = objDataAccess.conObj;
                //open connnection
                if (conObj.State == System.Data.ConnectionState.Closed)
                    conObj.Open();
                SqlTransaction sqlTrn = conObj.BeginTransaction();
                chkflag = objDataAccess.DaExecNonQueryStrTrn("insert into mcategory(name,type,description,folderName,createdby,createddate,modifiedby,modifieddate,activeflag) values(@name,@type,@description,@folderName,@UserID,getdate(),@UserID,getdate(),@activeflag)", paras, sqlTrn, conObj);

                //Folder creation logic
                /*
                if (chkflag > 0)
                {
                    try
                    {
                        //ConfigurationManager.AppSettings["RootDireName"].ToString() + 
                        subPath = "~\\" + subPath;
                        if (!System.IO.Directory.Exists(Server.MapPath(subPath)))
                            System.IO.Directory.CreateDirectory(Server.MapPath(subPath));
                        chkflag = 1;
                    }
                    catch (Exception)
                    {
                        chkflag = 0;
                    }

                    if (chkflag == 0)
                    {
                        sqlTrn.Rollback();
                    }
                    else
                    {
                        sqlTrn.Commit();
                        ClearControl();
                        AlertMsg("Records saved successfuly");
                    }
                }
                 */

                if (chkflag == 0)
                {
                    sqlTrn.Rollback();
                }
                else
                {
                    sqlTrn.Commit();
                    ClearControl();
                    AlertMsg("Records saved successfuly");
                }

                //close connnection
                if (conObj.State == System.Data.ConnectionState.Open)
                    conObj.Close();
            }
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
            if (!String.IsNullOrEmpty(txtnamefilter.Text))
            {
                sqlWher.Append(" AND c.name LIKE '%")
                    .Append(txtnamefilter.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtTypefilter.Text))
            {
                sqlWher.Append(" AND gc.name LIKE '%")
                    .Append(txtTypefilter.Text + "%'");
            }
            if (ddlStatusFil.SelectedValue != "00")
            {
                sqlWher.Append(" AND c.activeflag ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }
            BindGrid(sqlWher.ToString());
        }
        catch (Exception)
        {

        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            if (ValidateInsertCate("Update"))
            {
                //Data insert logic
                int chkflag = 1;
                string subPath = txtcategory.Text.Trim().Replace(" ", "-");
                UserInfo objUserInfo = UserInfo.GetUserInfo();
                int id = Convert.ToInt32(ddlmaincategory.SelectedValue);
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
                new SqlParameter("@name",txtcategory.Text.Trim()),
                new SqlParameter("@type", id),
                new SqlParameter("@folderName",subPath),
                String.IsNullOrEmpty(txtcategorydesc.Text)?new SqlParameter("@description", " "):new SqlParameter("@description", txtcategorydesc.Text.ToString()),
                new SqlParameter("@activeflag", i.ToString()),
                new SqlParameter("@categoryid", Convert.ToInt64(hdnCateId.Value)),
                new SqlParameter("@UserID",objUserInfo.userId)
                };

                SqlConnection conObj = objDataAccess.conObj;
                //open connnection
                if (conObj.State == System.Data.ConnectionState.Closed)
                    conObj.Open();
                SqlTransaction sqlTrn = conObj.BeginTransaction();
                StringBuilder sqlQuer = new StringBuilder();
                sqlQuer.Append("update mcategory set name=@name,type=@type,description=@description,")
                    .Append("folderName=@folderName,modifiedby=@UserID,modifieddate=getdate(),activeflag=@activeflag")
                    .Append(" WHERE categoryid=@categoryid");
                chkflag = objDataAccess.DaExecNonQueryStrTrn(sqlQuer.ToString(), paras, sqlTrn, conObj);

                //Folder creation logic
                /*
                if (chkflag > 0)
                {
                    try
                    {
                        //ConfigurationManager.AppSettings["RootDireName"].ToString() + 
                        subPath = "~\\" + subPath;
                        if (!System.IO.Directory.Exists(Server.MapPath("~\\" + hdnfolderName.Value)))
                            System.IO.Directory.CreateDirectory(Server.MapPath("~\\" + hdnfolderName.Value));
                        else
                        {
                            if (("~\\" + hdnfolderName.Value) != (subPath))
                            {
                                System.IO.Directory.Move(Server.MapPath("~\\" + hdnfolderName.Value), Server.MapPath(subPath));
                            }
                        }
                        chkflag = 1;
                    }
                    catch (Exception)
                    {
                        chkflag = 0;
                    }

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
                 * */

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

                //close connnection
                if (conObj.State == System.Data.ConnectionState.Open)
                    conObj.Close();
            }
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

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnCategorID = grRow.FindControl("hdnCategorID") as HiddenField;
            HiddenField hdnCategorType = grRow.FindControl("hdnCategorType") as HiddenField;
            Label lblname = grRow.FindControl("lblname") as Label;
            Label lbldesc = grRow.FindControl("lbldesc") as Label;
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;
            HiddenField hdnfolName = grRow.FindControl("hdnfolName") as HiddenField;

            ddlmaincategory.ClearSelection();
            ddlmaincategory.SelectedValue = hdnCategorType.Value;
            txtcategory.Text = lblname.Text.Trim();
            txtcategorydesc.Text = lbldesc.Text.Trim();
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
            hdnfolderName.Value = hdnfolName.Value;
            hdnCateId.Value = hdnCategorID.Value;
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
            HiddenField hdnCategorID = grRow.FindControl("hdnCategorID") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@DeleteFlage", 'D'),
                new SqlParameter("@ActiveFlage", Convert.ToInt32(0)),
                new SqlParameter("@categoryid", Convert.ToInt64(hdnCategorID.Value)),
                new SqlParameter("@UserID",UserInfo.GetUserInfo().userId)
                };
            string SqlQuery = "UPDATE mcategory SET DeleteFlage=@DeleteFlage, activeflag=@ActiveFlage,modifiedby=@UserID,modifieddate=getdate() WHERE categoryid=@categoryid";
            objDataAccess.DaExecNonQueryStr(SqlQuery, paras);
            BindGrid("");
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
}