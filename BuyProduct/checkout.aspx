<%@ Page Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master" AutoEventWireup="true"
    CodeFile="checkout.aspx.cs" Inherits="checkout" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="content0" ContentPlaceHolderID="headContent" runat="server">
    <link href="../Styles/Sidebar.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function chkaccept_checked(sender) {
            if (sender.checked == true) {
                //$('#<%=btnsubmitorder.ClientID %>').removeAttr('disabled');
                $('.trSubmit').show();
            }
            else {
                //$('#<%=btnsubmitorder.ClientID %>').attr('disabled','disabled');
                $('.trSubmit').hide();
            }
        }

        $(document).ready(function () {
            $("#divLeftCont").hide();
            getFlatDiscount();
            var chkPayment = document.getElementById('<%=radiopayment1.ClientID %>');
            oncheckchange(chkPayment);
            checkIfRegisteredUser();
            var chkshipFlag = "0";
            var rbId, ShipId, ShipCharg;
            $("#ContentPlaceHolder1_gvShipping tr td").each(function (indx, sender) {
                if (chkshipFlag == "0") {
                    $(sender).find("input").each(function (idx, obSen) {
                        if ($(obSen).prop("type") == "radio") {
                            rbId = $(obSen).attr("id");
                            ShipId = $(obSen).next("input[type='hidden']").val();
                            ShipCharg = $(obSen).next().next("input[type='hidden']").val();
                            chkshipFlag = "1";
                            $(obSen).prop("checked", "checked");
                            calculateTotalAmount();
                            ShipChecked(document.getElementById($(obSen).attr("id")), ShipId, ShipCharg)
                            return;
                        }
                    });
                }
            });

            $(".medicalInfo").hide();
            $('.medicalInfo .medicalValidate').each(function () { ValidatorEnable(this, false); });
            $("#<%= rblMedical.ClientID %> input[type='radio'][value='14']").prop("checked", true);
            $("#<%= rblMedical.ClientID %> input[type='radio']").click(function () {
                if ($(this).val() == "15") {
                    $(".medicalInfo").show();
                    $('.medicalInfo .medicalValidate').each(function () { ValidatorEnable(this, true); });
                } else {
                    $(".medicalInfo").hide();
                    $('.medicalInfo .medicalValidate').each(function () { ValidatorEnable(this, false); });
                }
            });

            $('.trSubmit').hide();
            if ($("#<%= chkaccept.ClientID %>").prop("checked", true)) {
                $('.trSubmit').show();
            }

        });

        function checkIfRegisteredUser() {
            if ($("#<%=hdnRegistered.ClientID %>").val() == 'N') {
                $('.newUser').show();
                $('.oldUser').hide();
                $('#divBillDetails').hide();
            }
            else {
                $('.newUser').hide();
                $('.oldUser').show();
                $('#divBillDetails').show();
                var rfv;
                debugger;
                rfv = document.getElementById('<%=rfvfname.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=fvlname.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvDOB.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvaddress.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvaddress2.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvcity.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvcountry.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvState.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvzip.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=fvphnno.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvMobile.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvEmailID.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=reEmailID.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvPassword.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvrepassword.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=cvPAss.ClientID %>');
                ValidatorEnable(rfv, false);
            }
        }

        function isNumberKey(evt) {
            var charcode = (evt.which) ? evt.which : event.keyCode;
            if (charcode != 46 && charcode > 31 && (charcode < 48 || charcode > 57))
                return false;
            return true;
        }

        function getFlatDiscount() {
            $.ajax({
                type: "POST",
                url: "../BuyProduct/checkout.aspx/getFlatDiscount",
                data: JSON.stringify({ BillAmount: $('#<%=lblBillingAmount.ClientID %>').html() }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    $('#<%=lblFlatDiscount.ClientID %>').html(result.d);
                    $('#<%=hdnFlatDiscount.ClientID %>').val(result.d);
                    calculateTotalAmount();
                },
                eror: function () {
                }
            });
            return false;
        }

        function DOB_Change() {
            var d1 = new Date($('#<%=txtdob.ClientID %>').val());
            var d2 = new Date();
            $('#<%=lblgetdbage.ClientID %>').html(d2.getFullYear() - d1.getFullYear());
        }

        function getNameForMedical() {
            $('#<%=lblgetdbname.ClientID %>').html($('#<%=txtfname.ClientID %>').val() + ' ' + $('#<%=txtlname.ClientID %>').val());
            return false;
        }

        function rblHistory_click(sender, txt) {
            var chkval = $("#" + sender.id + ' input:checked').val();
            var arr = sender.id.split('_');
            var rfv = document.getElementById(arr[0] + '_' + arr[1] + '_rfvReason_' + arr[3]);
            if (chkval == txt) {
                ValidatorEnable(rfv, true);
            }
            else {
                ValidatorEnable(rfv, false);
            }
        }

        function onGenderChange(sender) {
            var chkval = $("#" + sender.id + ' input:checked').val();
            //alert(chkval);
            $('#<%=lblgetdbsex.ClientID %>').html(chkval);
        }

        function btnApplyDisc_clientclicked() {
            $.ajax({
                type: "POST",
                url: "../BuyProduct/checkout.aspx/discountChk",
                data: JSON.stringify({ code: $('#<%=txtDiscount.ClientID %>').val() }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    //alert(result.d.discountamt + "  " + result.d.dismessage);
                    if (result.d.discountamt != '') {
                        $('#<%=hdnDiscountID.ClientID %>').val(result.d.discountid);
                        var dval = parseFloat(result.d.discountamt).toFixed(2);
                        $('#<%=hdnDiscountAmount.ClientID %>').val(dval);
                        $('#<%=lbldiscount.ClientID %>').html(parseFloat(result.d.discountamt).toFixed(2));
                        calculateTotalAmount();
                        $('#spandisc').hide();
                    }
                    $('#<%=lblDiscountMsg.ClientID %>').html(result.d.dismessage);
                },
                eror: function () {
                }
            });
            return false;
        }

        function checkDuplictEmail() {
            var txtemail = $("#<%= txtemailid.ClientID %>");
            $(txtemail).val($.trim($(txtemail).val()));
            if ($(txtemail).val() != "") {
                $.ajax({
                    type: "POST",
                    url: "checkout.aspx/CheckDuplicateEmaiId",
                    data: JSON.stringify({ emailID: $(txtemail).val() }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "fail") {
                            alert("User with this email Id already exist.");
                            txtemail.val('');
                        }
                    },
                    error: function (result) {
                    }
                });

            }
        }

        function ShipChecked(rb, shipId, shipCharg) {
            RollBackShippingCharge(rb.id);
            if (document.getElementById(rb.id).checked) {
                //alert(rb.id + "n" + shipId + "n" + shipCharg);
                var shipCharg = parseFloat(shipCharg);
                var FreeMax = parseFloat($('#<%=hdnFreeShipmentLimit.ClientID %>').val())
                if (isNaN(shipCharg))
                    shipCharg = 0;
                if (isNaN(FreeMax))
                    FreeMax = 0;

                $('#<%=hdnShippID.ClientID %>').val(shipId);
                if (parseFloat($('#<%=lblTotalAmount.ClientID %>').text()) < parseFloat(FreeMax)) {
                    $('#<%=hdnShippCharge.ClientID %>').val(shipCharg);
                    $('#<%=lblShippingAmount.ClientID %>').html(shipCharg);
                }
                else {
                    $('#<%=hdnShippCharge.ClientID %>').val('0');
                    $('#<%=lblShippingAmount.ClientID %>').html('0');
                }
            }
            else {
                $('#<%=hdnShippID.ClientID %>').val('');
                $('#<%=hdnShippCharge.ClientID %>').val('0');
                $('#<%=lblShippingAmount.ClientID %>').html('0');
            }
            calculateTotalAmount();
            //$('.JqradioChk').each(function () { alert($(this).attr("checked")) });
            //$('.JqradioChk').attr("checked", "false");
            //$('.JqradioChk').prop("checked", "false");
            //alert($('#<%=gvShipping.ClientID %> type:checkbox').size());
            //$('#<%=gvShipping.ClientID %> type:checkbox').attr("checked", "false");
            //$('#<%=gvShipping.ClientID %> type:checkbox').prop("checked", "false");
            return false;
        }
        function calculateTotalAmount() {
            var BillingAmount;
            BillingAmount = parseFloat($('#<%=lblBillingAmount.ClientID %>').html());
            var ShipCharge;
            ShipCharge = parseFloat($('#<%=hdnShippCharge.ClientID %>').val());
            var FlatDiscount;
            FlatDiscount = parseFloat($('#<%=hdnFlatDiscount.ClientID %>').val());

            var Discount = 0;
            if ($('#<%=hdnDiscountID.ClientID %>').val() != '') {
                Discount = parseFloat($('#<%=hdnDiscountAmount.ClientID %>').val());
            }
            //alert(Discount);
            if (isNaN(BillingAmount))
                BillingAmount = 0;
            if (isNaN(ShipCharge))
                ShipCharge = 0;
            if (isNaN(Discount))
                Discount = 0;
            if (isNaN(FlatDiscount))
                FlatDiscount = 0;

            var total = parseFloat(BillingAmount + ShipCharge - Discount - FlatDiscount).toFixed(2);
            $('#<%=lblTotalAmount.ClientID %>').html(total);
        }


        function RollBackShippingCharge(rbId) {
            try {
                var ShipCharge = 0;
                ShipCharge = parseFloat($('#<%=hdnShippCharge.ClientID %>').val());
                if (isNaN(ShipCharge))
                    ShipCharge = 0;
                var lblTotalAmt = 0;
                lblTotalAmt = parseFloat($('#<%=lblTotalAmount.ClientID %>').text());
                if (isNaN(lblTotalAmt))
                    lblTotalAmt = 0;
                lblTotalAmt = parseFloat(lblTotalAmt) - parseFloat(ShipCharge);
                $('#<%=lblTotalAmount.ClientID %>').html(lblTotalAmt);
                $('#<%=lblShippingAmount.ClientID %>').html('0');
                parseFloat(10) / parseFloat(0);
                // $("#<%= gvShipping.ClientID %>  tr td .JqradioChk input").not("#" + rbId).prop("checked", false);
            } catch (e) {
                alert("error");
            }
        }

        function radioregister_click(rb) {
            if (rb.checked == true) {
                $("#divBillDetails").show("fast");
            }
            else {
                $("#divBillDetails").hide("fast");
            }
        }

        function showDelAddDiv() {
            var ddl = document.getElementById("<%=ddlshipinginfo.ClientID %>");
            ddlshipinginfo_onchange(ddl);
        }
        function oncheckchange(sender) {
            var chkval = $("#" + sender.id + ' input:checked').val();
            clearall();
            var rfv;
            if (chkval == '11') {
                $("#divCeditCard").hide();
                $("#divCheque").show();
                $("#divMailCheque").hide();
                rfv = document.getElementById('<%=rfvReAccNo.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvAccNo.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvRoutingNo.ClientID %>');
                ValidatorEnable(rfv, true);

                rfv = document.getElementById('<%=rfvAccHOlder.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvAccAddress.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvAccCity.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvAccState.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvAccZip.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvAccPhone.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvBankName.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvBankCity.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvBankState.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvBankPhone.ClientID %>');
                ValidatorEnable(rfv, true);
            }
            else if (chkval == '12') {
                $("#divCeditCard").show();
                $("#divCheque").hide();
                $("#divMailCheque").hide();

                rfv = document.getElementById('<%=rfvCVV2.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvYear.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvMonth.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvCreditCardNo.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=CreditCardValidator.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvCCType.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvCCName.ClientID %>');
                ValidatorEnable(rfv, true);
            }
            else if (chkval == '13') {
                $("#divCeditCard").hide();
                $("#divCheque").hide();
                $("#divMailCheque").show();
            }
        }

        function clearall() {
            var rfv;
            /*eCheque*/
            rfv = document.getElementById('<%=rfvReAccNo.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvAccNo.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvRoutingNo.ClientID %>');
            ValidatorEnable(rfv, false);

            rfv = document.getElementById('<%=rfvAccHOlder.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvAccAddress.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvAccCity.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvAccState.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvAccZip.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvAccPhone.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvBankName.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvBankCity.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvBankState.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvBankPhone.ClientID %>');
            ValidatorEnable(rfv, false);

            /*CREDIT CARD*/
            rfv = document.getElementById('<%=rfvCVV2.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvYear.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvMonth.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvCreditCardNo.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=CreditCardValidator.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvCCType.ClientID %>');
            ValidatorEnable(rfv, false);
            rfv = document.getElementById('<%=rfvCCName.ClientID %>');
            ValidatorEnable(rfv, false);
        }

        function ddlshipinginfo_onchange(sender) {
            var chkVal = $("#" + sender.id + ' input:checked').val();
            //alert(chkVal);
            //if ($("#" + sender.id).val() == '10') {
            if (chkVal == '10') {
                $('#divDelAddress').show();
                var rfv;
                rfv = document.getElementById('<%=tfvSfname.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvslname.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=fvsAddress.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvsAdd2.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvSCity.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvSCountry.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvsState.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=fvZipCode.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvPhoneNo.ClientID %>');
                ValidatorEnable(rfv, true);
                rfv = document.getElementById('<%=rfvSMobile.ClientID %>');
                ValidatorEnable(rfv, true);
            }
            else {
                $('#divDelAddress').hide();
                var rfv;
                rfv = document.getElementById('<%=tfvSfname.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvslname.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=fvsAddress.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvsAdd2.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvSCity.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvSCountry.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvsState.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=fvZipCode.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvPhoneNo.ClientID %>');
                ValidatorEnable(rfv, false);
                rfv = document.getElementById('<%=rfvSMobile.ClientID %>');
                ValidatorEnable(rfv, false);
            }

            return false;
        }
    </script>
    <style type="text/css">
        .stylesuhead
        {
            text-align: left;
            background-color: #F1F1F1;
            color: #222222;
            font: 15px Arial;
            height: 16px;
            border-left: 1px solid #DDDDDD;
            border-right: 1px solid #DDDDDD;
        }
        .span
        {
            float: left;
            width: 1045px;
        }
        .contentstables
        {
            padding: 10px 30px 0 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="sidebar">
        <asp:Panel ID="pnlMsg" runat="server" Visible="false">
            <p>
                Order Confirmed</p>
            <p>
                Hi,</p>
            <p>
                Thank you for placing an order at pillsincart.com.Your parcel will be processed
                and shipped within 24-48 hours.The order will be processed as per the billing and
                shipping information provided by you.
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlAll" runat="server">
            <div class="">
                <table border="0" width="100%" cellpadding="1" cellspacing="1">
                    <tr>
                        <td align="left">
                            <asp:ValidationSummary ID="vsSummary" runat="server" ValidationGroup="Submit" Font-Bold="true"
                                ForeColor="Red" HeaderText="Error list" DisplayMode="BulletList"
                                ShowSummary="true" ShowMessageBox="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="step1">
                                <h3 class="headerbar">
                                    Step 1: Account Details</h3>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="contentstables">
                                <tr>
                                    <td>
                                        I'm A New Customer
                                        <br />
                                        <br />
                                        Register with us for a faster checkout, to track the status of your order
                                        <br />
                                        and more. You can also checkout as a guest.
                                    </td>
                                    <td>
                                        I'm A Returning Customer.
                                        <br />
                                        To continue, please enter your email address and password<br />
                                        that you use for your account.
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="radioregister" onclick="radioregister_click(this);" Text="Register an account"
                                            runat="server" />
                                    </td>
                                    <td rowspan="2">
                                        <table class="contentstables">
                                            <tr>
                                                <td>
                                                    Email ID
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtregistereemail" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtregistereemail"
                                                        ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="btnregistersubmit">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtregistereemail"
                                                        ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ValidationGroup="btnregistersubmit">Not Valid</asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Password
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtregisterpassword" TextMode="Password" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtregisterpassword"
                                                        ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="btnregistersubmit">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <center>
                                                        <asp:Button ID="btnregistersubmit" runat="server" Text="Check Validity" CausesValidation="true"
                                                            ValidationGroup="btnregistersubmit" OnClick="btnregistersubmit_Click" />
                                                    </center>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table id="divBillDetails">
                                <tr>
                                    <td>
                                        <div id="Div1">
                                            <h3 class="headerbar">
                                                Step 2: Billing & Account Details</h3>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" class="contentstables">
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr class="newUser">
                                                            <td>
                                                                First Name
                                                            </td>
                                                            <td valign="top">
                                                                <asp:TextBox ID="txtfname" MaxLength="50" onblur="return getNameForMedical();" runat="server"
                                                                    Width="100px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ValidationGroup="Submit" ID="rfvfname" runat="server"
                                                                    ControlToValidate="txtfname" ForeColor="Red" ErrorMessage="please enter name"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Last Name
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtlname" MaxLength="50" onblur="return getNameForMedical();" runat="server"
                                                                    Width="100px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="fvlname" runat="server" ValidationGroup="Submit"
                                                                    ErrorMessage="please enter last name" Text="*" ControlToValidate="txtlname"
                                                                    ForeColor="Red"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Date Of Birth
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtdob" MaxLength="12" onchange="return DOB_Change();" runat="server"></asp:TextBox>
                                                                <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtdob" runat="server">
                                                                </asp:CalendarExtender>
                                                                <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ValidationGroup="Submit" ControlToValidate="txtdob"
                                                                    ForeColor="Red" ErrorMessage="please enter dob" Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Gender
                                                            </td>
                                                            <td>
                                                                <asp:RadioButtonList ID="radiomale" onclick="return onGenderChange(this);" RepeatDirection="Horizontal"
                                                                    runat="server">
                                                                    <asp:ListItem Text="Male" Value="Male" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Address
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtaddress" MaxLength="500" runat="server" Width="221px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvaddress" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtaddress" ForeColor="Red" ErrorMessage="please enter address"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Address Line 2
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtaddress2" MaxLength="500" runat="server" Width="221px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvaddress2" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtaddress2" ForeColor="Red" ErrorMessage="please enter address line 2"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                City
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtcity" MaxLength="50" runat="server" Width="221px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvcity" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtcity" ForeColor="Red" ErrorMessage="please enter city"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Country
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlcountry" runat="server" Width="221px" AppendDataBoundItems="true"
                                                                    DataSourceID="dsCountry" DataTextField="Country" DataValueField="ID">
                                                                    <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="rfvcountry" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="ddlcountry" ForeColor="Red" InitialValue="0" ErrorMessage="please select country"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                                <asp:SqlDataSource ID="dsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                                                    SelectCommand="select ID,Country from MstCountry where ActiveFlag = 1"></asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                State
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtstate" runat="server" MaxLength="50" Width="221px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvState" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtstate" ForeColor="Red" ErrorMessage="please enter state"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Zip Code
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtzipcode" onkeypress="return isNumberKey(event);" runat="server"
                                                                    MaxLength="15" Width="221px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvzip" runat="server" ValidationGroup="Submit" ControlToValidate="txtzipcode"
                                                                    ForeColor="Red" ErrorMessage="please enter zip code" Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Phone
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtphoneno" runat="server" Width="221px" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="fvphnno" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtphoneno" ForeColor="Red" ErrorMessage="please enter phone"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Mobile
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtmobile" onkeypress="return isNumberKey(event);" runat="server"
                                                                    Width="221px" MaxLength="12"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtmobile" ForeColor="Red" ErrorMessage="please enter mobile number"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                E-mail
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtemailid" onblur="checkDuplictEmail();" MaxLength="200" runat="server"
                                                                    Width="221px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvEmailID" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtemailid" ForeColor="Red" ErrorMessage="please enter Email-ID"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="reEmailID" Enabled="true" ErrorMessage="Email Address Invalid"
                                                                    ControlToValidate="txtemailid" runat="server" ValidationExpression="^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$"
                                                                    Display="Dynamic" Text="Invalid email Addresss" ValidationGroup="Submit" ForeColor="Red"
                                                                    ToolTip="Invalid email Addresss" />
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Password
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtpassword" TextMode="Password" runat="server" Width="221px" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtpassword" ForeColor="Red" ErrorMessage="please enter password"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="newUser">
                                                            <td>
                                                                Re-enter Password
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtrepassword" runat="server" TextMode="Password" MaxLength="50"
                                                                    Width="221px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvrepassword" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="txtrepassword" ForeColor="Red" ErrorMessage="please re-enter password"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                                <asp:CompareValidator ID="cvPAss" runat="server" ControlToValidate="txtrepassword"
                                                                    ControlToCompare="txtpassword" ValidationGroup="Submit" ForeColor="Red" Operator="Equal"
                                                                    ErrorMessage="Password does not match !" Text="*"></asp:CompareValidator>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                First Name
                                                            </td>
                                                            <td valign="top">
                                                                <asp:Label ID="ofname" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Last Name
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="olname" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Date Of Birth
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="odob" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Gender
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="oGender" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Address
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="oAddress1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Address Line 2
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="oaddress2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                City
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="ocity" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Country
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="ocountry" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                State
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="ostate" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Zip Code
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="ozipcode" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Phone
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="ophone" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                Mobile
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="omobile" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="oldUser">
                                                            <td>
                                                                E-mail
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="oEmail" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                My Shipping Info
                                                            </td>
                                                            <td>
                                                                <%--<asp:DropDownList ID="ddlshipinginfo" runat="server" Width="221px" AppendDataBoundItems="true"
                                                                                DataSourceID="dsShipping" DataTextField="name" DataValueField="gconstantid" onchange="return ddlshipinginfo_onchange(this);">
                                                                                <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
                                                                            </asp:DropDownList>--%>
                                                                <asp:RadioButtonList ID="ddlshipinginfo" runat="server" RepeatDirection="Vertical"
                                                                    DataSourceID="dsShipping" DataTextField="name" DataValueField="gconstantid" onclick="ddlshipinginfo_onchange(this);">
                                                                </asp:RadioButtonList>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Submit"
                                                                    ControlToValidate="ddlshipinginfo" InitialValue="" ForeColor="Red" ErrorMessage="please select shipping info"
                                                                    Text="*"></asp:RequiredFieldValidator>
                                                                <asp:SqlDataSource ID="dsShipping" runat="server" ConnectionString="<%$ConnectionStrings:myConnectionString %>"
                                                                    SelectCommand="select gconstantid,name from mstGeneralCnst where typename='Delivery Address'">
                                                                </asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="bottom" style="vertical-align: bottom;">
                                                    <div id="divDelAddress" style="display: none;">
                                                        <table class="contentstables" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td colspan="2">
                                                                    Delivery Address
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    First Name
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtfname" MaxLength="50" runat="server" Width="100px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="tfvSfname" Enabled="false" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtfname" ForeColor="Red" ErrorMessage="please enter firstname."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Last Name
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtlname" MaxLength="50" runat="server" Width="100px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvslname" Enabled="false" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtlname" ForeColor="Red" ErrorMessage="please enter last name"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    Address
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtaddress" MaxLength="200" runat="server" Width="221px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="fvsAddress" runat="server" Enabled="false" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtaddress" ForeColor="Red" ErrorMessage="please enter address"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    Address Line 2
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtaddress2" MaxLength="200" runat="server" Width="221px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator Enabled="false" ID="rfvsAdd2" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtaddress2" ForeColor="Red" ErrorMessage="please enter address line2"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    City
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtcity" MaxLength="100" runat="server" Width="221px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator Enabled="false" ID="rfvSCity" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtcity" ForeColor="Red" ErrorMessage="please enter city"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    Country
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="shipddlcountry" runat="server" Width="221px" AppendDataBoundItems="true"
                                                                        DataSourceID="dsCountry" DataTextField="Country" DataValueField="ID">
                                                                        <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvSCountry" runat="server" Enabled="false" ValidationGroup="Submit"
                                                                        ControlToValidate="shipddlcountry" ForeColor="Red" InitialValue="0" ErrorMessage="please select delivery address country"
                                                                        >*</asp:RequiredFieldValidator>
                                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ConnectionStrings:myConnectionString %>"
                                                                        SelectCommand="select ID,Country from MstCountry where ActiveFlag = 1"></asp:SqlDataSource>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    State
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtstate" runat="server" MaxLength="100" Width="221px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvsState" Enabled="false" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtstate" ForeColor="Red" ErrorMessage="please enter delivery address state"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    Zip Code
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtzipcode" onkeypress="return isNumberKey(event);" MaxLength="15"
                                                                        runat="server" Width="221px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="fvZipCode" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtzipcode" Enabled="false" ForeColor="Red" ErrorMessage="please enter delivery address zip code"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    Phone
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtphoneno" runat="server" MaxLength="15" Width="221px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvPhoneNo" Enabled="false" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtphoneno" ForeColor="Red" ErrorMessage="please enter delivery address phone no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="text-right">
                                                                    Mobile
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="shiptxtmobile" MaxLength="12" onkeypress="return isNumberKey(event);"
                                                                        runat="server" Width="221px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvSMobile" Enabled="false" runat="server" ValidationGroup="Submit"
                                                                        ControlToValidate="shiptxtmobile" ForeColor="Red" ErrorMessage="please enter delivery address mobile no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="Div2">
                                            <h3 class="headerbar">
                                                Step 3: Order Information</h3>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" class="contentstables">
                                            <tr>
                                                <td colspan="4">
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
                                                <td colspan="4">
                                                    <span id="spandisc">Apply discount code
                                                        <asp:TextBox ID="txtDiscount" runat="server"></asp:TextBox>
                                                        <asp:Button ID="btnApplyDisc" runat="server" Text="Apply Discount" OnClientClick="return btnApplyDisc_clientclicked();" />
                                                    </span>
                                                    <br />
                                                    <asp:Label ID="lblDiscountMsg" Font-Bold="true" ForeColor="Blue" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="4">
                                                    <asp:Button ID="btnmodifycart" runat="server" OnClick="btnmodifycart_Click" Text="Modify Cart" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <asp:HiddenField ID="hdnRegistered" runat="server" />
                                                    <asp:HiddenField ID="hdnShippID" runat="server" />
                                                    <asp:HiddenField ID="hdnShippCharge" runat="server" />
                                                    <asp:HiddenField ID="hdnDiscountID" runat="server" />
                                                    <asp:HiddenField ID="hdnDiscountAmount" runat="server" />
                                                    <asp:HiddenField ID="hdnFreeShipmentLimit" runat="server" />
                                                    <asp:SqlDataSource ID="dsShippingCost" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                                        SelectCommand="select ShippingMstId,ShippName,DilverPerd,ShippCharge from ShippingMaste where ActiveFlag = 1">
                                                    </asp:SqlDataSource>
                                                    <asp:GridView ID="gvShipping" Width="100%" AutoGenerateColumns="false" runat="server"
                                                        DataSourceID="dsShippingCost" DataKeyNames="ShippingMstId">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <input type="radio" id='<%# "rdShipMeth_" + (Container.DataItemIndex + 1).ToString() %>'
                                                                        name="ShipMethod" onclick='<%#"ShipChecked(this,\"" + Eval("ShippingMstId") + "\",\"" + Eval("ShippCharge") + "\");" %>' />
                                                                    <asp:HiddenField ID="hdnShipId" runat="server" Value='<%# Eval("ShippingMstId") %>' />
                                                                    <asp:HiddenField ID="hdnShipChareg" runat="server" Value='<%#  Eval("ShippCharge") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Name" DataField="ShippName" />
                                                            <asp:BoundField HeaderText="Delivery period" DataField="DilverPerd" />
                                                            <asp:BoundField HeaderText="Charges" DataField="ShippCharge" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    Billing Amount
                                                </td>
                                                <td style="width: 150px">
                                                    <asp:Label ID="lblBillingAmount" runat="server" Text="0"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    Discount
                                                </td>
                                                <td style="width: 150px">
                                                    <asp:Label ID="lbldiscount" runat="server" Text="0"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    Flat Discount
                                                </td>
                                                <td style="width: 150px">
                                                    <asp:Label ID="lblFlatDiscount" runat="server" Text="0"></asp:Label>
                                                    <asp:HiddenField ID="hdnFlatDiscount" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    Shipping Amount
                                                </td>
                                                <td style="width: 150px">
                                                    <asp:Label ID="lblShippingAmount" Text="0" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    Total Amount
                                                </td>
                                                <td style="width: 150px">
                                                    <asp:Label ID="lblTotalAmount" runat="server" Text="0"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="Div3">
                                            <h3 class="headerbar">
                                                Step 4: Payment Details</h3>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="contentstables">
                                            <tr>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="rfvPaymentDetails" runat="server" ControlToValidate="radiopayment1"
                                                        ErrorMessage="please select payment details" ValidationGroup="Submit" Text="* please select payment details"
                                                        ForeColor="Red">  
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:RadioButtonList ID="radiopayment1" runat="server" RepeatDirection="Horizontal"
                                                        DataSourceID="dsPaymentMode" DataTextField="name" DataValueField="gconstantid"
                                                        onclick="oncheckchange(this)">
                                                    </asp:RadioButtonList>
                                                    <asp:SqlDataSource ID="dsPaymentMode" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                                        SelectCommand="select gconstantid,name from mstGeneralCnst where typename = 'Payment Details' and Activeflag  = 1">
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div id="divCheque" style="display: none;">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    Account Holder
                                                                    <asp:RequiredFieldValidator ID="rfvAccHOlder" runat="server" ControlToValidate="txtAccHolder"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter account holder"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAccHolder" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Account Address
                                                                    <asp:RequiredFieldValidator ID="rfvAccAddress" runat="server" ControlToValidate="txtAccAddress"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter account address"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAccAddress" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    City
                                                                    <asp:RequiredFieldValidator ID="rfvAccCity" runat="server" ControlToValidate="txtAccCity"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter city"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAccCity" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    State
                                                                    <asp:RequiredFieldValidator ID="rfvAccState" runat="server" ControlToValidate="txtAccState"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter state"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAccState" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Zip
                                                                    <asp:RequiredFieldValidator ID="rfvAccZip" runat="server" ControlToValidate="txtZip"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter payment details zip"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtZip" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Phone Number
                                                                    <asp:RequiredFieldValidator ID="rfvAccPhone" runat="server" ControlToValidate="txtAccPhone"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter payment detail phone no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAccPhone" onkeypress="return isNumberKey(event);" MaxLength="50"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Bank Name
                                                                    <asp:RequiredFieldValidator ID="rfvBankName" runat="server" ControlToValidate="txtBankName"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter bank name"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBankName" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Bank City
                                                                    <asp:RequiredFieldValidator ID="rfvBankCity" runat="server" ControlToValidate="txtBankCity"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter bank city"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBankCity" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Bank State
                                                                    <asp:RequiredFieldValidator ID="rfvBankState" runat="server" ControlToValidate="txtBankState"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter bank state"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBankState" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Bank Phone
                                                                    <asp:RequiredFieldValidator ID="rfvBankPhone" runat="server" ControlToValidate="txtBankPhone"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter bank phone no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBankPhone" onkeypress="return isNumberKey(event);" MaxLength="50"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Routing Number
                                                                    <asp:RequiredFieldValidator ID="rfvRoutingNo" runat="server" ControlToValidate="txtRoutingNo"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter routing no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtRoutingNo" onkeypress="return isNumberKey(event);" MaxLength="50"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Account Number
                                                                    <asp:RequiredFieldValidator ID="rfvAccNo" runat="server" ControlToValidate="txtAccNo"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter payment details account no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAccNo" onkeypress="return isNumberKey(event);" MaxLength="50"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Cheque Number (optional)
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtChequeNo" runat="server" MaxLength="50" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Re-Enter Account Number
                                                                    <asp:RequiredFieldValidator ID="rfvReAccNo" runat="server" ControlToValidate="txtReAccNo"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please re-enter payment details account no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtReAccNo" runat="server" onkeypress="return isNumberKey(event);"
                                                                        MaxLength="50"></asp:TextBox>
                                                                    <asp:CompareValidator ID="cvAccNo" runat="server" ControlToValidate="txtReAccNo"
                                                                        ControlToCompare="txtAccNo" ValidationGroup="Submit" ForeColor="Red" Operator="Equal"
                                                                        ErrorMessage="payment details Acc-No does not match !" Text="*"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="divCeditCard" style="display: none;">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    Card Type
                                                                    <asp:RequiredFieldValidator ID="rfvCCType" runat="server" ControlToValidate="ddlCCType"
                                                                        ForeColor="Red" ValidationGroup="Submit" InitialValue="0" Enabled="false" ErrorMessage="please select card type"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlCCType" Width="100px" runat="server" DataSourceID="dsCCType"
                                                                        DataTextField="CeditCardType" DataValueField="CeditCardTypeId" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="dsCCType" runat="server" ConnectionString="<%$ConnectionStrings:myConnectionString %>"
                                                                        SelectCommand="select * from MstCreditCardType where ActiveFlag = 1"></asp:SqlDataSource>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Name on Card
                                                                    <asp:RequiredFieldValidator ID="rfvCCName" runat="server" ControlToValidate="txtCCName"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter name of card"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCCName" MaxLength="200" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Card Number
                                                                    <asp:RequiredFieldValidator ID="rfvCreditCardNo" onkeypress="return isNumberKey(event);"
                                                                        runat="server" ControlToValidate="txtCreditCardNo" ForeColor="Red" ValidationGroup="Submit"
                                                                        Enabled="false" ErrorMessage="please enter card no." Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCreditCardNo" onkeypress="return isNumberKey(event);" MaxLength="50"
                                                                        runat="server"></asp:TextBox>
                                                                    <br />
                                                                    <asp:RegularExpressionValidator ID="CreditCardValidator" runat="server" ControlToValidate="txtCreditCardNo"
                                                                        Display="Static" ErrorMessage="Please enter valid card number" ValidationExpression="^((4\d{3})|(5[1-5]\d{2})|(6011)|(34\d{1})|(37\d{1}))-?\d{4}-?\d{4}-?\d{4}|3[4,7][\d\s-]{15}$"
                                                                        ValidationGroup="Submit" Text="*" />
                                                                    <%--http://www.aspneter.com/2011/01/a-regex-that-matches-all-credit-cards/--http://www.regular-expressions.info/creditcard.html --%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Expiry Date
                                                                    <asp:RequiredFieldValidator ID="rfvMonth" runat="server" ControlToValidate="ddlMonth"
                                                                        ForeColor="Red" ValidationGroup="Submit" InitialValue="0" Enabled="false" ErrorMessage="please enter expiry month"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                    <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="ddlYear"
                                                                        ForeColor="Red" ValidationGroup="Submit" InitialValue="0" Enabled="false" ErrorMessage="please enter expiry year"
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlMonth" Width="100px" runat="server">
                                                                        <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
                                                                        <asp:ListItem Text="Jan" Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="Feb" Value="2"></asp:ListItem>
                                                                        <asp:ListItem Text="Mar" Value="3"></asp:ListItem>
                                                                        <asp:ListItem Text="Apr" Value="4"></asp:ListItem>
                                                                        <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                                                        <asp:ListItem Text="Jun" Value="6"></asp:ListItem>
                                                                        <asp:ListItem Text="Jul" Value="7"></asp:ListItem>
                                                                        <asp:ListItem Text="Aug" Value="8"></asp:ListItem>
                                                                        <asp:ListItem Text="Sep" Value="9"></asp:ListItem>
                                                                        <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                                                                        <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                                                                        <asp:ListItem Text="Dec" Value="12"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:DropDownList ID="ddlYear" runat="server" Width="100px">
                                                                        <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
                                                                        <asp:ListItem Text="2013" Value="2013"></asp:ListItem>
                                                                        <asp:ListItem Text="2014" Value="2014"></asp:ListItem>
                                                                        <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                                                        <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                                                                        <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                                                                        <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                                                        <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                                                        <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                                                        <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                                                                        <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                                                                        <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                                                                        <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                                                                        <asp:ListItem Text="2025" Value="2025"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    CVV2
                                                                    <asp:RequiredFieldValidator ID="rfvCVV2" runat="server" ControlToValidate="txtCVV2"
                                                                        ForeColor="Red" ValidationGroup="Submit" Enabled="false" ErrorMessage="please enter cvv2 no."
                                                                        Text="*"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCVV2" onkeypress="return isNumberKey(event);" runat="server"
                                                                        MaxLength="3"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="divMailCheque" style="display: none;">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    Mail Cheque OR Money Order
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trMEdicalHeader" runat="server">
                                    <td>
                                        <div id="Div4">
                                            <h3 class="headerbar">
                                                Step 5: Medical Information</h3>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trMedicalDetaila" runat="server">
                                    <td>
                                        <table width="100%" runat="server" id="tblMedicalPres" runat="server" class="contentstables">
                                            <tr>
                                                <td>
                                                    <asp:RadioButtonList ID="rblMedical" runat="server" RepeatDirection="Vertical" DataSourceID="dsMEdical"
                                                        DataTextField="description" DataValueField="gconstantid">
                                                    </asp:RadioButtonList>
                                                    <asp:SqlDataSource ID="dsMEdical" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                                        SelectCommand="select gconstantid,description from mstGeneralCnst where typename = 'Medical Info'">
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="medicalInfo">
                                                        <table width="100%">
                                                            <tr>
                                                                <td class="stylesuhead">
                                                                    1. Personal Health Indices
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table align="center">
                                                                        <tr>
                                                                            <td class="text-right">
                                                                                Name
                                                                            </td>
                                                                            <td class="text-left">
                                                                                <asp:Label ID="lblgetdbname" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-right">
                                                                                Sex
                                                                            </td>
                                                                            <td class="text-left">
                                                                                <asp:Label ID="lblgetdbsex" Text="Male" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-right">
                                                                                Age
                                                                            </td>
                                                                            <td class="text-left">
                                                                                <asp:Label ID="lblgetdbage" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-right">
                                                                                Height
                                                                                <asp:RequiredFieldValidator ID="rfvHeight" CssClass="medicalValidate" runat="server"
                                                                                    ForeColor="Red" ValidationGroup="Submit" ControlToValidate="txtPersonalheight"
                                                                                    ErrorMessage="please enter your height" Text="*"></asp:RequiredFieldValidator>
                                                                            </td>
                                                                            <td class="text-left">
                                                                                <asp:TextBox ID="txtPersonalheight" onkeypress="return isNumberKey(event);" MaxLength="4"
                                                                                    runat="server"></asp:TextBox>
                                                                                <asp:DropDownList ID="ddlPersonalheight" runat="server" Width="60px" DataSourceID="dsHeight"
                                                                                    DataTextField="name" DataValueField="gconstantid">
                                                                                </asp:DropDownList>
                                                                                <asp:SqlDataSource ID="dsHeight" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                                                                    SelectCommand="select gconstantid,name from mstGeneralCnst where typename = 'Height Unit' and activeflag = 1">
                                                                                </asp:SqlDataSource>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-right">
                                                                                Weight
                                                                                <asp:RequiredFieldValidator ID="rfvWeight" CssClass="medicalValidate" ForeColor="Red"
                                                                                    runat="server" ValidationGroup="Submit" ControlToValidate="txtPersonalweight"
                                                                                    ErrorMessage="please enter your weight" Text="*"></asp:RequiredFieldValidator>
                                                                            </td>
                                                                            <td class="text-left">
                                                                                <asp:TextBox ID="txtPersonalweight" MaxLength="4" runat="server" onkeypress="return isNumberKey(event);"></asp:TextBox>LBS.
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-right">
                                                                                Medical Condition drug required for
                                                                                <asp:RequiredFieldValidator ID="rfvMedicalCondition" CssClass="medicalValidate" ForeColor="Red"
                                                                                    runat="server" ValidationGroup="Submit" ControlToValidate="txtPersonalmedicalcondition"
                                                                                    ErrorMessage="please enter medical condition drug required for" Text="*"></asp:RequiredFieldValidator>
                                                                            </td>
                                                                            <td class="text-left">
                                                                                <asp:TextBox ID="txtPersonalmedicalcondition" MaxLength="200" TextMode="MultiLine"
                                                                                    runat="server"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="medicalInfo">
                                                        <table width="100%">
                                                            <tr>
                                                                <td class="stylesuhead">
                                                                    2. Past Medical History
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Select Yes Or No. If Yes provide more information in the text area.
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:SqlDataSource ID="daPastHistory" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                                                        SelectCommand="select * from MstPrescritpionQuestion  where ParentId = 1"></asp:SqlDataSource>
                                                                    <asp:Repeater ID="gvPastMedicalHistory" DataSourceID="daPastHistory" runat="server">
                                                                        <HeaderTemplate>
                                                                            <table>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td align="right">
                                                                                    <asp:HiddenField ID="hdnQuestionID" runat="server" Value='<%#Eval("QuestionID") %>' />
                                                                                    <asp:Label ID="lblQ" runat="server" Text='<%#Eval("Question") %>'></asp:Label>
                                                                                    <asp:RequiredFieldValidator ID="rfvHistory" CssClass="medicalValidate" runat="server"
                                                                                        ControlToValidate="rblHistory" InitialValue="" ValidationGroup="Submit" ForeColor="Red"
                                                                                        ErrorMessage='<%# "please answer " + Eval("Question").ToString()  + "?" %>' Text="*"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:RadioButtonList ID="rblHistory" onclick="return rblHistory_click(this,'Yes');"
                                                                                        runat="server" RepeatDirection="Horizontal">
                                                                                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                                    </asp:RadioButtonList>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtReason" MaxLength="200" runat="server"></asp:TextBox>
                                                                                    <br />
                                                                                    <asp:RequiredFieldValidator ID="rfvReason" CssClass="medicalValidate" Enabled="false"
                                                                                        runat="server" ControlToValidate="txtReason" ValidationGroup="Submit" ForeColor="Red"
                                                                                        ErrorMessage='<%# "more info for question " + Eval("Question").ToString() + "?" %>' Text="*"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            </table>
                                                                        </FooterTemplate>
                                                                    </asp:Repeater>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="medicalInfo">
                                                        <table width="100%">
                                                            <tr>
                                                                <td class="stylesuhead" colspan="2">
                                                                    3. Personal Habits
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:SqlDataSource ID="dsHabbits" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                                                        SelectCommand="select * from MstPrescritpionQuestion  where ParentId = 12"></asp:SqlDataSource>
                                                                    <asp:Repeater ID="gvHAbbits" DataSourceID="dsHabbits" runat="server">
                                                                        <HeaderTemplate>
                                                                            <table>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td align="right">
                                                                                    <asp:HiddenField ID="hdnQuestionID" runat="server" Value='<%#Eval("QuestionID") %>' />
                                                                                    <asp:Label ID="lblQ" runat="server" Text='<%#Eval("Question") %>'></asp:Label>
                                                                                    <asp:RequiredFieldValidator ID="rfvHistory" CssClass="medicalValidate" runat="server"
                                                                                        ControlToValidate="rblHistory" InitialValue="" ValidationGroup="Submit" ForeColor="Red"
                                                                                        ErrorMessage='<%# "please answer " + Eval("Question").ToString() + "?" %>' Text="*"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:RadioButtonList ID="rblHistory" onclick="return rblHistory_click(this,'Yes');"
                                                                                        runat="server" RepeatDirection="Horizontal">
                                                                                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                                    </asp:RadioButtonList>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtReason" MaxLength="200" runat="server"></asp:TextBox>
                                                                                    <br />
                                                                                    <asp:RequiredFieldValidator ID="rfvReason" CssClass="medicalValidate" Enabled="false"
                                                                                        runat="server" ControlToValidate="txtReason" ValidationGroup="Submit" ForeColor="Red"
                                                                                        ErrorMessage='<%# "more info for question " + Eval("Question").ToString() + "?" %>' Text="*"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            </table>
                                                                        </FooterTemplate>
                                                                    </asp:Repeater>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Any Other Habbits
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtOtherHabbits" runat="server" TextMode="MultiLine" Height="80px"
                                                                        Width="250"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%-- <tr>
                            <td>
                                <div>
                                    <table width="100%">--%>
                                <%-- <tr>
                                            <td class="stylesuhead" style="padding: 0 30px 0 30px;">
                                               
                                            </td>
                                        </tr>--%>
                                <tr>
                                    <td class="stylesuhead" colspan="2">
                                        Terms & User Acceptance For Issuing Prescription
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        If you DISAGREE, please explain why consuming this medications is not harmful to
                                        your health. (Use the text area to enter details)
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:SqlDataSource ID="dsAgreement" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                                            SelectCommand="select * from MstPrescritpionQuestion  where ParentId = 17 and ActiveFlag=1">
                                        </asp:SqlDataSource>
                                        <asp:Repeater ID="rptAgreement" DataSourceID="dsAgreement" runat="server">
                                            <HeaderTemplate>
                                                <table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td align="right">
                                                        <asp:HiddenField ID="hdnQuestionID" runat="server" Value='<%#Eval("QuestionID") %>' />
                                                        <asp:Label ID="lblQ" runat="server" Text='<%#Eval("Question") %>'></asp:Label>
                                                        <asp:RequiredFieldValidator ID="rfvHistory" CssClass="medicalValidate" runat="server"
                                                            ControlToValidate="rblHistory" InitialValue="" ValidationGroup="Submit" Display="Dynamic"
                                                            ForeColor="Red" ErrorMessage='<%# "please answer " + Eval("Question").ToString() + "?" %>'
                                                            Text="*"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <asp:RadioButtonList ID="rblHistory" onclick="return rblHistory_click(this,'Disagree');"
                                                            runat="server" RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="I Agree" Value="I Agree"></asp:ListItem>
                                                            <asp:ListItem Text="Disagree" Value="Disagree"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtReason" MaxLength="200" runat="server"></asp:TextBox>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="rfvReason" CssClass="medicalValidate" Enabled="false"
                                                            runat="server" ControlToValidate="txtReason" ValidationGroup="Submit" ForeColor="Red"
                                                            ErrorMessage='<%# "more info for question " + Eval("Question").ToString() + "?" %>' Text="*"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </td>
                                </tr>
                                <%-- </table>
                                </div>
                            </td>
                        </tr>--%>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkaccept" onclick="chkaccept_checked(this);" Text=" I have read, I understand and accept the PillsinCart Disclaimer "
                                            runat="server" />
                                    </td>
                                </tr>
                                <tr class="trSubmit" style="display: none;">
                                    <td>
                                        <%--<asp:TextBox runat="server" ID="txtyag" />
                                        <asp:RequiredFieldValidator ErrorMessage="test yagnesh" Text="*" ControlToValidate="txtyag"
                                            ValidationGroup="Submit" runat="server" Display="Dynamic" />--%>
                                        <asp:Button ID="btnsubmitorder" runat="server" Text="Submit Order" ValidationGroup="Submit"
                                            OnClick="btnsubmitorder_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
