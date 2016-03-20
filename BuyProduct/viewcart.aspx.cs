using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;

public partial class viewcart : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    public string OrderId
    {
        get
        {
            string ordIdret = "";
            if (Session["OrdId"] != null)
            {
                ordIdret = Session["OrdId"].ToString();
            }
            return ordIdret;
        }
        set
        {
            OrderID.SetOrderID(value);
            //Session["OrdId"] = value;
        }
    }

    public string AffiliateID
    {
        get
        {
            string AffID = "";
            AffID = OrderID.getAffiliateId();
            return AffID;
        }
    }


    /*
    public string OrderId
    {
        get
        {
            string ordIdret = "";
            if (Request.Cookies["OrdId"] != null)
            {
                ordIdret = Request.Cookies["OrdId"].Value;
            }
            return ordIdret;
        }
        set
        {
            if (Request.Cookies["OrdId"] == null)
            {
                // Whenever user visit this page or move away from the page lets write the cookie 
                // that tracks the last visit time
                HttpCookie cookie = new HttpCookie("OrdId");
                //Set the cookie value
                cookie.Value = value;
                //make it a persistant cookie by setting the expiration time DateTime.Now.AddDays(1);
                cookie.Expires = DateTime.MinValue;
                //Push the cookie to the client computer.
                Response.Cookies.Add(cookie);
            }
            else
            {
                Response.Cookies["OrdId"].Value = value;
                Response.Cookies["OrdId"].Expires = DateTime.MinValue;
            }
        }
    }*/


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindData();
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

    protected void BindData()
    {
        string chkFlag = "";
        try
        {
            if (Request.Form["hdnPrPriceId"] != null)
            {
                SqlParameter[] paras = new SqlParameter[6];
                paras[0] = new SqlParameter("@ProdPriceId", Request.Form["hdnPrPriceId"].ToString());
                if (UserInfo.GetUserInfo() != null)
                {
                    paras[1] = new SqlParameter("@UserId", UserInfo.GetUserInfo().userId);
                }
                else
                {
                    paras[1] = new SqlParameter("@UserId", "1");
                }
                paras[2] = new SqlParameter("@FunType", hdnActionType.Value == "" ? "I" : hdnActionType.Value);
                if (!String.IsNullOrEmpty(OrderId))
                {
                    paras[3] = new SqlParameter("@OrderHeaderId", OrderId);
                }
                else
                {
                    paras[3] = new SqlParameter("@OrderHeaderId", "0");
                }
                paras[4] = new SqlParameter("@msgOut", SqlDbType.VarChar, 10000);

                if (!String.IsNullOrEmpty(AffiliateID))
                {
                    paras[5] = new SqlParameter("@AffiliatId", Convert.ToInt64(AffiliateID));
                }
                else
                {
                    paras[5] = new SqlParameter("@AffiliatId", 0);
                }

                chkFlag = objDataAccess.ExecSPWithOutPutPara("Cart_IUD", paras, 4, System.Data.CommandType.StoredProcedure);

                if (!String.IsNullOrEmpty(chkFlag))
                {
                    OrderId = chkFlag.Split('|')[1].ToString();
                }
                //This to remove affiliate Id 
                OrderID.RemoveAffId();
            }



            BindCartGrid();
        }
        catch (Exception)
        {

        }
    }


    protected void BindCartGrid()
    {
        try
        {
            DataTable dt = new DataTable();
            Int64? OrdId = null, UsrId = null;
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            if (objUserInfo != null)
                UsrId = objUserInfo.userId;
            if ((OrderId != null) && (!String.IsNullOrEmpty(OrderId)))
            {
                OrdId = Convert.ToInt64(OrderId);
            }

            dt = objDataAccess.GetCartItems(OrdId, UsrId);
            if ((dt != null) && (dt.Rows.Count > 0))
            {
                grdCartData.DataSource = dt;
                grdCartData.DataBind();

                Label lblFootrTotal = grdCartData.FooterRow.FindControl("lblFootrTotal") as Label;
                lblFootrTotal.Text = String.Format("{0:0.00}", dt.Compute("SUM(Price)", "1=1")); //ds.Tables[0].Rows[0]["TotalAmount"].ToString();

                //This to set order Id if user directly comes to the shopping cart.
                if ((OrderId == null) || (String.IsNullOrEmpty(OrderId)))
                {
                    OrderId = dt.Rows[0]["OrderHeaderId"].ToString();
                }
            }
            else
            {
                grdCartData.DataSource = null;
                grdCartData.DataBind();
            }

            //string SqlQuer = " select a.OrdeDetailId,a.OrderHeaderId,  b.* ,c.logoimgpath from OrderDetail a join mstProductPrice b on b.productid = a.ProductId join mproduct c on a.productid=b.productid where a.OrderHeaderId = @OrderHeaderId";
        }
        catch (Exception)
        {

        }
    }
    protected void grdCartData_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlQuantity = e.Row.FindControl("ddlQuantity") as DropDownList;
                HiddenField hdnproductid = e.Row.FindControl("hdnproductid") as HiddenField;
                HiddenField hdnProdPriceId = e.Row.FindControl("hdnProdPriceId") as HiddenField;
                SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@productid",hdnproductid.Value)
                };

                string SqlQuery = " SELECT ProdPriceId,quantity from mstProductPrice WHERE productid=@productid and activeflag = 1 ";
                DataSet ds = new DataSet();
                ds = objDataAccess.getDataSetQuery(SqlQuery, paras);
                if ((ds != null) && (ds.Tables.Count > 0))
                {
                    ddlQuantity.DataSource = ds;
                    ddlQuantity.DataValueField = "ProdPriceId";
                    ddlQuantity.DataTextField = "quantity";
                    ddlQuantity.DataBind();
                    ddlQuantity.SelectedValue = hdnProdPriceId.Value;
                }
            }
        }
        catch (Exception)
        {

        }
    }
    protected void lnkRemove_Click(object sender, EventArgs e)
    {
        string chkFlag = "";
        try
        {

            GridViewRow grdRw = (GridViewRow)((LinkButton)sender).NamingContainer;
            HiddenField hdnOrdeDetailId = grdRw.FindControl("hdnOrdeDetailId") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
               new SqlParameter("@OrderDetailId", hdnOrdeDetailId.Value),
               new SqlParameter("@OrderHeaderId", String.IsNullOrEmpty(OrderId)?"0":OrderId),
               new SqlParameter("@FunType",  "D"),
               new SqlParameter("@msgOut", SqlDbType.VarChar, 100)
            };
            chkFlag = objDataAccess.ExecSPWithOutPutPara("Cart_IUD", paras, 3, System.Data.CommandType.StoredProcedure);
            if (!String.IsNullOrEmpty(chkFlag))
            {
                if (!String.IsNullOrEmpty(chkFlag.Split('|')[1]) && (chkFlag.Split('|')[1].ToString() == "0"))
                {

                    OrderId = "";
                    Session.Remove("OrdId");

                }
            }

            BindCartGrid();
        }
        catch (Exception)
        {

        }
    }
    protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string chkFlag = "";
            GridViewRow grdRw = (GridViewRow)((DropDownList)sender).NamingContainer;
            DropDownList ddlQuantity = sender as DropDownList;
            HiddenField hdnOrdeDetailId = grdRw.FindControl("hdnOrdeDetailId") as HiddenField;
            Int64 UserId = 1;
            if (UserInfo.GetUserInfo() != null)
            {
                  UserId   = UserInfo.GetUserInfo().userId;
            }
            SqlParameter[] paras = new SqlParameter[]{
               new SqlParameter("@OrderDetailId", hdnOrdeDetailId.Value),
               new SqlParameter("@OrderHeaderId", String.IsNullOrEmpty(OrderId)?"0":OrderId),
               new SqlParameter("@FunType",  "U"),
               new SqlParameter("@UserId", UserId),
               new SqlParameter("@ProdPriceId",  ddlQuantity.SelectedValue),
               new SqlParameter("@msgOut", SqlDbType.VarChar, 100)
            };
            chkFlag = objDataAccess.ExecSPWithOutPutPara("Cart_IUD", paras, 5, System.Data.CommandType.StoredProcedure);
            BindCartGrid();
        }
        catch (Exception)
        {

        }
    }
    protected void CheckOut_Click(object sender, ImageClickEventArgs e)
    {
        string payTyp = ((ImageButton)sender).CommandArgument;
        Response.Redirect("~/BuyProduct/checkout.aspx?OrderId=" + (String.IsNullOrEmpty(OrderId) ? "0" : OrderId) + "&PayTp=" + payTyp);
    }
    protected void btnChkOut_Click(object sender, EventArgs e)
    {
        string payTyp = ((ImageButton)sender).CommandArgument;
        Response.Redirect("~/BuyProduct/checkout.aspx?OrderId=" + (String.IsNullOrEmpty(OrderId) ? "0" : OrderId) + "&PayTp=" + payTyp);
    }
}