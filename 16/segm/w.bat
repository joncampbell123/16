@echo off
echo ==This is the results of open watcom's base pointers== > wpee
echo These are the various memory models of the 8088 that are demonstrated here! >> wpee
echo ==tiny is not found so default== >> wpee
wcc -0 -mt pee.c
pee.exe >> wpee
echo ==small== >> wpee
wcc -0 -ms pee.c
pee.exe >> wpee
echo ==medium== >> wpee
wcc -0 -mm pee.c
pee.exe >> wpee
echo ==compact is what project 16 uses== >> wpee
wcc -0 -mc pee.c
pee.exe >> wpee
echo ==large== >> wpee
wcc -0 -ml pee.c
pee.exe >> wpee
echo ==HUGE GUTS!== >> wpee
wcl -0 -mh pee.c
pee.exe >> wpee