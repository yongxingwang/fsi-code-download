if exist matdata del matdata
md matdata
fl32 extrplotres.for
if exist stopc del stopc
:1
extrplotres.exe 

if not exist stopc goto 1
