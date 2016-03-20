<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCreation/MasterPage.master"
    AutoEventWireup="true" CodeFile="BecomeAnAffiliate.aspx.cs" Inherits="Affiliate_BecomeAnAffiliate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" class="short-table">
        <tr>
            <td colspan="3">
                <b>Bank Details </b>
            </td>
        </tr>
        <tr>
            <td>
                Benificiary name
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtbenname" MaxLength="90" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ErrorMessage="Please enter Benificiary name"
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtbenname" runat="server"
                    Text="*" ValidationGroup="ValbankDetails" />
            </td>
        </tr>
        <tr>
            <td>
                Benificiary Address
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtbeneaddress" MaxLength="200" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ErrorMessage="Please enter Benificiary Address"
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtbeneaddress" runat="server"
                    Text="*" ValidationGroup="ValbankDetails" />
            </td>
        </tr>
        <tr>
            <td>
                Account No.
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtAccountNo" MaxLength="90" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Please enter account no"
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtAccountNo" runat="server"
                    Text="*" ValidationGroup="ValbankDetails" />
            </td>
        </tr>
        <tr>
            <td>
                Bank Name
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtbankName" MaxLength="300" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ErrorMessage="Please enter Bank Name"
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtbankName" runat="server"
                    Text="*" ValidationGroup="ValbankDetails" />
            </td>
        </tr>
        <tr>
            <td>
                Branch Address
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtBranchName" MaxLength="500" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ErrorMessage="Please enter Branch Address"
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtBranchName" runat="server"
                    Text="*" ValidationGroup="ValbankDetails" />
            </td>
        </tr>
        <tr>
            <td>
                Swift Code
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtswiftcode" MaxLength="40" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ErrorMessage="Please enter Swift Code"
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtswiftcode" runat="server"
                    Text="*" ValidationGroup="ValbankDetails" />
            </td>
        </tr>
        <tr>
            <td>
                Routing No
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtRoutingno" MaxLength="90" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage="Please enter Routing No"
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtRoutingno" runat="server"
                    Text="*" ValidationGroup="ValbankDetails" />
            </td>
        </tr>
        <tr>
            <td>
                Correspondent Bank Name(Optional)
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtcorrbankname" MaxLength="500" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                Correspondent Bank Account No.(Optional)
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtcorracctno" MaxLength="300" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                Commission
            </td>
            <td>
                <asp:Label Text="0.00" ID="lblCommission" runat="server" />
                %
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:ValidationSummary runat="server" ID="valSumBankDetails" ValidationGroup="ValbankDetails"
                    ShowSummary="true" DisplayMode="List" />
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button Text="Update Details" ID="btnUpdtBnkDtais" runat="server" OnClick="btnUpdtBnkDtais_Click"
                    CausesValidation="true" ValidationGroup="ValbankDetails" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <table width="100%" class="short-table">
                <tr>
                    <td colspan="2">
                        <b>Select Product</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        Root Category *
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlrootCategory" OnSelectedIndexChanged="ddlrootCategory_SelectedIndexChanged"
                            AutoPostBack="true">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ErrorMessage="Please Select Root Category" Text="Please Select Root Category"
                            Display="Dynamic" ControlToValidate="ddlrootCategory" ValidationGroup="becoAffilVali"
                            InitialValue="0" runat="server" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Category *
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCategory" runat="server" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"
                            AutoPostBack="true">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Please Select Category"
                            Text="Please Select Category" Display="Dynamic" ControlToValidate="ddlCategory"
                            ValidationGroup="becoAffilVali" InitialValue="0" runat="server" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Product *
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlProduct" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Please Select Product"
                            Text="Please Select Product" Display="Dynamic" ControlToValidate="ddlProduct"
                            ValidationGroup="becoAffilVali" InitialValue="0" runat="server" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button Text="Become an Affiliate" runat="server" ID="btngetLink" OnClick="btngetLink_Click"
                            CausesValidation="true" ValidationGroup="becoAffilVali" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Affiliate Link
                    </td>
                    <td>
                        <asp:Label Text="" ID="lnkAffiliate" runat="server" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <b>
        <asp:HyperLink NavigateUrl="~/Affiliate/AffiliateDetails.aspx" Text="View your Affiliate Details"
            runat="server" /></b>
    <!--
    <asp:GridView ID="grdAffiliate" runat="server" AutoGenerateColumns="False" PageSize="20"
        AllowPaging="true" Width="100%" OnPageIndexChanging="grdAffiliate_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Product Id">
                <ItemTemplate>
                    <asp:Label ID="lblProId" runat="server" Text='<%# Eval("productId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product Name">
                <ItemTemplate>
                    <asp:Label ID="lblProName" runat="server" Text='<%# Eval("productName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Affiliate Link">
                <ItemTemplate>
                    <asp:Label ID="lblAffiliateUrl" runat="server" Text='<%# createAffiliateLink(Eval("affiliateId"), Eval("logoimgPath"),Eval("ShortName")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblActiveInac" runat="server" Text='<%# Eval("ActiveInactive") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    -->
</asp:Content>
