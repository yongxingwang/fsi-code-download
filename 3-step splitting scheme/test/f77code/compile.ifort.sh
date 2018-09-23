#! /bin/csh

set FC=ifort

echo 'compiling start_diff.for...'
${FC} -w -o start_diff start_diff.for ./bc/id.for ./bc/upinitial.for
echo 'compiling start_conv.for...'
${FC} -w -o start_conv start_conv.for ./bc/id.for
echo 'compiling start_solid.for...'
${FC} -w -o start_solid start_solid.for
echo 'compiling bft.for...'
${FC} -w -o bft bft.for ./bc/bound.for
echo 'compiling interpolation.for...'
${FC} -w -o interpolation interpolation.for
echo 'compiling interpolate.for...'
${FC} -w -o interpolate interpolate.for
echo 'compiling updatecoor.for...'
${FC} -w -o updatecoor updatecoor.for


echo 'compiling preconditioner.for...'
${FC} -w -o preconditioner preconditioner.for ./lib/ceq9g3.for ./lib/cec27g3.for ./lib/ccshap.for ./lib/shap.for

echo 'compiling convection.for...'
${FC} -w -o convection convection.for ./lib/beq9g3.for ./lib/bec27g3.for ./lib/ccshap.for ./lib/shap.for

echo 'compiling diffusion.for...'
${FC} -w -o diffusion diffusion.for ./lib/aeq9g3.for ./lib/aec27g3.for ./lib/ccshap.for ./lib/shap.for

echo 'compiling pressure.for...'
${FC} -w -o pressure pressure.for ./lib/feq9g3.for ./lib/fec27g3.for ./lib/ccshap.for ./lib/shap.for

echo 'compiling solid.for...'
${FC} -w -o solid solid.for ./lib/det3.for ./lib/dew4.for ./lib/ccshap.for ./lib/shap.for

echo 'compiling cauchystress.for...'
${FC} -w -o cauchystress cauchystress.for ./lib/eet3.for ./lib/eew4.for ./lib/ccshap.for ./lib/shap.for




