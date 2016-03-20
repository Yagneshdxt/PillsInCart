<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="ViewAffiliateOrder.aspx.cs" Inherits="Admin_ViewAffiliateOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table>
        <tr>
            <td>
                <%--<asp:HyperLink NavigateUrl="~/Admin/AcDeAffiliate.aspx" Text="Back" runat="server" />--%>
                <asp:HyperLink NavigateUrl="~/Admin/ViewSetAffiliate.aspx" Text="Back" runat="server" />
            </td>
            <td>
            </td>
            <td>
                <b>Affiliate Order Details </b>
            </td>
        </tr>
    </table>
    <%--    <asp:GridView ID="grdshowAffiliateOrderDetial" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Order No" ItemStyle-Width="120px">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkView" Target="_blank" runat="server" Text='<%#Eval("DisplayId") %>' NavigateUrl='<%# "~/Admin/ViewOrder.aspx?OrderHeaderId="+ Eval("OrderHeaderId").ToString() %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Customer" DataField="fName" ItemStyle-Width="200px" />
            <asp:BoundField HeaderText="Order Date" DataField="CreatedDate" DataFormatString="{0:dd-MMM-yyyy}"
                ItemStyle-Width="220px" />
            <asp:BoundField HeaderText="Billed Amount" DataField="totalOrderPrice" ItemStyle-Width="120px"
                ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Affiliate Amount" DataField="AfillTotal" ItemStyle-Width="120px"
                ItemStyle-HorizontalAlign="Right" />
        </Columns>
    </asp:GridView>--%>
    <asp:GridView ID="grdshowAffiliateOrderDetial" runat="server" 
        AutoGenerateColumns="false" PageSize="20"
        ShowHeader="true" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found"
        ShowFooter="true" Width="100%" 
        onpageindexchanging="grdshowAffiliateOrderDetial_PageIndexChanging">
        <Columns>
            <asp:BoundField HeaderText="AffiliateName" DataField="AffName" />
            <asp:TemplateField HeaderText="Order No">
                <ItemTemplate>
                    <asp:Label Text='<%#Eval("DisplayId") %>' ID="lblOrderNo" runat="server" />
                    <asp:HiddenField ID="hdnorderDetailID" Value='<%# Eval("ordeDetailId") %>' runat="server" />   
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Customer" DataField="CustName" />
            <asp:BoundField HeaderText="Order Date" DataField="CreatedDate" DataFormatString="{0:dd-MMM-yyyy}"
                ItemStyle-Width="220px" />
            <asp:TemplateField HeaderText="Order Amount" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    $
                    <asp:Label Text='<%#Eval("AfillTotal") %>' ID="lblAfillTotal" runat="server" />
                </ItemTemplate>
                <FooterTemplate>
                    Total : $
                    <asp:Label Text='0.00' ID="lblFooterAfillTotal" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Commission %" DataField="commisonPer_aff" />
            <asp:TemplateField HeaderText="Affiliate gets" ItemStyle-HorizontalAlign="Right"
                FooterStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    $
                    <asp:Label Text='<%#Eval("youget") %>' ID="lblyouGet" runat="server" />
                </ItemTemplate>
                <FooterTemplate>
                    Total : $
                    <asp:Label Text='0.00' ID="lblFooteryouGet" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:Button Text="Pay Out" ID="btnpayout" runat="server" OnClick="btnpayout_Click" OnClientClick="return confirm('Payout Amount??')" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
