if (! -e GID_res) mkdir GID_res

echo 'compiling gidpost1.for...'
ifort -w -o gidpost1 gidpost1.for

echo 'generating GID format files...'
./gidpost1

mv solid.flavia.res ./GID_res/
mv solid.flavia.msh ./GID_res/
