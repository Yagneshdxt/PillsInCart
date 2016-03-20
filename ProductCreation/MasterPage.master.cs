using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using System.Web.Services;


public partial class MasterPage : System.Web.UI.MasterPage
{
    DataAccess objDataAccess = new DataAccess();
    DataSet ds = new DataSet();
    Boolean chkFlag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.DataBind();
        Img3.Src = "http://www.pillsincart.com/images/logo.png";
        if (!IsPostBack)
        {
            BindContolData();
        }
    }

    protected void BindContolData()
    {
        try
        {
            //objDataAccess.getDataSetQuery("select categoryid,name,folderName from mcategory where activeflag=1");
            lstRootCate.DataSource = objDataAccess.getDataSetQuery(" SELECT DISTINCT RootCateoryId,CatName FROM RootCategory_Mst a LEFT JOIN mcategory b ON b.[type] = a.RootCateoryId AND b.ActiveFlag = 1  AND b.DeleteFlage = 'A' WHERE a.ActiveFlage = 1 AND a.DeleteFlage='A'");
            lstRootCate.DataBind();
            chkFlag = true;

            StringBuilder SqlQuery = new StringBuilder();
            SqlQuery.Append(" SELECT top 10 a.TestimonialID, a.Testimonial,b.fName, CONVERT(VARCHAR(10), a.CreatedDt ,105) Creteddt ")
                    .Append(" ,case a.ActiveFlag when 1 then 'Active' when 0 then 'Inactive' end tMoStatus, a.ActiveFlag  ")
                    .Append(" FROM  Testimonials a ")
                    .Append(" JOIN userdetail b ON a.CreatedBy = b.userId ")
                    .Append(" where a.ActiveFlag = 1 and a.DeleteFlag = 1");
            lstTestimonial.DataSource = objDataAccess.getDataSetQuery(SqlQuery.ToString());
            lstTestimonial.DataBind();
            chkFlag = true;

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
            chkFlag = true;
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

    [WebMethod]
    public static string LogOutUser()
    {
        string reStr = "";
        try
        {
            reStr = UserInfo.LogOutUser();
        }
        catch (Exception)
        {
            reStr = "";
        }
        return reStr;
    }
}

