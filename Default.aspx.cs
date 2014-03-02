using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Configuration;
using System.Collections.Generic;

namespace SimpleBlog {
	public partial class Blog : Page {
		protected void Page_Load(object sender, EventArgs e) {
			GetPosts();
		}
		
		// Get posts in posts dir
		public void GetPosts() {
			// TODO: grouped version, alternate modes, shit like that
			// TODO: is a repeater the best?
			var postList = new List<Post>();
			var di = new DirectoryInfo(WebConfigurationManager.AppSettings["PostsDirectory"]);
			var files = di.GetFiles().OrderByDescending(f =>
				f.LastWriteTime).ToList();
			foreach (var fi in files) {
				postList.Add(new Post{ Title = fi.Name, Posted = fi.LastWriteTime });
			}
			posts.DataSource = postList;
			posts.DataBind();
		}
	}

	public class Post
	{
		public string Title { get; set; }
		public DateTime Posted { get; set; }
		public Post() { }
	}
}
