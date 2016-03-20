<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="ViewProduct.aspx.cs" Inherits="Admin_ViewProduct" ValidateRequest="false"
    EnableEventValidation="false" EnableViewStateMac="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table>
        <tr>
            <td>
                Product Id:
                <asp:TextBox ID="txtProductID" runat="server" />
            </td>
            <td>
                name:
                <asp:TextBox ID="txtnamefilter" runat="server" />
            </td>
            <td>
                Category:
                <asp:TextBox ID="txtCategory" runat="server" />
            </td>
            <td>
                Sub Category:
                <asp:TextBox ID="txtSubCategory" runat="server" />
            </td>
            <td>
                Status:
                <asp:DropDownList runat="server" ID="ddlStatusFil">
                    <asp:ListItem Text="--Select--" Value="--Select--" />
                    <asp:ListItem Text="Active" Value="1" />
                    <asp:ListItem Text="InActive" Value="0" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    <p>
    </p>
    <asp:GridView runat="server" ID="grdProdLst" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true"
        PageSize="10" OnPageIndexChanging="grdProdLst_PageIndexChanging">
        <EmptyDataTemplate>
            No Records found
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Prodcut Id">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("prdiddisplay") %>' ID="lblPrdDisplay" runat="server" />
                    <asp:HiddenField ID="hdnProdID" runat="server" Value='<%# Eval("productid") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("catName") %>' ID="lblcatName" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sub Category">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("SubCatName") %>' ID="lblSubCatName" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Name">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("pName")  %>' ID="lblpName" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Short Name">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("ShortName") %>' ID="lblShortName" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description">
                <ItemTemplate>
                    <asp:Label Text='<%# Cutdesc(Eval("description")) %>' ID="lblDesciption" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("ActiveState") %>' ID="lblActiveState" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Edit/Delete">
                <ItemTemplate>
                    <a href='<%# "ProdEdit.aspx?PID=" + Eval("productid") %>' runat="server">Edit </a>
                    <asp:LinkButton Text="Delete" ID="lnkDelet" runat="server" OnClick="lnkDelet_Click"
                        OnClientClick="Javascript:return confirm('Do you want to delete?');" />
                    <%--<asp:LinkButton ID="lnkDelet" Text="Delete" Visible='<%# (Eval("ActiveState").ToString() == "Active") %>' runat="server" OnClick="lnkDelet_Click" OnClientClick="Javascript:return confirm('Do you want to Delete?');" />--%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
