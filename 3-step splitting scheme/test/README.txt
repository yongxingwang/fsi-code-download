step 1: Prepare all the input files in /input, and define boundary and initial conditions in /bc.
        (please refer to the readme.txt in /input for details, and the files in /bc are self explained.)

		
step 2: Copy all the files in folder /f77code to current directory /test.


step 3: Execute 'compile.fl32.bat' or 'compile.ifort.sh' to compile the fortran code.
        (Other compilers, such as GNU gfotran, are also possilbe. 
         However we only provide Intel fl32 and ifort commands here: 
	'compile.fl32.bat' for Windows and 'compile.ifort.sh' for Linux system.)

		
step 4: Execute "run.win.bat" or "run.linux.sh" to compute.


step 5: Copy all the files from /post2D or /post3D in order to visualize.
        Modify the first number in files fluid_gidpost.dof and solid_gidpost.dof to define how many steps you want to visualise.
	You will know how to do this after opening file fluid_gidpost.dof.
        Run postfluid.bat (Windows) or postfluid.sh (Linux) to generate /GID_res/fluid.flavia.msh and /GID_res/fluid.flavia.res.
	Run postsolid.bat (Windows) or postsolid.sh (Linux) to generate /GID_res/solid.flavia.msh and /GID_res/solid.flavia.res.

		
step 6: Use the software GID to open the above files and visalize the results.


