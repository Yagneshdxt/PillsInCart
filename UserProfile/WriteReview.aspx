<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="WriteReview.aspx.cs" Inherits="UserProfile_WriteReview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0" width="100%">
        <tr>
            <td>
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnsign" ShowMessageBox="false"
                    DisplayMode="List" ForeColor="Red" HeaderText="" ShowSummary="true" />
                <asp:Label Text="" ID="lblMsg" ForeColor="Red" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                Testimonials
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox runat="server" ID="txtTestimonial" TextMode="MultiLine"   style="height: 155px; width: 622px;" />
                <p>
                    *Max 1000 Characters
                </p>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTestimonial"
                    ErrorMessage="Please enter Testimonial" ForeColor="Red" ValidationGroup="btnsign">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Please do not enter special character "
                    ControlToValidate="txtTestimonial" runat="server" ValidationExpression="^[a-zA-Z'.'''_'\s]{1,1000}$"
                    Display="Dynamic" Text="*" ValidationGroup="btnsign" ToolTip="Numeric" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSubTestM" runat="server" Text="Submit Testimonial" OnClick="btnSubTestM_Click"
                    ValidationGroup="btnsign" CausesValidation="true" />
            </td>
        </tr>
    </table>
</asp:Content>
