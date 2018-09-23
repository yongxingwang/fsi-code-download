if (! -e GID_res) mkdir GID_res

echo 'compiling gidpost0.for...'
ifort -w -o gidpost0 gidpost0.for

echo 'generating GID format files...'
./gidpost0

mv fluid.flavia.res ./GID_res/
mv fluid.flavia.msh ./GID_res/
