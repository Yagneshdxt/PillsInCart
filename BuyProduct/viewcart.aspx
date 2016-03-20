<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="viewcart.aspx.cs" Inherits="viewcart" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="headContent" runat="server">
    <script type="text/javascript">

    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        SHOPPING CART</h2>
    <hr />
    <div>
        <asp:GridView runat="server" ID="grdCartData" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true"
            OnRowDataBound="grdCartData_RowDataBound" ShowFooter="true" ShowHeader="true">
            <EmptyDataTemplate>
                Your shopping cart is empty
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="Product">
                    <ItemTemplate>
                        <div class="ViewCartimageLogo">
                            <asp:Image ImageUrl='<%# Eval("logoimgpath") %>' ID="imgLogoImg" runat="server" AlternateText="Product Image" />
                        </div>
                        <asp:HiddenField ID="hdnproductid" Value='<%# Eval("productid") %>' runat="server" />
                        <asp:HiddenField ID="hdnProdPriceId" Value='<%# Eval("ProdPriceId") %>' runat="server" />
                        <asp:HiddenField ID="hdnOrdeDetailId" Value='<%# Eval("OrdeDetailId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="lblProdName" Text='<%# Eval("Name") %>' runat="server" />
                        <br />
                        <div style="color: red">
                            <asp:Label ID="lblQuantity" Text='<%# Eval("Quantity") %>' runat="server" />
                            of
                            <asp:Label ID="lblStrength" Text='<%# Eval("Strength") %>' runat="server" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlQuantity" AutoPostBack="true" OnSelectedIndexChanged="ddlQuantity_SelectedIndexChanged">
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("Price") %>' ID="lblprodPrice" runat="server" />
                    </ItemTemplate>
                    <FooterTemplate>
                        Total:
                        <asp:Label ID="lblFootrTotal" runat="server" />
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remove">
                    <ItemTemplate>
                        <asp:LinkButton Text="" ID="lnkRemove" runat="server" OnClick="lnkRemove_Click"><asp:image imageurl="~/images/icons/error.png" AlternateText="Remove" ToolTip="Remove" runat="server" /> </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:ImageButton ImageUrl="~/images/CheckOut.png" CommandArgument="test" OnClick="btnChkOut_Click"
            runat="server" />
    </div>
    <table style="width: 100%; display: none;">
        <tr>
            <td style="padding: 0" colspan="5">
                <asp:Image ID="Image4" ImageAlign="NotSet" ImageUrl="" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <%-- <asp:Image ID="Image1" runat="server" ImageUrl="https://secure.medexpressrx.com/images/echeck.png" />--%>
            </td>
            <td>
                <h2 style="color: #444444">
                    eCheck</h2>
            </td>
            <td>
                <h1 style="color: #FF1E1E">
                    10% ADDITIONAL DISCOUNT!</h1>
            </td>
            <td>
                TOTAL :
                <asp:Label ID="lblpayechecktotal" runat="server" Text="Label" ForeColor="#099E64"></asp:Label><br />
                SAVE :
                <asp:Label ID="lblpayechecksave" runat="server" Text="Label" ForeColor="#E80606"></asp:Label>
            </td>
            <td>
                <%--https://secure.medexpressrx.com/images/echeck_bttn.png--%>
                <asp:ImageButton ID="ImageButton1" runat="server" OnClick="CheckOut_Click" CommandArgument="eCheck"
                    AlternateText="Check Out" ImageUrl="" />
            </td>
        </tr>
        <tr>
            <td>
                <%--<asp:Image ID="Image2" runat="server" ImageUrl="https://secure.medexpressrx.com/images/visa.png" />--%>
            </td>
            <td>
                <h2 style="color: #444444">
                    Credit Card</h2>
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                TOTAL :
                <asp:Label ID="lblpaycredittotal" runat="server" Text="Label" ForeColor="#099E64"></asp:Label><br />
                SAVE :
                <asp:Label ID="lblpaycredisave" runat="server" Text="Label" ForeColor="#E80606"></asp:Label>
            </td>
            <td>
                <%--https://secure.medexpressrx.com/images/credit_bttn.png--%>
                <asp:ImageButton ID="ImageButton2" runat="server" OnClick="CheckOut_Click" AlternateText="Check Out"
                    CommandArgument="Credit Card" ImageUrl="" />
            </td>
        </tr>
        <tr>
            <td>
                <%--<asp:Image ID="Image3" runat="server" ImageUrl="https://secure.medexpressrx.com/images/money_order.png" />--%>
            </td>
            <td>
                <h2 style="color: #444444">
                    Mail check or
                    <br />
                    Money Order</h2>
                <p style="color: Red">
                    *Physical check required for order delivery</p>
            </td>
            <td>
                <h1 style="color: #FF1E1E">
                    10% ADDITIONAL DISCOUNT!</h1>
            </td>
            <td>
                TOTAL :
                <asp:Label ID="lblpaymailtotal" runat="server" Text="Label" ForeColor="#099E64"></asp:Label><br />
                SAVE :
                <asp:Label ID="lblpaymailsave" runat="server" Text="Label" ForeColor="#E80606"></asp:Label>
            </td>
            <td>
                <%--https://secure.medexpressrx.com/images/money_bttn.png--%>
                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="" OnClick="CheckOut_Click"
                    AlternateText="Check Out" CommandArgument="MoneyOrder" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnOrderId" runat="server" />
    <asp:HiddenField ID="hdnActionType" runat="server" Value="I" />
</asp:Content>
