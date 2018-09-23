step 1: Prepare all the input files in /input, and define boundary and initial conditions in /bc.

step 2: Copy all the files in folder /f77code to current directory.

step 3: Execute "compile.fl32.bat" or "compile.ifort.sh" to compile the fortran code.

step 4: Execute "run.win.bat" or "run.linux.sh" to compute.

step 5: Copy all the files from /post2D or /post3D in order to visualize.
        Modify the first number in files fluid_gidpost.dof and solid_gidpost.dof to define how many steps you want to visualise.
        Run postfluid.bat to generate /GID_res/fluid.flavia.msh and /GID_res/fluid.flavia.res.
		Run postsolid.bat to generate /GID_res/solid.flavia.msh and /GID_res/solid.flavia.res.

step 6: Use the software GID to open the above files and visalize the results.

