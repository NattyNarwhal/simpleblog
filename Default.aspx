<%@ Page MasterPageFile="Blog.master" Page Language="C#" CodeFile="Default.aspx.cs" Inherits="SimpleBlog.Blog" AutoEventWireup="true" EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
	<asp:Repeater id="posts" runat="server">
		<HeaderTemplate><ul></HeaderTemplate>
		<ItemTemplate><li><a href="View.aspx?p=<%# DataBinder.Eval(Container.DataItem, "Title") %>"><%# DataBinder.Eval(Container.DataItem, "Title") %></a> - <%# DataBinder.Eval(Container.DataItem, "Posted") %></li></ItemTemplate>
		<FooterTemplate></ul></FooterTemplate>
	</asp:Repeater>
</asp:Content>
