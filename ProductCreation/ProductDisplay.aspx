<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductDisplay.aspx.cs" Inherits="ProductDisplay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src='<%# ResolveUrl("~/Scripts/jquery-1.7.1.js") %>' type="text/javascript"></script>
    <script src='<%# ResolveUrl("~/Scripts/jquery-1.7.1.min.js") %>' type="text/javascript"></script>
    <script src='<%# ResolveUrl("~/Scripts/jquery-1.7.min.js") %>' type="text/javascript"></script>
    <link rel="stylesheet" href="../Styles/style.css" type="text/css" media="screen, projection" />
    <link rel="stylesheet" href="../Styles/prettyPhoto.css" type="text/css" media="screen" />
    <script type="text/javascript">
        $(document).ready(function () {

            $("#divFooterCont").load("../../Footer.html");
            //            $("#divCommBody").load("../../bodyComman.html", function () {
            //                tabNavi('.tab-navi');
            //            });

            tabNavi('.tab-navi');
            //            $.ajax(
            //            {
            //                type: "GET",
            //                url: "../ProductCreation/DynamicProductMaster.aspx",
            //                success: function (result) {
            //                    if ($(result).find('#divValidStatus').find("span").text() == "Success") {
            //                        //$("#divheaderCont").html($(result).find('#divHeader').html());
            //                        $("#divLinkDiv").html($(result).find('#divLinkDiv').html());
            //                        $("#tickerContainer").html($(result).find('#tickerContainer').html());
            //                    } else {
            //                        //window.location.href = "../../index.html";
            //                    }
            //                },
            //                error: function (result) {
            //                    // window.location.href = "../../index.html"
            //                }
            //            });


            $(".accordation-item-header").live('click', function () {
                $('.accordation-item-body').slideUp('normal');
                if ($(this).parent().find('.accordation-item-body').is(':hidden') == true) {
                    $(this).parent().find('.accordation-item-body').slideDown('normal');
                }
                return false;
            });

        });


        function AddProdPriceToCart(prdPriceId) {

            // ../BuyProduct/viewcart.aspx?pID=" + Eval("ProdPriceId").ToString()
            var hdnPrPriceId = document.getElementById("hdnPrPriceId");
            hdnPrPriceId.value = prdPriceId;
            document.forms[0].action = "../BuyProduct/viewcart.aspx";
            document.forms[0].method = "post";
            document.forms[0].submit();
            return false;
        }

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

                        $(this).parents('li.has-submenu').find('a.submn').addClass('active-trail');
                    }
                    return false;
                });
            }
        }


        function setLogOut() {
            $.ajax({
                type: "POST",
                url: "../../PageMethods.aspx/LogOutUser",
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
</head>
<body>
    <form id="form1" runat="server">
    <div id="divheaderCont">
        <div id="header-top">
            Generic viagra for ED treatment, viagra generic online for men
        </div>
        <div id="header">
            <div class="inner">
                <!--Logo-->
                <div class="logo">
                    <a id="A1" href="~/" runat="server">
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
                                <asp:Image ID="Img1" ImageUrl="~/images/log-in.png" runat="server" alt="LogIn" />&nbsp;&nbsp;<a
                                    id="A2" href="~/Account/login.aspx" runat="server" class="logLnk">Log In</a>
                                &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;<asp:Image ID="Img2" ImageUrl="~/images/register.png"
                                    runat="server" alt="Register" />&nbsp;&nbsp; <a id="A3" href="~/Account/createnewaccount.aspx"
                                        runat="server" class="logLnk">Register</a>
                            </div>
                            <div id="divLogOut" runat="server" clientidmode="Static">
                                <asp:Image ID="imgLogInPing" ImageUrl="~/images/log-in.png" runat="server" alt="Welcome User" />&nbsp;&nbsp;
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
                                &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;<asp:Image ID="Img4" ImageUrl="~/images/register.png"
                                    runat="server" alt="LogOut" />&nbsp;&nbsp; <a href="#" style="display: inline;" class="logLnk"
                                        onclick="setLogOut();">Log out</a>
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
                        <li><a href="~/Affiliate/BecomeAnAffiliate.aspx" runat="server">
                            <img src="~/images/offer/affiliate.jpg" alt="become an affiliate" runat="server" /></a></li>
                        <li>
                            <img src="~/images/offer/1.jpg" alt="free express mail shipping" runat="server" /></li>
                        <li>
                            <img src="~/images/offer/money-back.jpg" alt="Money back gareenty" runat="server" /></li>
                        <li>
                            <img src="~/images/offer/10-offer.jpg" alt="10% extra pills on next purchase" runat="server" /></li>
                        <li>
                            <img src="~/images/offer/satisfaction.jpg" alt="satisfaction gareented" runat="server" /></li>
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
                            $(function () {

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
                <div class="home-products">
                    <div id="divProdBody">
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
                            <div class="text-box">
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
                                            $
                                            <asp:Label ID="lblNewPrice" Text='<%# Eval("NewPrice") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New Unit Price" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            $
                                            <asp:Label ID="lblNewUnitPrice" Text='<%# Eval("NewUnitPrice") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Old Price" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            $
                                            <asp:Label ID="lblOldPrice" Text='<%# Eval("OldPrice") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Old Unit Price" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            $
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
                                                <asp:Image ID="Image1" ImageUrl="~/images/buy.png" AlternateText="Buy Now" runat="server" />
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div id="divCommBody">
                        <div class="span-18">
                            <div id="Div1">
                                <!-- tab block -->
                                <div class="tab-navi">
                                    <ul>
                                        <li class="first-li"><a href="#Planning" class="active">Planning</a></li>
                                        <li><a href="#Development">Development</a></li>
                                        <li><a href="#Support">Support</a></li>
                                        <li class="has-submenu"><a href="#OnlineSupport">Online Support</a></li>
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
            </div>
        </div>
    </div>
    <div id="divFooterCont">
    </div>
    <input type="hidden" id="hdnPrPriceId" name="hdnPrPriceId" />
    </form>
</body>
</html>
