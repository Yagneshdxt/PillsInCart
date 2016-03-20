<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="AffiliateDetails.aspx.cs" Inherits="Affiliate_AffiliateDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:GridView ID="grdshowAffiliateOrderDetial" runat="server" AutoGenerateColumns="false"
        ShowHeader="true" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" ShowFooter = "true" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="Order No">
                <ItemTemplate>
                    <asp:Label Text='<%#Eval("DisplayId") %>' ID="lblOrderNo" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Customer" DataField="fName" />
            <asp:BoundField HeaderText="Order Date" DataField="CreatedDate" DataFormatString="{0:dd-MMM-yyyy}"
                ItemStyle-Width="220px" />
            <asp:TemplateField HeaderText="Order Amount" ItemStyle-HorizontalAlign="Right"  FooterStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    $ <asp:Label Text='<%#Eval("AfillTotal") %>' ID="lblAfillTotal" runat="server" />
                </ItemTemplate>
                <FooterTemplate>
                   Total : $ <asp:Label Text='0.00' ID="lblFooterAfillTotal" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Commission %" DataField="commisonPer_aff" />
            <asp:TemplateField HeaderText="You get" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    $ <asp:Label Text='<%#Eval("youget") %>' ID="lblyouGet" runat="server" />
                </ItemTemplate>
                <FooterTemplate>
                   Total :  $ <asp:Label Text='0.00' ID="lblFooteryouGet" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <b>Affiliate Details</b>
    <hr />
    <asp:GridView ID="grdAffiliate" runat="server" AutoGenerateColumns="False" PageSize="10"
        AllowPaging="true" Width="100%" OnPageIndexChanging="grdAffiliate_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Product Id">
                <ItemTemplate>
                    <asp:Label ID="lblProId" runat="server" Text='<%# Eval("productId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product Name">
                <ItemTemplate>
                    <asp:Label ID="lblProName" runat="server" Text='<%# Eval("productName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Affiliate Link">
                <ItemTemplate>
                    <asp:Label ID="lblAffiliateUrl" runat="server" Text='<%# createAffiliateLink(Eval("affiliateId"), Eval("logoimgPath"),Eval("ShortName")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblActiveInac" runat="server" Text='<%# Eval("ActiveInactive") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
