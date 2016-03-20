using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Data;

public partial class DaynamicContent : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        Img1.Src = "http://www.pillsincart.com/images/logo.png";
        try
        {
            if (!IsPostBack)
            {
                BindContolData();

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
            DataSet ds = new DataSet();
            StringBuilder sqlQry = new StringBuilder();
            sqlQry.Append(" SELECT DISTINCT RootCateoryId,CatName FROM RootCategory_Mst a LEFT JOIN mcategory b ON b.[type] = a.RootCateoryId AND b.ActiveFlag = 1  AND b.DeleteFlage = 'A' WHERE a.ActiveFlage = 1 AND a.DeleteFlage='A'")
                .Append(" SELECT b.ShortName,b.name,b.logoPrice,b.logoimgpath,c.folderName,b.pageName, '~/'+c.folderName+'/'+b.pageName as PageUrl  FROM ")
                .Append(" Index_Product_Map a ")
                .Append(" JOIN mproduct b ON a.ProdcutId = b.productid ")
                .Append(" JOIN mcategory c ON c.categoryid=b.categoryId  ");
            ds = objDataAccess.getDataSetQuery(sqlQry.ToString());
            if ((ds != null) && (ds.Tables.Count > 0))
            {
                lstRootCate.DataSource = ds.Tables[0];
                lstRootCate.DataBind();

                if (ds.Tables[1].Rows.Count > 0)
                {

                    lblproductName1.Text = ds.Tables[1].Rows[0]["name"].ToString();
                    lblprodPrice1.Text = ds.Tables[1].Rows[0]["logoPrice"].ToString();
                    ImgProd1.ImageUrl = ds.Tables[1].Rows[0]["logoimgpath"].ToString();
                    ProdLink1.HRef = GetRouteUrl("ProductDisplay", new { folderName = "" + Convert.ToString(ds.Tables[1].Rows[0]["folderName"]) + "", ProductName = "" + Convert.ToString(ds.Tables[1].Rows[0]["pageName"]).Trim().Replace(" ", "-") + "" });
                    //ds.Tables[1].Rows[0]["PageUrl"].ToString();

                    lblprod2.Text = ds.Tables[1].Rows[1]["name"].ToString();
                    lblProPrice2.Text = ds.Tables[1].Rows[1]["logoPrice"].ToString();
                    imgProd2.ImageUrl = ds.Tables[1].Rows[1]["logoimgpath"].ToString();
                    ProdLink2.HRef = GetRouteUrl("ProductDisplay", new { folderName = "" + Convert.ToString(ds.Tables[1].Rows[1]["folderName"]) + "", ProductName = "" + Convert.ToString(ds.Tables[1].Rows[1]["pageName"]).Trim().Replace(" ", "-") + "" });
                    //ds.Tables[1].Rows[1]["PageUrl"].ToString();

                    lblProdName3.Text = ds.Tables[1].Rows[2]["name"].ToString();
                    lblPrice3.Text = ds.Tables[1].Rows[2]["logoPrice"].ToString();
                    ImgProd3.ImageUrl = ds.Tables[1].Rows[2]["logoimgpath"].ToString();
                    lnkbuy3.HRef = GetRouteUrl("ProductDisplay", new { folderName = "" + Convert.ToString(ds.Tables[1].Rows[2]["folderName"]) + "", ProductName = "" + Convert.ToString(ds.Tables[1].Rows[2]["pageName"]).Trim().Replace(" ", "-") + "" });
                    //ds.Tables[1].Rows[2]["PageUrl"].ToString();

                    lblprodName4.Text = ds.Tables[1].Rows[3]["name"].ToString();
                    lblPrice4.Text = ds.Tables[1].Rows[3]["logoPrice"].ToString();
                    imgProd4.ImageUrl = ds.Tables[1].Rows[3]["logoimgpath"].ToString();
                    lnk4.HRef = GetRouteUrl("ProductDisplay", new { folderName = "" + Convert.ToString(ds.Tables[1].Rows[3]["folderName"]) + "", ProductName = "" + Convert.ToString(ds.Tables[1].Rows[3]["pageName"]).Trim().Replace(" ", "-") + "" });
                    //ds.Tables[1].Rows[3]["PageUrl"].ToString();

                    lblProduct5.Text = ds.Tables[1].Rows[4]["name"].ToString();
                    lblProdPrice5.Text = ds.Tables[1].Rows[4]["logoPrice"].ToString();
                    ImgProd5.ImageUrl = ds.Tables[1].Rows[4]["logoimgpath"].ToString();
                    lnkProduct5.HRef = GetRouteUrl("ProductDisplay", new { folderName = "" + Convert.ToString(ds.Tables[1].Rows[4]["folderName"]) + "", ProductName = "" + Convert.ToString(ds.Tables[1].Rows[4]["pageName"]).Trim().Replace(" ", "-") + "" });
                    //ds.Tables[1].Rows[4]["PageUrl"].ToString();

                    lblProduct6.Text = ds.Tables[1].Rows[5]["name"].ToString();
                    lblProdPrice6.Text = ds.Tables[1].Rows[5]["logoPrice"].ToString();
                    Image6.ImageUrl = ds.Tables[1].Rows[5]["logoimgpath"].ToString();
                    lnkBuy6.HRef = GetRouteUrl("ProductDisplay", new { folderName = "" + Convert.ToString(ds.Tables[1].Rows[5]["folderName"]) + "", ProductName = "" + Convert.ToString(ds.Tables[1].Rows[5]["pageName"]).Trim().Replace(" ", "-") + "" });
                    //ds.Tables[1].Rows[5]["PageUrl"].ToString();
                }
            }

            StringBuilder SqlQuery = new StringBuilder();
            SqlQuery.Append(" SELECT top 10 a.TestimonialID, a.Testimonial,b.fName, CONVERT(VARCHAR(10), a.CreatedDt ,105) Creteddt ")
                    .Append(" ,case a.ActiveFlag when 1 then 'Active' when 0 then 'Inactive' end tMoStatus, a.ActiveFlag  ")
                    .Append(" FROM  Testimonials a ")
                    .Append(" JOIN userdetail b ON a.CreatedBy = b.userId ")
                    .Append(" where a.ActiveFlag = 1 ");
            lstTestimonial.DataSource = objDataAccess.getDataSetQuery(SqlQuery.ToString());
            lstTestimonial.DataBind();


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

            sqlQry = new StringBuilder();
            sqlQry.Append(" select top 2 blogId, Introduction,BName,Convert(varchar(10),CreatedDt,103) as CreatedDt from TrnBlog where activeFlag = 1 order by CreatedDt Desc");
            ds = objDataAccess.getDataSetQuery(sqlQry.ToString());
            if (ds != null && ds.Tables.Count > 0)
            {

                lnkBlogPostleft.NavigateUrl = "#";
                ltrBlogPostleft.Text = "";
                blogleftdesc.InnerHtml = string.Empty;

                lnkBlogPostRight.NavigateUrl = "#";
                ltrBlogPostrigth.Text = "";
                blogrightdesc.InnerHtml = string.Empty;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lnkBlogPostleft.NavigateUrl = "~/Blog/" + ds.Tables[0].Rows[0]["blogId"].ToString() + "/" + ds.Tables[0].Rows[0]["BName"].ToString() + "";
                    ltrBlogPostleft.Text = Cutdesc1(ds.Tables[0].Rows[0]["BName"]);
                    blogleftdesc.InnerHtml = Cutdesc1(ds.Tables[0].Rows[0]["Introduction"]);
                    lblleftblogdate.Text = Convert.ToString(ds.Tables[0].Rows[0]["CreatedDt"]);
                }
                if (ds.Tables[0].Rows.Count > 1)
                {
                    lnkBlogPostRight.NavigateUrl = "~/Blog/" + ds.Tables[0].Rows[1]["blogId"].ToString() + "/" + ds.Tables[0].Rows[1]["BName"].ToString() + "";
                    ltrBlogPostrigth.Text = Cutdesc1(ds.Tables[0].Rows[1]["BName"]);
                    blogrightdesc.InnerHtml = Cutdesc1(ds.Tables[0].Rows[1]["Introduction"]);
                    lblrightblogdate.Text = Convert.ToString(ds.Tables[0].Rows[1]["CreatedDt"]);
                }
            }
        }
        catch (Exception)
        {

        }
    }

    public string Cutdesc(object s)
    {
        string strlength = s.ToString();
        if (strlength.Length > 100)//checking the length of the string
        {
            strlength = strlength.Substring(0, 500);
            strlength += "....";
        }
        //HttpUtility.HtmlDecode("asd");
        return HttpUtility.HtmlDecode(strlength);
    }


    public string Cutdesc1(object s)
    {
        string strlength = s.ToString();
        if (strlength.Length > 500)//checking the length of the string
        {
            strlength = strlength.Substring(0, 500);
            strlength += "....";
        }
        //HttpUtility.HtmlDecode("asd");
        return HttpUtility.HtmlDecode(strlength);
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
                //HyperLink hyperlink = e.Item.FindControl("A1") as HyperLink;
                //hyperlink.NavigateUrl = Response.Redirect(GetRouteUrl("ProductDisplay", new { folderName = "" + BlogID + "", BName = "" + lnkbtn.Text.ToString().Trim().Replace(" ", "-") + "" }));
                lstVwProd.DataSource = objDataAccess.getDataSetQuery("SELECT p.name,p.productid,c.folderName,p.pageName,'~/Products/'+c.folderName+'/'+p.pageName as PageUrl FROM mproduct p JOIN mcategory c ON c.categoryid=p.categoryId AND c.activeflag='1' AND c.DeleteFlage='A' WHERE p.activeflag='1' AND p.categoryId=" + hdncateId.Value);
                lstVwProd.DataBind();
            }
        }
        catch (Exception)
        {

        }
    }


    protected void listproduct_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            DataRowView drv = (DataRowView)dataItem.DataItem;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HyperLink hyperlink = e.Item.FindControl("hyplinkprod") as HyperLink;
                hyperlink.NavigateUrl = GetRouteUrl("ProductDisplay", new { folderName = "" + drv["folderName"].ToString() + "", ProductName = "" + drv["pageName"].ToString().Trim().Replace(" ", "-") + "" });
                //lstVwProd.DataSource = objDataAccess.getDataSetQuery("SELECT p.name,p.productid,'Products/'+c.folderName+'/'+p.pageName as PageUrl FROM mproduct p JOIN mcategory c ON c.categoryid=p.categoryId AND c.activeflag='1' AND c.DeleteFlage='A' WHERE p.activeflag='1' AND p.categoryId=" + hdncateId.Value);
                //lstVwProd.DataBind();
            }
        }
        catch (Exception)
        {

        }
    }
}