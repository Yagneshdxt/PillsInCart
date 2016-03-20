<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="ApproveComments.aspx.cs" Inherits="Admin_ApproveComments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">
        function headerchk() {
            var header = ("div[grid=inner] span[checktype=header] input");
            var child = ("div[grid=inner] span[checktype=child] input");

            if ($("#MainContent_gvComments_chkAll").is(':checked')) {

                $(".chdck input").attr("checked", "checked");
            }
            else {
                $(".chdck input").attr("checked", false);
            }
        }

        function childchk() {
            var header = ("div[grid=inner] span[checktype=header] input");
            var child = ("div[grid=inner] span[checktype=child] input");
            var cnt = 0;
            $(".chdck input").each(function () {
                cnt++;
            });
            var num = 0;
            $(".chdck input").each(function () {

                if ($("#" + $(this).attr("id")).is(":checked")) {
                    num++;
                }
            });
            if (num == cnt)
                $(".chdpk input").attr('checked', 'checked');
            else
                $(".chdpk input").removeAttr('checked');
        }
    </script>
    <div class="gridH">
        <asp:GridView ID="gvComments" DataKeyNames="commentId,BlogId" runat="server" PageSize="15"
            AutoGenerateColumns="false" OnPageIndexChanging="gvComments_PageIndexChanging">
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Blog Name">
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" runat="server" checktype="header" onclick="headerchk()"
                            CssClass="chdpk" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkbox" runat="server" checktype="child" CssClass="chdck" onclick="childchk()" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Blog Name">
                    <ItemTemplate>
                        <asp:Label ID="lblBlogName" runat="server" Text='<%#Eval("BName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Comments">
                    <ItemTemplate>
                        <asp:Label ID="lblComment" runat="server" Text='<%#Eval("bcomments") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Created on">
                    <ItemTemplate>
                        <asp:Label ID="lblCreatedDate" runat="server" Text='<%#Eval("Createddate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div>
        <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="btnApprove_Click" />
        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
    </div>
</asp:Content>
