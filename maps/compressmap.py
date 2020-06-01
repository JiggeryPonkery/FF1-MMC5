import os
import sys
import glob

# define a function which outputs the compressed version of a run of a given length
def outputRun( out, runByte, runLen ):
    # do this in a loop.  If there are runs longer than 256 tiles, we have to
    #   compress it in "chunks" that are no bigger than 256.  The while loop here
    #   lets us repeat this "chunking" process as many times as is needed
    while runLen > 0:
        if runLen == 1:         # was it a 'run' of only 1 byte?
            out.append(runByte) # just output it normally  (no compression)
            runLen = 0
        elif runLen == 2:       # was it 2 bytes?
            out.append(runByte) # just output it twice, compressing won't save any space
            out.append(runByte)
            runLen = 0
        elif runLen >= 256:     # Run of 256 or more, we can only do 256
            out.append(runByte | 0x80)
            out.append(0)
            runLen -= 256
        else:                   # else, it's between 3-255... compress it normally!
            out.append(runByte | 0x80)
            out.append(runLen)
            runLen = 0

# define a function to compress some data
#  'src' technically be a string, but we will be treating it as a list of bytes
#  we will be compressing the input bytes and returning a bytearray of the compressed data
def compress(src):
    out = bytearray()       # create our output array
   
    runByte = 0             # a var to keep track of the current 'run' byte
    runLen = 0              # how long the run is
   
    for val in src:         # loop over each byte in our input string
        if val == runByte:          # is this part of the run?
            runLen += 1             # if yes, tally it
        else:
            # otherwise, we're ending a run and starting another.
            outputRun( out, runByte, runLen )   # before starting this new run, output any previous run
                   
            #  Next, we need to start a new run
            if val == 0x7F:     # can't start a run with tile 7F, because that would erroneously create an $FF byte
                # so just output this 7F tile immediately and don't start a run
                out.append(0x7F)
                runByte = 0
                runLen = 0
            else:               # any other tile can have a run
                runByte = val
                runLen = 1

    # Now that we've gone through the whole map, output any run we haven't output yet
    outputRun( out, runByte, runLen )
    out.append(0xFF)                # add the terminator
    return out
   
   
# Another function!  One specifically to handle overworld maps, since those have
#  the additional hassle of a per-row pointer table
def overworld(src):
    ptrTable = bytearray()          # will hold the pointers
    rowGlob = bytearray()           # will hold the compressed rows

    rawRows = {}                    # a dictionary to hold the uncompressed rows.
                                    #  Key = row, value = index in pointer table
                                    # This allows us to reuse mulitple rows if they are identical
                                 
    for rowIndex in range(0x100):
        row = src[ (rowIndex * 0x100):((rowIndex * 0x100) + 0x100) ]
       
        if row in rawRows:
            x = rawRows[row]
            ptrTable.append( ptrTable[(x * 2)    ] )
            ptrTable.append( ptrTable[(x * 2) + 1] )
        else:
            rawRows[row] = rowIndex
            row = compress(row)
            ptr = ((len(rowGlob) + 0x200) & 0x3FFF) + 0x8000
            ptrTable.append( ptr & 0xFF )
            ptrTable.append( (ptr >> 8) & 0xFF )
            rowGlob += row
   
    return ptrTable + rowGlob
    
    
# support function to change the file extension in a string
def changeExt(name, ext):
    pos = name.rfind('.')               # find the last dot in the string
    if pos < 0:                         # if one wasn't found...
        return name + '.' + ext         #   just append the ext to the name
    else:
        return name[0:(pos+1)] + ext    # replace everything after the dot with the given ext
        
def cmapIsOutdated(inName, outName):
    # if the outFile doesn't exist, it is outdated
    if not os.path.exists(outName):
        return True
        
    # get 'last modified' time of both input and output files.  If input was modified more recently, then
    #   the output is outdated
    return os.path.getmtime(inName) > os.path.getmtime(outName)
        
def doFile(inName, force):
    outName = changeExt(inName, 'cmap')
    
    if force or cmapIsOutdated(inName, outName):
        rawdata = open(inName, 'rb').read()
        
        if len(rawdata) > 0x40*0x40:    # too large for standard map?  If so, assume it's the overworld map
            compressedData = overworld(rawdata)
        else:
            compressedData = compress(rawdata)
            
        open(outName, 'wb').write(compressedData)
   
if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage:  python ffcompress.py <filename> [-f]\nIf -f is specified, recompression will be forced')
    else:
        force = (len(sys.argv) >= 3 and sys.argv[2] == '-f')
        
        for name in glob.glob(sys.argv[1]):
            doFile(name, force)
        
        