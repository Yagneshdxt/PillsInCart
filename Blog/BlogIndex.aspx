<%@ Page Title="" Language="C#" MasterPageFile="~/Blog/Blogmaster.master" AutoEventWireup="true"
    CodeFile="BlogIndex.aspx.cs" Inherits="Blog_BlogIndex" %>

<%@ Register TagName="Tag" TagPrefix="uc1" Src="~/Blog/TagCloud.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/Blog.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/main.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bjqs-1.3.min.js" type="text/javascript"></script>
    <style type="text/css">
        #slider
        {
            margin: 10px 0px;
        }
        ul.bjqs-controls.v-centered li.bjqs-next a
        {
            right: 0;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#slider').bjqs({
                width: 450,
                height: 170,
                automatic: true,
                showcontrols: true,
                showmarkers: false,
                hoverpause: true
            });
        });
    </script>
    <div class="leftbox">
        <div id="slider">
            <ul class="bjqs">
                <li>
                    <img src="../data1/images/product1.jpg" alt="" title="" /></li>
                <li>
                    <img src="../data1/images/product2.jpg" alt="" title="" /></li>
                <li>
                    <img src="../data1/images/phoneorders.jpg" alt="" title="" /></li>
            </ul>
        </div>
        <asp:ListView ID="lstBlogs" runat="server">
            <ItemTemplate>
                <div class="postbox left">
                    <h1>
                        <a href='<%# GetRouteUrl("BlogList", new { CategoryID = Eval("CategoryID"), CategoryName = Eval("CategoryName").ToString().Trim().Replace(" ","-") })%>'>
                            <%#Eval("CategoryName") %></a>
                    </h1>
                    <div class="boxcontent">
                        <div class="thumb">
                            <a href='<%# GetRouteUrl("BlogDetails", new { BlogId = Eval("BlogId"), BName = Eval("BName").ToString().Trim().Replace(" ","-") })%>'>
                                <asp:Image ID="blogimg" Height="100px" Width="220px" runat="server" class="thumb"
                                    ImageUrl='<%#Eval("bImgOne") %>' AlternateText="" />
                            </a>
                        </div>
                        <h2>
                            <a href='<%# GetRouteUrl("BlogDetails", new { BlogId = Eval("BlogId"), BName = Eval("BName").ToString().Trim().Replace(" ","-") })%>'>
                                <%#Eval("BName") %>
                            </a>
                        </h2>
                        <h5>
                            Posted on&nbsp;
                            <%#Eval("Createddate")%>
                        </h5>
                        <div>
                            <%#Eval("Introduction")%>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <div class="postbox right">
                    <h1>
                        <a href="#">
                            <%#Eval("CategoryName") %></a>
                    </h1>
                    <div class="boxcontent">
                        <div class="thumb">
                            <a href='<%# GetRouteUrl("BlogDetails", new { BlogId = Eval("BlogId"), BName = Eval("BName").ToString().Trim().Replace(" ","-") })%>'>
                                <asp:Image ID="blogimg" Height="100px" Width="220px" runat="server" class="thumb"
                                    ImageUrl='<%#Eval("bImgOne") %>' AlternateText="" />
                            </a>
                        </div>
                        <h2>
                            <a href='<%# GetRouteUrl("BlogDetails", new { BlogId = Eval("BlogId"), BName = Eval("BName").ToString().Trim().Replace(" ","-") })%>'>
                                <%#Eval("BName") %>
                            </a>
                        </h2>
                        <h5>
                            Posted on&nbsp;
                            <%#Eval("Createddate")%>
                        </h5>
                        <div>
                            <%#Eval("Introduction")%>
                        </div>
                    </div>
                </div>
            </AlternatingItemTemplate>
        </asp:ListView>
    </div>
    <div id="sidebar" class="right">
        <div id="tagcloudwidget" runat="server" class="tagcloudwidget">
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
        <div class="rightwidget">
            <h3>
                Archives</h3>
            <div class="clear">
            </div>
            <div class="box">
                <ul>
                    <asp:ListView ID="lstvwArchives" runat="server">
                        <ItemTemplate>
                            <li>
                                <asp:LinkButton ID="lnkbtnArchive" runat="server" Text='<%#Eval("BlogDate") %>' OnClick="lnkbtnArchive_Click"
                                    CommandArgument='<%#Eval("createdYear") %>' CommandName='<%#Eval("CreatedMonth") %>'>
                                </asp:LinkButton>
                            </li>
                        </ItemTemplate>
                    </asp:ListView>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
