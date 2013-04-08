# SimpleBlog

A blog so simple, it doesn't even have a name. It's a super lightweight ASP.NET/C# application, but completely atypical of most by not using forms, databases, or anything but the filesystem. The inspirations are from light blog scripts like Blosxom and hl--, resulting in a minimal blog.

It has been tested on xsp2 from Mono 2.6.7 on Debian 6.0 and Apache+mod_mono from Mono 2.10 on Debian 7.0,  (although some changing of pathes to absolute ones is needed) but it should run on anything with ASP.NET 2.0.

## Usage

Simply tweak Blog.master to your design and write Markdown formatted posted in the posts directory. Drop the contents somewhere, and it should Just Work.
