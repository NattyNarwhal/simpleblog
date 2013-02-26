using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using MarkdownSharp;

namespace SimpleBlog {
	public partial class View : Page {
		protected void Page_Load(object sender, EventArgs e) {
			Title += (" - " + Request.QueryString["p"]);
		}
		
		// Get posts in posts dir
		public void GetPost(string post) {
			Markdown md = new Markdown();
			var postFileName = "posts/" + post;
			
			Response.Write("<h2>" + post + "</h2>");
			Response.Write(md.Transform(File.ReadAllText(postFileName)));
			
			Response.Write("<p id='meta'>posted on " + File.GetCreationTime(postFileName).ToString() + ", updated on " + File.GetLastWriteTime(postFileName).ToString() + "</p>");
		}
	}
}
