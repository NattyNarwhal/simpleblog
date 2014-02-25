using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace SimpleBlog {
	public partial class Blog : Page {
		protected void Page_Load(object sender, EventArgs e) {
			// Set some vars in the future
		}
		
		// Get posts in posts dir
		public void GetPosts() {
			// TODO: grouped version, alternate modes, shit like that
			var di = new DirectoryInfo("posts");
			var files = di.GetFiles().OrderByDescending(f =>
				f.LastWriteTime).ToList();
			foreach (var fi in files) {
				var n = fi.Name;
				Response.Write("<li><a href='View.aspx?p=" + n + "'>" + n + "</a> - " + fi.LastWriteTime.ToString() + "</li>");
			}
		}
	}
}
