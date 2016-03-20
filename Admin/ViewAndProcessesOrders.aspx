<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="ViewAndProcessesOrders.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $('.chkHeader').click(function () {

                if ($('.chkHeader input').prop('checked')) {
                    $('#<%=gvShowOrders.ClientID %> .chkApprove input:radio').each(function (a, b) {
                        $(this).prop('checked', 'checked');
                    });
                    $('#<%=gvShowOrders.ClientID %> .chkDecline input:radio').each(function (a, b) {
                        $(this).prop('checked', '');
                    });
                } else {
                    $('#<%=gvShowOrders.ClientID %> input:radio').each(function (a, b) {
                        $(this).prop('checked', '');
                    });
                }

            });

            $(".lnkdelete").click(function () {
                var Confirmvalue = confirm("Are you sure you want to delete order. /n Deleting Order will not have any traces of order in future.");
                return Confirmvalue;

            });

            $('.chkHeaderDecline').click(function () {

                if ($('.chkHeaderDecline input').prop('checked')) {
                    $('#<%=gvShowOrders.ClientID %> .chkDecline input:radio').each(function (a, b) {
                        $(this).prop('checked', 'checked');
                    });
                    $('#<%=gvShowOrders.ClientID %> .chkApprove input:radio').each(function (a, b) {
                        $(this).prop('checked', '');
                    });
                } else {
                    $('#<%=gvShowOrders.ClientID %> .chkDecline input:radio').each(function (a, b) {
                        $(this).prop('checked', '');
                    });
                }

            });
        });
    </script>
    <div>
        <strong>VIEW / PROCESS ORDERS</strong>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr>
            <td>
                <asp:SqlDataSource ID="dsOrders" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                    SelectCommand="getOrderHeader" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:GridView ID="gvShowOrders" DataSourceID="dsOrders" runat="server" AutoGenerateColumns="false"
                    DataKeyNames="OrderHeaderId,OrderStatus,EmailID,UserName" OnRowDataBound="gvShowOrders_RowDataBound"
                    PageSize="10" OnPageIndexChanging="gvShowOrders_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:RadioButton ID="chkApprove" GroupName="gn" Text="Approve all" runat="server"
                                    CssClass="chkHeader" />
                                <br />
                                <asp:RadioButton ID="chkDecline" GroupName="gn" Text="Decline all" runat="server"
                                    CssClass="chkHeaderDecline" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:RadioButton ID="chkApprove" runat="server" CssClass="chkApprove" Visible='<%# (Eval("OrderStatus").ToString() == "Pending") %>'
                                    Text="Approve" />
                                <br />
                                <asp:RadioButton ID="chkDecline" runat="server" CssClass="chkDecline   " Visible='<%# (Eval("OrderStatus").ToString() == "Pending") %>'
                                    Text="Decline" />
                            </ItemTemplate>
                            <HeaderStyle Width="180px" HorizontalAlign="Left" />
                            <ItemStyle Width="180px" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Order No" ItemStyle-Width="120px">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkView" runat="server" Text='<%#Eval("DisplayID") %>' NavigateUrl='<%#Eval("Path") %>'
                                    Target="_blank"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Customer" DataField="UserName" ItemStyle-Width="200px" />
                        <asp:BoundField HeaderText="Order Date" DataField="CreatedDate" DataFormatString="{0:dd-MMM-yyyy mm:hh tt}"
                            ItemStyle-Width="220px" />
                        <asp:BoundField HeaderText="Billed Amount" DataField="Total" ItemStyle-Width="120px"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Shipping Charge" DataField="ShippingCharge" ItemStyle-Width="120px"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Flat Discount" DataField="FlatDiscount" ItemStyle-Width="120px"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Discount" DataField="DiscountAmt" ItemStyle-Width="120px"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Total" DataField="FinalAmt" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Order Status" DataField="OrderStatus" ItemStyle-Width="100px" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton Text="Delete" ID="lnkDelete" CssClass="lnkdelete" runat="server"
                                    CommandArgument='<%#Eval("OrderHeaderId") %>' OnClick="lnkDelete_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <center>
                    <asp:Button ID="btnAppove" runat="server" Text="SUBMIT" OnClick="btnAppove_Click" />
                </center>
            </td>
        </tr>
    </table>
</asp:Content>
