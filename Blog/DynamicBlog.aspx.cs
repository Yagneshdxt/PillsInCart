using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class Blog_DynamicBlog : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    DataSet ds = new DataSet();
    Boolean chkFlag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Img3.Src = "http://www.pillsincart.com/images/logo.png";
            Page.DataBind();
            if (!IsPostBack)
            {
                BindContolData();

                if (chkFlag)
                {
                    lblStatusState.Text = "Success";
                }
                else
                {
                    lblStatusState.Text = "failur";
                }
            }
        }
        catch (Exception)
        {

        }
    }

    protected void BindContolData()
    {
        try
        {
            //  //objDataAccess.getDataSetQuery("select categoryid,name,folderName from mcategory where activeflag=1");
            //  lstRootCate.DataSource = objDataAccess.getDataSetQuery(" SELECT DISTINCT RootCateoryId,CatName FROM RootCategory_Mst a LEFT JOIN mcategory b ON b.[type] = a.RootCateoryId AND b.ActiveFlag = 1  AND b.DeleteFlage = 'A' WHERE a.ActiveFlage = 1 AND a.DeleteFlage='A'");
            //  lstRootCate.DataBind();
            //  chkFlag = true;

            StringBuilder SqlQuery = new StringBuilder();
            SqlQuery.Append(" SELECT top 10 a.TestimonialID, a.Testimonial,b.fName, CONVERT(VARCHAR(10), a.CreatedDt ,105) Creteddt ")
                    .Append(" ,case a.ActiveFlag when 1 then 'Active' when 0 then 'Inactive' end tMoStatus, a.ActiveFlag  ")
                    .Append(" FROM  Testimonials a ")
                    .Append(" JOIN userdetail b ON a.CreatedBy = b.userId ")
                    .Append(" where a.ActiveFlag = 1 and a.DeleteFlag = 1");
            lstTestimonial.DataSource = objDataAccess.getDataSetQuery(SqlQuery.ToString());
            lstTestimonial.DataBind();
            //  chkFlag = true;

            //  SqlQuery.Length = 0;
            //  SqlQuery.Clear();
            //  SqlQuery = new StringBuilder();
            //  SqlQuery.Append(" SELECT DesHeading,prodDescription FROM productDescription WHERE activeflag=1 AND productid='")
            //          .Append(Convert.ToString(Request.QueryString["ProdId"]) + "'");
            ////  lstProductDes.DataSource = objDataAccess.getDataSetQuery(SqlQuery.ToString());
            // // lstProductDes.DataBind();
            //  chkFlag = true;


            //  UserInfo objUserInfo = UserInfo.GetUserInfo();
            //  divLogOut.Attributes.Add("style", "display:none;");
            //  divLogin.Attributes.Add("style", "display:none;");
            //  Int64? OrdID = null, UsrId = null;
            //  if (objUserInfo != null)
            //  {
            //      divLogOut.Attributes.Add("style", "display:block;");
            //     // lblUserName.Text = "Welcome " + objUserInfo.fName;
            //      UsrId = objUserInfo.userId;
            //  }
            //  else
            //  {
            //      divLogin.Attributes.Add("style", "display:block;");
            //      if (Session["OrdId"] != null)
            //      {
            //          OrdID = Convert.ToInt64(Session["OrdId"]);
            //      }
            //  }
            //  lblCartValu.Text = String.Format("{0:0.00}", objDataAccess.GetCartAmount(OrdID, UsrId));

            //  chkFlag = true;

            //  if ((Request.QueryString["ProdId"] != null) && (!String.IsNullOrEmpty(Convert.ToString(Request.QueryString["ProdId"]))))
            //  {
            //      ds = objDataAccess.getDataSetQuery("SELECT * FROM mproduct WHERE activeflag='1' AND DeleteFlage='A' AND productid=" + Request.QueryString["ProdId"].ToString());
            //      if ((ds != null) && (ds.Tables != null) && (ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0))
            //      {
            //          //lblShortName.Text = ds.Tables[0].Rows[0]["ShortName"].ToString();
            //          //imgLogoImg.ImageUrl = ds.Tables[0].Rows[0]["logoimgpath"].ToString();
            //          //logPrice.Text = ds.Tables[0].Rows[0]["logoPrice"].ToString();
            //          //lblGenericName.Text = ds.Tables[0].Rows[0]["genername"].ToString();
            //          //lblBrandName.Text = ds.Tables[0].Rows[0]["brandname"].ToString();
            //          //lblStrength.Text = ds.Tables[0].Rows[0]["strength"].ToString();
            //          //lblExpiry.Text = ds.Tables[0].Rows[0]["expirydate"].ToString();
            //          //lblAvrDele.Text = ds.Tables[0].Rows[0]["avgdelivery"].ToString();
            //          //lblPrice.Text = ds.Tables[0].Rows[0]["price"].ToString();
            //          //lblDescription.Text = HttpUtility.HtmlDecode(ds.Tables[0].Rows[0]["description"].ToString());
            //          //imgAddImg.ImageUrl = ds.Tables[0].Rows[0]["adimgpath"].ToString();

            //          //grdProdPrice.DataSource = objDataAccess.getDataSetQuery("DECLARE @FeeSippCharge bigint = 0 select @FeeSippCharge  = CAST(name as numeric(18,2))  from mstGeneralCnst where typename = 'FreeShippingLimit' select ProdPriceId,productid,quantity,strength,newprice,newUnitPrice,oldprice,oldUnitPrice,case when CAST(newprice as numeric(18,2)) >  @FeeSippCharge then 'Free Shipping' else '--' end freShip from mstProductPrice where activeflag=1 and productid=" + Request.QueryString["ProdId"].ToString());
            //          //grdProdPrice.DataBind();

            //          chkFlag = true;
            //      }
            //  }
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
                lstVwProd.DataSource = objDataAccess.getDataSetQuery("SELECT p.name,p.productid,'~/'+c.folderName+'/'+p.pageName as PageUrl FROM mproduct p JOIN mcategory c ON c.categoryid=p.categoryId AND c.activeflag='1' AND c.DeleteFlage='A' WHERE p.activeflag='1' AND p.categoryId=" + hdncateId.Value);
                lstVwProd.DataBind();
            }
        }
        catch (Exception)
        {
            chkFlag = false;
        }
    }


}