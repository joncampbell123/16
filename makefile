!ifdef __LINUX__
REMOVECOMMAND=rm -f
DIRSEP=/
OBJ=o
!else
REMOVECOMMAND=del
DIRSEP=\
OBJ=obj
!endif
TARGET_OS = dos
#-zk0u = translate kanji to unicode... wwww
#-zk0 = kanji support~
#-zkl = current codepage

SRC=src$(DIRSEP)
SRCLIB=$(SRC)lib$(DIRSEP)
JSMNLIB=$(SRCLIB)jsmn$(DIRSEP)
NYANLIB=$(SRCLIB)nyan$(DIRSEP)
#EXMMLIB=$(SRCLIB)exmm$(DIRSEP)
DOSLIB=$(SRCLIB)doslib$(DIRSEP)
WCPULIB=$(SRCLIB)wcpu$(DIRSEP)

16FLAGS=-fh=16.hed
BAKAPIFLAGS=-fh=bakapi.hed
SFLAGS=-sg -st -of+ -k32768#51200#49152#24576
DFLAGS=-DTARGET_MSDOS=16 -DMSDOS=1 $(SFLAGS)
ZFLAGS=-zk0 -zq -zu -zc -zm# -zdp# -zp16
CFLAGS=-mc -lr -l=dos -wo -x## -d2
OFLAGS=-obmiler -out -oh -ei -zp8 -0 -fpi87  -onac -ol+ -ok####x
FLAGS=$(OFLAGS) $(CFLAGS) $(DFLAGS) $(ZFLAGS)

DOSLIBEXMMOBJ = himemsys.$(OBJ) emm.$(OBJ)
DOSLIBOBJ = adlib.$(OBJ) 8254.$(OBJ) 8259.$(OBJ) dos.$(OBJ) cpu.$(OBJ)
16LIBOBJS = bakapee.$(OBJ) 16_in.$(OBJ) 16_mm.$(OBJ) wcpu.$(OBJ) 16_head.$(OBJ) scroll16.$(OBJ) 16_ca.$(OBJ) timer.$(OBJ) kitten.$(OBJ)
GFXLIBOBJS = modex16.$(OBJ) bitmap.$(OBJ) planar.$(OBJ) 16text.$(OBJ)

TESTEXEC =  exmmtest.exe test.exe pcxtest.exe test2.exe palettec.exe maptest.exe fmemtest.exe fonttest.exe fontgfx.exe sountest.exe tsthimem.exe inputest.exe scroll.exe sega.exe
#testemm.exe testemm0.exe fonttes0.exe miditest.exe
EXEC = 16.exe bakapi.exe $(TESTEXEC)

all: $(EXEC)

#
#game and bakapi executables
#
16.exe: 16.$(OBJ) mapread.$(OBJ) jsmn.$(OBJ) 16.lib
	wcl $(FLAGS) $(16FLAGS) 16.$(OBJ) mapread.$(OBJ) jsmn.$(OBJ) 16.lib

bakapi.exe: bakapi.$(OBJ) 16.lib
	wcl $(FLAGS) $(BAKAPIFLAGS) bakapi.$(OBJ) 16.lib
#
#Test Executables!
#
scroll.exe: scroll.$(OBJ) 16.lib mapread.$(OBJ) jsmn.$(OBJ)
	wcl $(FLAGS) scroll.$(OBJ) 16.lib mapread.$(OBJ) jsmn.$(OBJ)
scroll.$(OBJ): $(SRC)scroll.c
	wcl $(FLAGS) -c $(SRC)scroll.c

sega.exe: sega.$(OBJ)
	wcl $(FLAGS) sega.$(OBJ)
sega.$(OBJ): $(SRC)sega.c
	wcl $(FLAGS) -c $(SRC)sega.c

test.exe: test.$(OBJ) gfx.lib
	wcl $(FLAGS) test.$(OBJ) gfx.lib

test2.exe: test2.$(OBJ) gfx.lib
	wcl $(FLAGS) test2.$(OBJ) gfx.lib

