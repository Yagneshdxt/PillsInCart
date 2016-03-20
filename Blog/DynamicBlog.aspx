<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicBlog.aspx.cs" Inherits="Blog_DynamicBlog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%-- ~~~~~~~~~~~~~~~~~~~~~~ Header Tag ~~~~~~~~~~~~~~~~~~~~~~ --%>
        <div id="divHeader">
            <div id="header-top">
                Generic viagra for ED treatment, viagra generic online for men
            </div>
            <div id="header">
                <div class="inner">
                    <!--Logo-->
                    <div class="logo">
                        <a id="A1" href="~/" runat="server">
                            <%--<asp:Image ImageUrl="~/images/logo.png" runat="server" />--%>
                            <img id="Img3" alt="" runat="server" />
                        </a>
                    </div>
                    <div class="header-lines ">
                        100% Safe & Secure<br />
                        Free Shipping Worldwide<br />
                        100% Satisfaction Guaranteed
                    </div>
                    <!--Options-->
                    <div class="options">
                        <div class="top">
                            <div class="links">
                                <div id="divLogin" runat="server" clientidmode="Static">
                                    <%--<img src="~/images/log-in.png" runat="server" alt="LogIn" />&nbsp;&nbsp;<a id="A2"
                                        href="~/Account/login.aspx" runat="server" class="logLnk">Log In</a> &nbsp;&nbsp;&nbsp;
                                    | &nbsp;&nbsp;&nbsp;<img id="Img2" src="~/images/register.png" runat="server" alt="Register" />&nbsp;&nbsp;
                                    <a id="A3" href="~/Account/createnewaccount.aspx" runat="server" class="logLnk">Register</a>--%>
                                </div>
                                <div id="divLogOut" runat="server" clientidmode="Static">
                                    <%--<img id="Img1" src="~/images/log-in.png" runat="server" alt="Welcome User" />&nbsp;&nbsp;
                                    <a href="#" class="logLnk">
                                        <asp:Label ID="lblUserName" runat="server"></asp:Label></a>
                                    <div class="divUserProfile">
                                        <ul>
                                            <li><a id="lnkShoppinSumm" href="~/UserProfile/ViewShoppingSummary.aspx" runat="server"
                                                class="ProfNavLink">Shopping History </a></li>
                                            <li><a id="lnkChangePass" href="~/Account/ChangePassword.aspx" runat="server" class="ProfNavLink">
                                                Change Password </a></li>
                                            <li><a id="lnkWriteTest" href="~/UserProfile/WriteReview.aspx" runat="server" class="ProfNavLink">
                                                Writ testimonial </a></li>
                                        </ul>
                                    </div>
                                    &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;<img id="Img4" src="~/images/register.png"
                                        runat="server" alt="LogOut" />&nbsp;&nbsp; <a href="#" style="display: inline;" class="logLnk"
                                            onclick="setLogOut();">Log out</a>--%>
                                </div>
                            </div>
                            <div class="ShopCart">
                                <span><a id="A4" href="../BuyProduct/viewcart.aspx" runat="server">Shopping Cart: $</a></span>
                                <asp:Label ID="lblCartValu" Text="0.00" runat="server" ClientIDMode="Static"></asp:Label>
                            </div>
                        </div>
                        <div class="botom">
                            <div class="social-icon">
                                <a href="#" class="socials facebook" title="Facebook">facebook</a> <a href="#" class="socials twitter"
                                    title="Twitter">twitter</a> <a href="#" class="socials skype" title="Skype">skype</a>
                            </div>
                            <div class="account">
                                <!-- BEGIN Comm100 Live Chat Button Code-->
                                <!--
                                <link href="http://chatserver.comm100.com/css/comm100_livechatbutton.css" rel="stylesheet"
                                    type="text/css" />
                                <div id="comm100_ChatButton">
                                    <div id="comm100_warp">
                                        <div id="comm100_dvhelp">
                                            <a class="comm100_ahelp_css" href="http://www.comm100.com/livechat/" onclick="comm100_Chat();return false;"
                                                target="_blank" title="Live Chat Software for Website">
                                                <img src="http://chatserver.comm100.com/BBS.aspx?siteId=42053&amp;planId=60&amp;partnerId=-1"
                                                    alt="Generic-cialis-rx.com Live Chat" title="Generic-cialis-rx.com Live Chat"
                                                    width="100" height="50" id="comm100_ButtonImage" style="border: 0px" /></a><script
                                                        src="http://chatserver.comm100.com/js/LiveChat.js?siteId=42053&amp;planId=60&amp;partnerId=-1"
                                                        type="text/javascript"></script><div id="comm100_track">
                                                            <a href="http://www.comm100.com/livechat/" target="_blank">
                                                        </div>
                                        </div>
                                        <div id="comm100_dvbox" class="comm100_dvbox_css" style="display: none;" onmouseover="this.style.display=''"
                                            onmouseout="this.style.display='none'">
                                            <div class="comm100_dvcontent_css">
                                                <p class="comm100_ptitle_css">
                                                    <b><a href="http://www.comm100.com/" target="_blank" class="comm100_atitle_css">Comm100</a>
                                                        Products:</b></p>
                                                <ul class="comm100_ulbox_css">
                                                    <li style="display: none;" class="comm100_onelinone">&nbsp;</li>
                                                    <li><a href="http://www.comm100.com/" target="_blank">Customer Service Software</a></li>
                                                    <li><a href="http://www.comm100.com/livechat/" target="_blank">Live Chat Software</a></li>
                                                    <li><a href="http://www.comm100.com/emailmarketingnewsletter/" target="_blank">Email
                                                        Marketing Software</a></li>
                                                    <li><a href="http://www.comm100.com/livechat/" target="_blank">Live Help</a></li>
                                                    <li><a href="http://www.comm100.com/emailmarketingnewsletter/" target="_blank">Email
                                                        Marketing</a></li>
                                                    <li><a href="http://www.comm100.com/livechat/" target="_blank">Live Support</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>-->
                                <!-- End Comm100 Live Chat Button Code -->
                            </div>
                            <div class="login">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Menu and search bar-->
            <div id="menubar">
                <div class="inner">
                    <ul class="navigation">
                        <li class="current"><a href="<%= Page.ResolveUrl("~/Index.aspx") %>">HOME</a> </li>
                        <li><a href="#">SHIPPING & REFUND POLICY</a> </li>
                        <li><a href="#">PRIVACY POLICY</a></li>
                        <li><a href="<%= Page.ResolveUrl("~/ContactUs") %>">CONTACT US</a></li>
                        <li><a href="<%= Page.ResolveUrl("~/Blog/BlogIndex.aspx") %>">Blog</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <%-- ~~~~~~~~~~~~~~~~~~~~~~ Link content ~~~~~~~~~~~~~~~~~~~~~~ --%>
        <div id="divLinkDiv">
            <asp:ListView runat="server" ID="lstRootCate" OnItemDataBound="lstRootCate_ItemDataBound">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnRootCateGoryId" runat="server" Value='<%# Eval("RootCateoryId") %>' />
                    <div class="span-6 widget text">
                        <div class="title">
                            <h3>
                                <%# Eval("CatName")%>
                            </h3>
                        </div>
                        <!-- Accordation -->
                        <div class="accordation-items type2 without-bottom-line sidebar-accordation">
                            <asp:ListView ID="listCategory" runat="server" OnItemDataBound="listCategory_ItemDataBound">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdncateId" Value='<%# Eval("categoryid") %>' runat="server" />
                                    <!-- Item -->
                                    <div class="accordation-item">
                                        <div class="accordation-item-header">
                                            <a href="#">
                                                <%# Eval("name") %>
                                            </a>
                                        </div>
                                        <div class="accordation-item-body">
                                            <ul class="list_type7 mt-4 grey-links">
                                                <asp:ListView runat="server" ID="lstVwProd">
                                                    <ItemTemplate>
                                                        <li><a id="A1" href='<%# Eval("PageUrl") %>' runat="server">
                                                            <%# Eval("name") %>
                                                        </a></li>
                                                    </ItemTemplate>
                                                </asp:ListView>
                                            </ul>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
                        <!-- /Accordation -->
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
        <%-- ~~~~~~~~~~~~~~~~~~~~~~ Testimonial List ~~~~~~~~~~~~~~~~~~~~~~ --%>
        <div id="tickerContainer">
            <dl id="ticker">
                <asp:ListView runat="server" ID="lstTestimonial">
                    <ItemTemplate>
                        <dt class="heading">
                            <asp:Label Text='<%# Eval("fName") %>' ID="lblName" runat="server" />
                        </dt>
                        <dd class="text">
                            <asp:Label ID="lblTest" Text='<%# Eval("Testimonial") %>' runat="server" />
                        </dd>
                    </ItemTemplate>
                </asp:ListView>
            </dl>
        </div>
    </div>
    <div id="divValidStatus">
        <asp:Label ID="lblStatusState" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
