using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;

public partial class Admin_EditProduct : System.Web.UI.Page
{
    DataAccess objDaAcc = new DataAccess();
    DataSet ds = new DataSet();
    SqlTransaction SqlTrn;
    SqlDataAdapter da;
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

        if (!IsPostBack)
        {
            bindControls();
        }
    }


    protected void bindControls()
    {
        try
        {
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@productId",Request.QueryString["PID"].ToString())
            };
            ds = objDaAcc.getDataSetQuery("Product_Select", paras, CommandType.StoredProcedure);
            if ((ds != null) && (ds.Tables != null) && (ds.Tables.Count > 0))
            {
                ddlcategory.DataSource = ds.Tables[2];
                ddlcategory.DataTextField = "name";
                ddlcategory.DataValueField = "gconstantid";
                ddlcategory.DataBind();
                ddlcategory.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlsubcategory.DataSource = ds.Tables[3];
                ddlsubcategory.DataTextField = "name";
                ddlsubcategory.DataValueField = "categoryid";
                ddlsubcategory.DataBind();
                ddlsubcategory.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlcategory.SelectedValue = ds.Tables[4].Rows[0]["categoryId"].ToString();
                ddlsubcategory.SelectedValue = ds.Tables[4].Rows[0]["subCategoryId"].ToString();

                txtproductname.Text = ds.Tables[0].Rows[0]["name"].ToString();
                txtShortName.Text = ds.Tables[0].Rows[0]["ShortName"].ToString();
                txtproductdesc.Text = HttpUtility.HtmlDecode(ds.Tables[0].Rows[0]["description"].ToString());
                txtstrength.Text = ds.Tables[0].Rows[0]["strength"].ToString();
                txtexpiry.Text = ds.Tables[0].Rows[0]["expirydate"].ToString();
                txtdelivery.Text = ds.Tables[0].Rows[0]["avgdelivery"].ToString();
                txtprice.Text = ds.Tables[0].Rows[0]["price"].ToString();
                txtLogoPrice.Text = ds.Tables[0].Rows[0]["logoPrice"].ToString();
                txtgeneric.Text = ds.Tables[0].Rows[0]["genername"].ToString();
                txtbrand.Text = ds.Tables[0].Rows[0]["brandname"].ToString();
                imgUpLogo.ImageUrl = ds.Tables[0].Rows[0]["logoimgpath"].ToString().Replace("~", "..");
                imgUpAdver.ImageUrl = ds.Tables[0].Rows[0]["adimgpath"].ToString().Replace("~", "..");
                imgUpBigImg.ImageUrl = ds.Tables[0].Rows[0]["bigimgpath"].ToString().Replace("~", "..");
                rdActiveDeactive.ClearSelection();
                rdActiveDeactive.SelectedValue = (ds.Tables[0].Rows[0]["activeflag"].ToString() == "True") ? "1" : "0";

                grdUpdate.DataSource = ds.Tables[1];
                grdUpdate.DataBind();

                grdProdDes.DataSource = ds.Tables[5];
                grdProdDes.DataBind();


                hdnProductId.Value = Request.QueryString["PID"].ToString();

                hdnfilePath.Value = "~/" + ds.Tables[3].Rows[0]["folderName"].ToString() + "/" + ds.Tables[0].Rows[0]["pageName"].ToString();


                //txtMetaName.Text = Convert.ToString(ds.Tables[6].Rows[0]["MetaName"]);
                //txtMetaContent.Text = Convert.ToString(ds.Tables[6].Rows[0]["MetaContent"]);
                //hdnMetaId.Value = Convert.ToString(ds.Tables[6].Rows[0]["prodMetaId"]);
                /*
                ValidateImage objValidateImage = new ValidateImage();
                lblLogoImagVali.Text = "Height :" + objValidateImage.LogImgHeight + " Width :" + objValidateImage.LogImgWidth;
                lblAdImgVali.Text = "Height :" + objValidateImage.AddImgHeight + " Width :" + objValidateImage.AddImgWidth;
                lblbigImgVali.Text = "Height :" + objValidateImage.BigImgHeight + " Width :" + objValidateImage.BigImgWidth;
                lblImageType.Text = objValidateImage.valTypestr.Replace("|", ", ");
                */
            }
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

    protected string validateEntry()
    {
        string errMsg = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@categoryId",ddlsubcategory.SelectedValue),
                new SqlParameter("@productID",hdnProductId.Value)
            };
            ds = new DataSet();
            ds = objDataAccess.getDataSetQuery("SELECT b.folderName from mproduct a JOIN mcategory b ON b.categoryId = a.categoryId where a.productid = @productID select folderName from mcategory where categoryid = @categoryId", param);
            if ((ds != null) && (ds.Tables.Count > 0))
            {
                if (Convert.ToString(ds.Tables[0].Rows[0][0]) != Convert.ToString(ds.Tables[1].Rows[0][0]))
                {
                    string FolderNameStr = Convert.ToString(ds.Tables[1].Rows[0][0]);
                    if (File.Exists(Server.MapPath("~\\" + FolderNameStr + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html")))
                    {
                        errMsg = errMsg + "file with this name already exist in the selected sub-category\n";
                    }
                }
            }
            /*
            ValidateImage objValidateImage = new ValidateImage();
            errMsg = errMsg + objValidateImage.CheckImage(fileuplogo, ValidateImage.ImageType.LogoImage);
            errMsg = errMsg + objValidateImage.CheckImage(fileupad, ValidateImage.ImageType.AddImage);
            errMsg = errMsg + objValidateImage.CheckImage(fileuplogobig, ValidateImage.ImageType.BigImage);
             * */
        }
        catch (Exception)
        {
            errMsg = errMsg + "Error Inserting the data";
        }
        return errMsg;
    }

    protected void BindGridProductDescription()
    {
        try
        {
            DataSet ds = new DataSet();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@productId",Request.QueryString["PID"].ToString())
            };
            ds = objDaAcc.getDataSetQuery("SELECT prodDescriptionId,DesHeading,prodDescription,activeflag, CASE activeflag WHEN 1 THEN 'Active' WHEN 0 THEN 'Inactive' end DisStat FROM productDescription WHERE productid=@productId", paras, CommandType.Text);
            if ((ds != null) && (ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0))
            {
                grdProdDes.DataSource = ds;
                grdProdDes.DataBind();
            }
            else
            {
                grdProdDes.DataSource = string.Empty;
                grdProdDes.DataBind();
            }
        }
        catch (Exception)
        {

        }

    }

    protected void ClearContent()
    {
        try
        {
            ddlcategory.ClearSelection();
            ddlsubcategory.ClearSelection();
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
            imgUpLogo.ImageUrl = "";
            imgUpAdver.ImageUrl = "";
            imgUpBigImg.ImageUrl = "";
            rdActiveDeactive.ClearSelection();
            rdActiveDeactive.SelectedValue = "1";
            grdUpdate.DataSource = null;
            grdUpdate.DataBind();
            ClearAddPrice();
            grdPriceLIst.DataSource = null;
            grdPriceLIst.DataBind();
            grdProdDes.DataSource = string.Empty;
            grdProdDes.DataBind();
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

    protected DataTable grdUpdateToDataTable()
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

            foreach (GridViewRow grRow in grdUpdate.Rows)
            {
                if (grRow.RowType == DataControlRowType.DataRow)
                {
                    DataRow dr = dt.NewRow();
                    dr["Srno"] = ((HiddenField)grRow.FindControl("hdnProdPriceId")).Value;
                    dr["Quantity"] = ((TextBox)grRow.FindControl("txtQuantity")).Text;
                    dr["Strength"] = ((TextBox)grRow.FindControl("txtStrength")).Text;
                    dr["NewPrice"] = ((TextBox)grRow.FindControl("txtNewPrice")).Text;
                    dr["NewUnitPrice"] = ((TextBox)grRow.FindControl("txtNewUnitPrice")).Text;
                    dr["OldPrice"] = ((TextBox)grRow.FindControl("txtOldPrice")).Text;
                    dr["oldUnitPrice"] = ((TextBox)grRow.FindControl("txtoldUnitPrice")).Text;
                    dr["activeflag"] = ((RadioButtonList)grRow.FindControl("rdUpGridActInac")).SelectedValue;
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception)
        {

        }
        return dt;
    }

    protected void bindUpdateGrid()
    {
        try
        {
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@productId",hdnProductId.Value)
            };
            grdUpdate.DataSource = objDaAcc.DaExecNonQueryStr("select * from mstProductPrice where productid = @productId and activeflag=1", paras);
            grdUpdate.DataBind();
        }
        catch (Exception)
        {

        }
    }

    protected void btnUpdateMeta_Click(object sender, EventArgs e)
    {
        //hdnMetaId.Value = "1";
        //try
        //{
        //    updmeta.Visible = false;
        //    //if (hdnMetaId.Value != "")
        //    //{
        //    //    SqlParameter[] paras = new SqlParameter[]{
        //    //        new SqlParameter("@prodMetaId",hdnMetaId.Value), 
        //    //        new SqlParameter("@MetaName",txtMetaName.Text), 
        //    //        new SqlParameter("@MetaContent",txtMetaContent.Text), 
        //    //    };
        //    //    string SqlQry = "update product_Meta_trn set MetaName = @MetaName,MetaContent = @MetaContent where prodMetaId = @prodMetaId";
        //    //    objDataAccess.DaExecNonQueryStr(SqlQry, paras, CommandType.Text);
        //    //    AlertMsg("Updated Successfuly");
        //    //}
        //}
        //catch (Exception)
        //{

        //}
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
            dt.Rows.Add(dr);
            grdPriceLIst.DataSource = dt;
            grdPriceLIst.DataBind();

            ClearAddPrice();
        }
        catch (Exception)
        {

        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        bool redirectChk = false;
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

            //Variables
            bool chkflag = false;
            string chkExNonQry = "0";
            string folderPath = ConfigurationManager.AppSettings["ImageFolder"].ToString();
            DataTable PriceAdd = gridViewtoDatatable().Copy();
            DataTable PriceUpdate = grdUpdateToDataTable().Copy();

            //Save Image FIle
            string DefaultfileNamebig = ConfigurationManager.AppSettings["DefaultBigImg"].ToString();
            ValidateImage objImage = new ValidateImage();
            string FileNameWtOtExt = "";
            folderPath = ConfigurationManager.AppSettings["ImageFolder"].ToString();
            string CurrLogoImgFileName = Path.GetFileName(Server.MapPath(imgUpLogo.ImageUrl.Replace("..", "~")));
            string CurrAdverImgFileName = Path.GetFileName(Server.MapPath(imgUpAdver.ImageUrl.Replace("..", "~")));
            string CurrBigExtraImgFileName = Path.GetFileName(Server.MapPath(imgUpBigImg.ImageUrl.Replace("..", "~")));

            if ((fileuplogo.HasFile) && (fileuplogo.PostedFile.ContentLength > 0))
            {
                string DefaultfileNamelogo = ConfigurationManager.AppSettings["DefaultLogoImg"].ToString();
                //file Delete Logic Need to check if the file that is to be delete is default image then do not delete
                if (DefaultfileNamelogo != CurrLogoImgFileName)
                {
                    File.Delete(Server.MapPath(imgUpLogo.ImageUrl.Replace("..", "~")));
                    FileNameWtOtExt = Path.GetFileNameWithoutExtension(Server.MapPath(imgUpLogo.ImageUrl.Replace("..", "~")));
                    string filExt = Path.GetExtension(fileuplogo.PostedFile.FileName);
                    fileuplogo.SaveAs(Server.MapPath(folderPath + FileNameWtOtExt + filExt));
                    CurrLogoImgFileName = FileNameWtOtExt + filExt;
                }
                else
                {
                    objImage.saveimage(fileuplogo, out CurrLogoImgFileName);
                }
            }
            if ((fileupad.HasFile) && (fileupad.PostedFile.ContentLength > 0))
            {
                string DefaultfileNamead = ConfigurationManager.AppSettings["DefaultAddImg"].ToString();
                //file Delete Logic Need to check if the file that is to be delete is default image then do not delete
                if (DefaultfileNamead != CurrAdverImgFileName)
                {
                    File.Delete(Server.MapPath(imgUpAdver.ImageUrl.Replace("..", "~")));
                    FileNameWtOtExt = Path.GetFileNameWithoutExtension(Server.MapPath(imgUpAdver.ImageUrl.Replace("..", "~")));
                    string filExt = Path.GetExtension(fileupad.PostedFile.FileName);
                    fileupad.SaveAs(Server.MapPath(folderPath + FileNameWtOtExt + filExt));
                    CurrAdverImgFileName = FileNameWtOtExt + filExt;
                }
                else
                {
                    objImage.saveimage(fileupad, out CurrAdverImgFileName);
                }
            }
            if ((fileuplogobig.HasFile) && (fileuplogobig.PostedFile.ContentLength > 0))
            {

                string DefaultfileNamead = ConfigurationManager.AppSettings["DefaultAddImg"].ToString();
                //file Delete Logic Need to check if the file that is to be delete is default image then do not delete
                if (DefaultfileNamead != CurrBigExtraImgFileName)
                {
                    File.Delete(Server.MapPath(imgUpBigImg.ImageUrl.Replace("..", "~")));
                    FileNameWtOtExt = Path.GetFileNameWithoutExtension(Server.MapPath(imgUpBigImg.ImageUrl.Replace("..", "~")));
                    string filExt = Path.GetExtension(fileuplogobig.PostedFile.FileName);
                    fileuplogobig.SaveAs(Server.MapPath(folderPath + FileNameWtOtExt + filExt));
                    CurrBigExtraImgFileName = FileNameWtOtExt + filExt;
                }
                else
                {
                    objImage.saveimage(fileuplogobig, out CurrBigExtraImgFileName);
                }
            }

            if (!File.Exists(Server.MapPath(folderPath + CurrLogoImgFileName)))
                CurrLogoImgFileName = Path.GetFileName(Server.MapPath(imgUpLogo.ImageUrl.Replace("..", "~")));
            if (!File.Exists(Server.MapPath(folderPath + CurrAdverImgFileName)))
                CurrAdverImgFileName = Path.GetFileName(Server.MapPath(imgUpAdver.ImageUrl.Replace("..", "~")));
            if (!File.Exists(Server.MapPath(folderPath + CurrBigExtraImgFileName)))
                CurrBigExtraImgFileName = Path.GetFileName(Server.MapPath(imgUpBigImg.ImageUrl.Replace("..", "~")));

            SqlConnection con = objDaAcc.conObj;
            try
            {
                SqlCommand cmd = new SqlCommand("Product_IUD", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductId", hdnProductId.Value);
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
                cmd.Parameters.AddWithValue("@logoimgpath", folderPath + CurrLogoImgFileName); // folderPath = ~/images/products/ and CurrLogoImgFileName = abc.jpg
                cmd.Parameters.AddWithValue("@adimgpath", folderPath + CurrAdverImgFileName);
                cmd.Parameters.AddWithValue("@bigimgpath", folderPath + CurrBigExtraImgFileName);
                cmd.Parameters.AddWithValue("@activeflag", rdActiveDeactive.SelectedValue);
                cmd.Parameters.AddWithValue("@QuerType", "U");
                cmd.Parameters.AddWithValue("@LogInUser", UserInfo.GetUserInfo().userId);
                cmd.Parameters.AddWithValue("@priceTd", PriceAdd);
                cmd.Parameters.AddWithValue("@priceTbUpdate", PriceUpdate);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                    SqlTrn = con.BeginTransaction();
                    cmd.Transaction = SqlTrn;
                }
                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);
                if ((ds != null) && (ds.Tables != null))
                {
                    if (ds.Tables[2] != null)
                        chkExNonQry = ds.Tables[2].Rows[0][0].ToString();
                    if (ds.Tables[0].Rows[0]["PageUrl"] != null)
                        hdnfilePath.Value = ds.Tables[0].Rows[0]["PageUrl"].ToString();
                }
                chkflag = true;
            }
            catch (Exception)
            {
                chkExNonQry = "0";
            }
            //Rename and move to folder
            /*
            if (chkExNonQry == "1")
            {
                try
                {
                    if (!String.IsNullOrEmpty(hdnfilePath.Value))
                    {
                        //This to rename the file.
                        FileNameWtOtExt = Path.GetFileNameWithoutExtension(Server.MapPath(hdnfilePath.Value));
                        if (FileNameWtOtExt != txtproductname.Text.Trim().Replace(" ", "-"))
                        {
                            File.Move(Server.MapPath(hdnfilePath.Value), Server.MapPath(Path.GetDirectoryName(hdnfilePath.Value) + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html"));
                        }

                        //This to move to folder.
                        string ProdFolderNameStr = "~\\" + ds.Tables[1].Rows[0][0].ToString();
                        if (Path.GetDirectoryName(hdnfilePath.Value) != ProdFolderNameStr)
                        {
                            File.Move(Server.MapPath(Path.GetDirectoryName(hdnfilePath.Value) + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html"), Server.MapPath(ProdFolderNameStr + "\\" + txtproductname.Text.Trim().Replace(" ", "-") + ".html"));
                        }
                    }
                    chkflag = true;
                }
                catch (Exception)
                {
                    chkflag = false;
                }

            }*/
            if (chkflag)
            {
                ClearContent();
                SqlTrn.Commit();
                //AlertMsg("Records Updated Successfuly");
                redirectChk = true;
            }
            else
            {
                SqlTrn.Rollback();
                AlertMsg("Error Updating the record.");
            }
            con.Close();
        }
        catch (Exception)
        {
            SqlTrn.Dispose();
        }

        if (redirectChk)
        {
            Response.Redirect("~/Admin/ViewProduct.aspx", true);
        }
    }

    //protected void grdUpdate_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        if (e.CommandName == "delRow")
    //        {
    //            int chkFlg = 0;
    //            GridViewRow grdViewRow = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
    //            HiddenField hdnProdPriceId = grdViewRow.FindControl("hdnProdPriceId") as HiddenField;
    //            if ((hdnProdPriceId != null) && (!String.IsNullOrEmpty(hdnProdPriceId.Value)))
    //            {
    //                SqlParameter[] paras = new SqlParameter[]{
    //                    new SqlParameter("@ProdPriceId",hdnProdPriceId.Value)
    //                };
    //                chkFlg = objDaAcc.DaExecNonQueryStr("delete mstProductPrice where ProdPriceId = @ProdPriceId", paras);
    //                bindUpdateGrid();
    //            }

    //            if (chkFlg > 0)
    //            {
    //                //AlertMsg("Record deleted successfuly");
    //            }
    //            else
    //            {
    //                //AlertMsg("Error deleting the record.");
    //            }
    //        }
    //    }
    //    catch (Exception)
    //    {

    //    }
    //}

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
                grdPriceLIst.DataSource = dt;
                grdPriceLIst.DataBind();
            }
        }
        catch (Exception)
        {
        }
    }

    protected void ddlcategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlcategory.SelectedValue);
        SqlConnection con = objDaAcc.conObj;
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

    protected void grdUpdate_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                RadioButtonList rdUpGridActInac = e.Row.FindControl("rdUpGridActInac") as RadioButtonList;
                HiddenField hdnActivState = e.Row.FindControl("hdnActivState") as HiddenField;
                rdUpGridActInac.ClearSelection();
                rdUpGridActInac.SelectedValue = (hdnActivState.Value == "True") ? "1" : "0";

            }
        }
        catch (Exception)
        {

        }
    }

    protected void grdProdDes_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            GridViewRow gvr = grdProdDes.Rows[e.RowIndex] as GridViewRow;
            HiddenField hdnProductDesID = gvr.FindControl("hdnEditProductDesID") as HiddenField;
            TextBox txtDesHeading = gvr.FindControl("txtDesHeading") as TextBox;
            FreeTextBoxControls.FreeTextBox txtProdDescription = gvr.FindControl("txtProdDescription") as FreeTextBoxControls.FreeTextBox;
            RadioButtonList rdbStatus = gvr.FindControl("rdbStatus") as RadioButtonList;
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@prodDescriptionId",hdnProductDesID.Value),  
                    new SqlParameter("@DesHeading",txtDesHeading.Text.Trim()),  
                    new SqlParameter("@prodDescription",HttpUtility.HtmlEncode(txtProdDescription.Text.Trim())),
                    new SqlParameter("@activeflag",rdbStatus.SelectedValue),
                    new SqlParameter("@UserID",UserInfo.GetUserInfo().userId),
                };
            objDataAccess.DaExecNonQueryStr("UPDATE productDescription SET DesHeading = @DesHeading,prodDescription=@prodDescription,modifiedby=@UserID,modifieddate=getdate(),activeflag=@activeflag WHERE prodDescriptionId = @prodDescriptionId ", paras, CommandType.Text);
            grdProdDes.EditIndex = -1;
            BindGridProductDescription();
        }
        catch (Exception)
        {

        }
    }
    protected void grdProdDes_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            grdProdDes.EditIndex = e.NewEditIndex;
            BindGridProductDescription();
            //btnview_Click(null, null);
        }
        catch (Exception)
        {

        }
    }
    protected void grdProdDes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            grdProdDes.EditIndex = -1;
            BindGridProductDescription();
            //btnview_Click(null, null);
        }
        catch (Exception)
        {

        }
    }

    protected void btnAddProdDes_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@productId",Request.QueryString["PID"].ToString()), 
                    new SqlParameter("@DesHeading",txtProdDesHeading.Text.Trim()),  
                    new SqlParameter("@prodDescription",HttpUtility.HtmlEncode(txtProdDescription.Text.Trim())),
                    new SqlParameter("@activeflag","1"),
                    new SqlParameter("@UserID",UserInfo.GetUserInfo().userId),
                };

            StringBuilder sqlQuery = new StringBuilder();
            sqlQuery.Append(" INSERT INTO productDescription( ")
                    .Append(" productid,DesHeading,prodDescription,createdby,createddate,modifiedby, ")
                    .Append(" modifieddate,activeflag) ")
                    .Append(" values( ")
                    .Append(" @productId,@DesHeading,@prodDescription,@UserID,getdate(), ")
                    .Append(" @UserID,getdate(),1) ");

            objDataAccess.DaExecNonQueryStr(sqlQuery.ToString(), paras, CommandType.Text);
            txtProdDesHeading.Text = "";
            txtProdDescription.Text = "";
            BindGridProductDescription();
        }
        catch (Exception)
        {

        }
    }


}