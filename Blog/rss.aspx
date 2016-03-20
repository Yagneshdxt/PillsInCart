<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rss.aspx.cs" Inherits="Blog_rss" %>

<asp:repeater id="RepeaterRSS" runat="server">  
        <HeaderTemplate>  
           <rss version="2.0">  
                <channel>  
                    <title>Pills in Cart</title>  
                    <link>http://www.pillsincart.com/Blog/rss.aspx</link>  
                    <description>  
                    Short description of the website.  
                    </description>  
        </HeaderTemplate>  
        <ItemTemplate>  
            <item>  
                <title><%# RemoveIllegalCharacters(DataBinder.Eval(Container.DataItem, "BName"))%></title>
                   <link>http://www.pillsincart.com/Blog/<%#Eval("BlogId")%>/<%#Eval("BName").ToString().Trim().Replace(" ", "-")%></link>  
                <pubDate><%# String.Format("{0:R}", DataBinder.Eval(Container.DataItem, "DatePublished"))%></pubDate>  
                <description><%# RemoveIllegalCharacters(DataBinder.Eval(Container.DataItem, "Introduction"))%></description>  
        </item>  
        </ItemTemplate>  
        <FooterTemplate>  
                </channel>  
            </rss>    
        </FooterTemplate>  
</asp:repeater>
