<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DaynamicContent.aspx.cs"
    Inherits="DaynamicContent" %>

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
                            <img id="Img1" alt="" runat="server" />
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
                                    <img id="Img2" src="~/images/log-in.png" runat="server" alt="LogIn" />&nbsp;&nbsp;<a
                                        id="A2" href="~/Account/login.aspx" runat="server" class="logLnk">Log In</a>
                                    &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;<img id="Img3" src="~/images/register.png"
                                        runat="server" alt="Register" />&nbsp;&nbsp; <a id="A3" href="~/Account/createnewaccount.aspx"
                                            runat="server" class="logLnk">Register</a>
                                </div>
                                <div id="divLogOut" runat="server" clientidmode="Static">
                                    <img id="Img4" src="~/images/log-in.png" runat="server" alt="Welcome User" />&nbsp;&nbsp;
                                    <a href="#" class="logLnk">
                                        <asp:Label ID="lblUserName" runat="server"></asp:Label></a>
                                    <div class="divUserProfile">
                                        <ul>
                                            <li><a id="lnkShoppinSumm" href="~/UserProfile/ViewShoppingSummary.aspx" runat="server"
                                                class="ProfNavLink">Shopping History </a></li>
                                            <li><a id="lnkChangePass" href="~/Account/ChangePassword.aspx" runat="server" class="ProfNavLink">
                                                Change Password </a></li>
                                            <li><a id="lnkWriteTest" href="~/UserProfile/WriteReview.aspx" runat="server" class="ProfNavLink">
                                                Write testimonial </a></li>
                                            <li><a id="A5" href="~/Affiliate/AffiliateDetails.aspx" runat="server" class="ProfNavLink">
                                                Affiliates Details </a></li>
                                        </ul>
                                    </div>
                                    &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;<img id="Img5" src="~/images/register.png"
                                        runat="server" alt="LogOut" />&nbsp;&nbsp; <a href="#" style="display: inline;" class="logLnk"
                                            onclick="setLogOut();">Log out</a>
                                </div>
                            </div>
                            <div class="ShopCart">
                                <span><a id="A4" href="~/BuyProduct/viewcart.aspx" runat="server">Shopping Cart: $</a></span>
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
                                </div> -->
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
                                                <asp:ListView runat="server" ID="lstVwProd" OnItemDataBound="listproduct_ItemDataBound">
                                                    <ItemTemplate>
                                                        <li>
                                                            <asp:HyperLink ID="hyplinkprod" runat="server">
                                                        <%# Eval("name") %>
                                                            </asp:HyperLink></li>
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
        <%-- ~~~~~~~~~~~~~~~~~~~~~~ Testimonial List ~~~~~~~~~~~~~~~~~~~~~~ --%>
        <div id="divIndexProductImg">
            <div class="span-18 space">
                <!--products-->
                <div id="products-wrap-home">
                    <!--left products -->
                    <div class="left-product">
                        <div class="product-name">
                            <h1>
                                <asp:Label Text="" ID="lblproductName1" runat="server" />
                            </h1>
                        </div>
                        <div class="image-pri">
                            <div class="image">
                                <asp:Image runat="server" ID="ImgProd1" alt="Image" />
                            </div>
                            <div class="prize">
                                <div class="prize per-pill">
                                    Our Price</div>
                                <div class="prize per-pill-prize">
                                    $<asp:Label Text="" ID="lblprodPrice1" runat="server" />
                                </div>
                                <div class="know-buy">
                                    <a href="#" runat="server" id="ProdLink1">
                                        <img src="images/add-cart.png" width="78" height="22" style="border: none" alt="Buy" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--middle products -->
                    <div class="middle-product">
                        <div class="product-name">
                            <h1>
                                <asp:Label Text="" ID="lblprod2" runat="server" />
                            </h1>
                        </div>
                        <div class="image-pri">
                            <div class="image">
                                <asp:Image ID="imgProd2" runat="server" alt="Image" />
                            </div>
                            <div class="prize">
                                <div class="prize per-pill">
                                    Per pill</div>
                                <div class="prize per-pill-prize">
                                    $<asp:Label Text=" " runat="server" ID="lblProPrice2" />
                                </div>
                                <div class="know-buy">
                                    <a href="" runat="server" id="ProdLink2">
                                        <img src="images/add-cart.png" width="78" height="22" style="border: none" alt="buy" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--last products -->
                    <div class="last-product">
                        <div class="product-name">
                            <h1>
                                <asp:Label Text="" ID="lblProdName3" runat="server" />
                            </h1>
                        </div>
                        <div class="image-pri">
                            <div class="image">
                                <asp:Image runat="server" ID="ImgProd3" alt="Image" />
                            </div>
                            <div class="prize">
                                <div class="prize per-pill">
                                    Per pill</div>
                                <div class="prize per-pill-prize">
                                    $<asp:Label Text="" ID="lblPrice3" runat="server" />
                                </div>
                                <div class="know-buy">
                                    <a href="#" runat="server" id="lnkbuy3">
                                        <img src="images/add-cart.png" width="78" height="22" style="border: none" alt="Buy" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--last products close-->
                </div>
                <!--products close-->
            </div>
            <div class="span-18 space last">
                <div id="products-wrap-home">
                    <!--left products -->
                    <div class="left-product">
                        <div class="product-name">
                            <h1>
                                <asp:Label Text="" ID="lblprodName4" runat="server" />
                            </h1>
                        </div>
                        <div class="image-pri">
                            <div class="image">
                                <asp:Image runat="server" ID="imgProd4" alt="Image" />
                            </div>
                            <div class="prize">
                                <div class="prize per-pill">
                                    Per pill</div>
                                <div class="prize per-pill-prize">
                                    $<asp:Label Text="" ID="lblPrice4" runat="server" />
                                </div>
                                <div class="know-buy">
                                    <a href="#" runat="server" id="lnk4">
                                        <img src="images/add-cart.png" width="78" height="22" style="border: none" alt="Buy" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--middle products -->
                    <div class="middle-product">
                        <div class="product-name">
                            <h1>
                                <asp:Label Text="" ID="lblProduct5" runat="server" />
                            </h1>
                        </div>
                        <div class="image-pri">
                            <div class="image">
                                <asp:Image runat="server" ID="ImgProd5" alt="Image" />
                            </div>
                            <div class="prize">
                                <div class="prize per-pill">
                                    Per pill</div>
                                <div class="prize per-pill-prize">
                                    $<asp:Label Text="" ID="lblProdPrice5" runat="server" />
                                </div>
                                <div class="know-buy">
                                    <a href="#" runat="server" id="lnkProduct5">
                                        <img src="images/add-cart.png" width="78" height="22" style="border: none" alt="Buy" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--last products -->
                    <div class="last-product">
                        <div class="product-name">
                            <h1>
                                <asp:Label Text="" ID="lblProduct6" runat="server" />
                            </h1>
                        </div>
                        <div class="image-pri">
                            <div class="image">
                                <asp:Image runat="server" ID="Image6" alt="Image" />
                            </div>
                            <div class="prize">
                                <div class="prize per-pill">
                                    Per pill</div>
                                <div class="prize per-pill-prize">
                                    $<asp:Label Text="" ID="lblProdPrice6" runat="server" />
                                </div>
                                <div class="know-buy">
                                    <a href="#" runat="server" id="lnkBuy6">
                                        <img src="images/add-cart.png" width="78" height="22" style="border: none" alt="Buy" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--last products close-->
                </div>
            </div>
        </div>
        <%-- ~~~~~~~~~~~~~~~~~~~~~~ Blog post ~~~~~~~~~~~~~~~~~~~~~~ --%>
        <div id="blogboxwrap">
            <div class="left">
                <h2>
                    <asp:HyperLink NavigateUrl="" runat="server" ID="lnkBlogPostleft">
                        <asp:Literal Text="" ID="ltrBlogPostleft" runat="server" />
                    </asp:HyperLink></h2>
                <h6>
                    Posted On:
                    <asp:Label ID="lblleftblogdate" runat="server"></asp:Label>
                </h6>
                <div id="blogleftdesc" runat="server">
                </div>
            </div>
            <div class="right">
                <h2>
                    <asp:HyperLink NavigateUrl="" runat="server" ID="lnkBlogPostRight">
                        <asp:Literal Text="" ID="ltrBlogPostrigth" runat="server" />
                    </asp:HyperLink></h2>
                <h6>
                    Posted On:
                    <asp:Label ID="lblrightblogdate" runat="server"></asp:Label>
                </h6>
                <div id="blogrightdesc" runat="server">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
