fl32 starta.for
fl32 startb.for
fl32 upcoor.for
fl32 bft.for

copy .\post\* .
copy .\proto\plotname .
copy ..\state0\unod.200 unod0  
copy ..\state0\unods.200 unods  
copy ..\state0\coor0.200 coor0
copy ..\state0\coor0bak coor0bak

 
starta disp0 id0 nv disp0 bfd time0 time coor0 press unod cgma.io elem0 sys diag 
startb dispb0 idb0 nvb dispb0 bfdb time0 time coor0 unodb cgmb.io elemb0 sysb diagb 
startc dispc0 idc0 nvc dispc0 bfdc time0 time coor0 unodc cgmc.io elemc0 sysc diagc 


if exist stop del stop
:1
bft disp0 time coor0 nv bfdt bfdct stop 
call pri.bat

ecgmc dispc0 sysc time nvc coor0 bfdc diagc elemc0 unod 

ecgma disp0 sys time nv coor0 bfd diag elem0 unod press 

ecgmb dispb0 sysb time coor0 bfdb diagb elemb0 nvb unodb

rem ecgmd coor0 coor0 elemd0 unodd 
 
upcoor elem0 coor0 unodb time unods
 
call post.bat 

if not exist stop goto 1