fonttest.exe: fonttest.$(OBJ) 16.lib
	wcl $(FLAGS) fonttest.$(OBJ) 16.lib

fonttes0.exe: fonttes0.$(OBJ) 16.lib
	wcl $(FLAGS) fonttes0.$(OBJ) 16.lib

fontgfx.exe: fontgfx.$(OBJ) 16.lib
	wcl $(FLAGS) fontgfx.$(OBJ) 16.lib

inputest.exe: inputest.$(OBJ) 16.lib
	wcl $(FLAGS) -D__DEBUG_InputMgr__=1 inputest.$(OBJ) 16.lib

sountest.exe: sountest.$(OBJ) 16.lib
	wcl $(FLAGS) sountest.$(OBJ) 16.lib

miditest.exe: miditest.$(OBJ) 16.lib $(DOSLIBEXMMOBJ) midi.$(OBJ)
	wcl $(FLAGS) miditest.$(OBJ) 16.lib $(DOSLIBEXMMOBJ) midi.$(OBJ)

tsthimem.exe: tsthimem.$(OBJ) 16.lib $(DOSLIBEXMMOBJ)
	wcl $(FLAGS) tsthimem.$(OBJ) 16.lib $(DOSLIBEXMMOBJ)

testemm.exe: testemm.$(OBJ) 16.lib $(DOSLIBEXMMOBJ)
	wcl $(FLAGS) testemm.$(OBJ) 16.lib $(DOSLIBEXMMOBJ)

testemm0.exe: testemm0.$(OBJ) 16.lib $(DOSLIBEXMMOBJ)
	wcl $(FLAGS) testemm0.$(OBJ) 16.lib $(DOSLIBEXMMOBJ)

pcxtest.exe: pcxtest.$(OBJ) gfx.lib
	wcl $(FLAGS) pcxtest.$(OBJ) gfx.lib

palettec.exe: palettec.$(OBJ) 16.lib
	wcl $(FLAGS) palettec.$(OBJ) 16.lib

maptest.exe: maptest.$(OBJ) mapread.$(OBJ) jsmn.$(OBJ) 16.lib
	wcl $(FLAGS) maptest.$(OBJ) mapread.$(OBJ) jsmn.$(OBJ) 16.lib

#maptest0.exe: maptest0.$(OBJ) fmapread.$(OBJ) farjsmn.$(OBJ)# 16.lib
#	wcl $(FLAGS) $(MFLAGS) maptest0.$(OBJ) fmapread.$(OBJ) farjsmn.$(OBJ)# 16.lib

#emmtest.exe: emmtest.$(OBJ) memory.$(OBJ)
#	wcl $(FLAGS) $(MFLAGS) emmtest.$(OBJ) memory.$(OBJ)

#emsdump.exe: emsdump.$(OBJ) memory.$(OBJ)
#	wcl $(FLAGS) $(MFLAGS) emsdump.$(OBJ) memory.$(OBJ)

fmemtest.exe: fmemtest.$(OBJ) 16.lib
	wcl $(FLAGS) fmemtest.$(OBJ) 16.lib

exmmtest.exe: exmmtest.$(OBJ) 16.lib
	wcl $(FLAGS) exmmtest.$(OBJ) 16.lib

#
#executable's objects
#
16.$(OBJ): $(SRC)16.h $(SRC)16.c
	wcl $(FLAGS) -c $(SRC)16.c

bakapi.$(OBJ): $(SRC)bakapi.h $(SRC)bakapi.c
	wcl $(FLAGS) -c $(SRC)bakapi.c

test.$(OBJ): $(SRC)test.c $(SRCLIB)modex16.h
	wcl $(FLAGS) -c $(SRC)test.c

test2.$(OBJ): $(SRC)test2.c $(SRCLIB)modex16.h
	wcl $(FLAGS) -c $(SRC)test2.c

pcxtest.$(OBJ): $(SRC)pcxtest.c $(SRCLIB)modex16.h
	wcl $(FLAGS) -c $(SRC)pcxtest.c

palettec.$(OBJ): $(SRC)palettec.c
	wcl $(FLAGS) -c $(SRC)palettec.c

