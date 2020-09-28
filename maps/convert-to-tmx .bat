convertmap.py 00.bin
convertmap.py 01.bin
convertmap.py 02.bin
convertmap.py 03.bin
convertmap.py 04.bin
convertmap.py 05.bin
convertmap.py 06.bin
convertmap.py 07.bin
convertmap.py 08.bin
convertmap.py 09.bin

for /l %%x in (10, 1, 60) do convertmap.py %%x.bin

convertmap.py ow_00.bin

@echo.

@pause


