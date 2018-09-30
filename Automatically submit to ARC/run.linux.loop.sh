#! /bin/csh

echo '======get system time...'
date +%s > tstart

if (-e stop) rm stop
if (-e end) rm end
loop:

echo '======get system time...'
date +%s > tnow

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

if (! -e end) qsub job_3D_cylinder_loop