maptest.$(OBJ): $(SRC)maptest.c $(SRCLIB)modex16.h
	wcl $(FLAGS) -c $(SRC)maptest.c

#maptest0.$(OBJ): $(SRC)maptest0.c# $(SRCLIB)modex16.h
#	wcl $(FLAGS) $(MFLAGS) -c $(SRC)maptest0.c

#emmtest.$(OBJ): $(SRC)emmtest.c
#	wcl $(FLAGS) $(MFLAGS) -c $(SRC)emmtest.c

#emsdump.$(OBJ): $(SRC)emsdump.c
#	wcl $(FLAGS) $(MFLAGS) -c $(SRC)emsdump.c

fmemtest.$(OBJ): $(SRC)fmemtest.c
	wcl $(FLAGS) -c $(SRC)fmemtest.c

fonttest.$(OBJ): $(SRC)fonttest.c
	wcl $(FLAGS) -c $(SRC)fonttest.c

fonttes0.$(OBJ): $(SRC)fonttes0.c
	wcl $(FLAGS) -c $(SRC)fonttes0.c

fontgfx.$(OBJ): $(SRC)fontgfx.c
	wcl $(FLAGS) -c $(SRC)fontgfx.c

inputest.$(OBJ): $(SRC)inputest.c
	wcl $(FLAGS) -c $(SRC)inputest.c

sountest.$(OBJ): $(SRC)sountest.c
	wcl $(FLAGS) -c $(SRC)sountest.c

miditest.$(OBJ): $(SRC)miditest.c
	wcl $(FLAGS) -c $(SRC)miditest.c

testemm.$(OBJ): $(SRC)testemm.c
	wcl $(FLAGS) -c $(SRC)testemm.c

testemm0.$(OBJ): $(SRC)testemm0.c
	wcl $(FLAGS) -c $(SRC)testemm0.c

tsthimem.$(OBJ): $(SRC)tsthimem.c
	wcl $(FLAGS) -c $(SRC)tsthimem.c

exmmtest.$(OBJ): $(SRC)exmmtest.c
	wcl $(FLAGS) -c $(SRC)exmmtest.c

#
#non executable objects libraries
#
16.lib: $(16LIBOBJS) gfx.lib doslib.lib
	wlib -b 16.lib $(16LIBOBJS) gfx.lib doslib.lib

gfx.lib: $(GFXLIBOBJS)
	wlib -b gfx.lib $(GFXLIBOBJS)

doslib.lib: $(DOSLIBOBJ) # $(SRCLIB)cpu.lib
	wlib -b doslib.lib $(DOSLIBOBJ) # $(SRCLIB)cpu.lib

modex16.$(OBJ): $(SRCLIB)modex16.h $(SRCLIB)modex16.c
	wcl $(FLAGS) -c $(SRCLIB)modex16.c

bakapee.$(OBJ): $(SRCLIB)bakapee.h $(SRCLIB)bakapee.c
	wcl $(FLAGS) -c $(SRCLIB)bakapee.c

bitmap.$(OBJ): $(SRCLIB)bitmap.h $(SRCLIB)bitmap.c
	wcl $(FLAGS) -c $(SRCLIB)bitmap.c

planar.$(OBJ): $(SRCLIB)planar.h $(SRCLIB)planar.c
	wcl $(FLAGS) -c $(SRCLIB)planar.c

scroll16.$(OBJ): $(SRCLIB)scroll16.h $(SRCLIB)scroll16.c
	wcl $(FLAGS) -c $(SRCLIB)scroll16.c

wcpu.$(OBJ): $(WCPULIB)wcpu.h $(WCPULIB)wcpu.c
	wcl $(FLAGS) -c $(WCPULIB)wcpu.c

16text.$(OBJ): $(SRCLIB)16text.c
	wcl $(FLAGS) -c $(SRCLIB)16text.c

mapread.$(OBJ): $(SRCLIB)mapread.h $(SRCLIB)mapread.c
	wcl $(FLAGS) -c $(SRCLIB)mapread.c

