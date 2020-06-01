MADE BY DISCH! 

http://www.romhacking.net/forum/index.php?topic=27632.msg395314#msg395314
-----------------------------

Example usage:    python ffcompress.py maps\00.bin

The above will create the file 'maps\00.cmap' which will be the compressed map.

Additionally wildcard characters will work, so you can do this:    python ffcompress.py maps\*.bin

And it will compress ALL .bin files in that directory and create their respective .cmap file


Also, the compressor will examine 'last modified' timestamps and will only recompress maps if their cmap file is out of date.  So you can run this in a build step and it will mostly do nothing (and thus run very fast) unless you have recently modified a map.

However, this behavior can be ignored if you do:  python ffcompress.py yourfile.bin -f

The '-f' will force compression to happen even if the cmap file is up to date.

------------------------------
Jiggers: compressmap.exe is an executable version of the Python script, so "compressmap maps\00.bin" will work for the first example. 