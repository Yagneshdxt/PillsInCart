<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Account_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td>
            </td>
            <td>
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="valChangePass" ShowMessageBox="false"
                    DisplayMode="List" ForeColor="Red" HeaderText="" ShowSummary="true" />
                <asp:Label Text="" ID="lblMsg" ForeColor="Red" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Old Password
            </td>
            <td>
                <asp:TextBox runat="server" TextMode="Password" MaxLength="20" ID="txtOldPassword" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtOldPassword"
                    ErrorMessage="Please enter old Password" ForeColor="Red" ValidationGroup="valChangePass">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                New Password
            </td>
            <td>
                <asp:TextBox runat="server" TextMode="Password" MaxLength="20" ID="txtNewPassword" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNewPassword"
                    ErrorMessage="Please enter new password" ForeColor="Red" ValidationGroup="valChangePass">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Confirm Password
            </td>
            <td>
                <asp:TextBox runat="server" TextMode="Password" MaxLength="20" ID="txtConfirmPassword" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Please confirm password" ForeColor="Red" ValidationGroup="valChangePass">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" ErrorMessage="Password do not match"
                    ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword" ValidationGroup="valChangePass"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button Text="Change Password" ID="btnChangePass" runat="server" CausesValidation="true"
                    ValidationGroup="valChangePass" OnClick="btnChangePass_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
