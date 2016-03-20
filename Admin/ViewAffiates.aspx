<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true" CodeFile="ViewAffiates.aspx.cs" Inherits="Admin_ViewAffiates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" width="100%">
        <tr>
            <td>
                Product Id
                <asp:TextBox runat="server" ID="txtProductId" MaxLength="100" />
            </td>
            <td>
                Product Name
                <asp:TextBox runat="server" ID="txtProductName" MaxLength="100" />
            </td>
            <td>
                Status:
                <asp:DropDownList runat="server" ID="ddlStatusFil">
                    <asp:ListItem Text="--Select--" Value="00" />
                    <asp:ListItem Text="Active" Value="1" />
                    <asp:ListItem Text="InActive" Value="0" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdAffiliate" runat="server" AutoGenerateColumns="False" PageSize="20"
        AllowPaging="true" Width="100%" OnPageIndexChanging="grdAffiliate_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Affiliate Name">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("fName") %>' runat="server" ID="lblfName" />
                    <%--<asp:HyperLink NavigateUrl='<%# "~/Admin/ViewAffiliateOrder.aspx?AffId=" + Eval("affiliateId").ToString() %>'
                        Text='<%# Eval("fName") %>' runat="server"></asp:HyperLink>--%>
                    <asp:HiddenField ID="hdnAffiliateId" Value='<%# Eval("affiliateId") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
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
            <%--<asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblActiveInac" runat="server" Text='<%# Eval("ActiveInactive") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Active/Inactive">
                <ItemTemplate>
                    <asp:LinkButton Text='<%# (Eval("ActiveInactive").ToString() == "Active")?"Inactive":"Activate" %>'
                        ID="lnkupdate" runat="server" CommandArgument='<%# Eval("activeFlag") %>' OnClick="lnkupdate_Click" />
                </ItemTemplate>
            </asp:TemplateField>--%>
        </Columns>
    </asp:GridView>
</asp:Content>
