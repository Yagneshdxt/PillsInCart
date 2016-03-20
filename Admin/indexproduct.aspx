<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="indexproduct.aspx.cs" Inherits="Admin_indexproduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .ulList
        {
            margin: 0;
            padding: 0;
            list-style-type: none;
            text-align: center;
            overflow: hidden;
        }
        
        .ulList li
        {
            display: inline;
            float: left;
        }
        
        .productHold
        {
            width: 400px;
            overflow: hidden;
            border:1px solid black;
            margin:1px;
        }
        .productHold div
        {
            float: left;
        }
        .clsProdName
        {
            width: 380px;
            font-weight: bold;
            font-size: 20px;
        }
        .MidContainer
        {
            width: 380px;
        }
        .MidImage
        {
            width: 220px;
        }
        .MidPrice
        {
            width: 140px;
            height: 100%;
            margin-top: 20px;
            text-align: left;
        }
        .prodPrice
        {
            font-size: 15px;
            margin-top: 30px;
            font-weight: bold;
            color: Red;
        }
        .EditLInk
        {
            width: 380px;
            font-weight: bold;
            font-size: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0" cellpadding="5" cellspacing="5">
        <tr>
            <td>
                Root Category
            </td>
            <td>
                <asp:DropDownList ID="ddlProductCat" runat="server" AutoPostBack="True" Height="22px"
                    Width="200px" OnSelectedIndexChanged="ddlProductCat_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Sub Category
            </td>
            <td>
                <asp:DropDownList ID="ddlSubCat" runat="server" AutoPostBack="True" Height="22px"
                    Width="200px" OnSelectedIndexChanged="ddlSubCat_SelectedIndexChanged1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Products
            </td>
            <td>
                <asp:DropDownList ID="ddlProduct" runat="server" Height="22px" Width="200px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" InitialValue="0" ValidationGroup="btnupdate"
                    ControlToValidate="ddlProduct" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Description
            </td>
            <td>
                <asp:TextBox ID="txtdesc" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtdesc"
                    ForeColor="Red" runat="server" ValidationGroup="btnupdate" ErrorMessage="*" Enabled="false"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                    CausesValidation="true" ValidationGroup="btnupdate" Visible="false" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                    Visible="false" />
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
    <ul class="ulList">
        <asp:ListView ID="listproduct" runat="server">
            <ItemTemplate>
                <li>
                    <div class="productHold">
                        <div class="clsProdName">
                            <asp:Label ID="lblproductname" runat="server" Text='<%#Eval("name") %>'></asp:Label></div>
                        <div class="MidContainer">
                            <div class="MidImage">
                                <asp:Image ID="imgproduct" Width="100px" ImageUrl='<%#Eval("logoimgpath") %>' Height="100px"
                                    runat="server" /></div>
                            <div class="MidPrice">
                                <span>Per Pill</span>
                                <br />
                                <span class="prodPrice">$<asp:Label ID="lblproductprice" runat="server" Text='<%#Eval("logoPrice") %>'></asp:Label>
                                </span>
                            </div>
                        </div>
                        <div class="EditLInk">
                            <asp:LinkButton Text="Edit" ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" /></div>
                        <asp:HiddenField ID="hdnproductid" Value='<%#Eval("productid") %>' runat="server" />
                        <asp:HiddenField ID="hdnIndexMapId" Value='<%#Eval("IndexProdMapId") %>' runat="server" />
                        <asp:HiddenField ID="hdnActiveFlag" Value='<%#Eval("ActiveFlag") %>' runat="server" />
                    </div>
                </li>
            </ItemTemplate>
        </asp:ListView>
    </ul>
    <asp:HiddenField ID="hdnprdID" runat="server" />
    <asp:HiddenField ID="hdnIndexId" runat="server" />
</asp:Content>
