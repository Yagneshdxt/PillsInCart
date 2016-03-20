<%@ Page Language="C#" MasterPageFile="~/Blog/Blogmaster.master" AutoEventWireup="true"
    CodeFile="Bloglist.aspx.cs" Inherits="Bloglist" %>

<%@ Register TagName="Tag" TagPrefix="uc1" Src="~/Blog/TagCloud.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/Blog.css" rel="stylesheet" type="text/css" />
    <link href="../../Styles/Blog.css" rel="stylesheet" type="text/css" />
    <link href="../../../Styles/Blog.css" rel="stylesheet" type="text/css" />
    <div class="leftbox" style="width: 550px">
        <div class="span-18 last">
            <div class="home-products">
                <div id="blog">
                    <asp:ListView ID="listblog" runat="server">
                        <ItemTemplate>
                            <div class="archive">
                                <div class="thumb left">
                                    <a href='<%# GetRouteUrl("BlogDetails", new { BlogId = Eval("BlogId"), BName = Eval("BName").ToString().Trim().Replace(" ","-") })%>'>
                                        <asp:Image ID="blogimg" Height="60px" Width="60px" runat="server" ImageUrl='<%#Eval("bImgOne") %>'
                                            AlternateText='<%#Eval("BName") %>' />
                                    </a>
                                </div>
                                <h2>
                                    <asp:LinkButton ID="lbtncreatedblog" Text='<%#Eval("BName") %>' OnClick="gotopage_Click"
                                        runat="server"></asp:LinkButton>
                                    <asp:HiddenField ID="hiddenblogid" Value='<%#Eval ("BlogId") %>' runat="server" />
                                </h2>
                                <%#Eval("Introduction") %>
                                <div class="clear">
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>
    <div id="sidebar" class="right">
        <div id="tagcloudwidget" runat="server" class="tagcloudwidget" style="width: 155px">
            <h3>
                Tag Cloud</h3>
            <div class="clear">
            </div>
            <uc1:Tag ID="tagcloud" runat="server" />
        </div>
        <div class="leftwidget">
            <h3>
                Recent Posts</h3>
            <div class="clear">
            </div>
            <div class="box">
                <ul>
                    <asp:ListView ID="lstvwrecentpost" runat="server">
                        <ItemTemplate>
                            <li><a href='<%# GetRouteUrl("BlogDetails", new { BlogId = Eval("BlogId"), BName = Eval("BName").ToString().Trim().Replace(" ","-") })%>'>
                                <%#Eval("BName") %></a></li>
                        </ItemTemplate>
                    </asp:ListView>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
