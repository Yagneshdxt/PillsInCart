<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="Discountpage.aspx.cs" Inherits="Admin_discountpage"  MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" cellpadding="5" cellspacing="5">
        <tr>
            <td>
                Discount On
            </td>
            <td>
                <asp:DropDownList ID="ddlDiscounton" runat="server" AutoPostBack="True" Height="22px"
                    OnSelectedIndexChanged="ddlDiscounton_SelectedIndexChanged" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Please select Discount On"
                    Display="Dynamic" Text="*" ForeColor="Red" ControlToValidate="ddlDiscounton"
                    runat="server" InitialValue="0" ValidationGroup="btnadd" />
            </td>
        </tr>
        <tr>
            <td>
                Root Category
            </td>
            <td>
                <asp:DropDownList ID="ddlProductCat" runat="server" AutoPostBack="True" Height="22px"
                    OnSelectedIndexChanged="ddlProductCat_SelectedIndexChanged1" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvRootCategory" ErrorMessage="Please select Root Category"
                    Display="Dynamic" Text="*" ForeColor="Red" ControlToValidate="ddlProductCat"
                    runat="server" InitialValue="0" ValidationGroup="btnadd" />
            </td>
        </tr>
        <tr>
            <td>
                Sub Category
            </td>
            <td>
                <asp:DropDownList ID="ddlSubCat" runat="server" AutoPostBack="True" Height="22px"
                    OnSelectedIndexChanged="ddlSubCat_SelectedIndexChanged" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvSubCategory" ErrorMessage="Please select Sub Category"
                    Display="Dynamic" Text="*" ForeColor="Red" ControlToValidate="ddlSubCat" runat="server"
                    InitialValue="0" ValidationGroup="btnadd" />
            </td>
        </tr>
        <tr>
            <td>
                Products
            </td>
            <td>
                <asp:DropDownList ID="ddlProduct" runat="server" Height="22px" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvProduct" ErrorMessage="Please select Product"
                    Display="Dynamic" Text="*" ForeColor="Red" ControlToValidate="ddlProduct" runat="server"
                    InitialValue="0" ValidationGroup="btnadd" />
            </td>
        </tr>
        <tr>
            <td>
                Discount Amount
            </td>
            <td>
                <asp:TextBox ID="txtDiscountAm" runat="server" Height="22px" Width="200px" MaxLength="4"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDiscountAm"
                    ErrorMessage="Please enter discount amount" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
                <asp:FilteredTextBoxExtender ID="txtDiscountAm_FilteredTextBoxExtender" runat="server"
                    Enabled="True" FilterType="Numbers" TargetControlID="txtDiscountAm">
                </asp:FilteredTextBoxExtender>
            </td>
        </tr>
        <tr>
            <td>
                Discount Type
            </td>
            <td>
                <asp:DropDownList ID="ddlDiscounttype" runat="server" Height="22px" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage="Please select Discount type"
                    Display="Dynamic" ForeColor="Red" Text="*" ControlToValidate="ddlDiscounttype"
                    runat="server" InitialValue="0" ValidationGroup="btnadd" />
            </td>
        </tr>
        <tr>
            <td>
                Maximum Peoples To Get Discount
            </td>
            <td>
                <asp:TextBox ID="txtMaxPeople" MaxLength="4" runat="server" Height="22px" Width="200px"></asp:TextBox>
                <%--                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMaxPeople"
                    ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>--%>
                <asp:FilteredTextBoxExtender ID="FilBoxExMaxPeople" ClientIDMode="AutoID" runat="server"
                    Enabled="True" TargetControlID="txtMaxPeople" FilterType="Numbers">
                </asp:FilteredTextBoxExtender>
            </td>
        </tr>
        <tr>
            <td>
                Disount Validity Days
            </td>
            <td>
                <asp:TextBox ID="txtValiditydays" MaxLength="5" runat="server" Height="22px" Width="200px"></asp:TextBox>
                <%--            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtValiditydays"
                    ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>--%>
                <asp:FilteredTextBoxExtender ID="FitxtExValidDay" ClientIDMode="AutoID" runat="server"
                    Enabled="True" TargetControlID="txtValiditydays" FilterType="Custom, Numbers"
                    ValidChars="-">
                </asp:FilteredTextBoxExtender>
            </td>
        </tr>
        <tr>
            <td>
                Discount Valid Date From
            </td>
            <td>
                <asp:TextBox ID="txtValidfrom" runat="server" Height="22px" Width="200px"></asp:TextBox>
                <asp:CalendarExtender ID="calendarValidfrom" TargetControlID="txtValidfrom" runat="server">
                </asp:CalendarExtender>
                <%--                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtValidfrom"
                    ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr runat="server" visible="false">
            <td>
                Discount Valid Last Date
            </td>
            <td>
                <asp:TextBox ID="txtValidto" runat="server" Height="22px" Width="200px"></asp:TextBox>
                <asp:CalendarExtender ID="calendarValidto" TargetControlID="txtValidto" runat="server">
                </asp:CalendarExtender>
                <%--            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtValidto"
                    ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:RadioButton ID="radioactive" runat="server" Text="Active" GroupName="act" Checked="True" />
                <asp:RadioButton ID="radiodeactive" runat="server" Text="Deactive" GroupName="act" />
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
                <asp:HiddenField ID="hdnDiscountIDT" runat="server" />
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnadd" ShowMessageBox="true"
                    DisplayMode="List" HeaderText="Add Discount Error" ShowSummary="false" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <p>
    </p>
    <div>
        <table>
            <tr>
                <td>
                    Discount Code:
                    <asp:TextBox runat="server" ID="txtDisCode" />
                </td>
                <td>
                    Discount Amount:
                    <asp:TextBox ID="txtfilterDiscountAmt" runat="server" />
                </td>
                <td>
                    Discount Type:
                    <asp:DropDownList ID="ddlDiscounttype1" runat="server">
                    </asp:DropDownList>
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
    <asp:GridView ID="grdCategory" runat="server" AutoGenerateColumns="False" PageSize="10"
        Width="100%" OnRowUpdating="grdCategory_RowUpdating" OnRowEditing="grdCategory_RowEditing"
        OnRowCancelingEdit="grdCategory_RowCancelingEdit" 
        OnPageIndexChanging="grdCategory_PageIndexChanging" 
        onrowdeleting="grdCategory_RowDeleting">
        <Columns>
            <asp:TemplateField HeaderText="Discount Code" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <b>
                        <asp:Label ID="lbldiscode" runat="server" ForeColor="Red" Text='<%#Eval("Discountcode")%>'></asp:Label></b>
                    <asp:HiddenField ID="hdnDiscountID" Value='<%# Eval("DiscountID") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Applied On">
                <ItemTemplate>
                    <asp:Label ID="lblproductcat" runat="server" Text='<% #Eval("AppliedOn") %>'></asp:Label>
                    <asp:HiddenField ID="hdnDisAppOn" runat="server" Value='<% #Eval("DiscountAppliedOnType") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount Amount">
                <ItemTemplate>
                    <asp:Label ID="lbldiscountamt" runat="server" Text='<%#Eval("DiscountAmt")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount Type">
                <ItemTemplate>
                    <asp:Label ID="lbldiscounttype" runat="server" Text='<%#Eval("discType")%>'></asp:Label>
                    <asp:HiddenField ID="hdnDiscounttype" Value='<%#Eval("DiscountType")%>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Max Discount Count">
                <ItemTemplate>
                    <asp:Label ID="lblmaxpeopledis" runat="server" Text='<%#Eval("DiscntMaxLimit")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtmaxpeopleDis" runat="server" Text='<%#Eval("DiscntMaxLimit")%>'
                        Width="50"></asp:TextBox>
                    <asp:FilteredTextBoxExtender ID="filextMaxpeople" ClientIDMode="AutoID" runat="server"
                        Enabled="True" TargetControlID="txtmaxpeopleDis" FilterType="Custom, Numbers"
                        ValidChars="-">
                    </asp:FilteredTextBoxExtender>
                    <asp:CompareValidator ErrorMessage="" Display="Dynamic" ForeColor="Red" Text='<%# "above " + Eval("DiscntMaxLimit").ToString() %>'
                        ControlToValidate="txtmaxpeopleDis" ValueToCompare='<%#Eval("DiscntMaxLimit")%>'
                        runat="server" Operator="GreaterThanEqual" Type="Integer" />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Valid for days">
                <ItemTemplate>
                    <asp:Label ID="lbldisvalfrom" runat="server" Text='<%#Eval("DiscntDayLimit")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtdisDayLimit" runat="server" Text='<%#Eval("DiscntDayLimit")%>'
                        Width="50"></asp:TextBox>
                    <asp:FilteredTextBoxExtender ID="flextTxtDisValid" ClientIDMode="AutoID" runat="server"
                        Enabled="True" TargetControlID="txtdisDayLimit" FilterType="Custom, Numbers"
                        ValidChars="-">
                    </asp:FilteredTextBoxExtender>
                    <asp:CompareValidator ID="CompareValidator1" ErrorMessage="" Display="Dynamic" ForeColor="Red"
                        Text='<%# "above " + Eval("DiscntDayLimit").ToString() %>' ControlToValidate="txtdisDayLimit"
                        ValueToCompare='<%#Eval("DiscntDayLimit")%>' runat="server" Operator="GreaterThanEqual"
                        Type="Integer" />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Valid From">
                <ItemTemplate>
                    <asp:Label ID="lbldisvaldays" runat="server" Text='<%# String.Format("{0:MM/dd/yyyy}", Eval("DisValidfrom"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblactive" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                    <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("ActiveFlag") %>' runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:RadioButtonList runat="server" ID="rdbStatus" SelectedValue='<%#  (Eval("ActiveFlag").ToString() == "True")?"1":"0" %>'>
                        <asp:ListItem Text="Active" Value="1" />
                        <asp:ListItem Text="Inactive" Value="0" />
                    </asp:RadioButtonList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Link" HeaderText="Edit" EditText="Edit" CancelText="cancel"
                ShowHeader="true" ShowEditButton="true" ShowCancelButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>
</asp:Content>
