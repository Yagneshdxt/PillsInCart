using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Design;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class TagCloud : System.Web.UI.UserControl
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        SortedDictionary<string, int> tagsDictionary = new SortedDictionary<string, int>();
        SqlDataAdapter da = new SqlDataAdapter("usp_GetBlogTags", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        int postCount = 0;
        if (ds.Tables.Count > 0)
        {
            postCount = ds.Tables[0].Rows.Count;
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (tagsDictionary.ContainsKey(Convert.ToString(dr["TagId"])))
                    {
                        tagsDictionary[Convert.ToString(dr["TagId"])]++;
                    }
                    else
                    {
                        tagsDictionary.Add(Convert.ToString(dr["TagId"]), 1);
                    }

                }
            }
        }
        foreach (string s in tagsDictionary.Keys)
        {
            var tagname = ds.Tables[1].AsEnumerable().Where(rows => Convert.ToString(rows.Field<Int32>("TagId")) == s)
                .Select(row => row.Field<string>("Tagname")).FirstOrDefault();
            string tagInUrl = Server.UrlEncode(s);
            HyperLink link = new HyperLink();
            link.Text = tagname;
            link.NavigateUrl = GetRouteUrl("BlogTags", new { TagID = "" + s + "" });
            int tagCount = 0;
            tagsDictionary.TryGetValue(s, out tagCount);
            link.CssClass = GetCssClass(tagCount, postCount);
            PlaceHolder1.Controls.Add(link);
            PlaceHolder1.Controls.Add(new LiteralControl("  "));
        }

    }

    private string GetCssClass(int tagCount, int postCount)
    {
        int result = (tagCount * 100) / postCount;
        if (result <= 20)
            return "TagSize1";
        if (result <= 40)
            return "TagSize2";
        if (result <= 60)
            return "TagSize3";
        if (result <= 80)
            return "TagSize4";
        if (result <= 100)
            return "TagSize5";
        else
            return "";
    }
}