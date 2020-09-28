import os

NumberOfStandardMaps = 61


def decompress( src ):
    output = bytearray()
    srclen = len(src) - 1
    
    i = 0
    while i < srclen:
        v = src[i]
        i += 1
        if v == 0xFF:           # end of map data?
            break
            
        if v & 0x80:          # run?
            v = v & 0x7F
            runlen = src[i]
            i += 1
            
            if runlen == 0:
                runlen = 256
            for _ in range(runlen):
                output.append(v)
        else:
            output.append(v)
            
    return output




if __name__ == '__main__':
    # make a 'maps' director
    if not os.path.exists('maps'):
        os.mkdir('maps')
    
    infile = open('ff.nes', 'rb').read()

    # standard maps!
    for mapId in range(NumberOfStandardMaps):
        ptrOffset = 0x10010 + (mapId * 2)
        ptr = infile[ptrOffset] | (infile[ptrOffset + 1] << 8)
        ptr += 0x10010
        
        open('maps/%02d.bin' % mapId, 'wb').write( decompress( infile[ptr:] ) )
        
    # overworld map!
    ow = bytearray()
    for row in range(0x100):
        ptrOffset = 0x4010 + (row * 2)
        ptr = infile[ptrOffset] | (infile[ptrOffset + 1] << 8)
        ptr &= 0x3FFF
        ptr += 0x4010
        
        ow += decompress( infile[ptr:] )
        
    open('maps/ow_00.bin', 'wb').write( ow )