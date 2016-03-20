using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Blog_rss : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataAdapter da = new SqlDataAdapter("usp_GetBlogPostForRss", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        RepeaterRSS.DataSource = dt;
        RepeaterRSS.DataBind();
        //  sqlConn.Close();
    }
    protected string RemoveIllegalCharacters(object input)
    {
        // cast the input to a string  
        string data = input.ToString();

        // replace illegal characters in XML documents with their entity references  
        data = data.Replace("&", "&amp;");
        data = data.Replace("\"", "&quot;");
        data = data.Replace("'", "&apos;");
        data = data.Replace("<", "&lt;");
        data = data.Replace(">", "&gt;");
        return data;
    }
}