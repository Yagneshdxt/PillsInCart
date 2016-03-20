<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="Scripts/scroll.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.7.min.js" type="text/javascript"></script>
    <!--<script src="Scripts/beautymind.js" type="text/javascript"></script>-->
    <link rel="stylesheet" href="Styles/style.css" type="text/css" media="screen, projection" />
    <script src="Scripts/bjqs-1.3.min.js" type="text/javascript"></script>
    <link href="Styles/main.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {

            //$("#divheaderCont").load("Header.html");
            //$("#divBodyCont").load();
            $("#divFooterCont").load("Footer.html");
            //            $("#divCommBody").load("bodyComman.html", function () {
            //                tabNavi('.tab-navi');
            //            });
            tabNavi('.tab-navi');
            //            $.ajax(
            //            {
            //                type: "GET",
            //                url: "DaynamicContent.aspx",
            //                success: function (result) {
            //                    $("#divheaderCont").html($(result).find('#divHeader').html());
            //                    $("#divLinkDiv").html($(result).find('#divLinkDiv').html());
            //                    $("#tickerContainer").html($(result).find('#tickerContainer').html());
            //                    $("#divIndexProductImg").html($(result).find('#divIndexProductImg').html());
            //                    $("#blog-box-wrap").html($(result).find('#blogboxwrap').html());
            //                },
            //                error: function (result) {
            //                    alert("error");
            //                }
            //            });
            $(".accordation-item-header").live('click', function (event) {
                //event.preventDefault();
                $('.accordation-item-body').slideUp('normal');
                if ($(this).parent().find('.accordation-item-body').is(':hidden') == true) {
                    $(this).parent().find('.accordation-item-body').slideDown('normal');
                }
                return false;
            });
        });

        function tabNavi(tab) {
            if ($(tab + ' .has-submenu a').size()) {
                $('.wrapper').hover(function (e) {

                });

                $(tab + ' a:not(.submn)').hover(function (e) {
                    if (!$(this).hasClass('active')) {
                        p = $(this).parents(tab).find('a.active').removeClass('active').attr('href');
                        $(this).parents(tab).find('a.active-trail').removeClass('active-trail');
                        $(this).parents(tab).find('li ul').hide();
                        $(p).hide()
                        $($(this).addClass('active').attr('href')).show();

                        $(this).parents('li.has-submenu').find('a.active').addClass('active-trail');
                    }
                    return false;
                });
            }
        }

        function setLogOut() {
            $.ajax({
                type: "POST",
                url: "PageMethods.aspx/LogOutUser",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d == "Success") {
                        // window.location.reload();
                        $('#divLogin').attr("style", "display:block");
                        $('#divLogOut').attr("style", "display:none");
                        $('#lblCartValu').text("0.00");
                        $("#lblCartValu").html("0.00");
                    }
                },
                error: function (result) {
                    //window.location.href = "../index.html"
                }
            });
        }
    </script>
    <!--Start of Zopim Live Chat Script-->
    <script type="text/javascript">
        window.$zopim || (function (d, s) {
            var z = $zopim = function (c) { z._.push(c) }, $ = z.s =
d.createElement(s), e = d.getElementsByTagName(s)[0]; z.set = function (o) {
    z.set.
_.push(o)
}; z._ = []; z.set._ = []; $.async = !0; $.setAttribute('charset', 'utf-8');
            $.src = '//cdn.zopim.com/?1gkBYEE194UU1K1qCrzHOvRKyCkWxNZe'; z.t = +new Date; $.
type = 'text/javascript'; e.parentNode.insertBefore($, e)
        })(document, 'script');
        function Img1_onclick() {

        }

    </script>
    <!--End of Zopim Live Chat Script-->
