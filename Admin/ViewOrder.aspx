<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewOrder.aspx.cs" Inherits="Admin_ViewOrder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.7.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Styles/prettyPhoto.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="../Styles/style.css" type="text/css" media="screen, projection" />
    <script type="text/javascript">
        $(document).ready(function () {
            calculateTotalAmount();
            if ($('#<%=hdnPaymentModeId.ClientID %>').val() == 11) {
                $('.trCheque').show();
            }
            else if ($('#<%=hdnPaymentModeId.ClientID %>').val() == 12) {
                $('.trCC').show();
            }
            else if ($('#<%=hdnPaymentModeId.ClientID %>').val() == 13) {

            }
            if ($('#<%=hdnPrescriptionTypeId.ClientID %>').val() == "0") {
                $('.trMedicalInfo').hide();
            }
        });

        function calculateTotalAmount() {
            //alert(1);
            var BillingAmount;
            BillingAmount = parseFloat($('#<%=lblBillingAmount.ClientID %>').html());
            var ShipCharge;
            ShipCharge = parseFloat($('#<%=lblShippingAmount.ClientID %>').html());
            var FlatDiscount;
            FlatDiscount = parseFloat($('#<%=lblFlatDiscount.ClientID %>').html());
            var Discount = 0;
            if ($('#<%=hdnDiscountType.ClientID %>').val() == '5') {
                $('#<%=hdnDiscountAmount.ClientID %>').val(
                    parseFloat(($('#<%=hdnDiscountAmount.ClientID %>').val() / 100.00) * BillingAmount).toFixed(2).toString()
                 );
            }
            //if ($('#<%=hdnDiscountAmount.ClientID %>').val() != '') {

            Discount = parseFloat($('#<%=hdnDiscountAmount.ClientID %>').val());
            //alert(Discount);
            //}

            if (isNaN(BillingAmount))
                BillingAmount = 0;
            if (isNaN(ShipCharge))
                ShipCharge = 0;
            if (isNaN(Discount))
                Discount = 0;
            if (isNaN(FlatDiscount))
                FlatDiscount = 0;

            $('#<%=lbldiscount.ClientID %>').html(Discount);
            var total = parseFloat(BillingAmount + ShipCharge - Discount - FlatDiscount).toFixed(2);
            $('#<%=lblTotalAmount.ClientID %>').html(total);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="page">
        <%--<div class="header">
            <div class="title">
                <h1>
                    Admin Section
                </h1>
            </div>
            <div class="loginDisplay">
                <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="~/Account/Login.aspx" id="HeadLoginStatus" runat="server">Log In</a>
                        ]
                    </AnonymousTemplate>
                    <LoggedInTemplate>
                        Welcome <span class="bold">
                            <asp:LoginName ID="HeadLoginName" runat="server" />
                        </span>! [
                        <asp:LoginStatus ID="HeadLoginStatus" runat="server" LogoutAction="Redirect" LogoutText="Log Out"
                            LogoutPageUrl="~/" />
                        ]
                    </LoggedInTemplate>
                </asp:LoginView>
            </div>
            <div class="clear hideSkiplink">
            </div>
        </div>--%>
        <div class="main">
            <center>
                <asp:HiddenField ID="hdnShippCharge" runat="server" />
                <asp:HiddenField ID="hdnDiscountAmount" runat="server" />
                <asp:HiddenField ID="hdnDiscountType" runat="server" />
                <asp:HiddenField ID="hdnPaymentModeId" runat="server" />
                <asp:HiddenField ID="hdnPrescriptionTypeId" runat="server" />
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
                <asp:Panel ID="pnlAll" runat="server">
                    <table cellspacing="0" cellpadding="0" border="0" width="65%" style="background-color: White;">
                        <tr>
                            <td align="left">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <div id="Div1">
                                                <h3 class="headerbar">
                                                    Step 2: Billing & Account Details</h3>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td>
                                                        First Name
                                                    </td>
                                                    <td valign="top">
                                                        <asp:Label ID="lblfname" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Last Name
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbllname" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Date Of Birth
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDOB" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Gender
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblGende" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Address
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Address Line 2
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblAddress2" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        City
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblCity" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Country
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblCountry" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        State
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblState" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Zip Code
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblZipCode" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Phone
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Mobile
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        E-mail
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        My Shipping Info
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblShippingInfo" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <table cellpadding="0" cellspacing="0" border="0" id="tbDeliveryAddress" visible="false"
                                                runat="server">
                                                <tr>
                                                    <td colspan="2">
                                                        DELIVERY ADDRESS
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        First Name
                                                    </td>
                                                    <td valign="top">
                                                        <asp:Label ID="lblDFname" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Last Name
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDLname" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Address
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDAddress" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Address Line 2
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDAddress2" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        City
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDCity" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Country
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDCountry" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        State
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDState" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Zip Code
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDZipCode" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Phone
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDPhone" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Mobile
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDMobile" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div id="Div2">
                                                <h3 class="headerbar">
                                                    Step 3: Order Information</h3>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <ul class="submenu">
                                                <li>
                                                    <table width="100%">
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:SqlDataSource ID="dsProducts" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>">
                                                                </asp:SqlDataSource>
                                                                <asp:GridView ID="ListView1" Width="100%" AutoGenerateColumns="false" runat="server"
                                                                    DataSourceID="dsProducts" OnRowDataBound="ListView1_RowDataBound" DataKeyNames="Price">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Product" HeaderText="Product" />
                                                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                                                                        <asp:BoundField DataField="Price" HeaderText="Price" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                Discount Code Applied
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDiscountCode" Text="-" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                Shipping Type Selected
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblShippingType" Text="-" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                Billing Amount
                                                            </td>
                                                            <td style="width: 150px">
                                                                <asp:Label ID="lblBillingAmount" runat="server" Text="0"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                Discount
                                                            </td>
                                                            <td style="width: 150px">
                                                                <asp:Label ID="lbldiscount" runat="server" Text="0"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                Flat Discount
                                                            </td>
                                                            <td style="width: 150px">
                                                                <asp:Label ID="lblFlatDiscount" runat="server" Text="0"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                Shipping Amount
                                                            </td>
                                                            <td style="width: 150px">
                                                                <asp:Label ID="lblShippingAmount" Text="0" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                Total Amount
                                                            </td>
                                                            <td style="width: 150px">
                                                                <asp:Label ID="lblTotalAmount" runat="server" Text="0"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div id="Div3">
                                                <h3 class="headerbar">
                                                    Step 4: Payment Details</h3>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Payment Mode
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPaymentMode" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Account Holder
                                        </td>
                                        <td>
                                            <asp:Label ID="txtAccHolder" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Account Address
                                        </td>
                                        <td>
                                            <asp:Label ID="txtAccAddress" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            City
                                        </td>
                                        <td>
                                            <asp:Label ID="txtAccCity" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            State
                                        </td>
                                        <td>
                                            <asp:Label ID="txtAccState" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Zip
                                        </td>
                                        <td>
                                            <asp:Label ID="txtZip" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Phone Number
                                        </td>
                                        <td>
                                            <asp:Label ID="txtAccPhone" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Bank Name
                                        </td>
                                        <td>
                                            <asp:Label ID="txtBankName" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Bank City
                                        </td>
                                        <td>
                                            <asp:Label ID="txtBankCity" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Bank State
                                        </td>
                                        <td>
                                            <asp:Label ID="txtBankState" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Bank Phone
                                        </td>
                                        <td>
                                            <asp:Label ID="txtBankPhone" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Routing Number
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRoutingNo" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Account Number
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAccNo" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCheque" style="display: none;">
                                        <td>
                                            Cheque Number (optional)
                                        </td>
                                        <td>
                                            <asp:Label ID="lblChequeno" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCC" style="display: none;">
                                        <td>
                                            Credit Card Type
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCCTYpe" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCC" style="display: none;">
                                        <td>
                                            Credit Card Name
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCCName" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCC" style="display: none;">
                                        <td>
                                            Credit Card Number
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCCNo" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCC" style="display: none;">
                                        <td>
                                            Expiry Date
                                        </td>
                                        <td>
                                            <asp:Label ID="lblExpiryDate" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trCC" style="display: none;">
                                        <td>
                                            CVV2
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCVV2" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td colspan="2">
                                            <div id="Div4">
                                                <h3 class="headerbar">
                                                    Step 5: Medical Information</h3>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td colspan="2">
                                            <b>1. Personal Health Indices </b>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td>
                                            Prescription Details
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPrescription" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td class="text-right">
                                            Name
                                        </td>
                                        <td class="text-left">
                                            <asp:Label ID="lblMName" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td class="text-right">
                                            Sex
                                        </td>
                                        <td class="text-left">
                                            <asp:Label ID="lblSex" Text="Male" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td class="text-right">
                                            Age
                                        </td>
                                        <td class="text-left">
                                            <asp:Label ID="lblAge" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td class="text-right">
                                            Height
                                        </td>
                                        <td class="text-left">
                                            <asp:Label ID="lblHeight" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td class="text-right">
                                            Weight
                                        </td>
                                        <td class="text-left">
                                            <asp:Label ID="lblWeight" runat="server"></asp:Label>&nbsp;LBS
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td class="text-right">
                                            Medical Condition drug required for
                                        </td>
                                        <td class="text-left">
                                            <asp:Label ID="lblMedicalCondition" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td colspan="2">
                                            <b>2. Past Medical History </b>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td colspan="2">
                                            <asp:GridView ID="gvPastMedicalHistory" runat="server" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:BoundField HeaderText="Question" DataField="Question" />
                                                    <asp:BoundField HeaderText="Answer" DataField="Answer" />
                                                    <asp:BoundField HeaderText="More Info" DataField="DisagreeReason" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td colspan="2">
                                            <b>3. Personal Habits </b>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td colspan="2">
                                            <asp:GridView ID="gvPesonalHabits" runat="server" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:BoundField HeaderText="Question" DataField="Question" />
                                                    <asp:BoundField HeaderText="Answer" DataField="Answer" />
                                                    <asp:BoundField HeaderText="More Info" DataField="DisagreeReason" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr class="trMedicalInfo">
                                        <td>
                                            Any other habits
                                        </td>
                                        <td>
                                            <asp:Label ID="lblOtherHabits" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <b>Terms & User Acceptance For Issuing Prescription </b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:GridView ID="gvTermsnConditions" runat="server" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:BoundField HeaderText="Question" DataField="Question" />
                                                    <asp:BoundField HeaderText="Answer" DataField="Answer" />
                                                    <asp:BoundField HeaderText="Diagree Reason" DataField="DisagreeReason" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkaccept" Checked="true" Enabled="false" Text=" I have read, I understand and accept the PillsinCart Disclaimer "
                                                runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <center>
                                    <asp:Button ID="btnApprove" Text="Approve" runat="server" OnClick="btnApprove_Click" />
                                </center>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </center>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="footer">
    </div>
    </form>
</body>
</html>
