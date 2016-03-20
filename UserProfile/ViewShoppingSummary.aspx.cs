using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

public partial class UserProfile_ViewShoppingSummary : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Account/login.aspx", true);
        }

        try
        {
            BindGrid();
        }
        catch (Exception)
        {

        }
    }

    protected void BindGrid()
    {
        try
        {
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            SqlParameter[] param = new SqlParameter[]{
            new SqlParameter("@UserID",objUserInfo.userId)
            };
            StringBuilder SqlQuery = new StringBuilder();
            SqlQuery.Append(" SELECT 'ViewOrder.aspx?OrderHeaderId='+ CONVERT(varchar,OrderHeaderId) as path, ")
            .Append(" OrderHeaderId,ISNULL(DisplayId,'NULL') + '-[' + CONVERT(VARCHAR,OrderHeaderId) + ']'  as DisplayID, A.DisplayId as OrdId, ")
            .Append(" A.UserId,B.fName + ' ' + B.lName as Username,CreatedDate,( select CONVERT(DECIMAL(18,2),SUM(Price)) ")
            .Append(" FROM OrderDetail det where det.OrderHeaderId = A.OrderHeaderId ) as Total, ")
            .Append(" CASE WHEN IsProcessessedByAdmin = 0 then 'Declined'  when IsProcessessedByAdmin = 1 then 'Processed' else 'Pending' end as OrderStatus ")
            .Append(" from OrderHeader A INNER join userdetail B ON A.UserId = B.userId and a.ActiveFlag = 1 ")
             .Append(" Where A.UserId = @UserID ");
            gvShowOrders.DataSource = objDataAccess.getDataSetQuery(SqlQuery.ToString(),param);
            gvShowOrders.DataBind();
        }
        catch (Exception)
        {

        }
    }
}