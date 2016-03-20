using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;

public partial class Admin_AddProduct : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    DataSet ds = new DataSet();
    SqlDataAdapter da;
    SqlTransaction SqlTrn;
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
                bindControls();
            }
        }
        catch (Exception)
        {

        }
    }

    protected void bindControls()
    {
        try
        {
            //con.Open();
            //SqlCommand cmd = new SqlCommand("select RootCateoryId,CatName from RootCategory_Mst where ActiveFlage=1 AND DeleteFlage='A'", con);
            //SqlDataAdapter da = new SqlDataAdapter(cmd);
            //DataSet ds = new DataSet();
            //da.Fill(ds);
            //con.Close();
            ddlcategory.DataSource = objDataAccess.getRootCategory();
            ddlcategory.DataTextField = "CatName";
            ddlcategory.DataValueField = "RootCateoryId";
            ddlcategory.DataBind();
            ddlcategory.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlsubcategory.Items.Insert(0, new ListItem("--Select--", "0"));

            /*
            ValidateImage objValidateImage = new ValidateImage();
            lblLogoImagVali.Text = "* Height :" + objValidateImage.LogImgHeight + " Width :" + objValidateImage.LogImgWidth;
            lblAdImgVali.Text = "* Height :" + objValidateImage.AddImgHeight + " Width :" + objValidateImage.AddImgWidth;
            lblbigImgVali.Text = "* Height :" + objValidateImage.BigImgHeight + " Width :" + objValidateImage.BigImgWidth;
            lblImageType.Text = "* " + objValidateImage.valTypestr.Replace("|", ", ");
            */
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

    protected DataTable gridViewtoDatatable()
    {
        DataTable dt = new DataTable();
        try
        {
            dt.Columns.Add("Srno");
            dt.Columns.Add("Quantity");
            dt.Columns.Add("Strength");
            dt.Columns.Add("NewPrice");
            dt.Columns.Add("NewUnitPrice");
            dt.Columns.Add("OldPrice");
            dt.Columns.Add("oldUnitPrice");
            dt.Columns.Add("activeflag");

            foreach (GridViewRow grRow in grdPriceLIst.Rows)
            {
                if (grRow.RowType == DataControlRowType.DataRow)
                {
                    DataRow dr = dt.NewRow();
                    dr["Srno"] = ((Label)grRow.FindControl("lblSrNo")).Text;
                    dr["Quantity"] = ((Label)grRow.FindControl("lblQuantity")).Text;
                    dr["Strength"] = ((Label)grRow.FindControl("lblStrength")).Text;
                    dr["NewPrice"] = ((Label)grRow.FindControl("lblNewPrice")).Text;
                    dr["NewUnitPrice"] = ((Label)grRow.FindControl("lblNewUnitPrice")).Text;
                    dr["OldPrice"] = ((Label)grRow.FindControl("lblOldPrice")).Text;
                    dr["oldUnitPrice"] = ((Label)grRow.FindControl("lbloldUnitPrice")).Text;
                    dr["activeflag"] = "1";
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception)
        {

        }
        return dt;
    }

    protected DataTable MetaGridtoDatatable()
    {
        DataTable dt = new DataTable();
        try
        {
            dt.Columns.Add("Srno");
            dt.Columns.Add("Name");
            dt.Columns.Add("Content");
            dt.Columns.Add("activeflag");
            foreach (GridViewRow grRow in grdMetaTag.Rows)
            {
                if (grRow.RowType == DataControlRowType.DataRow)
                {
                    DataRow dr = dt.NewRow();
                    dr["Srno"] = ((Label)grRow.FindControl("lblSrNo")).Text;
                    dr["Name"] = ((Label)grRow.FindControl("lblName")).Text;
                    dr["Content"] = ((Label)grRow.FindControl("lblContent")).Text;
                    dr["activeflag"] = "1";
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception)
        {

        }
        return dt;
    }

    protected DataTable ProductDesGridtoDatatable()
    {
        DataTable dt = new DataTable();
        try
        {
            dt.Columns.Add("Srno");
            dt.Columns.Add("Heading");
            dt.Columns.Add("Description");
            dt.Columns.Add("activeflag");
            foreach (GridViewRow grRow in grdProdDes.Rows)
            {
                if (grRow.RowType == DataControlRowType.DataRow)
                {
                    DataRow dr = dt.NewRow();
                    dr["Srno"] = ((Label)grRow.FindControl("lblSrNo")).Text;
                    dr["Heading"] = ((Label)grRow.FindControl("lblHeading")).Text;
                    dr["Description"] = HttpUtility.HtmlEncode(((Label)grRow.FindControl("lblDescription")).Text);
                    dr["activeflag"] = "1";
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception)
        {

        }
        return dt;
    }


    protected void saveimage(FileUpload fileupload, out string SaveAsName)
    {
        string fileNa = "";
        try
        {
            fileNa = Path.GetFileName(fileupload.PostedFile.FileName);
            string filExt = Path.GetExtension(fileupload.PostedFile.FileName);
            string folderPath = ConfigurationManager.AppSettings["ImageFolder"].ToString();
            while (File.Exists(Server.MapPath(folderPath + fileNa)))
            {
                fileNa = Guid.NewGuid().ToString() + filExt;
            }
            fileupload.SaveAs(Server.MapPath(folderPath + fileNa));
            SaveAsName = fileNa;
        }
        catch (Exception)
        {
            SaveAsName = "";
        }

    }

    protected void ClearControls()
    {
        try
        {
            ddlcategory.ClearSelection();
            ddlcategory.SelectedIndex = 0;
            ddlsubcategory.Items.Clear();
            ddlsubcategory.Items.Insert(0, new ListItem("--Select--", "0"));
            txtproductname.Text = "";
            txtShortName.Text = "";
            txtproductdesc.Text = "";
            txtstrength.Text = "";
            txtexpiry.Text = "";
            txtdelivery.Text = "";
            txtprice.Text = "";
            txtLogoPrice.Text = "";
            txtgeneric.Text = "";
            txtbrand.Text = "";
            radioactive.Checked = true;
            radiodeactive.Checked = false;

            ClearAddPrice();
            grdPriceLIst.DataSource = string.Empty;
            grdPriceLIst.DataBind();
            ClearMetaFields();
            grdMetaTag.DataSource = string.Empty;
            grdMetaTag.DataBind();
            ClearProductDesField();
            grdProdDes.DataSource = string.Empty;
            grdProdDes.DataBind();
            btnAddMetaTag.Visible = true;
        }
        catch (Exception)
        {

        }
    }

    protected void ClearAddPrice()
    {
        try
        {
            txtQuant.Text = "";
            txtPricestrength.Text = "";
            txtNewPrice.Text = "";
            txtNewUnitPrice.Text = "";
            txtoldPrice.Text = "";
            txtOldUntPrice.Text = "";
        }
        catch (Exception)
        {

        }
    }
    protected void ClearMetaFields()
    {
        try
        {
            txtMetaName.Text = "";
            txtMetaContent.Text = "";
        }
        catch (Exception)
        {

        }
    }
    protected void ClearProductDesField()
    {
        try
        {
            txtProdDesHeading.Text = "";
            txtProdDescription.Text = "";
        }
        catch (Exception)
        {

        }
    }


    protected string validateEntry()
    {
        string errMsg = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@categoryId",ddlsubcategory.SelectedValue)
            };
            string FolderNameStr = Convert.ToString(objDataAccess.SelectScalarRetObj("select folderName from mcategory where categoryid = @categoryId", param));
            if (File.Exists(Server.MapPath("~\\" + FolderNameStr + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html")))
            {
                errMsg = errMsg + "file with this name already exist in the selected category\n";
            }
            /*
            ValidateImage objValidateImage = new ValidateImage();
            errMsg = errMsg + objValidateImage.CheckImage(fileuplogo, ValidateImage.ImageType.LogoImage);
            errMsg = errMsg + objValidateImage.CheckImage(fileupad, ValidateImage.ImageType.AddImage);
            errMsg = errMsg + objValidateImage.CheckImage(fileuplogobig, ValidateImage.ImageType.BigImage);*/

        }
        catch (Exception)
        {
            errMsg = errMsg + "Error Inserting the data";
        }
        return errMsg;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            string errMsg = "";
            errMsg = validateEntry();
            if (!String.IsNullOrEmpty(errMsg))
            {
                lblErrMsg.Text = errMsg.Replace("\n", "<br/>");
                AlertMsg(errMsg.Replace("\n", "\\n"));
                //Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "errMsg", "alert('hi')",true);
                return;
            }

            bool chkflag = true;
            string folderPath = ConfigurationManager.AppSettings["ImageFolder"].ToString();
            string fileNamelogo = "", fileNamead = "", fileNamebig = "", WrTofileName = "";
            Int64 PId = 0;
            DataTable prdPrice = gridViewtoDatatable().Copy();
            DataTable prdDescription = ProductDesGridtoDatatable().Copy();
            DataTable prdMetaTag = MetaGridtoDatatable().Copy();
            //prdPrice.Columns.Remove("Srno");
            fileNamelogo = ConfigurationManager.AppSettings["DefaultLogoImg"].ToString();
            fileNamead = ConfigurationManager.AppSettings["DefaultAddImg"].ToString();
            fileNamebig = ConfigurationManager.AppSettings["DefaultBigImg"].ToString();
            ValidateImage objImg = new ValidateImage();
            if ((fileuplogo.HasFile) && (fileuplogo.PostedFile.ContentLength > 0))
                objImg.saveimage(fileuplogo, out fileNamelogo);
            if ((fileupad.HasFile) && (fileupad.PostedFile.ContentLength > 0))
                objImg.saveimage(fileupad, out fileNamead);
            if ((fileuplogobig.HasFile) && (fileuplogobig.PostedFile.ContentLength > 0))
                objImg.saveimage(fileuplogobig, out fileNamebig);
            if (String.IsNullOrEmpty(fileNamelogo) || String.IsNullOrEmpty(fileNamead) || String.IsNullOrEmpty(fileNamebig))
            {
                if (File.Exists(Server.MapPath(folderPath + fileNamelogo)))
                    File.Delete(Server.MapPath(folderPath + fileNamelogo));
                if (File.Exists(Server.MapPath(folderPath + fileNamead)))
                    File.Delete(Server.MapPath(folderPath + fileNamead));
                if (File.Exists(Server.MapPath(folderPath + fileNamebig)))
                    File.Delete(Server.MapPath(folderPath + fileNamebig));
                chkflag = false;
            }
            if (chkflag) // Images are saved successfuly.
            {
                chkflag = false;
                try
                {
                    // Try inserting into database.
                    //SqlCommand cmd = new SqlCommand("insert into mproduct(prdiddisplay,categoryId,name,ShortName,description,strength,expirydate,avgdelivery,price,logoPrice,genername,brandname,pageName,logoimgpath,adimgpath,bigimgpath,createdby,createddate,modifiedby,modifieddate,activeflag) values('empty',@categoryId,@name,@ShortName,@description,@strength,@expirydate,@avgdelivery,@price,@logoPrice,@genername,@brandname,@pageName,@logoimgpath,@adimgpath,@bigimgpath,'admin',getdate(),'admin',getdate(),@activeflag)", con);
                    SqlCommand cmd = new SqlCommand("Product_IUD", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@categoryId", ddlsubcategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@name", txtproductname.Text);
                    cmd.Parameters.AddWithValue("@ShortName", txtShortName.Text);
                    cmd.Parameters.AddWithValue("@description", HttpUtility.HtmlEncode(txtproductdesc.Text));
                    cmd.Parameters.AddWithValue("@strength", txtstrength.Text);
                    cmd.Parameters.AddWithValue("@expirydate", txtexpiry.Text);
                    cmd.Parameters.AddWithValue("@avgdelivery", txtdelivery.Text);
                    cmd.Parameters.AddWithValue("@price", txtprice.Text);
                    cmd.Parameters.AddWithValue("@logoPrice", txtLogoPrice.Text);
                    cmd.Parameters.AddWithValue("@genername", txtgeneric.Text);
                    cmd.Parameters.AddWithValue("@brandname", txtbrand.Text);
                    cmd.Parameters.AddWithValue("@pageName", (txtproductname.Text.Trim().Replace(" ", "-")));
                    cmd.Parameters.AddWithValue("@logoimgpath", folderPath + fileNamelogo); // folderPath = ~/images/products/ and fileNamelogo = abc.jpg
                    cmd.Parameters.AddWithValue("@adimgpath", folderPath + fileNamead);
                    cmd.Parameters.AddWithValue("@bigimgpath", folderPath + fileNamebig);
                    cmd.Parameters.AddWithValue("@activeflag", radioactive.Checked ? 1 : 0);
                    cmd.Parameters.AddWithValue("@QuerType", "I");
                    cmd.Parameters.AddWithValue("@LogInUser", UserInfo.GetUserInfo().userId);
                    if ((prdPrice != null) && (prdPrice.Rows.Count > 0))
                        cmd.Parameters.AddWithValue("@priceTd", prdPrice);
                    if ((prdDescription != null) && (prdDescription.Rows.Count > 0))
                        cmd.Parameters.AddWithValue("@prdDesTbl", prdDescription);
                    if ((prdMetaTag != null) && (prdMetaTag.Rows.Count > 0))
                        cmd.Parameters.AddWithValue("@prdMetaTagTbl", prdMetaTag);

                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                        SqlTrn = con.BeginTransaction();
                        cmd.Transaction = SqlTrn;
                    }
                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);

                    if ((ds != null) && (ds.Tables != null) && (ds.Tables.Count > 0))
                    {
                        PId = Convert.ToInt64(ds.Tables[0].Rows[0][0]);
                        WrTofileName = ds.Tables[1].Rows[0]["folderName"].ToString();
                        chkflag = true;
                    }
                }
                catch (Exception)
                {
                    chkflag = false;
                }


                //Create Html file
                //if database insertion was successful and folder found then create html file.
                /*
                if (chkflag && (System.IO.Directory.Exists(Server.MapPath("~\\" + WrTofileName))))
                {
                    chkflag = false;
                    try
                    {

                        StreamWriter sw = new StreamWriter(Server.MapPath("~\\" + WrTofileName + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html"));

                        string line = "";
                        //Pass the file path and file name to the StreamReader constructor
                        StreamReader sr = new StreamReader(Server.MapPath(ConfigurationManager.AppSettings["ProductHtml"].ToString()));
                        //Read the first line of text
                        line = sr.ReadLine();
                        //Continue to read until you reach end of file
                        while (line != null)
                        {
                            if (line.Contains("[xxxMetaTagxxx]"))
                            {
                                string strMetaName = "", strMetaContent = "";
                                foreach (GridViewRow grRow in grdMetaTag.Rows)
                                {
                                    if (grRow.RowType == DataControlRowType.DataRow)
                                    {
                                        strMetaName = ((Label)grRow.FindControl("lblName")).Text;
                                        strMetaContent = ((Label)grRow.FindControl("lblContent")).Text;
                                        //sw.WriteLine(line.Replace("[xxxMetaTagxxx]", "<meta name=\"" + strMetaName.Trim() + "\" content=\"" + strMetaContent.Trim() + "\" />"));
                                        sw.WriteLine("<meta name=\"" + strMetaName.Trim() + "\" content=\"" + strMetaContent.Trim() + "\" />");
                                    }
                                }
                            }
                            else if (line.Contains("[xxxProductIDxxx]"))
                            {
                                //write the lie to console window
                                sw.WriteLine(line.Replace("[xxxProductIDxxx]", PId.ToString()));
                                //sw.WriteLine(PId.ToString());
                            }
                            else
                            {
                                sw.WriteLine(line);
                            }
                            //Read the next line
                            line = sr.ReadLine();
                        }
                        //close the file
                        sr.Close();
                        sw.Close();
                        chkflag = false;
                        if (File.Exists(Server.MapPath("~\\" + WrTofileName + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html")))
                            chkflag = true;
                    }
                    catch (Exception)
                    {
                        chkflag = false;
                    }
                }*/

                if (chkflag)
                {
                    SqlTrn.Commit();
                    ClearControls();
                    AlertMsg("Record Saved Successfuly");

                }
                else
                {
                    SqlTrn.Rollback();

                    string DefaultfileNamelogo = ConfigurationManager.AppSettings["DefaultLogoImg"].ToString();
                    string DefaultfileNamead = ConfigurationManager.AppSettings["DefaultAddImg"].ToString();
                    string DefaultfileNamebig = ConfigurationManager.AppSettings["DefaultBigImg"].ToString();

                    if (DefaultfileNamelogo != fileNamelogo && File.Exists(Server.MapPath(folderPath + fileNamelogo)))
                        File.Delete(Server.MapPath(folderPath + fileNamelogo));
                    if (DefaultfileNamead != fileNamead && File.Exists(Server.MapPath(folderPath + fileNamead)))
                        File.Delete(Server.MapPath(folderPath + fileNamead));
                    if (DefaultfileNamebig != fileNamebig && File.Exists(Server.MapPath(folderPath + fileNamebig)))
                        File.Delete(Server.MapPath(folderPath + fileNamebig));
                    if (File.Exists(Server.MapPath("~\\" + WrTofileName + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html")))
                        File.Delete(Server.MapPath("~\\" + WrTofileName + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html"));
                }
                con.Close();
            }


        }
        catch (Exception)
        {

        }
    }

    protected void ddlcategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlcategory.SelectedValue);
        con.Open();
        SqlCommand cmd = new SqlCommand("select name,categoryid from mcategory where activeflag=1 and DeleteFlage='A' AND type=" + ID, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlsubcategory.DataSource = ds;
        ddlsubcategory.DataTextField = "name";
        ddlsubcategory.DataValueField = "categoryid";
        ddlsubcategory.DataBind();
        ddlsubcategory.Items.Insert(0, new ListItem("--Select--", "0"));
    }
    protected void btnAddPrice_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = gridViewtoDatatable().Copy();
            DataRow dr = dt.NewRow();
            dr["Srno"] = dt.Rows.Count + 1;
            dr["Quantity"] = txtQuant.Text;
            dr["Strength"] = txtPricestrength.Text;
            dr["NewPrice"] = txtNewPrice.Text;
            dr["NewUnitPrice"] = txtNewUnitPrice.Text;
            dr["OldPrice"] = txtoldPrice.Text;
            dr["oldUnitPrice"] = txtOldUntPrice.Text;
            dr["activeflag"] = "1";
            dt.Rows.Add(dr);
            grdPriceLIst.DataSource = dt;
            grdPriceLIst.DataBind();

            ClearAddPrice();

        }
        catch (Exception)
        {

        }
    }
    protected void grdPriceLIst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "delRow")
            {

                string deleRowId = ((Label)((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).FindControl("lblSrno")).Text;
                DataTable dt = new DataTable();
                dt = gridViewtoDatatable().Copy();
                DataRow[] delRow = dt.Select("Srno = " + deleRowId);
                dt.Rows.Remove(delRow[0]);
                dt.AcceptChanges();
                grdPriceLIst.DataSource = dt;
                grdPriceLIst.DataBind();
            }
        }
        catch (Exception)
        {
        }
    }
    protected void btnAddMetaTag_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = MetaGridtoDatatable().Copy();
            DataRow dr = dt.NewRow();
            dr["Srno"] = dt.Rows.Count + 1;
            dr["Name"] = txtMetaName.Text.Trim();
            dr["Content"] = txtMetaContent.Text.Trim();
            //dr["TagMeta"] = "<meta name=\"" + txtMetaName.Text.Trim() + "\" content=\"" + txtMetaContent.Text.Trim() + "\" />";
            dt.Rows.Add(dr);
            grdMetaTag.DataSource = dt;
            grdMetaTag.DataBind();
            btnAddMetaTag.Visible = false;
            ClearMetaFields();

        }
        catch (Exception)
        {

        }
    }
    protected void grdMetaTag_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "delRow")
            {

                string deleRowId = ((Label)((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).FindControl("lblSrno")).Text;
                DataTable dt = new DataTable();
                dt = MetaGridtoDatatable().Copy();
                DataRow[] delRow = dt.Select("Srno = " + deleRowId);
                dt.Rows.Remove(delRow[0]);
                dt.AcceptChanges();
                grdMetaTag.DataSource = dt;
                grdMetaTag.DataBind();
            }
        }
        catch (Exception)
        {
        }
    }

    protected void btnAddProdDes_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ProductDesGridtoDatatable().Copy();
            DataRow dr = dt.NewRow();
            dr["Srno"] = dt.Rows.Count + 1;
            dr["Heading"] = txtProdDesHeading.Text.Trim();
            dr["Description"] = HttpUtility.HtmlEncode(txtProdDescription.Text.Trim());
            dr["activeflag"] = "1";
            dt.Rows.Add(dr);
            grdProdDes.DataSource = dt;
            grdProdDes.DataBind();

            ClearProductDesField();

        }
        catch (Exception)
        {

        }
    }
    protected void lnkDeletMeta_Click(object sender, EventArgs e)
    {
        try
        {
            string deleRowId = ((Label)((GridViewRow)((LinkButton)sender).NamingContainer).FindControl("lblSrno")).Text;
            DataTable dt = new DataTable();
            dt = ProductDesGridtoDatatable().Copy();
            DataRow[] delRow = dt.Select("Srno = " + deleRowId);
            dt.Rows.Remove(delRow[0]);
            dt.AcceptChanges();
            grdProdDes.DataSource = dt;
            grdProdDes.DataBind();

        }
        catch (Exception)
        {
        }
    }
}