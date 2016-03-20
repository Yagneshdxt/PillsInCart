using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;

public partial class Admin_AddBlog : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        RequiredFieldValidator4.Enabled = true;
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
        imgblog1.Visible = false;
        imgblog2.Visible = false;
        if (!IsPostBack)
        {
            BindCategoriesandTags();
            BindGridView();
        }
    }

    private void BindCategoriesandTags()
    {
        SqlDataAdapter da = new SqlDataAdapter("usp_GetBlogCategoryandTags", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
        {
            ddlcategory.DataSource = ds.Tables[0];
            ddlcategory.DataTextField = "CategoryName";
            ddlcategory.DataValueField = "RootCategoryID";
            ddlcategory.DataBind();
            ddlcategory.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
        {
            cbxlisttags.DataSource = ds.Tables[1];
            cbxlisttags.DataTextField = "CategoryName";
            cbxlisttags.DataValueField = "RootCategoryID";
            cbxlisttags.DataBind();
        }
        if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
        {
            ddlMonthFilter.DataSource = ds.Tables[2];
            ddlMonthFilter.DataTextField = "BlogDate";
            ddlMonthFilter.DataValueField = "Monthyear";
            ddlMonthFilter.DataBind();
            ddlMonthFilter.Items.Insert(0, new ListItem("-Select-", "0"));
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
    protected void saveimage(FileUpload fileupload, out string SaveAsName)
    {
        string fileNa = "";
        SaveAsName = fileNa;
        try
        {
            fileNa = Path.GetFileName(fileupload.PostedFile.FileName);
            string filExt = Path.GetExtension(fileupload.PostedFile.FileName);
            string folderPath = ConfigurationManager.AppSettings["blogImage"].ToString();
            while (File.Exists(Server.MapPath(folderPath + fileNa)))
            {
                fileNa = Guid.NewGuid().ToString() + filExt;
            }
            fileupload.SaveAs(Server.MapPath(folderPath + fileNa));
        }
        catch (Exception)
        {

        }
        SaveAsName = fileNa;
    }
    protected void ClearControl()
    {
        try
        {
            txtblogname.Text = "";
            txtintro.Text = "";
            ftxtblog.Text = "";
            radioactive.Checked = true;
            //hdnCateId.Value = "";
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
            cbxlisttags.ClearSelection();
            ddlcategory.SelectedValue = "0";
        }
        catch (Exception)
        {

        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlCommand cmd = new SqlCommand("usp_InsertUpdateBlog", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            string folderPath = ConfigurationManager.AppSettings["blogImage"].ToString();

            string fileNamelogo = "", fileNamead = "";
            saveimage(fileupimg1, out fileNamelogo);
            saveimage(fileupimg2, out fileNamead);
            DataTable dt = new DataTable();
            DataRow dr = null;
            dt.Columns.Add("TagId");
            try
            {
                foreach (ListItem item in cbxlisttags.Items)
                {
                    if (item.Selected)
                    {
                        dr = dt.NewRow();
                        dr["TagId"] = item.Value;
                        dt.Rows.Add(dr);
                    }
                }
                cmd.Parameters.Add("@BName", SqlDbType.VarChar).Value = txtblogname.Text;
                cmd.Parameters.Add("@Introduction", SqlDbType.VarChar).Value = txtintro.Text;
                cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = ftxtblog.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserInfo.GetUserInfo().userId;
                cmd.Parameters.Add("@CategoryID", SqlDbType.BigInt).Value = ddlcategory.SelectedValue;
                cmd.Parameters.Add("@bImgOne", SqlDbType.VarChar).Value = folderPath + fileNamelogo;
                cmd.Parameters.Add("@bImgTwo", SqlDbType.VarChar).Value = folderPath + fileNamead;
                cmd.Parameters.Add("@ActiveFlag", SqlDbType.Bit).Value = i;
                cmd.Parameters.Add("@BlogID ", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@BlogTagstbl", SqlDbType.Structured).Value = dt;
                cmd.Parameters.Add("@InsertUpdateType", SqlDbType.Bit).Value = 0;
                cmd.Parameters.Add("@IscommentActive", SqlDbType.Bit).Value = chkiscommentvisible.Checked;
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                {
                    AlertMsg("Blog saved successfuly");
                    BindGridView();
                    ResetContorl();
                }
            }
            catch (Exception)
            {
                con.Close();
            }
            con.Close();


        }
        catch (Exception)
        {
            con.Close();
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        RequiredFieldValidator4.Enabled = false;
        try
        {
            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlCommand cmd = new SqlCommand("usp_InsertUpdateBlog", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            string folderPath = ConfigurationManager.AppSettings["blogImage"].ToString();

            string fileNamelogo = "", fileNamead = "";
            saveimage(fileupimg1, out fileNamelogo);
            saveimage(fileupimg2, out fileNamead);
            DataTable dt = new DataTable();
            DataRow dr = null;
            dt.Columns.Add("TagId");
            try
            {
                foreach (ListItem item in cbxlisttags.Items)
                {
                    if (item.Selected)
                    {
                        dr = dt.NewRow();
                        dr["TagId"] = item.Value;
                        dt.Rows.Add(dr);
                    }
                }
                cmd.Parameters.Add("@BName", SqlDbType.VarChar).Value = txtblogname.Text;
                cmd.Parameters.Add("@Introduction", SqlDbType.VarChar).Value = txtintro.Text;
                cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = ftxtblog.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserInfo.GetUserInfo().userId;
                cmd.Parameters.Add("@CategoryID", SqlDbType.BigInt).Value = ddlcategory.SelectedValue;
                if (fileNamelogo == string.Empty)
                {
                    cmd.Parameters.Add("@bImgOne", SqlDbType.VarChar).Value = imgblog1.ImageUrl;
                }
                else
                {
                    cmd.Parameters.Add("@bImgOne", SqlDbType.VarChar).Value = folderPath + fileNamelogo;
                }
                cmd.Parameters.Add("@bImgTwo", SqlDbType.VarChar).Value = folderPath + fileNamead;
                cmd.Parameters.Add("@ActiveFlag", SqlDbType.Bit).Value = i;
                cmd.Parameters.Add("@BlogID ", SqlDbType.Int).Value = hdnBlogIDSelected.Value;
                cmd.Parameters.Add("@BlogTagstbl", SqlDbType.Structured).Value = dt;
                cmd.Parameters.Add("@InsertUpdateType", SqlDbType.Bit).Value = 1;
                cmd.Parameters.Add("@IscommentActive", SqlDbType.Bit).Value = chkiscommentvisible.Checked;
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                {
                    AlertMsg("Blog Updated successfuly");
                    BindGridView();
                    ResetContorl();
                    RequiredFieldValidator4.Enabled = true;
                }
            }
            catch (Exception)
            {
                con.Close();
            }
            finally
            {
                hdnBlogIDSelected.Value = string.Empty;
                con.Close();
            }



        }
        catch (Exception)
        {
            con.Close();
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
    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdBlogID = grRow.FindControl("hdBlogID") as HiddenField;
            SqlCommand cmd = new SqlCommand("usp_BlogDelete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BlogID", SqlDbType.Int).Value = hdBlogID.Value;
            con.Open();
            int res = cmd.ExecuteNonQuery();
            if (res > 0)
            {
                AlertMsg("Blog Deleted successfuly");
                BindGridView();
                ResetContorl();
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }

    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        RequiredFieldValidator4.Enabled = false;
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdBlogID = grRow.FindControl("hdBlogID") as HiddenField;
            Label lblBname = grRow.FindControl("lblBname") as Label;
            Label lblIntro = grRow.FindControl("lblIntro") as Label;
            Label lbldesc = grRow.FindControl("lbldesc") as Label;
            Label lblimg1 = grRow.FindControl("lblimg1") as Label;
            Label lblimg2 = grRow.FindControl("lblimg2") as Label;
            HyperLink hlinkimg2 = grRow.FindControl("hlinkimg") as HyperLink;
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;
            HiddenField hdnCategoryID = grRow.FindControl("hdnCategoryID") as HiddenField;
            //HiddenField hdnfolName = grRow.FindControl("hdnfolName") as HiddenField;
            imgblog1.Visible = true;
            imgblog2.Visible = true;
            imgblog1.ImageUrl = lblimg1.Text;
            imgblog2.ImageUrl = lblimg2.Text;
            txtblogname.Text = lblBname.Text.Trim();
            txtintro.Text = lblIntro.Text.Trim();
            ftxtblog.Text = lbldesc.Text.Trim();
            radioactive.Checked = true;
            radiodeactive.Checked = false;
            chkiscommentvisible.Checked = Convert.ToBoolean(grdBlog.DataKeys[grRow.RowIndex]["IscommentActive"]);
            if (hdnactiveflag.Value == "True")
            {
                radioactive.Checked = true;
            }
            else
            {
                radiodeactive.Checked = true;
            }
            //hdnfolderName.Value = hdnfolName.Value;
            //hdnCateId.Value = hdBlogID.Value;
            hdnBlogIDSelected.Value = hdBlogID.Value;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
            ddlcategory.SelectedValue = hdnCategoryID.Value;
            string TagId = Convert.ToString(grdBlog.DataKeys[grRow.RowIndex]["TagID"]);
            foreach (ListItem item in cbxlisttags.Items)
            {
                foreach (string Tag in TagId.Split(','))
                {
                    if (item.Value == Tag)
                    {
                        item.Selected = true;
                    }
                }
            }

        }
        catch (Exception)
        {

        }
    }

    private FileUpload ProfileParameter(string p)
    {
        throw new NotImplementedException();
    }
    protected void BindGridView()
    {
        SqlCommand command = null;
        if ((ddlMonthFilter.SelectedValue == "0") || String.IsNullOrEmpty(ddlMonthFilter.SelectedValue))
        {
            command = new SqlCommand("SELECT [BlogId],[BName],[Introduction],[Description],[bImgOne],[bImgTwo],[ActiveFlag],CategoryID,IscommentActive,case when [ActiveFlag]= 1 then 'Active' else 'Inactive' end as actInac,dbo.GetCommaSeperatedTagID(BlogId) as TagID from TrnBlog order by CreatedDt desc", con);
        }
        else
        {
            string[] selectedmonthyr = ddlMonthFilter.SelectedValue.Split('$');
            command = new SqlCommand("SELECT [BlogId],[BName],[Introduction],[Description],[bImgOne],[bImgTwo],[ActiveFlag],CategoryID,IscommentActive,case when [ActiveFlag]= 1 then 'Active' else 'Inactive' end as actInac,dbo.GetCommaSeperatedTagID(BlogId) as TagID from TrnBlog where CreatedMonth=" + Convert.ToString(selectedmonthyr[0]) + " and createdYear=" + Convert.ToString(selectedmonthyr[1]) + " order by CreatedDt desc", con);
        }
        SqlDataAdapter da = new SqlDataAdapter(command);
        DataTable dt = new DataTable();
        da.Fill(dt);
        grdBlog.DataSource = dt;
        grdBlog.DataBind();
    }

    protected string ValidateInsertCategory()
    {
        string errMsg = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@CatName",txtAddblogtag.Text.Trim())
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

    protected void btnAddBlogTag_Click(object sender, EventArgs e)
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
                new SqlParameter("@CatName", txtAddblogtag.Text.Trim()),
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
                    txtAddblogtag.Text = string.Empty;
                    AlertMsg("Tag saved successfuly");
                    Response.Redirect(Request.RawUrl);
                }
            }
            //close connnection
            if (conObj.State == System.Data.ConnectionState.Open)
                conObj.Close();
        }
        catch (Exception)
        {

        }
    }
    protected void grdBlog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdBlog.PageIndex = e.NewPageIndex;
        BindGridView();
    }

    protected void ddlMonthFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGridView();
    }
}