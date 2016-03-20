<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table id="tbldetails" runat="server">
        <tr>
            <td>
                Name
            </td>
            <td>
                <asp:TextBox ID="txtName" CssClass="inptextbox" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="reqname" runat="server" ControlToValidate="txtName"
                    EnableClientScript="true" SetFocusOnError="true" CssClass="error" ValidationGroup="register"
                    ErrorMessage="Please Enter Name"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Address
            </td>
            <td>
                <asp:TextBox ID="txtAddress" Height="45px" CssClass="inptextbox" TextMode="MultiLine"
                    runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="reqCompanyCode" runat="server" ControlToValidate="txtAddress"
                    EnableClientScript="true" SetFocusOnError="true" CssClass="error" ValidationGroup="register"
                    ErrorMessage="Please Enter Address"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Contact No.
            </td>
            <td>
                <asp:TextBox ID="txtContactNo" CssClass="inptextbox" MaxLength="10" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="reqcontactperson" ErrorMessage="Please Enter Contact No."
                    EnableClientScript="true" SetFocusOnError="true" CssClass="error" ValidationGroup="register"
                    runat="server" ControlToValidate="txtContactNo"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regexcontactperson" runat="server" ErrorMessage="Contact No: Numbers only"
                    EnableClientScript="true" SetFocusOnError="true" CssClass="error" ValidationGroup="register"
                    ControlToValidate="txtContactNo" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                Email-ID
            </td>
            <td>
                <asp:TextBox ID="txtEmailID" CssClass="inptextbox" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="reqemailId" runat="server" ErrorMessage="Please Enter EmailID"
                    EnableClientScript="true" SetFocusOnError="true" CssClass="error" ValidationGroup="register"
                    ControlToValidate="txtEmailID">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regextxtemailid" runat="server" ErrorMessage="Please Enter valid EmailID"
                    EnableClientScript="true" SetFocusOnError="true" CssClass="error" ValidationGroup="register"
                    ControlToValidate="txtEmailID" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                Message
            </td>
            <td>
                <asp:TextBox ID="txtFeedBack" CssClass="inptextbox" TextMode="MultiLine" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAddress"
                    EnableClientScript="true" SetFocusOnError="true" CssClass="error" ValidationGroup="register"
                    ErrorMessage="Please Enter Message"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Button Text="Send" ID="btnSend" CssClass="Btn" ValidationGroup="register" runat="server"
                    OnClick="btnSend_Click" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
     <div id="thankyoumsg" runat="server">
                Thank Your Contacting us.Our Team Will get back to you soon.
            </div>
</asp:Content>
