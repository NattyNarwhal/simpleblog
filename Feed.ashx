<%@ WebHandler Language="C#" Class="SimpleBlog.Feed" %>

using System;
using System.IO;
using System.Web;
using System.Web.Configuration;
using System.Xml;
using System.Linq;

namespace SimpleBlog {
	public class Feed : IHttpHandler {
		// the Atom XMLNS (do not change)
		const string xmlns = "http://www.w3.org/2005/Atom";

		public void ProcessRequest (HttpContext context) {
			context.Response.ContentType = "application/atom+xml";
			// The blog (we get this with some clever tricks?)
			var site = (context.Request.Url.GetLeftPart(UriPartial.Authority) + VirtualPathUtility.ToAbsolute("~/")).ToString();
			// The prefix, which is just site + thing
			var prefix = site + "View.aspx?p=";

			// get the posts
			var di = new DirectoryInfo(WebConfigurationManager.AppSettings["PostsDirectory"]);
			var files = di.GetFiles().OrderByDescending(f => f.LastWriteTime)
				.Take(Convert.ToInt32(WebConfigurationManager.AppSettings["MaxFeedPosts"])).ToList();

			// create RSS boilerplate (is there a better way?)
			var xd = new XmlDocument();

			var atomRoot = xd.CreateElement("feed", xmlns); // <feed>

			var atomTitle = xd.CreateElement("title", xmlns); // <title>
			atomTitle.InnerText = WebConfigurationManager.AppSettings["BlogTitle"];
			atomRoot.AppendChild(atomTitle);

			var atomSelfLink = xd.CreateElement("link", xmlns); // <link href= rel=self>
			atomSelfLink.SetAttribute("href", context.Request.Url.ToString());
			atomSelfLink.SetAttribute("rel", "self");
			atomRoot.AppendChild(atomSelfLink);

			var atomBlogLink = xd.CreateElement("link", xmlns); // <link href=>
			atomBlogLink.SetAttribute("href", site);
			atomRoot.AppendChild(atomBlogLink);

			var atomId = xd.CreateElement("id", xmlns); // <id>
			atomId.InnerText = site; // is this valid?
			atomRoot.AppendChild(atomId);

			// iter the array
			foreach (var fi in files) {
				var name = fi.Name;
				var updated = fi.LastWriteTime.ToString("s") + "Z"; // TERRIBLE UGLY HACK FOR ATOM DATES
				var link = prefix + name;
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