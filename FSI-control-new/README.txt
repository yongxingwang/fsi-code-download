step 1: compile generatebat.for and execute it to create a batch file run.bat in order to execute the FSI control programme.
This can be either gfortran or ifort on Windows.
		
step 2: Use the same compiler to compile the Fortran code in all the directory: ./state0, ./state1,./state2, ./dual1.


step 3: Run cgm.bat in ./state0 to generate initial data.

		
step 4: Execute run.bat to run the FSI control programme.
	
=====================================================================================
NOTES:
1. plotj.m read file obj.txt and plot the convergecne of the objective function.
2. plotf.m in folder state* read fnorm.txt and plot the magnitude of the control foce f.
3. in folder state*, ecgma.for: alpha is inital size of the iteration step, and theta is the regularisation prameter.
4. file time0 is to set the time step for all the simulations including the primal and dual problem.
