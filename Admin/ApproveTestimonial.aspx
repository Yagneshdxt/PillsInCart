<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="ApproveTestimonial.aspx.cs" Inherits="Admin_ApproveTestimonial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" width="100%">
        <tr>
            <td>
                Testimonial
                <asp:TextBox runat="server" ID="txtTestimonial" MaxLength="100" />
            </td>
            <td>
                User Name
                <asp:TextBox runat="server" ID="txtUserName" MaxLength="100" />
            </td>
            <td>
                Status:
                <asp:DropDownList runat="server" ID="ddlStatusFil">
                    <asp:ListItem Text="--Select--" Value="00" />
                    <asp:ListItem Text="Active" Value="1" />
                    <asp:ListItem Text="InActive" Value="0" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdTestimonial" runat="server" AutoGenerateColumns="False" PageSize="10"
        AllowPaging="true" Width="100%" OnPageIndexChanging="grdTestimonial_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Testimonial" ItemStyle-Width="550px">
                <ItemTemplate>
                    <asp:Label ID="lblname" runat="server" Text='<% #Eval("Testimonial") %>'></asp:Label>
                    <asp:HiddenField ID="hdnTestmonId" Value='<% #Eval("TestimonialID") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:Label ID="lblfname" runat="server" Text='<%#Eval("fName")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Created Date">
                <ItemTemplate>
                    <asp:Label ID="lblCreatedDt" runat="server" Text='<%#Eval("Creteddt")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("tMoStatus")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Edit">
                <ItemTemplate>
                    <asp:LinkButton Text='<%# (Eval("tMoStatus").ToString() == "Active")?"Inactive":"Activate" %>'
                        ID="lnkupdate" runat="server" CommandArgument='<%# Eval("ActiveFlag ") %>' OnClick="lnkupdate_Click" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton Text="Delete" ID="lnkDelete" runat="server" OnClick="lnkDelete_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
