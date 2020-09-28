#!/usr/bin/python
import os
import sys
import xml.etree.ElementTree as ETree


def backup_old_file(file):
    if not os.path.isfile(file):
        return

    if os.path.isfile(file + ".bkp"):
        os.remove(file + ".bkp")

    os.rename(file, file + ".bkp")


def convert_map(map_file):
    if not map_file.endswith(".tmx"):
        print("Error: " + map_file + " is not a tmx file")
        sys.exit(1)

    basename = map_file.strip(".tmx")

    tree = ETree.parse(map_file)
    root = tree.getroot()
    data = root.find("layer").find("data").text
    numbers = [(int(byte) - 1) for byte in data.strip().split(",")]

    backup_old_file(basename)

    with open(basename, "wb") as outfile:
        outfile.write(bytearray(numbers))


if (len(sys.argv)) <= 1:
    print("Usage: tmxToBin.py [filename]")
    exit(1)

if __name__ == "__main__":
    convert_map(sys.argv[1])
