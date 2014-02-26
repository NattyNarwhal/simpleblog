using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Configuration;
using MarkdownSharp;

namespace SimpleBlog {
	public partial class View : Page {
		protected void Page_Load(object sender, EventArgs e) {
			Title += (" - " + Request.QueryString["p"]);
			GetPost(Request.QueryString["p"]);
		}
		
		// Get posts in posts dir
		public void GetPost(string post) {
			Markdown md = new Markdown();
			var postFileName = Path.Combine(WebConfigurationManager.AppSettings["PostsDirectory"], post);
			// attempt to remove directory traversal, ghetto edition
			postFileName = postFileName.Replace("../", String.Empty);

			PostHeader.Text = post;
			
			PostContent.Text = md.Transform(File.ReadAllText(postFileName));
			
			PostDate.Text= File.GetLastWriteTime(postFileName).ToString();
			
			PostSource.NavigateUrl = postFileName;
		}
	}
}
