<%@ Page Language="C#" MasterPageFile="~/Blog/Blogmaster.master" AutoEventWireup="true"
    CodeFile="blogdisplay.aspx.cs" Inherits="blogdisplay" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/Blog.css" rel="stylesheet" type="text/css" />
    <link href="../../Styles/Blog.css" rel="stylesheet" type="text/css" />
    <div class="leftbox" style="width: 570px">
        <div class="span-18 last">
            <div class="blogcontent">
                <div class="blogname">
                    <asp:Label ID="lblblogname" runat="server"></asp:Label>
                </div>
                <div class="blogimage" style="text-align: center">
                    <asp:Image ID="blogimage" Width="480px" Height="250px" runat="server" />
                </div>
                <div class="blogdate">
                    Posted On &nbsp;&nbsp;
                    <asp:Label ID="lblposteddate" runat="server"></asp:Label>
                </div>
                <div class="text-box">
                    <div id="blogdescription" runat="server" style="padding: 14px">
                    </div>
                </div>
                <div id="btags" runat="server" class="tags">
                    <span style="font-size: 15px; font-weight: bold">TagName:</span>&nbsp;&nbsp;
                    <asp:Label ID="lblTags" CssClass="taglist" runat="server"></asp:Label>
                </div>
                <div class="blogcomments" id="blogcomments" runat="server">
                    <table border="0" style="width: 100%">
                        <tr>
                            <td>
                                Comments
                            </td>
                        </tr>
                        <asp:Repeater ID="rptcomments" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <h4>
                                            <%#Eval("UserName")%></h4>
                                        <%#Eval("bcomments")%>
                                        <br />
                                        <%#Eval("CreatedDt")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
            <div>
                <asp:Label ID="lblrelatedpost" Text="Related Post" runat="server"></asp:Label>
                <table>
                    <asp:Repeater ID="rptrelatedpost" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lnkbtnBlogName" CommandArgument='<%#Eval("BlogId") %>' OnClick="lnk_BlogDetails"
                                        runat="server" Text='<%#Eval("BName") %>'>
                                    </asp:LinkButton>
                                    <div>
                                        <%#Eval("Introduction")%>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
            <div class="Blog" id="divblogcomments" runat="server">
                <div id="blog">
                    <table border="0" cellpadding="5" cellspacing="5">
                        <tr>
                            <td>
                                Name<span style="color: Red;">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtName" MaxLength="40" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName"
                                    Display="Dynamic" ErrorMessage="Please Enter Name!" CssClass="error" ValidationGroup="comment">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Email
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" MaxLength="70" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RegularExpressionValidator ID="RequiredFieldValidator3" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Please Enter Valid Email!"
                                    CssClass="error" ValidationGroup="comment"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Comment<span style="color: Red;">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBlogComment" Width="260px" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqcomment" runat="server" ControlToValidate="txtBlogComment"
                                    Display="Dynamic" ErrorMessage="Please Enter Comment!" CssClass="error" ValidationGroup="comment">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnBlogCommentSubmit" CssClass="bluebutton" runat="server" Text="Submit"
                                    OnClick="btnBlogCommentSubmit_Click" ValidationGroup="comment" />
                                <asp:Label ID="lblstatus" CssClass="error" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="sidebar" class="right">
        <div class="leftwidget">
            <h3>
                Recent Posts</h3>
            <div class="clear">
            </div>
            <div class="box">
                <ul>
                    <asp:ListView ID="lstvwrecentpost" runat="server">
                        <ItemTemplate>
                            <li><a href='<%# GetRouteUrl("BlogDetails", new { BlogId = Eval("BlogId"), BName = Eval("BName").ToString().Trim().Replace(" ","-") })%>'>
                                <%#Eval("BName") %></a></li>
                        </ItemTemplate>
                    </asp:ListView>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
