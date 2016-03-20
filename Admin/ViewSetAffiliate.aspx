<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="ViewSetAffiliate.aspx.cs" Inherits="Admin_ViewSetAffiliate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0">
        <tr>
            <td>
                Affiliate Name
                <asp:TextBox runat="server" ID="txtAffiliate" MaxLength="100" />
            </td>
            <td>
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdAffiliate" runat="server" AutoGenerateColumns="False" PageSize="20"
        AllowPaging="true" Width="100%" OnPageIndexChanging="grdAffiliate_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Affiliate Name">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "~/Admin/ViewAffiliateOrder.aspx?UserId=" + Eval("userId").ToString() %>'
                        Text='<%# Eval("fName") %>' runat="server"></asp:HyperLink>
                    <%--<asp:Label Text='<%# Eval("fName") %>' runat="server" ID="lblFirstName" />--%>
                    <asp:HiddenField ID="hdnuserId" Value='<%# Eval("userId") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Contact Info">
                <ItemTemplate>
                    Email Id :
                    <asp:Label Text='<%# Eval("EmailID") %>' runat="server" ID="lblemailID" />
                    <br />
                    Mobile No :
                    <asp:Label Text='<%# Eval("Mobile") %>' runat="server" ID="lblMobile" />
                    <br />
                    Phone No :
                    <asp:Label Text='<%# Eval("phone") %>' runat="server" ID="lblphone" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Account No/Swift Code/Routing No">
                <ItemTemplate>
                    <div style="overflow: auto; height: 100px;">
                        <asp:Label Text='<%# Eval("bankAccNo_aff") %>' runat="server" ID="lblAccountNo" />/
                        <br />
                        <%# Eval("SwiftCode")%>
                        <br />
                        <%# Eval("RoutingNo")%>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Benificiary Name/Benificiary Address">
                <ItemTemplate>
                    <div style="overflow: auto; height: 100px;">
                        <asp:Label Text='<%# Eval("Benificiaryname") %>' runat="server" ID="lblBenificiaryname" />/
                        <br />
                        <%# Eval("BenificiaryAddress")%>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Bank Name/Bank Address">
                <ItemTemplate>
                    <div style="overflow: auto; height: 100px;">
                        <asp:Label Text='<%# Eval("bankName_aff") %>' runat="server" ID="lblBankName" />/
                        <br />
                        <%# Eval("bankBranchName_aff") %>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Corr Bank Account No/Name">
                <ItemTemplate>
                    <div style="overflow: auto; height: 100px;">
                        <asp:Label Text='<%# Eval("CorrespondentBankActNo") %>' runat="server" ID="lblBranchName" />
                        <br />
                        <%# Eval("CorrespondentBankName")%>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Commission %">
                <ItemTemplate>
                    <asp:TextBox Text='<%# Eval("commisonPer_aff") %>' runat="server" ID="txtCommission" />
                    <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="txtCommission" Text="*"
                        ForeColor="Red" ValidationGroup='<%# "valPerCommision" + Container.DataItemIndex %>'
                        runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:Button Text="Update" ID="btnUpdtCommision" runat="server" OnClick="btnUpdtCommision_Click"
                        CausesValidation="true" ValidationGroup='<%# "valPerCommision" + Container.DataItemIndex %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
