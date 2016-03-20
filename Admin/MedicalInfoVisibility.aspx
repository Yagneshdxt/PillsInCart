<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeFile="MedicalInfoVisibility.aspx.cs" Inherits="Admin_MedicalInfoVisibility" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <center>
        <asp:SqlDataSource ID="dsAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
            SelectCommand="select gconstantid,typename,description,modifieddate,activeflag from mstGeneralCnst where typename = 'DisplayMedicalInfo'">
        </asp:SqlDataSource>
        <asp:GridView ID="gvAdminMedical" DataSourceID="dsAdmin" runat="server" AutoGenerateColumns="false"
            Width="500px" DataKeyNames="gconstantid">
            <Columns>
                <asp:BoundField HeaderText="Desciption" DataField="Description" />
                <asp:BoundField HeaderText="Last Modified On" DataField="modifieddate" DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" />
                <asp:TemplateField HeaderText="Activate">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkActivate" OnCheckedChanged="chkActivate_CheckedChanged" AutoPostBack="true"
                            runat="server" Checked='<%#Eval("activeflag") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </center>
</asp:Content>
