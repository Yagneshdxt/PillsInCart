<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Categories.ascx.cs" Inherits="Blog_Categories" %>
<ul>
    <li>
        <li><a class="home" href="<%= Page.ResolveUrl("~/Blog/BlogIndex.aspx") %>">Home</a></li>
    </li>
    <asp:ListView ID="lstallcategories" runat="server">
        <ItemTemplate>
            <li><a href='<%# GetRouteUrl("BlogList", new { CategoryID = Eval("CategoryID"), CategoryName = Eval("CategoryName").ToString().Trim().Replace(" ","-") })%>'>
                <%#Eval("CategoryName") %></a> </li>
        </ItemTemplate>
    </asp:ListView>
</ul>
