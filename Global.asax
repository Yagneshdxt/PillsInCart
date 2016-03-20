<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>
<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        RegisterRoutes(RouteTable.Routes);

    }

    // for routing 
    void RegisterRoutes(RouteCollection routes)
    {
        //routes.MapPageRoute("MensHealth", "mens-health-herbal.html", "~/Men's-health/mens-health-herbal.html");
        routes.MapPageRoute("BlogDetails", "Blog/{BlogId}/{*BName}", "~/Blog/blogdisplay.aspx", false);
        routes.MapPageRoute("BlogList", "BlogList/{CategoryID}/{*CategoryName}", "~/Blog/Bloglist.aspx", false);
        routes.MapPageRoute("BlogListYear", "BlogArchive/{year}/{*month}", "~/Blog/Bloglist.aspx", false);
        routes.MapPageRoute("BlogTags", "BlogTag/{TagID}", "~/Blog/Bloglist.aspx", false);
        //This for product display
        routes.MapPageRoute("ProductDisplay", "Product/{ProductName}", "~/ProductCreation/ProductDisplay.aspx", true);
        //routes.MapPageRoute("MensHealtha", "view-cart", "~/BuyProduct/viewcart.aspx");
        routes.MapPageRoute("Contactus", "ContactUs", "~/ContactUs.aspx", false);
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
