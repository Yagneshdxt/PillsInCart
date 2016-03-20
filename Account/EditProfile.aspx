<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="EditProfile.aspx.cs" Inherits="Account_EditProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" style="width: 100%">
        <tr>
            <td colspan="2">
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnadd" ShowMessageBox="false"
                    DisplayMode="List" ForeColor="Red" HeaderText="" ShowSummary="true" />
                <asp:Label Text="" ID="lblMsg" ForeColor="Red" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <table align="center" style="width: 100%">
                    <tr>
                        <td class="text-right">
                            First Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtfname" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtfname"
                                ErrorMessage="Please enter first Name" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Please do not enter special character for Name"
                                ControlToValidate="txtfname" runat="server" ValidationExpression="^[a-zA-Z''_'\s]{1,100}$"
                                Display="Dynamic" Text="*" ValidationGroup="btnadd" ForeColor="Red" ToolTip="Numeric" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Last Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtlname" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtlname"
                                ErrorMessage="Please enter Last Name" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Please do not enter special character for Last Name"
                                ControlToValidate="txtlname" runat="server" ValidationExpression="^[a-zA-Z''_'\s]{1,100}$"
                                Display="Dynamic" Text="*" ValidationGroup="btnadd" ForeColor="Red" ToolTip="Numeric" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Gender
                        </td>
                        <td>
                            <asp:RadioButton ID="radiomale" GroupName="gender" Text="Male" runat="server" Checked="True" />
                            <asp:RadioButton ID="radiofemale" GroupName="gender" Text="Female" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            BirthDay
                        </td>
                        <td>
                            <asp:TextBox ID="txtdob" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="calendarValidfrom" TargetControlID="txtdob" runat="server">
                            </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Address1
                        </td>
                        <td>
                            <asp:TextBox ID="txtadd1" runat="server" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Address2
                        </td>
                        <td>
                            <asp:TextBox ID="txtadd2" runat="server" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table align="center" style="width: 100%">
                    <tr>
                        <td class="text-right">
                            Country
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlcountry" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            State/Province
                        </td>
                        <td>
                            <asp:TextBox ID="txtstate" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            City
                        </td>
                        <td>
                            <asp:TextBox ID="txtcity" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Zip Code
                        </td>
                        <td>
                            <asp:TextBox ID="txtzipcode" runat="server"></asp:TextBox>
                            <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" Enabled="True"
                                FilterType="Custom, Numbers" ValidChars="." TargetControlID="txtzipcode">
                            </asp:FilteredTextBoxExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Phone
                        </td>
                        <td>
                            <asp:TextBox ID="txtphone" runat="server"></asp:TextBox>
                            <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" Enabled="True"
                                FilterType="Custom, Numbers" ValidChars="." TargetControlID="txtphone">
                            </asp:FilteredTextBoxExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Mobile No
                        </td>
                        <td>
                            <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>
                            <asp:FilteredTextBoxExtender ID="TextBox1_FilteredTextBoxExtender" runat="server"
                                Enabled="True" FilterType="Custom, Numbers" ValidChars="." TargetControlID="txtMobile">
                            </asp:FilteredTextBoxExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                        </td>
                        <td style="text-align: center">
                            <asp:Button ID="btncreatenew" runat="server" CausesValidation="true" ValidationGroup="btnadd"
                                Text="Update Details" OnClick="btncreatenew_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label Text="" ID="lblsucessmsg" ForeColor="Red" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
