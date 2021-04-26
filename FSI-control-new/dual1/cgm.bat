copy .\post\* .
copy .\proto\plotname .
copy .\proto\ob .
fl32 starta.for
fl32 startb.for
fl32 bft.for
fl32 append.for


starta disp0 id0 nv disp0 bfd coor0 time press unod.100 ugoal uhat cgma.io elem0 sys diag 

startb dispb0 idb0 nvb dispb0 bfdb coor0 what cgmb.io elemb0 sysb diagb 


if exist stop del stop
:1
bft disp0 time coor0 nv bfdt stop 
call pri.bat

rem ecgmc coor0 coor0 elemc0 normal 

ecgma disp0 sys time nv coor0 bfd diag elem0 uhat press 
rem ecgmb dispb0 sysb time nvb coor0 bfdb diagb elemb0 what 

ecgmd coor0 coor0 elemd0 ob

call post.bat 

if not exist stop goto 1

append ob obj.txt

