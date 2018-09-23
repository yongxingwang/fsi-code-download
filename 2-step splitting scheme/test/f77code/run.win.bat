copy input\dimension dimension
copy input\materials materials
rem copy the fluid mesh and coordinates
copy input\coor0.txt coor0.txt
copy input\elem0.txt elem0.txt

rem copy the solid mesh and coordinates
copy input\coor1.txt coor1.txt
copy input\elem1.txt elem1.txt

copy input\plotname plotname
copy input\time0 time0
copy input\nstep nstep

start_diff.exe

start_conv.exe

start_solid.exe
copy coor1 coor1.bak

rem get the initial velocity 'usolid' from interpolation of 'ufluid'
interpolation.exe
interpolate.exe

preconditioner.exe

if exist stop del stop
:1
bft.exe

interpolation.exe

convection.exe

solid.exe
diffusion.exe

interpolate.exe

updatecoor.exe

cauchystress.exe

call post.bat

if not exist stop goto 1
