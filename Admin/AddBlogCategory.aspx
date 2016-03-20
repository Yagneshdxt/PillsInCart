<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="AddBlogCategory.aspx.cs" Inherits="Admin_AddBlogCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" cellpadding="5" cellspacing="5">
        <tr>
            <td>
                Root Category Name
            </td>
            <td>
                <asp:TextBox ID="txtcategoryname" runat="server" MaxLength="98"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcategoryname"
                    ErrorMessage="Please enter Root Category Name" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
               <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Please do not enter special character for Name"
                    ControlToValidate="txtcategoryname" runat="server" ValidationExpression="^[a-zA-Z''_'\s]{1,100}$"
                    Display="Dynamic" Text="*" ValidationGroup="btnadd" ForeColor="Red" ToolTip="Numeric" />--%>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:RadioButton ID="radioactive" runat="server" Text="Active" Checked="True" GroupName="act" />
                <asp:RadioButton ID="radiodeactive" runat="server" Text="Deactive" GroupName="act" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:CheckBox ID="chkIsDisplayOnHomePage" runat="server" Text="Display On IndexPage" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Add" OnClick="btnSubmit_Click" CausesValidation="true"
                    ValidationGroup="btnadd" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                    CausesValidation="true" ValidationGroup="btnadd" Visible="false" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                    Visible="false" />
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnadd" ShowMessageBox="true"
                    DisplayMode="List" HeaderText="Add Category Error" ShowSummary="false" />
            </td>
        </tr>
    </table>
    <p>
    </p>
    <table width="100%">
        <tr>
            <td>
                Root Category Name:
                <asp:TextBox ID="txtProductID" runat="server" />
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
    <div class="gridH">
        <asp:GridView ID="grdRootcat" runat="server" DataKeyNames="IsIndexDisplay" AutoGenerateColumns="false"
            PageSize="10" Width="100%" 
            onpageindexchanging="grdRootcat_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Root Category Name">
                    <ItemTemplate>
                        <asp:Label ID="lblrootcatnmae" runat="server" Text='<%#Eval("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblactive" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                        <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("ActiveFlage") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Display On Home Page">
                    <ItemTemplate>
                        <asp:Label ID="lblIsDisplayOnHomePage" runat="server" Text='<%#Eval("IsHomePageDisplay") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton Text="Edit" ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" />
                        <asp:LinkButton Text="Delete" ID="lnkDelete" runat="server" OnClick="lnkDelete_Click"
                            OnClientClick="Javascript:return confirm('Do you want to delete?');" />
                        <asp:HiddenField ID="hdnRootCategorID" Value='<%# Eval("RootCategoryID") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:HiddenField ID="hdrootid" runat="server" />
    <asp:HiddenField ID="hdnRootCategoryName" runat="server" />
</asp:Content>
