copy .\post\* .
copy .\proto\plotname .
copy .\proto\fnorm.txt .

fl32 starta.for
fl32 startb.for
fl32 upcoor.for
fl32 bft.for
 
starta disp0 id0 nv disp0 bfd time0 time coor0 unods unod cgma.io elem0 sys diag 
startb dispb0 idb0 nvb dispb0 bfdb time0 time coor0 unodb cgmb.io elemb0 sysb diagb 
startc dispc0 idc0 nvc dispc0 bfdc time0 time coor0 unodc cgmc.io elemc0 sysc diagc 
 
copy unods press 
copy unods force
copy coor0 coor0bak


if exist stop del stop
:1
bft disp0 time coor0 nv bfd bfdc stop 
call pri.bat

ecgmc dispc0 sysc time nvc coor0 bfdc diagc elemc0 unod 

ecgma disp0 sys time nv coor0 bfd diag elem0 unod press 
ecgmb dispb0 sysb time coor0 bfdb diagb elemb0 nvb unodb

rem ecgmd coor0 coor0 elemd0 unodd 

ecgme coor0 coor0 elem0   
 
upcoor elem0 coor0 unodb time unods
 
call post.bat 

if not exist stop goto 1



