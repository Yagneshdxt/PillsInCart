<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" style="width: 100%">
        <tr>
            <td colspan="2">
                <h2>
                    SIGN IN OR CREATE AN ACCOUNT</h2>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnsign" ShowMessageBox="false"
                    DisplayMode="List" ForeColor="Red" HeaderText="" ShowSummary="true" />
                <asp:Label Text="" ID="lblMsg" ForeColor="Red" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <table align="center" style="width: 100%; height: 304px;">
                    <tr>
                        <td>
                            <h3>
                                I HAVE AN ACCOUNT</h3>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="in_log_txt">PLEASE SIGN IN</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="in_log_data">Your Email Address</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtemailid" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtemailid"
                                ErrorMessage="Please enter Email Address" ForeColor="Red" ValidationGroup="btnsign">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtemailid"
                                ErrorMessage="Invalid Email Address" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ValidationGroup="btnsign">Not Valid</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="in_log_data">Your Password</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtpassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpassword"
                                ErrorMessage="Please enter Password" ForeColor="Red" ValidationGroup="btnsign">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="lbtnforgot" PostBackUrl="~/Account/ForgotPassword.aspx" runat="server">Forgotten Your Password?</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnsign" runat="server" Text="SIGN IN" OnClick="btnsign_Click" ValidationGroup="btnsign" CausesValidation="true"/>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table align="center" style="width: 100%; height: 304px;">
                    <tr>
                        <td>
                            <h3>
                                NEW CUSTOMER</h3>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="log_info">If you are new to PillsinCart.com you will need to create an
                                account.</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="log_info" style="font-weight: bold; font-size: 13px">MY ACCOUNT BENEFITS</span><br />
                            <span class="log_info">Sign up with PillsinCart.com and benefit from:</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="log_info">
                                <img alt="" src="https://secure.medexpressrx.com/images/sml_nw_arr.jpg" />&nbsp;&nbsp;10%
                                Returning Customer Discounts!<br />
                                <img alt="" src="https://secure.medexpressrx.com/images/sml_nw_arr.jpg" />&nbsp;&nbsp;Order
                                History<br />
                                <img alt="" src="https://secure.medexpressrx.com/images/sml_nw_arr.jpg" />&nbsp;&nbsp;more...</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btncreatenew" runat="server" Text="CREATE AN ACCOUNT" OnClick="btncreatenew_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
