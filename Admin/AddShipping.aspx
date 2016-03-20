<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="AddShipping.aspx.cs" Inherits="Admin_AddShipping" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table cellpadding="5" cellspacing="5" border="0">
        <tr>
            <td>
                Shipping Name
            </td>
            <td>
                <asp:TextBox ID="txtshippingname" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtshippingname"
                    ErrorMessage="Add Shipping Name" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Shipping cost/Charges
            </td>
            <td>
                <asp:TextBox ID="txtshippingcharges" runat="server" MaxLength="4"></asp:TextBox>
                <asp:FilteredTextBoxExtender ID="TextBox1_FilteredTextBoxExtender" runat="server"
                    Enabled="True" FilterType="Custom, Numbers" ValidChars="." TargetControlID="txtshippingcharges">
                </asp:FilteredTextBoxExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtshippingcharges"
                    ErrorMessage="Enter Shipping Cost" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Average Delivery Period
            </td>
            <td>
                <asp:TextBox ID="txtavgdelperiod" MaxLength="4" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtavgdelperiod"
                    ErrorMessage="Enter Average Delivery Period" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:RadioButton ID="radioactive" runat="server" Text="Active" Checked="True" GroupName="act" />
                <asp:RadioButton ID="radiodeactive" runat="server" Text="Deactive" GroupName="act" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Add" CausesValidation="true" ValidationGroup="btnadd"
                    OnClick="btnSubmit_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                    CausesValidation="true" ValidationGroup="btnadd" Visible="false" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                    Visible="false" />
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnadd" ShowMessageBox="true"
                    DisplayMode="List" HeaderText="Add Shipping error" ShowSummary="false" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Shipping Limit
            </td>
            <td>
                <asp:TextBox ID="txtshippingcost" MaxLength="5" runat="server"></asp:TextBox>
                <asp:FilteredTextBoxExtender ID="txtshippingcost_FilteredTextBoxExtender" runat="server"
                    Enabled="True" FilterType="Numbers" TargetControlID="txtshippingcost">
                </asp:FilteredTextBoxExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtshippingcost"
                    ErrorMessage="Please enter Shopping cart" ForeColor="Red" ValidationGroup="btnupdate">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnshippingcostupdate" runat="server" Text="Update" ValidationGroup="btnupdate"
                    OnClick="btnshippingcostupdate_Click" Style="height: 26px" />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="btnupdate"
                    ShowMessageBox="true" DisplayMode="List" HeaderText="Update shipping limit Error"
                    ShowSummary="false" />
            </td>
        </tr>
    </table>
    <p>
    </p>
    <table>
        <tr>
            <td>
                Shipping Type Name:
                <asp:TextBox ID="txtProductID" runat="server" />
            </td>
            <td>
                Shipping Delivery Period:
                <asp:TextBox ID="txtnamefilter" runat="server" />
            </td>
            <td>
                Shipping Charge:
                <asp:TextBox ID="txtCategory" runat="server" />
            </td>
            <td>
                Status:
                <asp:DropDownList runat="server" ID="ddlStatusFil">
                    <asp:ListItem Text="--Select--" Value="--Select--" />
                    <asp:ListItem Text="Active" Value="1" />
                    <asp:ListItem Text="InActive" Value="0" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdShipping" runat="server" AutoGenerateColumns="false" PageSize="10"
        Width="100%" OnPageIndexChanging="grdShipping_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Shipping Type Name">
                <ItemTemplate>
                    <asp:Label ID="lblshippinname" runat="server" Text='<%#Eval("ShippName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Shipping Delivery Period">
                <ItemTemplate>
                    <asp:Label ID="lblshipdeliver" runat="server" Text='<%#Eval("DilverPerd") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Shipping Charge">
                <ItemTemplate>
                    <asp:Label ID="lblshipcharge" runat="server" Text='<%#Eval("ShippCharge") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblactive" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                    <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("ActiveFlag") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Edit">
                <ItemTemplate>
                    <asp:LinkButton Text="Edit" ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" />
                    <asp:HiddenField ID="hdnShippingDataID" Value='<%# Eval("ShippingMstId") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="hdnshippingid" runat="server" />
</asp:Content>
