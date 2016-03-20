<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="EditProduct.aspx.cs" Inherits="Admin_EditProduct" ValidateRequest="false"
    EnableEventValidation="false" EnableViewStateMac="false" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript" language="javascript">

        $(document).ready(function () {
            $('.lightbox').click(function () {
                $(this).closest("td").find('.box').animate({ 'opacity': '.50' }, 300, 'linear');
                $(this).closest("td").find('.box').animate({ 'opacity': '1.00' }, 300, 'linear');
                $(this).closest("td").find('.box').css('display', 'block');
                $('.backdrop').animate({ 'opacity': '.50' }, 300, 'linear');
                $('.backdrop').css('display', 'block');
            });

            $('.close').click(function () {
                close_box();
            });

            $('.backdrop').click(function () {
                close_box();
            });
        });

        function close_box() {
            $('.backdrop, .box').animate({ 'opacity': '0' }, 300, 'linear', function () {
                $('.backdrop, .box').css('display', 'none');
            });
        }

        function ValiAddProd(sender, args) {
            args.IsValid = true;
            var chkflag = "0";
            if (parseFloat($("#<%=grdPriceLIst.ClientID %> tr").size()) <= parseFloat("0")) {
                chkflag = "1";
            }
            var chckACtive = "1";
            $("#<%=grdUpdate.ClientID %> tr td .JqActiveInacti").each(function (indx, send) {
                if ($(send).find("input[value='1']").prop("checked")) {
                    chckACtive = "0";
                    return;
                }
            });

            if ((chkflag == "1") && (chckACtive == "1")) {
                sender.errormessage = "There is no Active price list for the product."
                args.IsValid = false;
            }
        }
    </script>
    <style type="text/css">
        .backdrop
        {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 100%;
            background: #000;
            opacity: .0;
            filter: alpha(opacity=0);
            z-index: 50;
            display: none;
        }
        
        
        .box
        {
            position: absolute;
            top: 20%;
            left: 30%;
            width: 500px;
            height: 300px;
            background: #ffffff;
            z-index: 51;
            padding: 10px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -moz-box-shadow: 0px 0px 5px #444444;
            -webkit-box-shadow: 0px 0px 5px #444444;
            box-shadow: 0px 0px 5px #444444;
            display: none;
            overflow: scroll;
        }
        
        .close
        {
            float: right;
            margin-right: 6px;
            cursor: pointer;
        }
        
        .ClsImgDiv
        {
            vertical-align: middle;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" cellpadding="5" cellspacing="5">
        <tr>
            <td colspan="2">
                <asp:Label Text="" ID="lblErrMsg" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Category
            </td>
            <td>
                <asp:DropDownList ID="ddlcategory" runat="server" Width="200px" OnSelectedIndexChanged="ddlcategory_SelectedIndexChanged"
                    AutoPostBack="True">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage="Please select Category"
                    ControlToValidate="ddlcategory" Display="Dynamic" ValidationGroup="ProdValid"
                    InitialValue="0" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Sub-Category
            </td>
            <td>
                <asp:DropDownList ID="ddlsubcategory" runat="server" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ErrorMessage="Please select Sub Category"
                    ControlToValidate="ddlsubcategory" Display="Dynamic" ValidationGroup="ProdValid"
                    InitialValue="0" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Name
            </td>
            <td>
                <asp:TextBox ID="txtproductname" runat="server" Width="200px" MaxLength="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ErrorMessage="Please enter Name"
                    ControlToValidate="txtproductname" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" />
               <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Please do not enter special character for Name"
                    ControlToValidate="txtproductname" runat="server" ValidationExpression="^[a-zA-Z''_'\s]{1,100}$"
                    Display="Dynamic" Text="*" ValidationGroup="ProdValid" ToolTip="Numeric" />--%>
            </td>
        </tr>
        <tr>
            <td>
                Short Name
            </td>
            <td>
                <asp:TextBox ID="txtShortName" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ErrorMessage="Please enter Short Name"
                    ControlToValidate="txtShortName" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Description
            </td>
            <td>
                <%--<asp:TextBox ID="txtproductdesc" runat="server" Width="200px" TextMode="MultiLine"></asp:TextBox>--%>
                <FTB:FreeTextBox ID="txtproductdesc" runat="server" Height="150" Width="500">
                </FTB:FreeTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ErrorMessage="Please enter Descriptoin"
                    ControlToValidate="txtproductdesc" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Strength
            </td>
            <td>
                <asp:TextBox ID="txtstrength" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ErrorMessage="Please enter strength"
                    ControlToValidate="txtstrength" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Expiry
            </td>
            <td>
                <asp:TextBox ID="txtexpiry" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ErrorMessage="Please enter expiry"
                    ControlToValidate="txtexpiry" Display="Dynamic" ValidationGroup="ProdValid" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Average Dilivery
            </td>
            <td>
                <asp:TextBox ID="txtdelivery" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ErrorMessage="Please Average Dilivery"
                    ControlToValidate="txtdelivery" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Price
            </td>
            <td>
                <asp:TextBox ID="txtprice" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ErrorMessage="Please enter Price"
                    ControlToValidate="txtprice" Display="Dynamic" ValidationGroup="ProdValid" runat="server" />
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator6" ErrorMessage="Please enter Numeric in Price"
                    ControlToValidate="txtprice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                    Display="Dynamic" Text="*" ValidationGroup="ProdValid" ToolTip="Numeric" />--%>
            </td>
        </tr>
        <tr>
            <td>
                Logo Price
            </td>
            <td>
                <asp:TextBox ID="txtLogoPrice" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ErrorMessage="Please enter Logo Price"
                    ControlToValidate="txtLogoPrice" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ErrorMessage="Please enter Numeric in Logo Price"
                    ControlToValidate="txtLogoPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                    Display="Dynamic" Text="*" ValidationGroup="ProdValid" ToolTip="Numeric" />
            </td>
        </tr>
        <tr>
            <td>
                Generic Name
            </td>
            <td>
                <asp:TextBox ID="txtgeneric" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ErrorMessage="Please enter Generic Name"
                    ControlToValidate="txtgeneric" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Brand Name
            </td>
            <td>
                <asp:TextBox ID="txtbrand" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ErrorMessage="Please enter Brand Name"
                    ControlToValidate="txtbrand" Display="Dynamic" ValidationGroup="ProdValid" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Valid Imag Type
            </td>
            <td>
                <asp:Label ID="lblImageType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Upload Logo
            </td>
            <td>
                <asp:FileUpload ID="fileuplogo" runat="server" Width="200px" />
                <asp:LinkButton Text="View" href="#" ID="lnkUpLogo" class="lightbox" runat="server" />
                <div class="box">
                    <div class="close">
                        x</div>
                    <div class="ClsImgDiv">
                        <asp:Image ImageUrl="" ID="imgUpLogo" runat="server" AlternateText="Logo Image" />
                    </div>
                </div>
                <br />
                <asp:Label ID="lblLogoImagVali" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Upload Advertise
            </td>
            <td>
                <asp:FileUpload ID="fileupad" runat="server" Width="200px" />
                <asp:LinkButton Text="View" href="#" ID="lnkUpAdver" class="lightbox" runat="server" />
                <div class="box">
                    <div class="close">
                        x</div>
                    <div class="ClsImgDiv">
                        <asp:Image ImageUrl="" ID="imgUpAdver" runat="server" AlternateText="Addvertise Image" />
                    </div>
                </div>
                <br />
                <asp:Label ID="lblAdImgVali" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Upload Logo Big Image
            </td>
            <td>
                <asp:FileUpload ID="fileuplogobig" runat="server" Width="200px" />
                <asp:LinkButton Text="View" href="#" ID="lnkUpBigImg" class="lightbox" runat="server" />
                <div class="box">
                    <div class="close">
                        x</div>
                    <div class="ClsImgDiv">
                        <asp:Image ImageUrl="" ID="imgUpBigImg" runat="server" AlternateText="Big Image" />
                    </div>
                </div>
                <br />
                <asp:Label ID="lblbigImgVali" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <fieldset>
        <legend>Price List</legend>
        <asp:GridView runat="server" ID="grdUpdate" AutoGenerateColumns="false" class="clsAddPrice"
            Width="100%" OnRowDataBound="grdUpdate_RowDataBound" ShowHeaderWhenEmpty="true">
            <EmptyDataTemplate>
                No Records found.
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="Sr no.">
                    <ItemTemplate>
                        <asp:Label Text="<%# Container.DataItemIndex + 1 %>" ID="lblSrNo" runat="server" />
                        <asp:HiddenField ID="hdnProdPriceId" runat="server" Value='<%# Eval("ProdPriceId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:TextBox runat="server" ID="txtQuantity" Text='<%# Eval("Quantity") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Strength">
                    <ItemTemplate>
                        <asp:TextBox ID="txtStrength" Text='<%# Eval("Strength") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="New Price">
                    <ItemTemplate>
                        <asp:TextBox ID="txtNewPrice" Text='<%# Eval("NewPrice") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="New Unit Price">
                    <ItemTemplate>
                        <asp:TextBox ID="txtNewUnitPrice" Text='<%# Eval("NewUnitPrice") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Old Price">
                    <ItemTemplate>
                        <asp:TextBox ID="txtOldPrice" Text='<%# Eval("OldPrice") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Old Price">
                    <ItemTemplate>
                        <asp:TextBox ID="txtoldUnitPrice" Text='<%# Eval("oldUnitPrice") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:RadioButtonList runat="server" ID="rdUpGridActInac" RepeatDirection="Vertical"
                            RepeatLayout="Flow" CssClass="JqActiveInacti">
                            <asp:ListItem Text="Active" Value="1" />
                            <asp:ListItem Text="Inactive" Value="0" />
                        </asp:RadioButtonList>
                        <asp:HiddenField ID="hdnActivState" runat="server" Value='<%# Eval("activeflag") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <p>
        </p>
        <asp:UpdatePanel ID="upPanelAddPrice" runat="server">
            <ContentTemplate>
                <table id="tblAddPrice" class="clsAddPrice" border="1">
                    <tr>
                        <td>
                            Quantity
                        </td>
                        <td>
                            Strength
                        </td>
                        <td>
                            New Price
                        </td>
                        <td>
                            New Unit Price
                        </td>
                        <td>
                            Old Price
                        </td>
                        <td>
                            Old unit Price
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox runat="server" ID="txtQuant" MaxLength="9" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Please enter Quantity"
                                ControlToValidate="txtQuant" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                           <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ErrorMessage="Please enter Numeric in Quantity"
                                ControlToValidate="txtQuant" runat="server" ValidationExpression="^\d{1,9}$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />--%>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtPricestrength" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Please enter Strength"
                                ControlToValidate="txtPricestrength" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtNewPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Please enter New Price"
                                ControlToValidate="txtNewPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ErrorMessage="Please enter Numeric upto 2 decimals in New Price"
                                ControlToValidate="txtNewPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtNewUnitPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ErrorMessage="Please enter New Unit Price"
                                ControlToValidate="txtNewUnitPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="Please enter Numeric upto 2 decimals in New Unit Price"
                                ControlToValidate="txtNewUnitPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtoldPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ErrorMessage="Please enter Old Price"
                                ControlToValidate="txtoldPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Please enter Numeric upto 2 decimals in Old Price"
                                ControlToValidate="txtoldPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtOldUntPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ErrorMessage="Please enter Old Unit Price"
                                ControlToValidate="txtOldUntPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ID="RegExpre" ErrorMessage="Please enter Numeric Numeric upto 2 decimals in Old Unit Price"
                                ControlToValidate="txtOldUntPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />
                        </td>
                        <td>
                            <asp:Button Text="Add" runat="server" CausesValidation="true" ValidationGroup="addPrice"
                                ID="btnAddPrice" OnClick="btnAddPrice_Click" />
                            <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="addPrice" ShowMessageBox="true"
                                DisplayMode="List" HeaderText="Add Price Error" ShowSummary="false" />
                        </td>
                    </tr>
                </table>
                <asp:UpdateProgress ID="upProgress" AssociatedUpdatePanelID="upPanelAddPrice" runat="server">
                    <ProgressTemplate>
                        <div>
                            Loading ......
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <p>
                </p>
                <asp:GridView ID="grdPriceLIst" runat="server" AutoGenerateColumns="false" OnRowCommand="grdPriceLIst_RowCommand"
                    Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr no.">
                            <ItemTemplate>
                                <asp:Label ID="lblSrNo" runat="server" Text="<%# Container.DataItemIndex + 1 %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Strength">
                            <ItemTemplate>
                                <asp:Label ID="lblStrength" runat="server" Text='<%# Eval("Strength") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="New Price">
                            <ItemTemplate>
                                <asp:Label ID="lblNewPrice" runat="server" Text='<%# Eval("NewPrice") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="New Unit Price">
                            <ItemTemplate>
                                <asp:Label ID="lblNewUnitPrice" runat="server" Text='<%# Eval("NewUnitPrice") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Old Price">
                            <ItemTemplate>
                                <asp:Label ID="lblOldPrice" runat="server" Text='<%# Eval("OldPrice") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Old Price">
                            <ItemTemplate>
                                <asp:Label ID="lbloldUnitPrice" runat="server" Text='<%# Eval("oldUnitPrice") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="delRow" Text="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
    <fieldset>
        <legend>Product Description</legend>
        <asp:UpdatePanel ID="upPnlProDes" runat="server">
            <ContentTemplate>
                <table id="tblAddDescription">
                    <tr>
                        <td>
                            Heading
                        </td>
                        <td>
                            <asp:TextBox ID="txtProdDesHeading" Width="499px" runat="server" MaxLength="450"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ErrorMessage="Please enter Heading"
                                ControlToValidate="txtProdDesHeading" Display="Dynamic" Text="*" ValidationGroup="valProductDescription"
                                runat="server" ForeColor="Red" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Description
                        </td>
                        <td>
                            <FTB:FreeTextBox ID="txtProdDescription" runat="server" Height="150" Width="500">
                            </FTB:FreeTextBox>
                            <%--<asp:TextBox ID="txtproductdesc" runat="server" Width="200px" TextMode="MultiLine"></asp:TextBox>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ErrorMessage="Please enter Descriptoin"
                                ControlToValidate="txtProdDescription" Display="Dynamic" ValidationGroup="valProductDescription"
                                runat="server" Text="*" ForeColor="Red" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td align="right">
                            <asp:Button Text="Add" runat="server" CausesValidation="true" ValidationGroup="valProductDescription"
                                ID="btnAddProdDes" OnClick="btnAddProdDes_Click" />
                            <asp:ValidationSummary ID="ValidationSummary3" runat="server" ValidationGroup="valProductDescription"
                                ShowMessageBox="true" DisplayMode="List" HeaderText="Product Description Errors"
                                ShowSummary="false" />
                        </td>
                    </tr>
                </table>
                <p>
                </p>
                 <asp:UpdateProgress ID="upProProDes" AssociatedUpdatePanelID="upPnlProDes"
                    runat="server">
                    <ProgressTemplate>
                        <div>
                            Loading ......
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <p></p>
                <asp:GridView ID="grdProdDes" runat="server" AutoGenerateColumns="False" PageSize="10"
                    Width="100%" OnRowUpdating="grdProdDes_RowUpdating" OnRowEditing="grdProdDes_RowEditing"
                    OnRowCancelingEdit="grdProdDes_RowCancelingEdit">
                    <Columns>
                        <asp:TemplateField HeaderText="Description Heading" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lbldisHeading" runat="server" Text='<%#Eval("DesHeading")%>'></asp:Label>
                                <asp:HiddenField ID="hdnProductDesID" Value='<%# Eval("prodDescriptionId") %>' runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="hdnEditProductDesID" Value='<%# Eval("prodDescriptionId") %>'
                                    runat="server" />
                                <asp:TextBox runat="server" ID="txtDesHeading" Text='<%# Eval("DesHeading") %>' MaxLength="450" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ErrorMessage="Please enter Heading"
                                    ControlToValidate="txtDesHeading" Display="Dynamic" Text="*" ValidationGroup="valProductDescription"
                                    runat="server" ForeColor="Red" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="lblProdDes" runat="server" Text='<%# HttpUtility.HtmlDecode(Eval("prodDescription").ToString()) %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <FTB:FreeTextBox ID="txtProdDescription" runat="server" Height="150" Width="500"
                                    Text='<%# HttpUtility.HtmlDecode(Eval("prodDescription").ToString()) %>'>
                                </FTB:FreeTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ErrorMessage="Please enter Descriptoin"
                                    ControlToValidate="txtProdDescription" Display="Dynamic" ValidationGroup="valProductDescription"
                                    runat="server" Text="*" ForeColor="Red" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblactive" runat="server" Text='<%# Eval("DisStat") %>'></asp:Label>
                                <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("activeflag") %>' runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:RadioButtonList runat="server" ID="rdbStatus" SelectedValue='<%#  (Eval("activeflag").ToString() == "True")?"1":"0" %>'>
                                    <asp:ListItem Text="Active" Value="1" />
                                    <asp:ListItem Text="Inactive" Value="0" />
                                </asp:RadioButtonList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ButtonType="Link" HeaderText="Edit" EditText="Edit" CancelText="cancel"
                            ShowHeader="true" ShowEditButton="true" ShowCancelButton="true" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
    <table>
        <tr>
            <td>
            </td>
            <td>
                <asp:RadioButtonList runat="server" ID="rdActiveDeactive" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Active" Value="1" Selected="True" />
                    <asp:ListItem Text="Inactive" Value="0" />
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CausesValidation="true" ValidationGroup="ProdValid"
                    OnClick="btnSubmit_Click" />
                <asp:CustomValidator ID="CustomValidator1" ErrorMessage="" ControlToValidate="" ValidationGroup="ProdValid"
                    Display="Dynamic" ClientValidationFunction="ValiAddProd" runat="server" />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ProdValid"
                    ShowMessageBox="true" DisplayMode="List" HeaderText="Add Product Error" ShowSummary="false" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" PostBackUrl="~/Admin/ViewProduct.aspx" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnProductId" runat="server" />
    <asp:HiddenField ID="hdnfilePath" runat="server" />
    <div class="backdrop">
    </div>
</asp:Content>
