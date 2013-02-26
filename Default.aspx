<%@ Page MasterPageFile="Blog.master" Page Language="C#" CodeFile="Default.aspx.cs" Inherits="SimpleBlog.Blog" AutoEventWireup="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
	<ul><% GetPosts(); %></ul>
</asp:Content>
