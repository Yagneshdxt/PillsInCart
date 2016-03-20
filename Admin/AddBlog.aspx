<%@ Page Language="C#" EnableEventValidation="true" ValidateRequest="false" AutoEventWireup="true"
    CodeFile="AddBlog.aspx.cs" Inherits="Admin_AddBlog" MasterPageFile="~/Admin/Site.master"
    MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="../Scripts/jscripts/tiny_mce/tiny_mce.js" type="text/javascript"></script>
    <script type="text/javascript">
        window.onload = function () {
            var tmr = false;
            var labels = document.getElementById('cbxlisttags').getElementsByTagName('label');
            var func = function () {
                if (tmr)
                    clearTimeout(tmr);
                tmr = setTimeout(function () {
                    var regx = new RegExp(document.getElementById('txtSearch').value);
                    for (var i = 0, size = labels.length; i < size; i++)
                        if (document.getElementById('txtSearch').value.length > 0) {
                            if (labels[i].textContent.match(regx)) setItemVisibility(i, true);
                            else setItemVisibility(i, false);
                        }
                        else
                            setItemVisibility(i, true);
                }, 500);

                function setItemVisibility(position, visible) {
                    if (visible) {
                        labels[position].style.display = '';
                        labels[position].previousSibling.style.display = '';
                        if (labels[position].nextSibling != null)
                            labels[position].nextSibling.style.display = '';
                    }
                    else {
                        labels[position].style.display = 'none';
                        labels[position].previousSibling.style.display = 'none';
                        if (labels[position].nextSibling != null)
                            labels[position].nextSibling.style.display = 'none';

                    }
                }
            }

            if (document.attachEvent) document.getElementById('txtSearch').attachEvent('onkeypress', func);  // IE compatibility
            else document.getElementById('txtSearch').addEventListener('keydown', func, false); // other browsers
        };

        tinyMCE.init({
            // General options
            //            mode: "specific_textareas",
            //            editor_selector: "txtEditor",
            //            theme: "simple",
            //            plugins: "tabfocus",
            //            tabfocus_elements: ":prev,:next"
            // content_css: "/includes/css/content.css"



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


        //        tinyMCE.init({
        //            // General options
        //            mode: "exact",
        //            elements: "txtEditor",
        //            theme: "advanced",
        //            plugins: "inlinepopups,fullscreen,contextmenu,emotions,table,iespell,advlink,insertcode",
        //            convert_urls: false,

        //            // Theme options
        //            theme_advanced_buttons1: "fullscreen,code,|,cut,copy,paste,pastetext,pasteword,|,undo,redo,|,bold,italic,underline,strikethrough,|,blockquote,sub,sup,|,justifyleft,justifycenter,justifyright,|,bullist,numlist,outdent,indent",
        //            theme_advanced_buttons2: "iespell,link,unlink,removeformat,cleanup,charmap,emotions,|,formatselect,fontselect,fontsizeselect,|,forecolor,backcolor,insertcode",
        //            theme_advanced_buttons3: "",
        //            theme_advanced_toolbar_location: "top",
        //            theme_advanced_toolbar_align: "left",
        //            theme_advanced_statusbar_location: "bottom",
        //            theme_advanced_resizing: true,
        //            theme_advanced_resize_horizontal: false,
        //            tab_focus: ":prev,:next",
        //            gecko_spellcheck: true,

        //            //Character count        
        //            theme_advanced_path: false,
        //            setup: function (ed) {
        //                ed.onKeyUp.add(function (ed, e) {

        //                    var strip = (tinyMCE.activeEditor.getContent()).replace(/(<([^>]+)>)/ig, "");
        //                    var text = strip.split(' ').length + " Words, " + strip.length + " Characters"
        //                    tinymce.DOM.setHTML(tinymce.DOM.get(tinyMCE.activeEditor.id + '_path_row'), text);
        //                });
        //            }
        //        });
    </script>
    <table border="0" cellpadding="5" cellspacing="5">
        <tr>
            <td>
                Blog Name
            </td>
            <td>
                <asp:TextBox ID="txtblogname" runat="server" MaxLength="500"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Blog Name"
                    ControlToValidate="txtblogname" ForeColor="Red" ValidationGroup="btnSubmit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Introduction
            </td>
            <td>
                <asp:TextBox ID="txtintro" runat="server" MaxLength="500" Rows="4" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Introduction"
                    ControlToValidate="txtintro" ForeColor="Red" ValidationGroup="btnSubmit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Description
            </td>
            <td>
                <asp:TextBox ID="ftxtblog" runat="server" TextMode="MultiLine" Width="400px" CssClass="txtEditor"
                    Rows="15"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Description"
                    ControlToValidate="ftxtblog" ForeColor="Red" ValidationGroup="btnSubmit">*</asp:RequiredFieldValidator>
                <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="ftxtblog"
                    ErrorMessage="Please Enter Only Alphabets" ForeColor="Red" ValidationExpression="^[a-zA-Z]+$"
                    Enabled="False"></asp:RegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td>
                Blog Image1
            </td>
            <td>
                <asp:FileUpload ID="fileupimg1" runat="server" /><asp:Image ID="imgblog1" runat="server" />
                <asp:Label ID="lblimglink" runat="server" Text='<% #Eval("bImgOne") %>'></asp:Label>
                <%--<asp:HyperLink ID="hlinkimg1" runat="server" NavigateUrl='<% #Eval("bImgOne") %>'  target="_blank">hyperlink</asp:HyperLink>--%>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Select Image1"
                    ControlToValidate="fileupimg1" ForeColor="Red" ValidationGroup="btnSubmit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Blog Image2
            </td>
            <td>
                <asp:FileUpload ID="fileupimg2" runat="server" /><asp:Image ID="imgblog2" runat="server" />
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Is Comment Visible
            </td>
            <td>
                <asp:CheckBox ID="chkiscommentvisible" runat="server" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                Select Category
            </td>
            <td>
                <asp:DropDownList ID="ddlcategory" runat="server">
                </asp:DropDownList>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ErrorMessage="Please select Category"
                    Text="*" ForeColor="Red" ControlToValidate="ddlcategory" Display="Dynamic" ValidationGroup="btnSubmit"
                    InitialValue="0" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Select Tags
            </td>
            <td>
                <div class="ddlscroll">
                    Search:
                    <asp:TextBox ID="txtSearch" ClientIDMode="Static" CssClass="searchtag" runat="server">                
                    </asp:TextBox>
                    <asp:CheckBoxList ID="cbxlisttags" ClientIDMode="Static" runat="server" RepeatDirection="Vertical">
                    </asp:CheckBoxList>
                </div>
                <div>
                    Add New Tag:
                    <asp:TextBox ID="txtAddblogtag" runat="server"></asp:TextBox>
                    <asp:Button ID="btnAddBlogTag" ValidationGroup="validatetag" Text="Add" runat="server"
                        OnClick="btnAddBlogTag_Click" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Display="Dynamic" runat="server"
                        ErrorMessage="Please Enter Tag" ControlToValidate="txtAddblogtag" ForeColor="Red"
                        ValidationGroup="validatetag"></asp:RequiredFieldValidator>
                </div>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:RadioButton ID="radioactive" runat="server" Text="Active" GroupName="act" Checked="True" />
                <asp:RadioButton ID="radiodeactive" runat="server" Text="Deactive" GroupName="act" />
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Add" ValidationGroup="btnSubmit" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                    CausesValidation="true" ValidationGroup="valAddCat" Visible="false" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                    Visible="false" />
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnSubmit" ShowMessageBox="true"
                    DisplayMode="List" HeaderText="Add Category Error" ShowSummary="false" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    <p>
    </p>
    Filter By:
    <asp:DropDownList ID="ddlMonthFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonthFilter_SelectedIndexChanged">
    </asp:DropDownList>
    <div class="gridH">
        <asp:GridView ID="grdBlog" PageSize="10" DataKeyNames="TagID,IscommentActive" runat="server"
            AutoGenerateColumns="False" Width="100%" OnPageIndexChanging="grdBlog_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Blog Name">
                    <ItemTemplate>
                        <asp:Label ID="lblBname" runat="server" Text='<% #Eval("Bname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Introduction">
                    <ItemTemplate>
                        <div style="overflow: auto; height: 100px;">
                            <asp:Label ID="lblIntro" runat="server" Text='<% #Eval("Introduction") %>'></asp:Label>
                        </div>
                        <asp:Label Style="display: none" ID="lblimg2" runat="server" Text='<% #Eval("bImgTwo") %>'></asp:Label>
                        <asp:Label Style="display: none" ID="lblimg1" runat="server" Text='<% #Eval("bImgOne") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <div style="overflow: auto; height: 100px;">
                            <asp:Label ID="lbldesc" runat="server" Text='<% #Eval("Description") %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblactive" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                        <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("[ActiveFlag]") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton Text="Edit" ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" />
                        <asp:LinkButton Text="Delete" ID="lnkDelete" runat="server" OnClick="lnkDelete_Click" />
                        <asp:HiddenField ID="hdBlogID" Value='<%# Eval("BlogId") %>' runat="server" />
                        <asp:HiddenField ID="hdnCategoryID" Value='<%# Eval("CategoryID") %>' runat="server" />
                        <%--<asp:HiddenField ID="hdnfolName" Value='<%# Eval("folderName") %>' runat="server" />--%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:HiddenField ID="hdnBlogIDSelected" runat="server" />
    <asp:HiddenField ID="hdnCateId" runat="server" />
</asp:Content>
