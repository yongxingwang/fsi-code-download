if not exist GID_res md GID_res

fl32 /W0 /nologo gidpost1.for
gidpost1.exe
move solid.flavia.res GID_res>nul
move solid.flavia.msh GID_res>nul
