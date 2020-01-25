step 1: Prepare all the input files in ./input, and define boundary and initial conditions in ./bc.
        (please refer to the readme.txt in ./input for details, and the files in ./bc are self explained.)

		
step 2: Copy all the files in folder ./C-code and ./bc to current directory ./test.


step 3: Execute 'compile.bat' for Windows or 'make' Linux to compile the C code.

		
step 4: Execute "fsi.exe" (Windows) or "fsi" (Linux) to compute.
	
step 5: Use the software GID to open the files in ./output and visalize the results.
        (one can modify the code gidres.c (for the fluid) and gidres1.c (for the solid)
        and write a preferable format in order to visalize uisng the correponding software.) 
		

=====================================================================================
NOTES:
1. About Memorry:
2. Constraint(Drichlet BC) for the solid:
3. Provide interpolation area:
4. Master-slave nodes (can be applied for peridic boundary conditions):
5. Initial values for the solid:
