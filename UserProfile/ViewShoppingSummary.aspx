<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="ViewShoppingSummary.aspx.cs" Inherits="UserProfile_ViewShoppingSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:GridView ID="gvShowOrders" runat="server" AutoGenerateColumns="false" DataKeyNames="OrderHeaderId"
        ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found">
        <EmptyDataTemplate>
            No Records found
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Order No" ItemStyle-Width="120px">
                <ItemTemplate>
                <%--<%#Eval("Path") %>--%>
                    <asp:HyperLink ID="lnkView" runat="server" Text='<%#Eval("DisplayID") %>' NavigateUrl='#'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Order Id" DataField="OrdId" ItemStyle-Width="200px" />
            <asp:BoundField HeaderText="Order Date" DataField="CreatedDate" DataFormatString="{0:dd-MMM-yyyy mm:hh tt}"
                ItemStyle-Width="150px" />
            <asp:BoundField HeaderText="Order Amount" DataField="Total" ItemStyle-Width="120px"
                ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField HeaderText="Order Status" DataField="OrderStatus" ItemStyle-Width="100px" />
        </Columns>
    </asp:GridView>
</asp:Content>