#fmapread.$(OBJ): $(SRCLIB)fmapread.h $(SRCLIB)fmapread.c 16.lib
#	wcl $(FLAGS) $(MFLAGS) -c $(SRCLIB)fmapread.c 16.lib

timer.$(OBJ): $(SRCLIB)timer.h $(SRCLIB)timer.c
        wcl $(FLAGS) -c $(SRCLIB)timer.c

16_in.$(OBJ): $(SRCLIB)16_in.h $(SRCLIB)16_in.c
	wcl $(FLAGS) -c $(SRCLIB)16_in.c

16_mm.$(OBJ): $(SRCLIB)16_mm.h $(SRCLIB)16_mm.c
	wcl $(FLAGS) -c $(SRCLIB)16_mm.c

16_ca.$(OBJ): $(SRCLIB)16_ca.h $(SRCLIB)16_ca.c
	wcl $(FLAGS) -c $(SRCLIB)16_ca.c

midi.$(OBJ): $(SRCLIB)midi.h $(SRCLIB)midi.c
	wcl $(FLAGS) -c $(SRCLIB)midi.c

#
# doslib stuff
#
adlib.$(OBJ): $(DOSLIB)adlib.h $(DOSLIB)adlib.c
	wcl $(FLAGS) -c $(DOSLIB)adlib.c

8254.$(OBJ): $(DOSLIB)8254.h $(DOSLIB)8254.c
	wcl $(FLAGS) -c $(DOSLIB)8254.c

8259.$(OBJ): $(DOSLIB)8259.h $(DOSLIB)8259.c
	wcl $(FLAGS) -c $(DOSLIB)8259.c

dos.$(OBJ): $(DOSLIB)dos.h $(DOSLIB)dos.c
	wcl $(FLAGS) -c $(DOSLIB)dos.c

cpu.$(OBJ): $(DOSLIB)cpu.h $(DOSLIB)cpu.c
	wcl $(FLAGS) -c $(DOSLIB)cpu.c

himemsys.$(OBJ): $(DOSLIB)himemsys.h $(DOSLIB)himemsys.c
	wcl $(FLAGS) -c $(DOSLIB)himemsys.c

emm.$(OBJ): $(DOSLIB)emm.h $(DOSLIB)emm.c
	wcl $(FLAGS) -c $(DOSLIB)emm.c

# end of doslib stuff

16_head.$(OBJ): $(SRCLIB)16_head.h $(SRCLIB)16_head.c
	wcl $(FLAGS) -c $(SRCLIB)16_head.c

jsmn.$(OBJ): $(JSMNLIB)jsmn.h $(JSMNLIB)jsmn.c
	wcl $(FLAGS) -c $(JSMNLIB)jsmn.c

kitten.$(OBJ): $(NYANLIB)kitten.h $(NYANLIB)kitten.c
        wcl $(FLAGS) -c $(NYANLIB)kitten.c

#farjsmn.$(OBJ): $(JSMNLIB)farjsmn.h $(JSMNLIB)farjsmn.c
#	wcl $(FLAGS) $(MFLAGS) -c $(JSMNLIB)farjsmn.c

#memory.$(OBJ): $(EXMMLIB)memory.h $(EXMMLIB)memory.c
#	wcl $(FLAGS) $(MFLAGS) -c $(EXMMLIB)memory.c

#
#other~
#
clean: .symbolic
	@$(REMOVECOMMAND) $(EXEC)
	@$(REMOVECOMMAND) *.$(OBJ)
	@$(REMOVECOMMAND) *.lib
	@wlib -n 16.lib
	@wlib -n  gfx.lib
	@wlib -n  doslib.lib
	@$(REMOVECOMMAND) *.16
	@$(REMOVECOMMAND) *.OBJ
	@$(REMOVECOMMAND) makefi~1
	@$(REMOVECOMMAND) makefile~
	@$(REMOVECOMMAND) __WCL__.LNK
#	@$(REMOVECOMMAND) *.smp
	@$(REMOVECOMMAND) *.SMP
	@$(REMOVECOMMAND) 16.hed
	@$(REMOVECOMMAND) bakapi.hed
