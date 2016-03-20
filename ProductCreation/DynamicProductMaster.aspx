<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicProductMaster.aspx.cs"
    Inherits="DynamicProductMaster" EnableViewState="false" %>

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
                        <a href="~/" runat="server">
                            <%--<asp:Image ImageUrl="~/images/logo.png" runat="server" />--%>
                            <%--<img id="Img3" src="images/logo.png" alt="" runat="server" />--%>
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
                                    <img src="~/images/log-in.png" runat="server" alt="LogIn" />&nbsp;&nbsp;<a href="~/Account/login.aspx"
                                        runat="server" class="logLnk">Log In</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;<img
                                            src="~/images/register.png" runat="server" alt="Register" />&nbsp;&nbsp;
                                    <a href="~/Account/createnewaccount.aspx" runat="server" class="logLnk">Register</a>
                                </div>
                                <div id="divLogOut" runat="server" clientidmode="Static">
                                    <img id="Img1" src="~/images/log-in.png" runat="server" alt="Welcome User" />&nbsp;&nbsp;
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
                                    &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;<img id="Img2" src="~/images/register.png"
                                        runat="server" alt="LogOut" />&nbsp;&nbsp; <a href="#" style="display: inline;" class="logLnk"
                                            onclick="setLogOut();">Log out</a>
                                </div>
                            </div>
                            <div class="ShopCart">
                                <span><a href="../BuyProduct/viewcart.aspx" runat="server">Shopping Cart: $</a></span>
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
                        <li><a href="<%= Page.ResolveUrl("~/ContactUs.aspx") %>">CONTACT US</a></li>
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
                                                        <li>
                                                            <asp:LinkButton ID="linkbtnprod" runat="server" OnClick="gotopage_Click" Text='<%# Eval("name") %>'
                                                                CommandArgument='<%#Eval("folderName") %>' CommandName='<%#Eval("pageName") %>'></asp:LinkButton></li>
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
        <%-- ~~~~~~~~~~~~~~~~~~~~~~~~ Product Master ~~~~~~~~~~~~~~~~~~~~~~ --%>
        <div id="productContent">
            <div class="span-18">
                <!--products-->
                <div id="products-wrap-home">
                    <div class="product-img-dis">
                        <div class="top">
                            <h1>
                                <asp:Label Text="" ID="lblShortName" runat="server" /></h1>
                        </div>
                        <div class="botom">
                            <div class="left">
                                <div class="image-pri">
                                    <div class="image">
                                        <asp:Image ImageUrl="" ID="imgLogoImg" runat="server" />
                                    </div>
                                    <div class="prize">
                                        <div class="prize per-pill">
                                            Our Price</div>
                                        <div class="prize per-pill-prize">
                                            $<asp:Label Text="" ID="logPrice" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="right">
                                <table class="short-table white" style="width: 100%" cellspacing="0" cellpadding="0">
                                    <thead>
                                        <tr>
                                            <th class="color-heading">
                                                Safe & Secure Shopping
                                            </th>
                                            <th>
                                                Worldwide Free Shipping
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                Generic Name :
                                                <asp:Label Text="" ID="lblGenericName" runat="server" />
                                            </td>
                                            <td>
                                                Brand Name:
                                                <asp:Label Text="" ID="lblBrandName" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Strength(s):
                                                <asp:Label Text="" ID="lblStrength" runat="server" />
                                            </td>
                                            <td>
                                                Expiry :
                                                <asp:Label Text="" ID="lblExpiry" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Average Delivery:
                                                <asp:Label Text="" ID="lblAvrDele" runat="server" />
                                            </td>
                                            <td>
                                                Price:
                                                <asp:Label Text="" ID="lblPrice" runat="server" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!--products close-->
                <div class="text-box" style="height: 385px; overflow-y: scroll">
                    <p>
                        <asp:Label Text="" ID="lblDescription" runat="server" />
                    </p>
                </div>
            </div>
            <div class="span-18">
                <div class="ClsaddImgHold">
                    <asp:Image ImageUrl="" ID="imgAddImg" runat="server" AlternateText="addImg" />
                </div>
                <p>
                </p>
            </div>
            <div class="span-18 ">
                <asp:GridView runat="server" ID="grdProdPrice" AutoGenerateColumns="false" class="short-table blue"
                    Style="width: 100%" CellSpacing="0" CellPadding="0">
                    <Columns>
                        <asp:TemplateField HeaderText="Quantity" ItemStyle-CssClass="features" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <b>
                                    <asp:Label ID="lblQuantity" Text='<%# Eval("Quantity") %>' runat="server" /></b>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Strength" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblStrength" Text='<%# Eval("Strength") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="New Price" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblNewPrice" Text='<%# Eval("NewPrice") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="New Unit Price" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblNewUnitPrice" Text='<%# Eval("NewUnitPrice") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Old Price" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblOldPrice" Text='<%# Eval("OldPrice") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Old Unit Price" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lbloldUnitPrice" Text='<%# Eval("oldUnitPrice") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Free Shipping" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblfreeShipping" Text='<%# Eval("freShip") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <%--href=' "../BuyProduct/viewcart.aspx?pID=" + Eval("ProdPriceId").ToString()  '--%>
                                <asp:LinkButton ID="LnkAddtoCart" Text="" runat="server" href="#" OnClientClick='<%# "return AddProdPriceToCart(" + Eval("ProdPriceId").ToString() + ")" %>'>
                                <asp:image imageurl="~/images/buy.png" AlternateText="Buy Now" runat="server" />
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Product Description Accordian ~~~~~~~~~~~~~~~~~~~~~~--%>
        <div id="divProdaccoridan">
            <div class="span-18">
                <div id="tab-wrap">
                    <!-- Accordation -->
                    <div class="accordation-items type1">
                        <asp:ListView runat="server" ID="lstProductDes">
                            <ItemTemplate>
                                <div class="accordation-item">
                                    <div class="accordation-item-header pt-sans">
                                        <a href="#">
                                            <asp:Literal Text='<%# Eval("DesHeading") %>' ID="ltrProHeading" runat="server" />
                                        </a>
                                    </div>
                                    <div class="accordation-item-body">
                                        <div id="scroll">
                                            <div id="scrollcontent">
                                                <p>
                                                    <asp:Literal Text='<%# HttpUtility.HtmlDecode(Eval("prodDescription").ToString()) %>'
                                                        ID="ltrDescription" runat="server" />
                                                </p>
                                                <%--<a class="button" href="#">Read more</a>--%>
                                            </div>
                                            <div id="scrollbar">
                                                <div id="scroller" class="scroller">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <!-- /Accordation -->
                </div>
            </div>
        </div>
    </div>
    <div id="divValidStatus">
        <asp:Label ID="lblStatusState" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
