Uncompress the source code to QwebIRC into this directory.  By that, I don't
mean qwebirc-qwebirc-<some hash here>, I mean that all of the source code
needs to be decompressed into this directory as if this directory was
qwebirc-qwebirc-<some hash here>.

To build the .deb package, execute the command `debuild`.  Sit back and watch.

When asked, answer 'y'.

You'll see a couple of errors throughout the process.  They're not fatal, and
the package will work normally.

I had to include a bunch of .files in the qwebirc source code directory after
precompilation because it looks for that stuff.  Fiddly as hell.
