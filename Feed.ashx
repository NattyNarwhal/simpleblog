<%@ WebHandler Language="C#" Class="SimpleBlog.Feed" %>

using System;
using System.IO;
using System.Web;
using System.Xml;
using System.Linq;

namespace SimpleBlog {
	public class Feed : IHttpHandler {
		// the Atom XMLNS (do not change)
		const string xmlns = "http://www.w3.org/2005/Atom";
		// your website's metadata
		const string title = "My blog";
		// how many posts
		const int max_posts = 15;
		// the URL & the posts prefix of the site, ending in / - the feed will also link back to this
		const string site = "http://www.example.com/blog/";
		const string site_prefix = site + "posts/";
		// the posts directory
		const string posts_dir = "/home/calvin/src/simpleblog/posts";

		public void ProcessRequest (HttpContext context) {
			context.Response.ContentType = "application/atom+xml";

			// get the posts
			var di = new DirectoryInfo(posts_dir);
			var files = di.GetFiles().OrderByDescending(f => f.LastWriteTime)
				.Take(max_posts).ToList();

			// create RSS boilerplate (is there a better way?)
			var xd = new XmlDocument();

			var atomRoot = xd.CreateElement("feed", xmlns); // <feed>

			var atomTitle = xd.CreateElement("title", xmlns); // <title>
			atomTitle.InnerText = title;
			atomRoot.AppendChild(atomTitle);

			var atomBlogLink = xd.CreateElement("link", xmlns); // <link href=>
			//var atomBlogLinkHref = xd.CreateAttribute("href", xmlns);
			//atomBlogLinkHref.Value = site;
			//atomBlogLink.Attributes.SetNamedItem(atomBlogLinkHref);
			atomBlogLink.SetAttribute("href", site);
			atomRoot.AppendChild(atomBlogLink);

			var atomId = xd.CreateElement("id", xmlns); // <id>
			atomId.InnerText = site_prefix; // is this valid?
			atomRoot.AppendChild(atomId);

			// iter the array
			foreach (var fi in files) {
				var name = fi.Name;
				var updated = fi.LastWriteTime.ToString("s") + "Z"; // TERRIBLE UGLY HACK FOR ATOM DATES
				var link = site_prefix + name;
				// make the nodes
				var atomEntry = xd.CreateElement("entry", xmlns); // <entry>

				var atomPostTitle = xd.CreateElement("title", xmlns); // <title>
				atomPostTitle.InnerText = name;
				atomEntry.AppendChild(atomPostTitle);

				// Titles are unique, as they are filesystem-based, so we can use them as ID
				var atomPostId = xd.CreateElement("id", xmlns); // <id>
				atomPostId.InnerText = name;
				atomEntry.AppendChild(atomPostId);

				var atomPostUpdated = xd.CreateElement("updated", xmlns); // <updated>
				atomPostUpdated.InnerText = updated;
				atomEntry.AppendChild(atomPostUpdated);

				var atomPostLink = xd.CreateElement("link", xmlns); // <link href=>
				//var atomPostLinkHref = xd.CreateAttribute("href", xmlns);
				//atomPostLinkHref.Value = link;
				//atomPostLink.Attributes.SetNamedItem(atomPostLinkHref);
				atomPostLink.SetAttribute("href", link);
				atomEntry.AppendChild(atomPostLink);

				atomRoot.AppendChild(atomEntry);
			}

			// insert it and the XML declaration into the XmlDocument
			xd.AppendChild(xd.CreateXmlDeclaration("1.0", null, null));
			xd.AppendChild(atomRoot);

			// and write I guess
			context.Response.Write(xd.DocumentElement.OuterXml);
		}

		public bool IsReusable {
			get { return true; }
		}
	}
}