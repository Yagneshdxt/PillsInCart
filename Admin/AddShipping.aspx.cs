using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
//using System.Windows.Forms;

public partial class Admin_AddShipping : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
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
            bindtxtshippincost();
            BindGrid("");
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
    protected void ClearControl()
    {
        try
        {
            txtshippingname.Text = "";
            txtshippingcharges.Text = "";
            txtavgdelperiod.Text = "";
            radioactive.Checked = true;
            BindGrid("");
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
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
        }
        catch (Exception)
        {

        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlCommand cmd = new SqlCommand("insert into ShippingMaste(ShippName,DilverPerd,ShippCharge,createdby,createddate,modifiedby,modifieddate,ActiveFlag) values(@ShippName,@DilverPerd,@ShippCharge,@UserID,getdate(),@UserID,getdate(),@ActiveFlag)", con);
            con.Open();
            cmd.Parameters.AddWithValue("@ShippName", txtshippingname.Text.ToString());
            cmd.Parameters.AddWithValue("@ShippCharge", txtshippingcharges.Text.ToString());
            cmd.Parameters.AddWithValue("@DilverPerd", txtavgdelperiod.Text.ToString());
            cmd.Parameters.AddWithValue("@ActiveFlag", i);
            cmd.Parameters.AddWithValue("@UserID", UserInfo.GetUserInfo().userId);
            cmd.ExecuteNonQuery();
            con.Close();

            AlertMsg("Shipping saved successfuly");
            BindGrid("");
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
            sqlQuer.Append("SELECT ShippingMstId,ShippName,DilverPerd,ShippCharge,createdby,createddate,modifiedby,modifieddate,ActiveFlag, case when ActiveFlag= 1 then 'Active' else 'Inactive' end as actInac from ShippingMaste");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            grdShipping.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdShipping.DataBind();
        }
        catch (Exception)
        {

        }
    }
    protected void bindtxtshippincost()
    {
        String str = "select * from mstGeneralCnst where typename = 'FreeShippingLimit'";
        SqlCommand cmd = new SqlCommand(str, con);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            txtshippingcost.Text = dr["name"].ToString();
        }
        con.Close();
    }

    protected void btnshippingcostupdate_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("update mstGeneralCnst set name=@name where typename = 'FreeShippingLimit'", con);
            //Passing parameters to query
            con.Open();
            cmd.Parameters.AddWithValue("@name", txtshippingcost.Text);
            cmd.ExecuteNonQuery();
            con.Close();

            AlertMsg("Shipping New Cost saved successfuly");
        }
        catch (Exception)
        {

        }
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnShippingDataID = grRow.FindControl("hdnShippingDataID") as HiddenField;
            Label lblshippinname = grRow.FindControl("lblshippinname") as Label;
            Label lblshipdeliver = grRow.FindControl("lblshipdeliver") as Label;
            Label lblshipcharge = grRow.FindControl("lblshipcharge") as Label;
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;

            txtshippingname.Text = lblshippinname.Text.Trim();
            txtshippingcharges.Text = lblshipcharge.Text.Trim();
            txtavgdelperiod.Text = lblshipdeliver.Text.Trim();
            radioactive.Checked = false;
            radiodeactive.Checked = false;
            if (hdnactiveflag.Value == "True")
            {
                radioactive.Checked = true;
            }
            else
            {
                radiodeactive.Checked = true;
            }
            hdnshippingid.Value = hdnShippingDataID.Value;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
            btnshippingcostupdate.Visible = false;
        }
        catch (Exception)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //Data insert logic
            int chkflag = 1;
            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@ShippName", txtshippingname.Text.Trim()),
                new SqlParameter("@DilverPerd", txtavgdelperiod.Text.Trim()),
                new SqlParameter("@ShippCharge",txtshippingcharges.Text.Trim()),
                new SqlParameter("@ActiveFlage", i),
                new SqlParameter("@ShippingMstId", Convert.ToInt32(hdnshippingid.Value))
                };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append("UPDATE ShippingMaste SET ShippName=@ShippName,DilverPerd=@DilverPerd,ShippCharge=@ShippCharge,ActiveFlag=@ActiveFlage where ShippingMstId=@ShippingMstId");
            chkflag = objDataAccess.DaExecNonQueryStrTrn(sqlQuer.ToString(), paras, sqlTrn, conObj);

            //Folder creation logic
            if (chkflag > 0)
            {
                if (chkflag == 0)
                {
                    sqlTrn.Rollback();
                    AlertMsg("Error updating the records");
                }
                else
                {
                    sqlTrn.Commit();
                    ResetContorl();
                    AlertMsg("Records updated successfuly");
                }
            }
            //close connnection
            if (conObj.State == System.Data.ConnectionState.Open)
                conObj.Close();
            BindGrid("");
            btnshippingcostupdate.Visible = true;
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


    protected void btnview_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sqlWher = new StringBuilder();
            sqlWher.Append(" WHERE 1=1 ");
            if (!String.IsNullOrEmpty(txtProductID.Text))
            {
                sqlWher.Append(" AND ShippName LIKE '%")
                    .Append(txtProductID.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtnamefilter.Text))
            {
                sqlWher.Append(" AND DilverPerd LIKE '%")
                    .Append(txtnamefilter.Text + "%'");
            }
            if (!String.IsNullOrEmpty(txtCategory.Text))
            {
                sqlWher.Append(" AND ShippCharge LIKE '%")
                    .Append(txtCategory.Text + "%'");
            }
            if (ddlStatusFil.SelectedValue != "--Select--")
            {
                sqlWher.Append(" AND ActiveFlag ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }
            BindGrid(sqlWher.ToString());
        }
        catch (Exception)
        {

        }
    }
    protected void grdShipping_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdShipping.PageIndex = e.NewPageIndex;
        BindGrid("");
    }
}
