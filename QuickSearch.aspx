<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuickSearch.aspx.cs" Inherits="QuickSearch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Styles/QuickSearch.css" />
    <script type="text/javascript" language="javascript">

        function AddProdPriceToCart(prdPriceId) {
            // ../BuyProduct/viewcart.aspx?pID=" + Eval("ProdPriceId").ToString()
            var hdnPrPriceId = parent.document.getElementById("hdnPrPriceId");
            hdnPrPriceId.value = prdPriceId;
            parent.document.forms[0].action = "../BuyProduct/viewcart.aspx";
            parent.document.forms[0].method = "post";
            parent.document.forms[0].submit();
            return false;
        }

        function QuickSearchValidate() {
            var errMsg = "";
            var QuickprdPriceId = "";
            var ddlrootCategory = document.getElementById('<%= ddlrootCategory.ClientID %>');
            var ddlCategory = document.getElementById('<%= ddlCategory.ClientID %>');
            var ddlProduct = document.getElementById('<%= ddlProduct.ClientID %>');
            var ddlQuantity = document.getElementById('<%= ddlQuantity.ClientID %>');
            if (ddlrootCategory.options[ddlrootCategory.selectedIndex].value == "" || ddlrootCategory.options[ddlrootCategory.selectedIndex].value == "0") {
                errMsg = errMsg + "Please select Root category \n";
            }
            if (ddlCategory.options[ddlCategory.selectedIndex].value == "" || ddlCategory.options[ddlCategory.selectedIndex].value == "0") {
                errMsg = errMsg + "Please select category \n";
            }
            if (ddlProduct.options[ddlProduct.selectedIndex].value == "" || ddlProduct.options[ddlProduct.selectedIndex].value == "0") {
                errMsg = errMsg + "Please select Product \n";
            }
            if (ddlQuantity.options[ddlQuantity.selectedIndex].value == "" || ddlQuantity.options[ddlQuantity.selectedIndex].value == "0") {
                errMsg = errMsg + "Please select Quantity \n";
            } else {
                QuickprdPriceId = ddlQuantity.options[ddlQuantity.selectedIndex].value;
            }

            if (errMsg == "") {
                var hdnPrPriceId = window.parent.document.getElementById("hdnPrPriceId");
                hdnPrPriceId.value = QuickprdPriceId;
                window.parent.document.forms[0].action = "BuyProduct/viewcart.aspx";
                window.parent.document.forms[0].method = "post";
                window.parent.document.forms[0].submit();
                return false;
            } else {
                alert(errMsg);
            }

            return false;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="quicSerContainer gridH">
        <div class="quickshopheader">
            Shop In Easy Steps
        </div>
        <table width="100%" class="short-table">
            <tr>
                <td>
                    <asp:DropDownList runat="server" CssClass="select" ID="ddlrootCategory" OnSelectedIndexChanged="ddlrootCategory_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlCategory" CssClass="select" runat="server" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlProduct" CssClass="select" runat="server" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlQuantity" CssClass="select" runat="server" OnSelectedIndexChanged="ddlQuantity_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </td>
                <td>
                    $<asp:Label Text="0.00" ID="lblPrice" runat="server" />
                </td>
                <td>
                    <%--          <asp:ImageButton ImageUrl="images/add-cart.png" runat="server" alt="Buy" Width="78"
                        Height="22" />--%>
                    <asp:LinkButton ID="LnkAddtoCart" Text="" runat="server" href="#" OnClientClick="QuickSearchValidate()">
                        <asp:Image ID="Image1" ImageUrl="~/images/buy.png" AlternateText="Buy Now" runat="server" />
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnselproductPriceID" runat="server" />
    </div>
    </form>
</body>
</html>
