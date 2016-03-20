<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="AffiliateAddToCart.aspx.cs" Inherits="Affiliate_AffiliateAddToCart"
    EnableViewState="false" EnableViewStateMac="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            if ($("#<%= hdnPrPriceIdSer.ClientID %>").val() != "") {
                $("#hdnPrPriceId").val($("#<%= hdnPrPriceIdSer.ClientID %>").val());
                var lnkToViewCart = document.getElementById("<%=lnkToViewCart.ClientID %>");
                lnkToViewCart.click();
                //window.document.forms[0].action = "../BuyProduct/viewcart.aspx";
                //window.document.forms[0].method = "post";
                // window.document.forms[0].submit();
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hdnPrPriceIdSer" runat="server" />
    <input type="hidden" id="hdnPrPriceId" name="hdnPrPriceId" />
    <div style="display: none;">
        <asp:LinkButton Text="" PostBackUrl="~/BuyProduct/viewcart.aspx" ID="lnkToViewCart"
            runat="server" />
    </div>
</asp:Content>
