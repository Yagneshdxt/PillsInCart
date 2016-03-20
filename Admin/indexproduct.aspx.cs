using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class Admin_indexproduct : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    DataAccess objDataAccess = new DataAccess();
    DataSet ds = new DataSet();
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
            bindlistproduct();
        }

    }
    protected void ClearControl()
    {
        try
        {
            ddlProductCat.Items.Clear();
            ddlSubCat.Items.Clear();
            ddlProduct.Items.Clear();
            txtdesc.Text = "";
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
            btnUpdate.Visible = false;
            btnCancel.Visible = false;

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
    protected void bindlistproduct()
    {
        try
        {
            string sqlQry = @"SELECT a.* FROM Index_Product_Map a 
                             JOIN mproduct b ON a.ProdcutId = b.productid and b.activeflag='1' AND b.DeleteFlage='A' 
                             JOIN mcategory c ON c.categoryid=b.categoryId AND c.ActiveFlag = 1  AND c.DeleteFlage = 'A'  
                             JOIN RootCategory_Mst d on c.[type] = d.RootCateoryId and d.ActiveFlage = 1 AND d.DeleteFlage='A'";
            SqlCommand cmd = new SqlCommand("select * from Index_Product_Map a join mproduct b on a.ProdcutId = b.productid", con);
            //SqlCommand cmd = new SqlCommand(sqlQry, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            listproduct.DataSource = dt;
            listproduct.DataBind();
        }
        catch (Exception)
        { }
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {

            LinkButton editlinkbutton = sender as LinkButton;
            HiddenField hdnproductid = editlinkbutton.NamingContainer.FindControl("hdnproductid") as HiddenField;
            HiddenField hdnIndexMapId = editlinkbutton.NamingContainer.FindControl("hdnIndexMapId") as HiddenField;
            HiddenField hdnActiveFlag = editlinkbutton.NamingContainer.FindControl("hdnActiveFlag") as HiddenField;
            hdnprdID.Value = hdnproductid.Value;
            hdnIndexId.Value = hdnIndexMapId.Value;
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
            fillControl(hdnIndexId.Value);
        }
        catch (Exception)
        {

        }
    }
    protected void fillControl(string IndexMapId)
    {
        try
        {
            //ddlmaincategory 
            DataSet ds = new DataSet();
            StringBuilder sqlQry = new StringBuilder();
            sqlQry.Append(" select d.RootCateoryId,c.categoryid,b.productid,a.IndexProdMapId,a.IndProDiscription from ")
                    .Append(" Index_Product_Map a ")
                    .Append(" join mproduct b on a.ProdcutId = b.productid ")
                    .Append(" join mcategory c on b.categoryId = c.categoryid ")
                    .Append(" join RootCategory_Mst d on d.RootCateoryId = c.[type] ")
                    .Append(" where a.IndexProdMapId = @IndexProdMapId ")
                //To bind root product
                    .Append(" select RootCateoryId,CatName from RootCategory_Mst where ActiveFlage = 1 ")
                    ;
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@IndexProdMapId",IndexMapId)
            };
            ds = objDataAccess.getDataSetQuery(sqlQry.ToString(), param);
            if ((ds != null) && (ds.Tables.Count > 0))
            {
                ddlProductCat.DataSource = ds.Tables[1];
                ddlProductCat.DataValueField = "RootCateoryId";
                ddlProductCat.DataTextField = "CatName";
                ddlProductCat.DataBind();
                ddlProductCat.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlProductCat.SelectedValue = ds.Tables[0].Rows[0]["RootCateoryId"].ToString();
                ddlProductCat_SelectedIndexChanged(null, null);
                ddlSubCat.SelectedValue = ds.Tables[0].Rows[0]["categoryid"].ToString();
                ddlSubCat_SelectedIndexChanged1(null, null);
                ddlProduct.SelectedValue = ds.Tables[0].Rows[0]["productid"].ToString();
                txtdesc.Text = ds.Tables[0].Rows[0]["IndProDiscription"].ToString();

            }


        }
        catch (Exception)
        {

        }
    }
    protected void ddlProductCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlProductCat.SelectedValue);
        ddlSubCat.DataSource = objDataAccess.getDataSetQuery("select categoryid,name from mcategory WHERE activeflag=1 AND DeleteFlage='A' and type=" + ID);
        ddlSubCat.DataValueField = "categoryid";
        ddlSubCat.DataTextField = "name";
        ddlSubCat.DataBind();
        ddlSubCat.Items.Insert(0, new ListItem("--Select--", "0"));
        
        //ddlProduct.DataSource = string.Empty;
        //ddlProduct.DataBind();
        ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
    }
    protected void ddlSubCat_SelectedIndexChanged1(object sender, EventArgs e)
    {
        int ID = Convert.ToInt32(ddlSubCat.SelectedValue);
        ddlProduct.DataSource = objDataAccess.getDataSetQuery("select productid,name from mproduct where activeflag=1 and categoryId=" + ID);
        ddlProduct.DataValueField = "productid";
        ddlProduct.DataTextField = "name";
        ddlProduct.DataBind();
        ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //Data insert logic
            int chkflag = 1;
            int i = 1;
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@ProdcutId",Convert.ToInt32(ddlProduct.SelectedValue)),
                    new SqlParameter("@IndexProdMapId",Convert.ToInt32(hdnIndexId.Value)),
                    new SqlParameter("@IndProDiscription", String.IsNullOrEmpty(txtdesc.Text.Trim())?" ":txtdesc.Text.Trim()),
                    new SqlParameter("@ActiveFlag", i),
                };

            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append("UPDATE Index_Product_Map set ProdcutId=@ProdcutId,IndProDiscription=@IndProDiscription,ActiveFlag=@ActiveFlag WHERE IndexProdMapId=@IndexProdMapId");
            chkflag = objDataAccess.DaExecNonQueryStr(sqlQuer.ToString(), paras);
            
            if (chkflag == 0)
            {
                AlertMsg("Error updating the records");
            }
            else
            {
                AlertMsg("Records updated successfuly");
            }

            ResetContorl();
            bindlistproduct();

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

}