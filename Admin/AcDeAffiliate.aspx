<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="AcDeAffiliate.aspx.cs" Inherits="Admin_AcDeAffiliate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" width="100%">
        <tr>
            <td>
                Affiliate Name
                <asp:TextBox runat="server" ID="txtAffiliate" MaxLength="100" />
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
                    <asp:HyperLink ID="hyplink" runat="server" Text='<%# Eval("fName") %>' NavigateUrl='<%# Eval("userID", "~/Admin/ViewAffiates.aspx?UserID={0}")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="EmailID">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("EmailID") %>' runat="server" ID="lblEmailId" />
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
