<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="Account_ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0">
        <tr>
            <td>
            </td>
            <td>
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnsign" ShowMessageBox="false"
                    DisplayMode="List" ForeColor="Red" HeaderText="" ShowSummary="true" />
                <asp:Label Text="" ID="lblMsg" ForeColor="Red" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Email Id:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtEmailID" MaxLength="50" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmailID"
                    ErrorMessage="Please enter Email Address" ForeColor="Red" ValidationGroup="btnsign">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmailID"
                    ErrorMessage="Invalid Email Address" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ValidationGroup="btnsign">Not Valid</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnsign" runat="server" Text="GET PASSWORD" OnClick="btnsign_Click" ValidationGroup="btnsign"
                    CausesValidation="true" />
            </td>
        </tr>
    </table>
</asp:Content>
