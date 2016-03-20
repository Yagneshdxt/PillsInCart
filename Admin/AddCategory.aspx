<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="AddCategory.aspx.cs" Inherits="Admin_AddCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <strong>Category Add</strong>
    </div>
    <table>
        <tr>
            <td>
                <asp:Label Text="Main Category" ID="lblMainCategory" runat="server" />
            </td>
            <td>
                <asp:DropDownList ID="ddlmaincategory" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ErrorMessage="Please select Main Category" ControlToValidate="ddlmaincategory"
                    ID="rfvMainCate" Text="*" InitialValue="0" ForeColor="Red" runat="server" Display="Dynamic"
                    ValidationGroup="valAddCat" />
                <%-- <asp:CompareValidator ID="cmpElevel" runat="server" ControlToValidate="ddlmaincategory"
                    ErrorMessage="Please select Main Category" Text="*" Operator="NotEqual" ValueToCompare="0"
                    Display="Dynamic" ValidationGroup="valAddCat"></asp:CompareValidator>--%>
            </td>
        </tr>
        <tr>
            <td>
                Category Name
            </td>
            <td>
                <asp:TextBox ID="txtcategory" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Please enter category Name" ControlToValidate="txtcategory"
                    ID="RequiredFieldValidator1" Text="*" ForeColor="Red" runat="server" Display="Dynamic"
                    ValidationGroup="valAddCat" />
              <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Please do not enter special character for Name"
                    ControlToValidate="txtcategory" runat="server" ValidationExpression="^[a-zA-Z''_'\s]{1,100}$"
                    Display="Dynamic" Text="*" ValidationGroup="valAddCat" ForeColor="Red" ToolTip="Numeric" />--%>
            </td>
        </tr>
        <tr>
            <td>
                Description
            </td>
            <td>
                <asp:TextBox ID="txtcategorydesc" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Description length is more than valid length"
                    ControlToValidate="txtcategorydesc" runat="server" ValidationExpression="(\s|.){0,5000}$"
                    Display="Dynamic" Text="*" ValidationGroup="valAddCat" ForeColor="Red" ToolTip="Numeric" />
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
                <asp:Button ID="btnSubmit" runat="server" Text="Add" OnClick="btnSubmit_Click" CausesValidation="true"
                    ValidationGroup="valAddCat" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                    CausesValidation="true" ValidationGroup="valAddCat" Visible="false" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                    Visible="false" />
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="valAddCat" ShowMessageBox="true"
                    DisplayMode="List" HeaderText="Add Category Erro" ShowSummary="false" />
            </td>
        </tr>
    </table>
    <p>
    </p>
    <div>
        <table>
            <tr>
                <td>
                    name:
                    <asp:TextBox ID="txtnamefilter" runat="server" />
                </td>
                <td>
                    Type:
                    <asp:TextBox ID="txtTypefilter" runat="server" />
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
                <td>
                </td>
            </tr>
        </table>
    </div>
    <div class="gridH">
        <asp:GridView ID="grdCategory" runat="server" AutoGenerateColumns="False" PageSize="10"
            Width="100%" onpageindexchanging="grdCategory_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="lblname" runat="server" Text='<% #Eval("name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Type">
                    <ItemTemplate>
                        <asp:Label ID="lbltype" runat="server" Text='<%#Eval("categorytype")%>'></asp:Label>
                        <asp:HiddenField ID="hdnCategorType" Value='<%# Eval("catType") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <asp:Label ID="lbldesc" runat="server" Text='<%#Eval("description")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:TemplateField HeaderText="Created By">
                <ItemTemplate>
                    <asp:Label ID="lblcreatedby" runat="server" Text='<%#Eval("createdby")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Created Date">
                <ItemTemplate>
                    <asp:Label ID="lblcreateddate" runat="server" Text='<%#Eval("createddate")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Modified By">
                <ItemTemplate>
                    <asp:Label ID="lblmodifiedby" runat="server" Text='<%#Eval("modifiedby")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Modified Date">
                <ItemTemplate>
                    <asp:Label ID="modifieddate" runat="server" Text='<%#Eval("modifieddate")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblactive" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                        <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("activeflag") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton Text="Edit" ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" />
                        <asp:LinkButton Text="Delete" ID="lnkDelete" runat="server" OnClick="lnkDelete_Click"
                            OnClientClick="Javascript:return confirm('Do you want to delete?');" />
                        <asp:HiddenField ID="hdnCategorID" Value='<%# Eval("categoryid") %>' runat="server" />
                        <asp:HiddenField ID="hdnfolName" Value='<%# Eval("folderName") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:HiddenField ID="hdnfolderName" runat="server" />
    <asp:HiddenField ID="hdnCateId" runat="server" />
</asp:Content>
