ca65 bank_00.asm -g
ca65 bank_01.asm -g
ca65 bank_02.asm -g
ca65 bank_03.asm -g
ca65 bank_04.asm -g
ca65 bank_05.asm -g
ca65 bank_06.asm -g
ca65 bank_07.asm -g
ca65 bank_08.asm -g
ca65 bank_09.asm -g
ca65 bank_0A.asm -g
ca65 bank_0B.asm -g
ca65 bank_0C.asm -g
ca65 bank_0D.asm -g
ca65 bank_0E.asm -g
ca65 bank_0F.asm -g
ca65 bank_10.asm -g
ca65 bank_11.asm -g
ca65 bank_12.asm -g
ca65 bank_13.asm -g
ca65 bank_14.asm -g
ca65 bank_15.asm -g
ca65 bank_16.asm -g
ca65 bank_17.asm -g
ca65 bank_18.asm -g
ca65 bank_19.asm -g
ca65 bank_1A.asm -g
ca65 bank_1B.asm -g
ca65 bank_1C.asm -g
ca65 bank_1D.asm -g
ca65 bank_1E.asm -g
ca65 bank_1F.asm -g

ld65 -C nes.cfg bank_00.o bank_01.o bank_02.o bank_03.o bank_04.o bank_05.o bank_06.o bank_07.o bank_08.o bank_09.o bank_0A.o bank_0B.o bank_0C.o bank_0D.o bank_0E.o bank_0F.o bank_10.o bank_11.o bank_12.o bank_13.o bank_14.o bank_15.o bank_16.o bank_17.o bank_18.o bank_19.o bank_1A.o bank_1B.o bank_1C.o bank_1D.o bank_1E.o bank_1F.o -m mapfile.txt -Ln labels.txt -o FinalFantasy.nes --dbgfile FinalFantasy.dbg

del *.o

pause
