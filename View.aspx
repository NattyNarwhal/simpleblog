<%@ Page MasterPageFile="Blog.master" Page Language="C#" CodeFile="View.aspx.cs" Inherits="SimpleBlog.View" AutoEventWireup="true" EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
	<h2><asp:Label id="PostHeader" runat="server" /></h2>
	
	<asp:Literal id="PostContent" runat="server" />
	
	<p id="meta">Last updated on <asp:Label id="PostDate" runat="server" /> (<asp:HyperLink runat="server" id="PostSource" Text="Source" />)</p>
</asp:Content>
