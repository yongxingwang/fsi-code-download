#! /bin/csh

cp ./input/dimension .
cp ./input/materials .
# cp the fluid mesh and coordinates
cp ./input/coor0.txt .
cp ./input/elem0.txt .

# cp the solid mesh and coordinates
cp ./input/coor1.txt .
cp ./input/elem1.txt .

cp ./input/plotname .
cp ./input/time0 .
cp ./input/nstep .

echo '======start_diff.for...'
./start_diff
echo '======start_conv.for...'
./start_conv
echo '======start_solid.for...'
./start_solid
cp coor1 coor1.bak

echo '======get the initial velocity usolid from interpolation of ufluid'
./interpolation
./interpolate

echo '======preconditioner...'
./preconditioner


if (-e stop) rm stop
loop:
echo '======bft.for...'
./bft
echo '======interpolation.for...'
./interpolation
echo '======convection.for...'
./convection
echo '======solid.for...'
./solid
echo '======diffusion.for...'
./diffusion
echo '======pressure.for...'
./pressure
echo '======interpolate.for...'
./interpolate
echo '======updatecoor.for...'
./updatecoor
echo '======cauchystress.for...'
./cauchystress
echo '======post.sh...'
csh post.sh

if (! -e stop) goto loop

