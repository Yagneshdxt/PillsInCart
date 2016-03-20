using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;

public partial class Admin_ApproveTestimonial : System.Web.UI.Page
{
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
                StringBuilder sqlWher = new StringBuilder();
                sqlWher.Append(" WHERE DeleteFlag=1 ");
                BindGrid(sqlWher.ToString());
            }
        }
        catch (Exception)
        {

        }
    }

    protected void BindGrid(string sqlWhere)
    {
        try
        {

            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(" SELECT a.TestimonialID, a.Testimonial,b.fName, CONVERT(VARCHAR(10), a.CreatedDt ,105) Creteddt ")
                   .Append(" ,case a.ActiveFlag when 1 then 'Active' when 0 then 'Inactive' end tMoStatus, a.ActiveFlag ")
                   .Append(" FROM  Testimonials a ")
                   .Append(" JOIN userdetail b ON a.CreatedBy = b.userId ");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append(" ORDER BY a.CreatedDt DESC ");
            grdTestimonial.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdTestimonial.DataBind();
        }
        catch (Exception)
        {

        }
    }

    protected void btnview_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE DeleteFlag=1 ");
            if (!String.IsNullOrEmpty(txtTestimonial.Text))
            {
                sqlWher.Append(" AND a.Testimonial LIKE '%")
                    .Append(txtTestimonial.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtUserName.Text))
            {
                sqlWher.Append(" AND b.fName LIKE '%")
                    .Append(txtUserName.Text + "%'");
            }
            if (ddlStatusFil.SelectedValue != "00")
            {
                sqlWher.Append(" AND a.ActiveFlag ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }
            BindGrid(sqlWher.ToString());
        }
        catch (Exception)
        {

        }
    }


    protected void lnkupdate_Click(object sender, EventArgs e)
    {
        int chkFlage = 0;
        try
        {
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            LinkButton lnkupdate = sender as LinkButton;
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnTesMonialId = grRow.FindControl("hdnTestmonId") as HiddenField;
            if (lnkupdate.CommandArgument.Trim() == "True")
            {
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ModifiedBy",objUserInfo.userId),
                new SqlParameter("@ActiveFlag","0"),
                new SqlParameter("@TestId",hdnTesMonialId.Value)
            };
                chkFlage = objDataAccess.DaExecNonQueryStr(" update Testimonials set ActiveFlag = @ActiveFlag,ModifiedBy=@ModifiedBy where TestimonialID = @TestId ", param);
            }
            if (lnkupdate.CommandArgument.Trim() == "False")
            {
                SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ModifiedBy",objUserInfo.userId),
                new SqlParameter("@ActiveFlag","1"),
                new SqlParameter("@TestId",hdnTesMonialId.Value)
                };
                chkFlage = objDataAccess.DaExecNonQueryStr(" update Testimonials set ActiveFlag = @ActiveFlag,ModifiedBy=@ModifiedBy where TestimonialID = @TestId ", param);
            }

            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE DeleteFlag=1 ");
            BindGrid(sqlWher.ToString());
            AlertMsg("Records Updated Sucessfully.");
        }
        catch (Exception)
        {


        }
    }


    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        int chkFlage = 0;
        try
        {
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            LinkButton lnkupdate = sender as LinkButton;
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnTesMonialId = grRow.FindControl("hdnTestmonId") as HiddenField;
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ModifiedBy",objUserInfo.userId),
                new SqlParameter("@TestId",hdnTesMonialId.Value)
                };

            chkFlage = objDataAccess.DaExecNonQueryStr(" update Testimonials set DeleteFlag = 0,ModifiedBy=@ModifiedBy where TestimonialID = @TestId ", param);
            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE DeleteFlag=1 ");
            BindGrid(sqlWher.ToString());
            AlertMsg("Records Deleted Sucessfully.");
        }
        catch (Exception)
        {
        }
    }

    protected void grdTestimonial_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdTestimonial.PageIndex = e.NewPageIndex;
            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE DeleteFlag=1 ");
            BindGrid(sqlWher.ToString());
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
}