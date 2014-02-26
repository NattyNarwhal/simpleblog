using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using MarkdownSharp;

namespace SimpleBlog {
	public partial class View : Page {
		// You might have problems with relative directories - in that case
		// just set this variable to an absolute path (or something else)
		const string posts_dir = "./posts";

		protected void Page_Load(object sender, EventArgs e) {
			Title += (" - " + Request.QueryString["p"]);
			GetPost(Request.QueryString["p"]);
		}
		
		// Get posts in posts dir
		public void GetPost(string post) {
			Markdown md = new Markdown();
			var postFileName = Path.Combine(posts_dir, post);
			// attempt to remove directory traversal, ghetto edition
			postFileName = postFileName.Replace("../", String.Empty);

			PostHeader.Text = post;
			
			PostContent.Text = md.Transform(File.ReadAllText(postFileName));
			
			PostDate.Text= File.GetLastWriteTime(postFileName).ToString();
			
			PostSource.NavigateUrl = postFileName;
		}
	}
}
