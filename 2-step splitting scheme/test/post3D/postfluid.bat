if not exist GID_res md GID_res

fl32 /W0 /nologo gidpost0.for
gidpost0.exe
move fluid.flavia.res GID_res>nul
move fluid.flavia.msh GID_res>nul
