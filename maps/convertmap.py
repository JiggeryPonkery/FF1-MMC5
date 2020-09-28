#!/usr/bin/python
import os
import re
import sys


def row_to_str(binary_row):
    dec_strs = [str(byte + 1) for byte in binary_row]
    return ",".join(dec_strs) + "\n"

def load_tileset_index():
    with open("tilesets.bin", "rb") as tileset_index_file:
        all = tileset_index_file.read()
    return all

def convert_map(map_file):

    tileset_index = load_tileset_index()

    matches = re.match(".*(\d\d+).bin", map_file)

    tileset_map = [
        "Town",
        "Castle",
        "Volcano",
        "Cave",
        "Tower",
        "Shrine",
        "SkyPalace",
        "ToF"
    ]

    map_size = 64
    if matches:
        map_index = int(matches.group(1))
        base_file_name = matches.group(0)
    else:
        print("Could not find tileset id for map " + map_file)
        sys.exit(1)

    tileset_mapped = tileset_index[map_index]
    tileset_name = tileset_map[tileset_mapped]

    if os.path.getsize(map_file) > 4096:
        tileset_name = "Overworld"
        map_size = 256


    header = """<?xml version="1.0" encoding="UTF-8"?>
<map version="1.2" tiledversion="1.3.4" orientation="orthogonal" renderorder="right-down" width="64" height="64" tilewidth="16" tileheight="16" infinite="0" nextlayerid="2" nextobjectid="1">
 <tileset firstgid="1" source="Tilesets/%s.tsx"/>
 <layer id="1" name="Tile Layer 1" width="%s" height="%s">
  <data encoding="csv">""" % (tileset_name, map_size, map_size)

    with open(base_file_name + ".tmx", "w") as outfile:
        outfile.write(header)
        first = True
        with open(map_file, "rb") as infile:
            row = infile.read(map_size)
            while row:
                row_str = row_to_str(row)
                if first:
                    first = False
                else:
                    row_str = "," + row_str
                    first = False

                outfile.write(row_str)
                row = infile.read(map_size)


        outfile.write("""</data>
 </layer>
</map>""")


if (len(sys.argv)) <= 1:
    print("Usage: convertmap.py [filename]")
    exit(1)

if __name__ == "__main__":
    convert_map(sys.argv[1])