</head>
<body>
    <form id="Form1" runat="server">
    <div id="divheaderCont">
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
                                        <li><a id="A6" href="~/Account/EditProfile.aspx" runat="server" class="ProfNavLink">
                                            Edit Profile </a></li>
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
    <div id="divBodyCont">
        <!--Main body-->
        <div class="container">
            <!--Sidebar-->
            <div class="span-6 sidebar">
                <!--Search widget-->
                <div id="divLinkDiv">
                    <asp:ListView runat="server" ID="lstRootCate" OnItemDataBound="lstRootCate_ItemDataBound">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnRootCateGoryId" runat="server" Value='<%# Eval("RootCateoryId") %>' />
                            <div class="span-6 widget text">
                                <div class="title">
                                    <strong style="font-size: 15px">
                                        <%# Eval("CatName")%>
                                    </strong>
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
                                                                        CommandArgument='<%#Eval("categoryid") %>' CommandName='<%#Eval("pageName") %>'></asp:LinkButton></li>
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
                <div class="span-6 widget">
                    <ul id="little-post">
                        <li><a href="Affiliate/BecomeAnAffiliate.aspx">
                            <img src="images/offer/affiliate.jpg" alt="Become an Affiliate" /></a></li>
                        <li>
                            <img src="images/offer/1.jpg" alt="Offer" /></li>
                        <li>
                            <img src="images/offer/money-back.jpg" alt="money back" /></li>
                        <li>
                            <img src="images/offer/10-offer.jpg" alt="Offer" /></li>
                        <li>
                            <img src="images/offer/satisfaction.jpg" alt="satisfaction" /></li>
                    </ul>
                </div>
                <!--Little posts-->
                <div class="span-6 widget">
                    <div class="title">
                        <strong style="font-size: 15px">Testimonial </strong>
                    </div>
                    <div class="testimonial">
                        <div style="height: 300px; overflow: hidden;">
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
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $('#slider').bjqs({
                                    width: 750,
                                    height: 210,
                                    automatic: true,
                                    showcontrols: true,
                                    showmarkers: false,
                                    hoverpause: true
                                });


                                //cache the ticker
                                var ticker = $("#tickerContainer").live("#ticker");
                                //wrap dt:dd pairs in divs
                                ticker.children().filter("dt").each(function () {

                                    var dt = $(this),
		                container = $("<div>");

                                    dt.next().appendTo(container);
                                    dt.prependTo(container);

                                    container.appendTo(ticker);
                                });

                                //hide the scrollbar
                                ticker.css("overflow", "hidden");

                                //animator function
                                function animator(currentItem) {

                                    //work out new anim duration
                                    var distance = currentItem.height();
                                    duration = (distance + parseInt(currentItem.css("marginTop"))) / 0.025;

                                    //animate the first child of the ticker
                                    currentItem.animate({ marginTop: -distance }, duration, "linear", function () {

                                        //move current item to the bottom
                                        currentItem.appendTo(currentItem.parent()).css("marginTop", 0);

                                        //recurse
                                        animator(currentItem.parent().children(":first"));
                                    });
                                };

                                //start the ticker
                                setTimeout(function () {
                                    animator(ticker.children(":first"));
                                }, 1000);


                                //set mouseenter
                                ticker.mouseenter(function () {

                                    //stop current animation
                                    ticker.children().stop();

                                });

                                //set mouseleave
                                ticker.mouseleave(function () {

                                    //resume animation
                                    animator(ticker.children(":first"));

                                });
                            });



                            


                           
                        </script>
                    </div>
                </div>
            </div>
            <!--Blog category-->
            <div class="span-18 last">
                <!--Blog post-->
                <div class="home-products">
                    <!--Blog image-->
                    <div class="span-18">
                        <div id="QuickSerch" class="quicSerContainer">
                            <iframe src="QuickSearch.aspx" class="clsQuickSerch" width="100%"></iframe>
                        </div>
                        <div id="slider">
                            <ul class="bjqs">
                                <li>
                                    <img src="data1/images/product1.jpg" alt="" title="Cherish your precious moments
                                            of your life. shop anything from generic-cialis-rx.com Get 10 % discount for new
                                            customers Get 20% discount for existing customers free shipping." /></li>
                                <li>
                                    <img src="data1/images/product2.jpg" alt="" title="Bimatoprost - Beauty Secret
                                            For Eyelashes Buy Bimatoprost (Generic Latisse) at Just $29" /></li>
                                <li>
                                    <img src="data1/images/phoneorders.jpg" alt="" title="Order Now" /></li>
                            </ul>
                        </div>
                    </div>
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
                                            <asp:Image runat="server" Height="110px" Width="120px" ID="ImgProd1" alt="Image" />
                                        </div>
                                        <div class="prize">
                                            <div class="prize per-pill">
                                                Our Price</div>
                                            <div class="prize per-pill-prize">
                                                $<asp:Label Text="" ID="lblprodPrice1" runat="server" />
                                            </div>
                                            <div class="know-buy">
                                                <asp:LinkButton ID="lnkbtnprodlink1" runat="server" OnClick="gotoproductpage_Click">
                                                    <asp:Image ID="imgFolder" runat="server" Width="78" Height="22" Style="border: none"
                                                        ImageUrl="images/add-cart.png" />
                                                </asp:LinkButton>
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
                                            <asp:Image ID="imgProd2" Height="110px" Width="120px" runat="server" alt="Image" />
                                        </div>
                                        <div class="prize">
                                            <div class="prize per-pill">
                                                Per pill</div>
                                            <div class="prize per-pill-prize">
                                                $<asp:Label Text=" " runat="server" ID="lblProPrice2" />
                                            </div>
                                            <div class="know-buy">
                                                <asp:LinkButton ID="lnkbtnprodlink2" runat="server" OnClick="gotoproductpage_Click">
                                                    <asp:Image ID="Image1" runat="server" Width="78" Height="22" Style="border: none"
                                                        ImageUrl="images/add-cart.png" />
                                                </asp:LinkButton>
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
                                            <asp:Image runat="server" Height="110px" Width="120px" ID="ImgProd3" alt="Image" />
                                        </div>
                                        <div class="prize">
                                            <div class="prize per-pill">
                                                Per pill</div>
                                            <div class="prize per-pill-prize">
                                                $<asp:Label Text="" ID="lblPrice3" runat="server" />
                                            </div>
                                            <div class="know-buy">
                                                <asp:LinkButton ID="lnkbtnprodlink3" runat="server" OnClick="gotoproductpage_Click">
                                                    <asp:Image ID="Image2" runat="server" Width="78" Height="22" Style="border: none"
                                                        ImageUrl="images/add-cart.png" /></asp:LinkButton>
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
                                            <asp:Image runat="server" Height="110px" Width="120px" ID="imgProd4" alt="Image" />
                                        </div>
                                        <div class="prize">
                                            <div class="prize per-pill">
                                                Per pill</div>
                                            <div class="prize per-pill-prize">
                                                $<asp:Label Text="" ID="lblPrice4" runat="server" />
                                            </div>
                                            <div class="know-buy">
                                                <asp:LinkButton ID="lnkbtnprodlink4" runat="server" OnClick="gotoproductpage_Click">
                                                    <asp:Image ID="Image3" runat="server" Width="78" Height="22" Style="border: none"
                                                        ImageUrl="images/add-cart.png" />
                                                </asp:LinkButton>
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
                                            <asp:Image runat="server" Height="110px" Width="120px" ID="ImgProd5" alt="Image" />
                                        </div>
                                        <div class="prize">
                                            <div class="prize per-pill">
                                                Per pill</div>
                                            <div class="prize per-pill-prize">
                                                $<asp:Label Text="" ID="lblProdPrice5" runat="server" />
                                            </div>
                                            <div class="know-buy">
                                                <asp:LinkButton ID="lnkbtnprodlink5" runat="server" OnClick="gotoproductpage_Click">
                                                    <asp:Image ID="Image4" runat="server" Width="78" Height="22" Style="border: none"
                                                        ImageUrl="images/add-cart.png" /></asp:LinkButton>
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
                                            <asp:Image runat="server" Height="110px" Width="120px" ID="Image6" alt="Image" />
                                        </div>
                                        <div class="prize">
                                            <div class="prize per-pill">
                                                Per pill</div>
                                            <div class="prize per-pill-prize">
                                                $<asp:Label Text="" ID="lblProdPrice6" runat="server" />
                                            </div>
                                            <div class="know-buy">
                                                <asp:LinkButton ID="lnkbtnprodlink6" runat="server" OnClick="gotoproductpage_Click">
                                                    <asp:Image ID="Image5" runat="server" Width="78" Height="22" Style="border: none"
                                                        ImageUrl="images/add-cart.png" /></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--last products close-->
                            </div>
                        </div>
                    </div>
                    <div class="span-18">
                        <p>
                            <img src="images/offers.png" alt="Post" /></p>
                    </div>
                    <div class="span-18">
                        <div id="text-box-wrap">
                            <div class="top">
                                <h3>
                                    2medicure.com-online source for generic Viagra, generic cialis and kamagra oral
                                    jelly at lowest prices</h3>
                            </div>
                            <div class="botom">
                                <div id="scroll">
                                    <div id="scrollcontent">
                                        <p>
                                            2medicure is online drug stores that offer our customers with a wide range of over
                                            1000 of over the counter medications. It is an online drug store that has been trusted
                                            over by millions of customers for its quality and reliability in medications. The
                                            hottest selling products of 2medicure are generic Viagra, kamagra oral jelly, generic
                                            cialis, generic latisse, generic albuterol, generic zovirax and many more. 2medicure
                                            is a one stop destination to shop for all kinds of medications. Customers can shop
                                            for all medications at one place rather than hopping to other websites. 2medicure
                                            is a hassle free online drug store; you order is just a click away! The pricing
                                            strategy of 2medicure has been fixed very carefully keeping in mind our customer’s
                                            budget and requirement. We can give you a price match guarantee for our medications.
                                            2medicure is a trusted brand amongst its customer because of its superiority in
                                            the quality of medication, lowest price tags, excellent customer support system,
                                            fastest shipping and ultimate guaranteed satisfaction. It has kept its customer’s
                                            health and requirements as their top priority. Quality is something that 2medicure
                                            cannot compromise with hence the medications sold are all FDA approved medications.
                                            The medications sold at 2medicure are known for its effectiveness, quality and reliability.
                                            We also offer price match guarantee for our medications. Our ultimate objective
                                            is to offer our customers with medications at lowest possible prices. 2medicure
                                            is committed to professionalism and building trust with its customers by way of
                                            commitment to customer support and quality. It sells generic Viagra of different
                                            varieties and versions each having their own unique characteristics and effectiveness.
                                            2medicure has more than 80% of returning customers who are satisfied and have found
                                            our medications worth and result oriented. Customers who shop here have a great
                                            experience buying. The best part of 2medicure is that the medications are available
                                            without prescriptions. 2medicure guarantees free reshipment of the medication if
                                            the parcel does not reach your door step before the stipulated time. Keeping customer’s
                                            identity and information is extremely essential, which is why 2medicure protects
                                            their buyers from endless number of online frauds. Hence keeping in mind the customer’s
                                            privacy and confidentiality of information it processes the orders through secure
                                            socket layer (SSL) protocols to keep information private. We have multiple payment
                                            options available as per customer’s convenience. Read more...</p>
                                        <a class="button" href="#">Read more</a>
                                    </div>
                                    <div id="scrollbar">
                                        <div id="scroller" class="scroller">
                                        </div>
                                    </div>
                                </div>
                                <script type="text/javascript">
                                    TINY.scroller.init('scroll', 'scrollcontent', 'scrollbar', 'scroller', 'buttonclick');
                                </script>
                            </div>
                        </div>
                    </div>
                    <div id="divCommBody">
                        <div class="span-18">
                            <div id="tab-wrap">
                                <!-- tab block -->
                                <div class="tab-navi">
                                    <ul>
                                        <li class="first-li"><a href="#Planning" class="active">Planning</a></li>
                                        <li><a href="#Development">Development</a></li>
                                        <li><a href="#Support">Support</a></li>
                                        <li class="has-submenu" ><a href="#OnlineSupport">Online Support</a></li>
                                        <%--<li><a href="#TemplateSupport"></a></li>
                                        <li class="last-li has-submenu"><a href="#SalesDepartment"></a></li>--%>
                                    </ul>
                                </div>
                                <div class="tab-content tab1-content">
                                    <div id="Planning" class="tab-content-item display-block">
                                        <p>
                                            2medicure is online drug stores that offer our customers with a wide range of over
                                            1000 of over the counter medications. It is an online drug store that has been trusted
                                            over by millions of customers for its quality and reliability in medications. The
                                            hottest selling products of 2medicure are generic Viagra, kamagra oral jelly, generic
                                            cialis, generic latisse, generic albuterol, generic zovirax and many more. 2medicure
                                            is a one stop destination to shop for all kinds of medications. Customers can shop
                                            for all medications at one place rather than hopping to other websites. 2medicure
                                            is a hassle free online drug store; you order is just a click away! The pricing
                                            strategy of 2medicure has been fixed very carefully keeping in mind our customer’s
                                            budget and requirement. We can give you a price match guarantee for our medications.
                                            2medicure is a trusted brand amongst its customer because of its superiority in
                                            the quality of medication, lowest price tags, excellent customer support system,
                                            fastest shipping and ultimate guaranteed satisfaction. It has kept its customer’s
                                            health and requirements as their top priority. Quality is something that 2medicure
                                            cannot compromise with hence the medications sold are all FDA approved medications.
                                            The medications sold at 2medicure are known for its effectiveness, quality and reliability.
                                            We also offer price match guarantee for our medications. Our ultimate objective
                                            is to offer our customers with medications at lowest possible prices. 2medicure
                                            is committed to professionalism and building trust with its customers by way of
                                            commitment to customer support and quality. It sells generic Viagra of different
                                            varieties and versions each having their own unique characteristics and effectiveness.
                                            2medicure has more than 80% of returning customers who are satisfied and have found
                                            our medications worth and result oriented. Customers who shop here have a great
                                            experience buying. The best part of 2medicure is that the medications are available
                                            without prescriptions. 2medicure guarantees free reshipment of the medication if
                                            the parcel does not reach your door step before the stipulated time. Keeping customer’s
                                            identity and information is extremely essential, which is why 2medicure protects
                                            their buyers from endless number of online frauds. Hence keeping in mind the customer’s
                                            privacy and confidentiality of information it processes the orders through secure
                                            socket layer (SSL) protocols to keep information private. We have multiple payment
                                            options available as per customer’s convenience. Read more...</p>
                                    </div>
                                    <div id="Development" class="tab-content-item">
                                        <p>
                                            Passages of Lorem Ipsum available, but the majority suffered alteration in some
                                            form, by injected. Humour, or randomised words which don't look even slightly believable.
                                            If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't
                                            anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators
                                            on the Internet tend to repeat predefined chunks as necessary.</p>
                                        <p>
                                            Passages of Lorem Ipsum available, but the majority suffered alteration in some
                                            form, by injected. Humour, or randomised words which don't look even slightly believable.
                                            If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't
                                            anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators
                                            on the Internet tend to repeat predefined chunks as necessary.</p>
                                        <p>
                                            Passages of Lorem Ipsum available, but the majority suffered alteration in some
                                            form, by injected. Humour, or randomised words which don't look even slightly believable.
                                            If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't
                                            anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators
                                            on the Internet tend to repeat predefined chunks as necessary.</p>
                                    </div>
                                    <div id="Support" class="tab-content-item">
                                        <p>
                                            Variations of passages of Lorem Ipsum available, but the majority suffered alteration
                                            in some form, by injected. Humour, or randomised words which don't look even slightly
                                            believable. If you are going to use a passage of Lorem Ipsum, you need to be sure
                                            there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum
                                            generators on the Internet tend to repeat.</p>
                                    </div>
                                    <div id="OnlineSupport" class="tab-content-item">
                                        <p>
                                            Variations of passages of Lorem Ipsum available, but the majority suffered alteration
                                            in some form, by injected. Humour, or randomised words which don't look even slightly
                                            believable. If you are going to use a passage of Lorem Ipsum, you need to be sure
                                            there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum
                                            generators on the Internet tend to repeat.</p>
                                        <p>
                                            Passages of Lorem Ipsum available, but the majority suffered alteration in some
                                            form, by injected. Humour, or randomised words which don't look even slightly believable.
                                            If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't
                                            anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators
                                            on the Internet tend to repeat predefined chunks as necessary.</p>
                                    </div>
                                    <!--
                                    <div id="TemplateSupport" class="tab-content-item">
                                        <p>
                                            Passages of Lorem Ipsum available, but the majority suffered alteration in some
                                            form, by injected. Humour, or randomised words which don't look even slightly believable.
                                            If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't
                                            anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators
                                            on the Internet tend to repeat predefined chunks as necessary, making.</p>
                                    </div>
                                    <div id="SalesDepartment" class="tab-content-item">
                                        <p>
                                            Variations of passages of Lorem Ipsum available, but the majority suffered alteration
                                            in some form, by injected. Humour, or randomised words which don't look even slightly
                                            believable. If you are going to use a passage of Lorem Ipsum, you need to be sure
                                            there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum
                                            generators on the Internet tend to repeat predefined chunks as necessary, making
                                            this the first true generator.</p>
                                        <p>
                                            Passages of Lorem Ipsum available, but the majority suffered alteration in some
                                            form, by injected. Humour, or randomised words which don't look even slightly believable.
                                            If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't
                                            anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators
                                            on the Internet tend to repeat predefined chunks as necessary.</p>
                                    </div>
                                -->
                                </div>
                                <!-- /tab block -->
                            </div>
                        </div>
                    </div>
                    <div class="span-18">
                        <div id="blog-box-wrap">
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
                </div>
            </div>
        </div>
    </div>
    <div id="divFooterCont">
    </div>
    <input type="hidden" id="hdnPrPriceId" name="hdnPrPriceId" />
    </form>
</body>
</html>
