<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="FlatDiscount.aspx.cs" Inherits="Admin_FlatDiscount" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                User Type
            </td>
            <td>
                <asp:DropDownList ID="ddlUserType" runat="server" Height="22px" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Please select User type"
                    Display="Dynamic" ForeColor="Red" Text="*" ControlToValidate="ddlUserType" runat="server"
                    InitialValue="0" ValidationGroup="valFlatDis" />
            </td>
        </tr>
        <tr>
            <td>
                Discount Amount
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtAmt" MaxLength="10" />
                <asp:RequiredFieldValidator ErrorMessage="Please enter discount Amount" Text="*"
                    ForeColor="Red" ControlToValidate="txtAmt" runat="server" Display="Dynamic" ValidationGroup="valFlatDis" />
                <asp:FilteredTextBoxExtender ID="txtValiditydays_FilteredTextBoxExtender" runat="server"
                    Enabled="True" TargetControlID="txtAmt" FilterType="Custom, Numbers"
                    ValidChars="-">
                </asp:FilteredTextBoxExtender>
            </td>
        </tr>
        <tr>
            <td>
                Discount Type
            </td>
            <td>
                <asp:DropDownList ID="ddlDiscounttype" runat="server" Height="22px" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage="Please select Discount type"
                    Display="Dynamic" ForeColor="Red" Text="*" ControlToValidate="ddlDiscounttype"
                    runat="server" InitialValue="0" ValidationGroup="valFlatDis" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:RadioButtonList runat="server" ID="rdActiveDeactive" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Active" Value="1" Selected="True" />
                    <asp:ListItem Text="Inactive" Value="0" />
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Add" OnClick="btnSubmit_Click" CausesValidation="true"
                    ValidationGroup="valFlatDis" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                    Visible="false" />
            </td>
        </tr>
    </table>
    <p>
    </p>
    <asp:GridView ID="grdFlatDiscount" runat="server" AutoGenerateColumns="false" PageSize="10"
        Width="100%" onpageindexchanging="grdFlatDiscount_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="User Type">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("UseType") %>' ID="lblUserType" runat="server" />
                    <asp:HiddenField ID="hdnUserType" Value='<%# Eval("UserType") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount Amt">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("DiscountAmt") %>' ID="lblDisAmt" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount Type">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("DisType") %>' ID="lblDisType" runat="server" />
                    <asp:HiddenField ID="hdnDisType" Value='<%# Eval("DiscountType") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Active Status">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("ActStatus") %>' ID="ActiveStaus" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Edit">
                <ItemTemplate>
                    <asp:LinkButton Text="Edit" ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
