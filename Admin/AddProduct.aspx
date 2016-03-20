<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="AddProduct.aspx.cs" Inherits="Admin_AddProduct" ValidateRequest="false"
    EnableEventValidation="false" EnableViewStateMac="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/jscripts/tiny_mce/tiny_mce.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">

        function ValiAddProd(sender, args) {
            args.IsValid = true;
            if (parseFloat($("#<%=grdPriceLIst.ClientID %> tr").size()) <= parseFloat("0")) {
                sender.errormessage = "Please enter price list.\n";
                args.IsValid = false;
            }
            //            if (parseFloat($("#<%=grdProdDes.ClientID %> tr").size()) <= parseFloat("0")) {
            //                sender.errormessage = sender.errormessage + "Please enter atlease one Description of the product.\n";
            //                args.IsValid = false;
            //            }
        }

        TinyMCEEditor();

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            TinyMCEEditor();
        });

        function TinyMCEEditor() {

            tinyMCE.init({
                mode: "specific_textareas",
                editor_selector: "txtEditor",
                theme: "advanced",
                plugins: "tabfocus,paste,pasteAsPlainText",
                convert_urls: false,
                theme_advanced_buttons1: "fullscreen,code,|,cut,copy,paste,pastetext,pasteword,|,undo,redo,|,bold,italic,underline,strikethrough,|,blockquote,sub,sup,|,justifyleft,justifycenter,justifyright,|,bullist,numlist,outdent,indent",
                theme_advanced_buttons2: "iespell,link,unlink,removeformat,cleanup,charmap,emotions,|,formatselect,fontselect,fontsizeselect,|,forecolor,backcolor,insertcode",
                theme_advanced_buttons3: "",
                theme_advanced_toolbar_location: "top",
                theme_advanced_toolbar_align: "left",
                tab_focus: ':prev,:next',
                paste_use_dialog: false,
                paste_auto_cleanup_on_paste: true

            });
        }

    </script>
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
                <asp:RequiredFieldValidator ErrorMessage="Please select Category" Text="*" ForeColor="Red"
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
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ErrorMessage="Please select Sub Category"
                    ControlToValidate="ddlsubcategory" Display="Dynamic" ValidationGroup="ProdValid"
                    InitialValue="0" runat="server" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Name
            </td>
            <td>
                <asp:TextBox ID="txtproductname" runat="server" Width="200px" MaxLength="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage="Please enter Name"
                    ControlToValidate="txtproductname" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" Text="*" ForeColor="Red" />
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Please do not enter special character for Name"
                    ControlToValidate="txtproductname" runat="server" ValidationExpression="^[a-zA-Z''_'\s]{1,100}$"
                    Display="Dynamic" ValidationGroup="ProdValid" ToolTip="Numeric" Text="*" ForeColor="Red" />--%>
            </td>
        </tr>
        <tr>
            <td>
                Title
            </td>
            <td>
                <asp:TextBox ID="txtShortName" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ErrorMessage="Please enter Short Name"
                    ControlToValidate="txtShortName" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Description
            </td>
            <td>
                <asp:TextBox ID="txtproductdesc" runat="server" TextMode="MultiLine" Width="400px"
                    CssClass="txtEditor" Rows="15"></asp:TextBox>
                <%--<asp:TextBox ID="txtproductdesc" runat="server" Width="200px" TextMode="MultiLine"></asp:TextBox>--%>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ErrorMessage="Please enter Descriptoin"
                    ControlToValidate="txtproductdesc" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Strength
            </td>
            <td>
                <asp:TextBox ID="txtstrength" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ErrorMessage="Please enter strength"
                    ControlToValidate="txtstrength" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Expiry
            </td>
            <td>
                <asp:TextBox ID="txtexpiry" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ErrorMessage="Please enter expiry"
                    ControlToValidate="txtexpiry" Display="Dynamic" ValidationGroup="ProdValid" runat="server"
                    Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Average Dilivery
            </td>
            <td>
                <asp:TextBox ID="txtdelivery" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ErrorMessage="Please Average Dilivery"
                    ControlToValidate="txtdelivery" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Price
            </td>
            <td>
                <asp:TextBox ID="txtprice" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ErrorMessage="Please enter Price"
                    ControlToValidate="txtprice" Display="Dynamic" ValidationGroup="ProdValid" runat="server"
                    Text="*" ForeColor="Red" />
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator6" ErrorMessage="Please enter Numeric in Price"
                    ControlToValidate="txtprice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                    Display="Dynamic" ValidationGroup="ProdValid" ToolTip="Numeric" Text="*" ForeColor="Red" />--%>
            </td>
        </tr>
        <tr>
            <td>
                Logo Price
            </td>
            <td>
                <asp:TextBox ID="txtLogoPrice" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ErrorMessage="Please enter Logo Price"
                    ControlToValidate="txtLogoPrice" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" Text="*" ForeColor="Red" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ErrorMessage="Please enter Numeric in Logo Price"
                    ControlToValidate="txtLogoPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                    Display="Dynamic" ValidationGroup="ProdValid" ToolTip="Numeric" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Generic Name
            </td>
            <td>
                <asp:TextBox ID="txtgeneric" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ErrorMessage="Please enter Generic Name"
                    ControlToValidate="txtgeneric" Display="Dynamic" ValidationGroup="ProdValid"
                    runat="server" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                Brand Name
            </td>
            <td>
                <asp:TextBox ID="txtbrand" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ErrorMessage="Please enter Brand Name"
                    ControlToValidate="txtbrand" Display="Dynamic" ValidationGroup="ProdValid" runat="server"
                    Text="*" ForeColor="Red" />
            </td>
        </tr>
        <%--        <tr>
            <td>
                Valid Imag Type
            </td>
            <td>
                <asp:Label ID="lblImageType" ForeColor="Red" runat="server"></asp:Label>
            </td>
        </tr>--%>
        <tr>
            <td>
                Upload Logo
            </td>
            <td>
                <asp:FileUpload ID="fileuplogo" runat="server" Width="200px" />
                <br />
                <%--<asp:Label ID="lblLogoImagVali" ForeColor="Red" runat="server"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <td>
                Upload Advertise
            </td>
            <td>
                <asp:FileUpload ID="fileupad" runat="server" Width="200px" />
                <br />
                <%--<asp:Label ID="lblAdImgVali" ForeColor="Red" runat="server"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <td>
                <%--Upload Logo Big Image--%>
            </td>
            <td>
                <div style="display: none">
                    <asp:FileUpload ID="fileuplogobig" runat="server" Width="200px" />
                    <br />
                </div>
                <%--<asp:Label ID="lblbigImgVali" ForeColor="Red" runat="server"></asp:Label>--%>
            </td>
        </tr>
    </table>
    <fieldset>
        <legend>Meta Tags </legend>
        <asp:UpdatePanel ID="UpAddMetaTag" runat="server">
            <ContentTemplate>
                <table id="tblAddMetaTag" width="100%" border="0">
                    <tr>
                        <td>
                            Keywords:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMetaName" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ErrorMessage="Please enter Name"
                                ControlToValidate="txtMetaName" Display="Dynamic" Text="*" ValidationGroup="addMetachk"
                                runat="server" ForeColor="Red" />
                        </td>
                        <td>
                            Description:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMetaContent" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ErrorMessage="Please enter Content"
                                ControlToValidate="txtMetaContent" Display="Dynamic" Text="*" ValidationGroup="addMetachk"
                                runat="server" ForeColor="Red" />
                        </td>
                        <td>
                            <asp:Button Text="Add" runat="server" CausesValidation="true" ValidationGroup="addMetachk"
                                ID="btnAddMetaTag" OnClick="btnAddMetaTag_Click" />
                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="addMetachk"
                                ShowMessageBox="true" DisplayMode="List" HeaderText="Meta tag Errors" ShowSummary="false" />
                        </td>
                    </tr>
                </table>
                <p>
                    &nbsp;<asp:UpdateProgress ID="UpProAddMetaTag" AssociatedUpdatePanelID="UpAddMetaTag"
                        runat="server">
                        <ProgressTemplate>
                            <div>
                                Loading ......
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <p>
                    </p>
                    <asp:GridView ID="grdMetaTag" runat="server" AutoGenerateColumns="false" OnRowCommand="grdMetaTag_RowCommand"
                        Width="100%">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr no.">
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server" Text="<%# Container.DataItemIndex + 1 %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Content">
                                <ItemTemplate>
                                    <asp:Label ID="lblContent" runat="server" Text='<%# Eval("Content") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDeletMeta" runat="server" CommandName="delRow" Text="Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </p>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
    <fieldset>
        <legend>Price List </legend>
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
                            <asp:TextBox runat="server" ID="txtQuant" MaxLength="40" />
                            <asp:RequiredFieldValidator ErrorMessage="Please enter Quantity" ControlToValidate="txtQuant"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" runat="server" />
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator4" ErrorMessage="Please enter Numeric in Quantity"
                                ControlToValidate="txtQuant" runat="server" ValidationExpression="^\d{1,9}$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />--%>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtPricestrength" MaxLength="40" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Please enter Strength"
                                ControlToValidate="txtPricestrength" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" ForeColor="Red" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtNewPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Please enter New Price"
                                ControlToValidate="txtNewPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ErrorMessage="Please enter Numeric upto 2 decimals in New Price"
                                ControlToValidate="txtNewPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtNewUnitPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Please enter New Unit Price"
                                ControlToValidate="txtNewUnitPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="Please enter Numeric upto 2 decimals in New Unit Price"
                                ControlToValidate="txtNewUnitPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtoldPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ErrorMessage="Please enter Old Price"
                                ControlToValidate="txtoldPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Please enter Numeric upto 2 decimals in Old Price"
                                ControlToValidate="txtoldPrice" runat="server" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"
                                Display="Dynamic" Text="*" ValidationGroup="addPrice" ToolTip="Numeric" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtOldUntPrice" MaxLength="12" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ErrorMessage="Please enter Old Unit Price"
                                ControlToValidate="txtOldUntPrice" Display="Dynamic" Text="*" ValidationGroup="addPrice"
                                runat="server" />
                            <asp:RegularExpressionValidator ErrorMessage="Please enter Numeric Numeric upto 2 decimals in Old Unit Price"
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
                <p>
                    &nbsp;<asp:UpdateProgress ID="upProgress" AssociatedUpdatePanelID="upPanelAddPrice"
                        runat="server">
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
                                    <asp:LinkButton runat="server" CommandName="delRow" Text="Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </p>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
    <fieldset>
        <legend>Product Description</legend>
        <asp:UpdatePanel ID="upPanProdDis" runat="server">
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
                            <asp:TextBox ID="txtProdDescription" runat="server" TextMode="MultiLine" Width="400px"
                                CssClass="txtEditor" Rows="15"></asp:TextBox>
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
                    &nbsp;<asp:UpdateProgress ID="upProgProDes" AssociatedUpdatePanelID="upPanProdDis"
                        runat="server">
                        <ProgressTemplate>
                            <div>
                                Loading ......
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <p>
                    </p>
                    <asp:GridView ID="grdProdDes" runat="server" AutoGenerateColumns="false" Width="100%">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr no.">
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server" Text="<%# Container.DataItemIndex + 1 %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Heading">
                                <ItemTemplate>
                                    <asp:Label ID="lblHeading" runat="server" Text='<%# Eval("Heading") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lblDescription" runat="server" Text='<%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDeletMeta" runat="server" OnClick="lnkDeletMeta_Click" Text="Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </p>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
    <table>
        <tr>
            <td>
            </td>
            <td>
                <asp:RadioButton ID="radioactive" runat="server" Text="Active" Checked="true" GroupName="act" />
                <asp:RadioButton ID="radiodeactive" runat="server" Text="Deactive" GroupName="act" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CausesValidation="true" ValidationGroup="ProdValid"
                    OnClick="btnSubmit_Click" />
                <asp:CustomValidator ErrorMessage="" ControlToValidate="" ValidationGroup="ProdValid"
                    Display="Dynamic" ClientValidationFunction="ValiAddProd" runat="server" />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ProdValid"
                    ShowMessageBox="true" DisplayMode="List" HeaderText="Add Product Error" ShowSummary="false" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
