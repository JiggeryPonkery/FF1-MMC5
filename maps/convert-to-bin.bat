tmxToBin.py 00.bin.tmx
tmxToBin.py 01.bin.tmx
tmxToBin.py 02.bin.tmx
tmxToBin.py 03.bin.tmx
tmxToBin.py 04.bin.tmx
tmxToBin.py 05.bin.tmx
tmxToBin.py 06.bin.tmx
tmxToBin.py 07.bin.tmx
tmxToBin.py 08.bin.tmx
tmxToBin.py 09.bin.tmx

for /l %%x in (10, 1, 60) do tmxToBin.py %%x.bin.tmx

tmxToBin.py ow_00.bin.tmx

@echo.

@pause
