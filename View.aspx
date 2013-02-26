<%@ Page MasterPageFile="Blog.master" Page Language="C#" CodeFile="View.aspx.cs" Inherits="SimpleBlog.View" AutoEventWireup="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
	<% GetPost(Request.QueryString["p"]); %>
</asp:Content>
