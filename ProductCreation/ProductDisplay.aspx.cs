using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Data.SqlClient;

public partial class ProductDisplay : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    DataSet ds = new DataSet();
    Boolean chkFlag = false;

    public string productID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        Img3.Src = "http://www.pillsincart.com/images/logo.png";
        Page.DataBind();
        BindContolData();
    }


    protected void BindContolData()
    {
        try
        {
            chkFlag = true;
            StringBuilder SqlQuery = new StringBuilder();


            UserInfo objUserInfo = UserInfo.GetUserInfo();
            divLogOut.Attributes.Add("style", "display:none;");
            divLogin.Attributes.Add("style", "display:none;");
            Int64? OrdID = null, UsrId = null;
            if (objUserInfo != null)
            {
                divLogOut.Attributes.Add("style", "display:block;");
                lblUserName.Text = "Welcome " + objUserInfo.fName;
                UsrId = objUserInfo.userId;
            }
            else
            {
                divLogin.Attributes.Add("style", "display:block;");
                if (Session["OrdId"] != null)
                {
                    OrdID = Convert.ToInt64(Session["OrdId"]);
                }
            }
            lblCartValu.Text = String.Format("{0:0.00}", objDataAccess.GetCartAmount(OrdID, UsrId));



            //string folderName = Convert.ToString(Session["folderName"]);
            //string CatID = Convert.ToString(Page.RouteData.Values["CategoryID"]);
            string prodCatName = Convert.ToString(Page.RouteData.Values["ProductName"]);
            string CatID = prodCatName.Split('-')[0];
            string prodName = prodCatName.Substring(prodCatName.IndexOf("-") + 1);
            //LtrProductTitle.Text = prodName;
            if (!String.IsNullOrEmpty(CatID) && !String.IsNullOrEmpty(prodName))
            {
                SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@CategoryId",CatID),
                new SqlParameter("@productName","%"+prodName+"%")
                };

                SqlQuery.Append(" SELECT top 1 dbo.mproduct.productid ")
                        .Append(" FROM dbo.mproduct ")
                        .Append("  INNER JOIN dbo.mcategory ON dbo.mproduct.categoryId = dbo.mcategory.categoryid AND dbo.mcategory.ActiveFlag = 1  AND dbo.mcategory.DeleteFlage = 'A' ")
                        .Append(" WHERE dbo.mcategory.categoryid=@CategoryId AND dbo.mproduct.pageName LIKE @productName and dbo.mproduct.activeflag='1' AND dbo.mproduct.DeleteFlage='A' ");
                DataSet ds = objDataAccess.getDataSetQuery(SqlQuery.ToString(), parameters);
                //productID = "31";
                if ((ds != null) && (ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0))
                {
                    productID = Convert.ToString(ds.Tables[0].Rows[0][0]);
                }
            }

            if (!String.IsNullOrEmpty(productID))
            {
                SqlQuery.Length = 0;
                SqlQuery.Clear();
                SqlQuery = new StringBuilder();
                SqlQuery.Append(" SELECT DesHeading,prodDescription FROM productDescription WHERE activeflag=1 AND productid='")
                        .Append(productID + "'");
                lstProductDes.DataSource = objDataAccess.getDataSetQuery(SqlQuery.ToString());
                lstProductDes.DataBind();
                chkFlag = true;

                ds = objDataAccess.getDataSetQuery("SELECT * FROM mproduct WHERE activeflag='1' AND DeleteFlage='A' AND productid=" + productID);
                if ((ds != null) && (ds.Tables != null) && (ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0))
                {
                    lblShortName.Text = ds.Tables[0].Rows[0]["ShortName"].ToString();
                    Page.Title = Convert.ToString(ds.Tables[0].Rows[0]["ShortName"]);
                    imgLogoImg.ImageUrl = ds.Tables[0].Rows[0]["logoimgpath"].ToString();
                    logPrice.Text = ds.Tables[0].Rows[0]["logoPrice"].ToString();
                    lblGenericName.Text = ds.Tables[0].Rows[0]["genername"].ToString();
                    lblBrandName.Text = ds.Tables[0].Rows[0]["brandname"].ToString();
                    lblStrength.Text = ds.Tables[0].Rows[0]["strength"].ToString();
                    lblExpiry.Text = ds.Tables[0].Rows[0]["expirydate"].ToString();
                    lblAvrDele.Text = ds.Tables[0].Rows[0]["avgdelivery"].ToString();
                    lblPrice.Text = ds.Tables[0].Rows[0]["price"].ToString();
                    lblDescription.Text = HttpUtility.HtmlDecode(ds.Tables[0].Rows[0]["description"].ToString());
                    imgAddImg.ImageUrl = ds.Tables[0].Rows[0]["adimgpath"].ToString();

                    grdProdPrice.DataSource = objDataAccess.getDataSetQuery("DECLARE @FeeSippCharge bigint = 0 select @FeeSippCharge  = CAST(name as numeric(18,2))  from mstGeneralCnst where typename = 'FreeShippingLimit' select ProdPriceId,productid,quantity,strength,newprice,newUnitPrice,oldprice,oldUnitPrice,case when CAST(newprice as numeric(18,2)) >  @FeeSippCharge then 'Free Shipping' else '--' end freShip from mstProductPrice where activeflag=1 and productid=" + productID);
                    grdProdPrice.DataBind();

                    chkFlag = true;
                }
                lstRootCate.DataSource = objDataAccess.getDataSetQuery(" SELECT DISTINCT RootCateoryId,CatName FROM RootCategory_Mst a LEFT JOIN mcategory b ON b.[type] = a.RootCateoryId AND b.ActiveFlag = 1  AND b.DeleteFlage = 'A' WHERE a.ActiveFlage = 1 AND a.DeleteFlage='A'");
                lstRootCate.DataBind();
                chkFlag = true;

                StringBuilder SqlQuery1 = new StringBuilder();
                SqlQuery1.Append(" SELECT top 10 a.TestimonialID, a.Testimonial,b.fName, CONVERT(VARCHAR(10), a.CreatedDt ,105) Creteddt ")
                        .Append(" ,case a.ActiveFlag when 1 then 'Active' when 0 then 'Inactive' end tMoStatus, a.ActiveFlag  ")
                        .Append(" FROM  Testimonials a ")
                        .Append(" JOIN userdetail b ON a.CreatedBy = b.userId ")
                        .Append(" where a.ActiveFlag = 1 and a.DeleteFlag = 1");
                lstTestimonial.DataSource = objDataAccess.getDataSetQuery(SqlQuery1.ToString());
                lstTestimonial.DataBind();
                chkFlag = true;

                SqlQuery.Length = 0;
                SqlQuery.Clear();
                SqlQuery = new StringBuilder();
                SqlQuery.Append(" select MetaName,MetaContent from product_Meta_trn where ProductID='")
                        .Append(productID + "'");
                DataSet ds1 = objDataAccess.getDataSetQuery(SqlQuery.ToString());
                if (ds1 != null && ds1.Tables.Count > 0)
                {
                    Page.MetaDescription = Convert.ToString(ds1.Tables[0].Rows[0]["MetaContent"]);
                    Page.MetaKeywords = Convert.ToString(ds1.Tables[0].Rows[0]["MetaName"]);
                }
                chkFlag = true;
            }
        }
        catch (Exception)
        {
            chkFlag = false;
        }
    }

    protected void lstRootCate_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HiddenField hdnRootCateGoryId = e.Item.FindControl("hdnRootCateGoryId") as HiddenField;
                ListView listCategory = e.Item.FindControl("listCategory") as ListView;
                listCategory.DataSource = objDataAccess.getDataSetQuery("SELECT DISTINCT a.categoryid,a.name,folderName FROM mcategory a LEFT JOIN mproduct b ON b.categoryId = a.categoryid AND b.activeflag=1 WHERE a.activeflag=1 AND [type]='" + hdnRootCateGoryId.Value + "' AND a.DeleteFlage='A'");
                listCategory.DataBind();
            }
        }
        catch (Exception)
        {
            chkFlag = false;
        }
    }

    protected void listCategory_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HiddenField hdncateId = e.Item.FindControl("hdncateId") as HiddenField;
                ListView lstVwProd = e.Item.FindControl("lstVwProd") as ListView;
                lstVwProd.DataSource = objDataAccess.getDataSetQuery("SELECT p.name,p.productid,p.categoryid,c.folderName,p.pageName,'~/Products/'+c.folderName+'/'+p.pageName as PageUrl FROM mproduct p JOIN mcategory c ON c.categoryid=p.categoryId AND c.activeflag='1' AND c.DeleteFlage='A' WHERE p.activeflag='1' AND p.categoryId=" + hdncateId.Value);
                lstVwProd.DataBind();
            }
        }
        catch (Exception)
        {
            chkFlag = false;
        }
    }

    protected void gotopage_Click(object sender, EventArgs e)
    {
        LinkButton linkbutton = sender as LinkButton;
        if (linkbutton != null)
        {
            //Session["folderName"] = linkbutton.CommandArgument;
            string PrdCatname = linkbutton.CommandArgument.Trim() + "-" + linkbutton.CommandName.Trim().Replace(" ", "-");
            string Url = GetRouteUrl("ProductDisplay", new { ProductName = "" + PrdCatname + "" });
            Response.Redirect(Url);
        }

    }
}