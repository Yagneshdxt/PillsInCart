using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class QuickSearch : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Bindcontrols();
        }
    }

    protected void Bindcontrols()
    {
        try
        {
            DataAccess objDataAccess = new DataAccess();
            ddlrootCategory.DataSource = objDataAccess.getRootCategory();
            ddlrootCategory.DataValueField = "RootCateoryId";
            ddlrootCategory.DataTextField = "CatName";
            ddlrootCategory.DataBind();
            ddlrootCategory.Items.Insert(0, new ListItem("Choose Category", "0"));

            ddlCategory.Items.Clear();
            ddlCategory.Items.Insert(0, new ListItem("Choose SubCategory", "0"));

            ddlProduct.Items.Clear();
            ddlProduct.Items.Insert(0, new ListItem("Choose Product", "0"));

            ddlQuantity.Items.Clear();
            ddlQuantity.Items.Insert(0, new ListItem("Choose Quantity", "0"));

            hdnselproductPriceID.Value = "";
            //<%# "return AddProdPriceToCart(" + Eval("ProdPriceId").ToString() + ")" %>
        }
        catch (Exception)
        {

        }
    }

    protected void ddlrootCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlrootCategory.SelectedValue != "0")
            {
                DataAccess objDataAccess = new DataAccess();
                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@Type",ddlrootCategory.SelectedValue)
                };
                ds = objDataAccess.getDataSetQuery("SELECT name,categoryid FROM mcategory WHERE activeflag=1 AND DeleteFlage='A' AND type=@Type", param);
                ddlCategory.Items.Clear();
                ddlCategory.DataSource = ds;
                ddlCategory.DataValueField = "categoryid";
                ddlCategory.DataTextField = "name";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlProduct.Items.Clear();
                ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlQuantity.Items.Clear();
                ddlQuantity.Items.Insert(0, new ListItem("--Select--", "0"));

                hdnselproductPriceID.Value = "";
                //LnkAddtoCart.Attributes.Add("onClick", "return false");
            }

        }
        catch (Exception)
        {

        }
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCategory.SelectedValue != "0")
            {
                DataAccess objDataAccess = new DataAccess();
                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@categoryId",ddlCategory.SelectedValue)
                };
                ds = objDataAccess.getDataSetQuery("select productid,name from mproduct where categoryId=@categoryId AND activeflag=1 AND DeleteFlage = 'A' AND categoryId=@categoryId", param);
                ddlProduct.Items.Clear();
                ddlProduct.DataSource = ds;
                ddlProduct.DataValueField = "productid";
                ddlProduct.DataTextField = "name";
                ddlProduct.DataBind();
                ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
                

                ddlQuantity.Items.Clear();
                ddlQuantity.Items.Insert(0, new ListItem("--Select--", "0"));

                hdnselproductPriceID.Value = "";
                //LnkAddtoCart.Attributes.Add("onClick", "return false");
            }
        }
        catch (Exception)
        {

        }
    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlProduct.SelectedValue != "0")
            {
                DataAccess objDataAccess = new DataAccess();
                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@productid",ddlProduct.SelectedValue)
                };
                ds = objDataAccess.getDataSetQuery("select prodPriceId,quantity from mstProductPrice where activeflag = 1 AND productid=@productid", param);
                ddlQuantity.Items.Clear();
                ddlQuantity.DataSource = ds;
                ddlQuantity.DataValueField = "prodPriceId";
                ddlQuantity.DataTextField = "quantity";
                ddlQuantity.DataBind();
                ddlQuantity.Items.Insert(0, new ListItem("--Select--", "0"));
                

                hdnselproductPriceID.Value = "";
                //LnkAddtoCart.Attributes.Add("onClick", "return false");

            }
        }
        catch (Exception)
        {

        }
    }
    protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlQuantity.SelectedValue != "0")
            {
                DataAccess objDataAccess = new DataAccess();
                UserInfo objUserInfo = UserInfo.GetUserInfo();
                Int64 UserId = 0;
                UserId = objUserInfo == null ? 0 : objUserInfo.userId;
                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ProdPriceId",ddlQuantity.SelectedValue),
                new SqlParameter("@UserId",UserId)
                };

                ds = objDataAccess.getDataSetQuery("getPriceOfProduct", param,CommandType.StoredProcedure);
                lblPrice.Text = "0.00";
                if ((ds != null) && (ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0)) {
                    lblPrice.Text = ds.Tables[0].Rows[0][0].ToString();
                }
                //hdnselproductPriceID.Value = ddlQuantity.SelectedValue;
                //LnkAddtoCart.Attributes.Add("onClick", "return false");
            }
        }
        catch (Exception)
        {

        }
    }
}