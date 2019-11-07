ca65 bank_00.asm
ca65 bank_01.asm
ca65 bank_02.asm
ca65 bank_03.asm
ca65 bank_04.asm
ca65 bank_05.asm
ca65 bank_06.asm
ca65 bank_07.asm
ca65 bank_08.asm
ca65 bank_09.asm
ca65 bank_0A.asm
ca65 bank_0B.asm
ca65 bank_0C.asm
ca65 bank_0D.asm
ca65 bank_0E.asm
ca65 bank_0F.asm
ca65 bank_10.asm
ca65 bank_11.asm
ca65 bank_12.asm
ca65 bank_13.asm
ca65 bank_14.asm
ca65 bank_15.asm
ca65 bank_16.asm
ca65 bank_17.asm
ca65 bank_18.asm
ca65 bank_19.asm
ca65 bank_1A.asm
ca65 bank_1B.asm
ca65 bank_1C.asm
ca65 bank_1D.asm
ca65 bank_1E.asm
ca65 bank_1F.asm


ld65 -C nes.cfg bank_00.o bank_01.o bank_02.o bank_03.o bank_04.o bank_05.o bank_06.o bank_07.o bank_08.o bank_09.o bank_0A.o bank_0B.o bank_0C.o bank_0D.o bank_0E.o bank_0F.o bank_10.o bank_11.o bank_12.o bank_13.o bank_14.o bank_15.o bank_16.o bank_17.o bank_18.o bank_19.o bank_1A.o bank_1B.o bank_1C.o bank_1D.o bank_1E.o bank_1F.o --dbgfile FinalFantasy.dbg

copy /B nesheader.bin+bank_00.bin+bank_01.bin+bank_02.bin+bank_03.bin+bank_04.bin+bank_05.bin+bank_06.bin+bank_07.bin+bank_08.bin+bank_09.bin+bank_0A.bin+bank_0B.bin+bank_0C.bin+bank_0D.bin+bank_0E.bin+bank_0F.bin+bank_10.bin+bank_11.bin+bank_12.bin+bank_13.bin+bank_14.bin+bank_15.bin+bank_16.bin+bank_17.bin+bank_18.bin+bank_19.bin+bank_1A.bin+bank_1B.bin+bank_1C.bin+bank_1D.bin+bank_1E.bin+bank_1F.bin FinalFantasy.nes

del *.o
del bank_*.bin

pause
