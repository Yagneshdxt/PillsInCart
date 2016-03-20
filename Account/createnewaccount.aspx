<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="createnewaccount.aspx.cs" Inherits="createnewaccoumt" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ContentPlaceHolderID="headContent" ID="hedCont" runat="server">
    <script type="text/javascript">
        function checkDuplictEmail() {
            var txtemail = $("#<%= txtemail.ClientID %>");
            $(txtemail).val($.trim($(txtemail).val()));
            if ($(txtemail).val() != "") {
                $.ajax({
                    type: "POST",
                    url: "createnewaccount.aspx/CheckDuplicateEmaiId",
                    data: JSON.stringify({ emailID: $(txtemail).val() }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "fail") {
                            alert("User with this email Id already exist.");
                        }
                    },
                    error: function (result) {
                        //window.location.href = "../index.html"
                    }

                });

            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" style="width: 100%">
        <tr style="background-color: FFFCEE">
            <td colspan="2" style="font-size: 15px">
                <b style="font-size: 16px">ONLINE REGISTRATION</b><br />
                By registering, you will be able to access customer utilities, such as order tracking,
                convenient refills of past orders, your order history and more.<br />
                To register, simply fill in the fields to the right and click the CREATE AN ACCOUNT
                button at the bottom of the page. You will be instantly registered and able to place
                online orders instantly.
            </td>
        </tr>
        <tr>
            <td colspan="2">
            </td>
        </tr>
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
                            E-mail
                        </td>
                        <td>
                            <asp:TextBox ID="txtemail" onblur="checkDuplictEmail();" runat="server" MaxLength="200"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage="Please enter Email Id"
                                ControlToValidate="txtemail" Display="Dynamic" ValidationGroup="btnadd" Text="*"
                                ForeColor="Red" runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="Email Address Invalid"
                                ControlToValidate="txtemail" runat="server" ValidationExpression="^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$"
                                Display="Dynamic" Text="*" ValidationGroup="btnadd" ForeColor="Red" ToolTip="Invalid email Addresss" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Password
                        </td>
                        <td>
                            <asp:TextBox ID="txtpassword" TextMode="Password" runat="server" MaxLength="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ErrorMessage="Please enter Password" runat="server" ID="RequiredFieldValidator1"
                                ControlToValidate="txtpassword" Display="Dynamic" ValidationGroup="btnadd" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">
                            Confirm Password
                        </td>
                        <td>
                            <asp:TextBox ID="txtconpassword" TextMode="Password" runat="server" MaxLength="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ErrorMessage="Please enter confirm password" runat="server"
                                ID="RequiredFieldValidator2" ControlToValidate="txtconpassword" Display="Dynamic"
                                ValidationGroup="btnadd" />
                            <asp:CompareValidator ErrorMessage="Password do not match" ControlToValidate="txtconpassword"
                                ControlToCompare="txtpassword" ValidationGroup="btnadd" runat="server" />
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
                        <td style="text-align: center">
                            <asp:Button ID="btnbacklogin" runat="server" Text="Back To Login" OnClick="btnbacklogin_Click" />
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
                                Text="Create Account" OnClick="btncreatenew_Click" />
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
