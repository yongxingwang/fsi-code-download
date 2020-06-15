 cd state0      
 call cgm.bat
 cd ..
 
 cd state1     
 call cgm.bat
 cd ..

 Xcopy /E /I dual1 dual2
 cd dual1       
 copy ..\state1\unod.* .
 copy ..\state1\press.* .
 copy ..\state1\unodb.* .
 copy ..\state1\unods.* .
 copy ..\state1\coor0.* .
 copy ..\state1\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 cd state2      
 copy ..\state1\force.* .
 copy ..\state1\unod.??? vel.???
 copy ..\dual1\uhat.* .
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual2 dual3
 cd dual2       
 copy ..\state2\unod.* .
 copy ..\state2\press.* .
 copy ..\state2\unodb.* .
 copy ..\state2\unods.* .
 copy ..\state2\coor0.* .
 copy ..\state2\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state3 state4
 cd state3      
 copy ..\dual2\uhat.* .
 copy ..\state2\fnew.??? force.???
 copy ..\state2\force.??? fold.???
 copy ..\dual1\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual3 dual4
 cd dual3       
 copy ..\state3\unod.* .
 copy ..\state3\press.* .
 copy ..\state3\unodb.* .
 copy ..\state3\unods.* .
 copy ..\state3\coor0.* .
 copy ..\state3\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state4 state5
 cd state4      
 copy ..\dual3\uhat.* .
 copy ..\state3\fnew.??? force.???
 copy ..\state3\force.??? fold.???
 copy ..\dual2\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual4 dual5
 cd dual4       
 copy ..\state4\unod.* .
 copy ..\state4\press.* .
 copy ..\state4\unodb.* .
 copy ..\state4\unods.* .
 copy ..\state4\coor0.* .
 copy ..\state4\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state5 state6
 cd state5      
 copy ..\dual4\uhat.* .
 copy ..\state4\fnew.??? force.???
 copy ..\state4\force.??? fold.???
 copy ..\dual3\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual5 dual6
 cd dual5       
 copy ..\state5\unod.* .
 copy ..\state5\press.* .
 copy ..\state5\unodb.* .
 copy ..\state5\unods.* .
 copy ..\state5\coor0.* .
 copy ..\state5\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state6 state7
 cd state6      
 copy ..\dual5\uhat.* .
 copy ..\state5\fnew.??? force.???
 copy ..\state5\force.??? fold.???
 copy ..\dual4\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual6 dual7
 cd dual6       
 copy ..\state6\unod.* .
 copy ..\state6\press.* .
 copy ..\state6\unodb.* .
 copy ..\state6\unods.* .
 copy ..\state6\coor0.* .
 copy ..\state6\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state7 state8
 cd state7      
 copy ..\dual6\uhat.* .
 copy ..\state6\fnew.??? force.???
 copy ..\state6\force.??? fold.???
 copy ..\dual5\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual7 dual8
 cd dual7       
 copy ..\state7\unod.* .
 copy ..\state7\press.* .
 copy ..\state7\unodb.* .
 copy ..\state7\unods.* .
 copy ..\state7\coor0.* .
 copy ..\state7\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state8 state9
 cd state8      
 copy ..\dual7\uhat.* .
 copy ..\state7\fnew.??? force.???
 copy ..\state7\force.??? fold.???
 copy ..\dual6\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual8 dual9
 cd dual8       
 copy ..\state8\unod.* .
 copy ..\state8\press.* .
 copy ..\state8\unodb.* .
 copy ..\state8\unods.* .
 copy ..\state8\coor0.* .
 copy ..\state8\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state9 state10
 cd state9      
 copy ..\dual8\uhat.* .
 copy ..\state8\fnew.??? force.???
 copy ..\state8\force.??? fold.???
 copy ..\dual7\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual9 dual10
 cd dual9       
 copy ..\state9\unod.* .
 copy ..\state9\press.* .
 copy ..\state9\unodb.* .
 copy ..\state9\unods.* .
 copy ..\state9\coor0.* .
 copy ..\state9\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state10 state11
 cd state10     
 copy ..\dual9\uhat.* .
 copy ..\state9\fnew.??? force.???
 copy ..\state9\force.??? fold.???
 copy ..\dual8\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual10 dual11
 cd dual10      
 copy ..\state10\unod.* .
 copy ..\state10\press.* .
 copy ..\state10\unodb.* .
 copy ..\state10\unods.* .
 copy ..\state10\coor0.* .
 copy ..\state10\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state11 state12
 cd state11     
 copy ..\dual10\uhat.* .
 copy ..\state10\fnew.??? force.???
 copy ..\state10\force.??? fold.???
 copy ..\dual9\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual11 dual12
 cd dual11      
 copy ..\state11\unod.* .
 copy ..\state11\press.* .
 copy ..\state11\unodb.* .
 copy ..\state11\unods.* .
 copy ..\state11\coor0.* .
 copy ..\state11\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state12 state13
 cd state12     
 copy ..\dual11\uhat.* .
 copy ..\state11\fnew.??? force.???
 copy ..\state11\force.??? fold.???
 copy ..\dual10\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual12 dual13
 cd dual12      
 copy ..\state12\unod.* .
 copy ..\state12\press.* .
 copy ..\state12\unodb.* .
 copy ..\state12\unods.* .
 copy ..\state12\coor0.* .
 copy ..\state12\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state13 state14
 cd state13     
 copy ..\dual12\uhat.* .
 copy ..\state12\fnew.??? force.???
 copy ..\state12\force.??? fold.???
 copy ..\dual11\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual13 dual14
 cd dual13      
 copy ..\state13\unod.* .
 copy ..\state13\press.* .
 copy ..\state13\unodb.* .
 copy ..\state13\unods.* .
 copy ..\state13\coor0.* .
 copy ..\state13\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state14 state15
 cd state14     
 copy ..\dual13\uhat.* .
 copy ..\state13\fnew.??? force.???
 copy ..\state13\force.??? fold.???
 copy ..\dual12\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual14 dual15
 cd dual14      
 copy ..\state14\unod.* .
 copy ..\state14\press.* .
 copy ..\state14\unodb.* .
 copy ..\state14\unods.* .
 copy ..\state14\coor0.* .
 copy ..\state14\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state15 state16
 cd state15     
 copy ..\dual14\uhat.* .
 copy ..\state14\fnew.??? force.???
 copy ..\state14\force.??? fold.???
 copy ..\dual13\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual15 dual16
 cd dual15      
 copy ..\state15\unod.* .
 copy ..\state15\press.* .
 copy ..\state15\unodb.* .
 copy ..\state15\unods.* .
 copy ..\state15\coor0.* .
 copy ..\state15\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state16 state17
 cd state16     
 copy ..\dual15\uhat.* .
 copy ..\state15\fnew.??? force.???
 copy ..\state15\force.??? fold.???
 copy ..\dual14\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual16 dual17
 cd dual16      
 copy ..\state16\unod.* .
 copy ..\state16\press.* .
 copy ..\state16\unodb.* .
 copy ..\state16\unods.* .
 copy ..\state16\coor0.* .
 copy ..\state16\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state17 state18
 cd state17     
 copy ..\dual16\uhat.* .
 copy ..\state16\fnew.??? force.???
 copy ..\state16\force.??? fold.???
 copy ..\dual15\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual17 dual18
 cd dual17      
 copy ..\state17\unod.* .
 copy ..\state17\press.* .
 copy ..\state17\unodb.* .
 copy ..\state17\unods.* .
 copy ..\state17\coor0.* .
 copy ..\state17\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state18 state19
 cd state18     
 copy ..\dual17\uhat.* .
 copy ..\state17\fnew.??? force.???
 copy ..\state17\force.??? fold.???
 copy ..\dual16\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual18 dual19
 cd dual18      
 copy ..\state18\unod.* .
 copy ..\state18\press.* .
 copy ..\state18\unodb.* .
 copy ..\state18\unods.* .
 copy ..\state18\coor0.* .
 copy ..\state18\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state19 state20
 cd state19     
 copy ..\dual18\uhat.* .
 copy ..\state18\fnew.??? force.???
 copy ..\state18\force.??? fold.???
 copy ..\dual17\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual19 dual20
 cd dual19      
 copy ..\state19\unod.* .
 copy ..\state19\press.* .
 copy ..\state19\unodb.* .
 copy ..\state19\unods.* .
 copy ..\state19\coor0.* .
 copy ..\state19\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state20 state21
 cd state20     
 copy ..\dual19\uhat.* .
 copy ..\state19\fnew.??? force.???
 copy ..\state19\force.??? fold.???
 copy ..\dual18\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual20 dual21
 cd dual20      
 copy ..\state20\unod.* .
 copy ..\state20\press.* .
 copy ..\state20\unodb.* .
 copy ..\state20\unods.* .
 copy ..\state20\coor0.* .
 copy ..\state20\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state21 state22
 cd state21     
 copy ..\dual20\uhat.* .
 copy ..\state20\fnew.??? force.???
 copy ..\state20\force.??? fold.???
 copy ..\dual19\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual21 dual22
 cd dual21      
 copy ..\state21\unod.* .
 copy ..\state21\press.* .
 copy ..\state21\unodb.* .
 copy ..\state21\unods.* .
 copy ..\state21\coor0.* .
 copy ..\state21\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state22 state23
 cd state22     
 copy ..\dual21\uhat.* .
 copy ..\state21\fnew.??? force.???
 copy ..\state21\force.??? fold.???
 copy ..\dual20\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual22 dual23
 cd dual22      
 copy ..\state22\unod.* .
 copy ..\state22\press.* .
 copy ..\state22\unodb.* .
 copy ..\state22\unods.* .
 copy ..\state22\coor0.* .
 copy ..\state22\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state23 state24
 cd state23     
 copy ..\dual22\uhat.* .
 copy ..\state22\fnew.??? force.???
 copy ..\state22\force.??? fold.???
 copy ..\dual21\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual23 dual24
 cd dual23      
 copy ..\state23\unod.* .
 copy ..\state23\press.* .
 copy ..\state23\unodb.* .
 copy ..\state23\unods.* .
 copy ..\state23\coor0.* .
 copy ..\state23\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state24 state25
 cd state24     
 copy ..\dual23\uhat.* .
 copy ..\state23\fnew.??? force.???
 copy ..\state23\force.??? fold.???
 copy ..\dual22\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual24 dual25
 cd dual24      
 copy ..\state24\unod.* .
 copy ..\state24\press.* .
 copy ..\state24\unodb.* .
 copy ..\state24\unods.* .
 copy ..\state24\coor0.* .
 copy ..\state24\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state25 state26
 cd state25     
 copy ..\dual24\uhat.* .
 copy ..\state24\fnew.??? force.???
 copy ..\state24\force.??? fold.???
 copy ..\dual23\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual25 dual26
 cd dual25      
 copy ..\state25\unod.* .
 copy ..\state25\press.* .
 copy ..\state25\unodb.* .
 copy ..\state25\unods.* .
 copy ..\state25\coor0.* .
 copy ..\state25\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state26 state27
 cd state26     
 copy ..\dual25\uhat.* .
 copy ..\state25\fnew.??? force.???
 copy ..\state25\force.??? fold.???
 copy ..\dual24\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual26 dual27
 cd dual26      
 copy ..\state26\unod.* .
 copy ..\state26\press.* .
 copy ..\state26\unodb.* .
 copy ..\state26\unods.* .
 copy ..\state26\coor0.* .
 copy ..\state26\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state27 state28
 cd state27     
 copy ..\dual26\uhat.* .
 copy ..\state26\fnew.??? force.???
 copy ..\state26\force.??? fold.???
 copy ..\dual25\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual27 dual28
 cd dual27      
 copy ..\state27\unod.* .
 copy ..\state27\press.* .
 copy ..\state27\unodb.* .
 copy ..\state27\unods.* .
 copy ..\state27\coor0.* .
 copy ..\state27\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state28 state29
 cd state28     
 copy ..\dual27\uhat.* .
 copy ..\state27\fnew.??? force.???
 copy ..\state27\force.??? fold.???
 copy ..\dual26\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual28 dual29
 cd dual28      
 copy ..\state28\unod.* .
 copy ..\state28\press.* .
 copy ..\state28\unodb.* .
 copy ..\state28\unods.* .
 copy ..\state28\coor0.* .
 copy ..\state28\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state29 state30
 cd state29     
 copy ..\dual28\uhat.* .
 copy ..\state28\fnew.??? force.???
 copy ..\state28\force.??? fold.???
 copy ..\dual27\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual29 dual30
 cd dual29      
 copy ..\state29\unod.* .
 copy ..\state29\press.* .
 copy ..\state29\unodb.* .
 copy ..\state29\unods.* .
 copy ..\state29\coor0.* .
 copy ..\state29\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state30 state31
 cd state30     
 copy ..\dual29\uhat.* .
 copy ..\state29\fnew.??? force.???
 copy ..\state29\force.??? fold.???
 copy ..\dual28\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual30 dual31
 cd dual30      
 copy ..\state30\unod.* .
 copy ..\state30\press.* .
 copy ..\state30\unodb.* .
 copy ..\state30\unods.* .
 copy ..\state30\coor0.* .
 copy ..\state30\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state31 state32
 cd state31     
 copy ..\dual30\uhat.* .
 copy ..\state30\fnew.??? force.???
 copy ..\state30\force.??? fold.???
 copy ..\dual29\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual31 dual32
 cd dual31      
 copy ..\state31\unod.* .
 copy ..\state31\press.* .
 copy ..\state31\unodb.* .
 copy ..\state31\unods.* .
 copy ..\state31\coor0.* .
 copy ..\state31\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state32 state33
 cd state32     
 copy ..\dual31\uhat.* .
 copy ..\state31\fnew.??? force.???
 copy ..\state31\force.??? fold.???
 copy ..\dual30\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual32 dual33
 cd dual32      
 copy ..\state32\unod.* .
 copy ..\state32\press.* .
 copy ..\state32\unodb.* .
 copy ..\state32\unods.* .
 copy ..\state32\coor0.* .
 copy ..\state32\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state33 state34
 cd state33     
 copy ..\dual32\uhat.* .
 copy ..\state32\fnew.??? force.???
 copy ..\state32\force.??? fold.???
 copy ..\dual31\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual33 dual34
 cd dual33      
 copy ..\state33\unod.* .
 copy ..\state33\press.* .
 copy ..\state33\unodb.* .
 copy ..\state33\unods.* .
 copy ..\state33\coor0.* .
 copy ..\state33\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state34 state35
 cd state34     
 copy ..\dual33\uhat.* .
 copy ..\state33\fnew.??? force.???
 copy ..\state33\force.??? fold.???
 copy ..\dual32\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual34 dual35
 cd dual34      
 copy ..\state34\unod.* .
 copy ..\state34\press.* .
 copy ..\state34\unodb.* .
 copy ..\state34\unods.* .
 copy ..\state34\coor0.* .
 copy ..\state34\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state35 state36
 cd state35     
 copy ..\dual34\uhat.* .
 copy ..\state34\fnew.??? force.???
 copy ..\state34\force.??? fold.???
 copy ..\dual33\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual35 dual36
 cd dual35      
 copy ..\state35\unod.* .
 copy ..\state35\press.* .
 copy ..\state35\unodb.* .
 copy ..\state35\unods.* .
 copy ..\state35\coor0.* .
 copy ..\state35\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state36 state37
 cd state36     
 copy ..\dual35\uhat.* .
 copy ..\state35\fnew.??? force.???
 copy ..\state35\force.??? fold.???
 copy ..\dual34\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual36 dual37
 cd dual36      
 copy ..\state36\unod.* .
 copy ..\state36\press.* .
 copy ..\state36\unodb.* .
 copy ..\state36\unods.* .
 copy ..\state36\coor0.* .
 copy ..\state36\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state37 state38
 cd state37     
 copy ..\dual36\uhat.* .
 copy ..\state36\fnew.??? force.???
 copy ..\state36\force.??? fold.???
 copy ..\dual35\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual37 dual38
 cd dual37      
 copy ..\state37\unod.* .
 copy ..\state37\press.* .
 copy ..\state37\unodb.* .
 copy ..\state37\unods.* .
 copy ..\state37\coor0.* .
 copy ..\state37\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state38 state39
 cd state38     
 copy ..\dual37\uhat.* .
 copy ..\state37\fnew.??? force.???
 copy ..\state37\force.??? fold.???
 copy ..\dual36\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual38 dual39
 cd dual38      
 copy ..\state38\unod.* .
 copy ..\state38\press.* .
 copy ..\state38\unodb.* .
 copy ..\state38\unods.* .
 copy ..\state38\coor0.* .
 copy ..\state38\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state39 state40
 cd state39     
 copy ..\dual38\uhat.* .
 copy ..\state38\fnew.??? force.???
 copy ..\state38\force.??? fold.???
 copy ..\dual37\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual39 dual40
 cd dual39      
 copy ..\state39\unod.* .
 copy ..\state39\press.* .
 copy ..\state39\unodb.* .
 copy ..\state39\unods.* .
 copy ..\state39\coor0.* .
 copy ..\state39\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state40 state41
 cd state40     
 copy ..\dual39\uhat.* .
 copy ..\state39\fnew.??? force.???
 copy ..\state39\force.??? fold.???
 copy ..\dual38\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual40 dual41
 cd dual40      
 copy ..\state40\unod.* .
 copy ..\state40\press.* .
 copy ..\state40\unodb.* .
 copy ..\state40\unods.* .
 copy ..\state40\coor0.* .
 copy ..\state40\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state41 state42
 cd state41     
 copy ..\dual40\uhat.* .
 copy ..\state40\fnew.??? force.???
 copy ..\state40\force.??? fold.???
 copy ..\dual39\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual41 dual42
 cd dual41      
 copy ..\state41\unod.* .
 copy ..\state41\press.* .
 copy ..\state41\unodb.* .
 copy ..\state41\unods.* .
 copy ..\state41\coor0.* .
 copy ..\state41\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state42 state43
 cd state42     
 copy ..\dual41\uhat.* .
 copy ..\state41\fnew.??? force.???
 copy ..\state41\force.??? fold.???
 copy ..\dual40\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual42 dual43
 cd dual42      
 copy ..\state42\unod.* .
 copy ..\state42\press.* .
 copy ..\state42\unodb.* .
 copy ..\state42\unods.* .
 copy ..\state42\coor0.* .
 copy ..\state42\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state43 state44
 cd state43     
 copy ..\dual42\uhat.* .
 copy ..\state42\fnew.??? force.???
 copy ..\state42\force.??? fold.???
 copy ..\dual41\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual43 dual44
 cd dual43      
 copy ..\state43\unod.* .
 copy ..\state43\press.* .
 copy ..\state43\unodb.* .
 copy ..\state43\unods.* .
 copy ..\state43\coor0.* .
 copy ..\state43\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state44 state45
 cd state44     
 copy ..\dual43\uhat.* .
 copy ..\state43\fnew.??? force.???
 copy ..\state43\force.??? fold.???
 copy ..\dual42\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual44 dual45
 cd dual44      
 copy ..\state44\unod.* .
 copy ..\state44\press.* .
 copy ..\state44\unodb.* .
 copy ..\state44\unods.* .
 copy ..\state44\coor0.* .
 copy ..\state44\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state45 state46
 cd state45     
 copy ..\dual44\uhat.* .
 copy ..\state44\fnew.??? force.???
 copy ..\state44\force.??? fold.???
 copy ..\dual43\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual45 dual46
 cd dual45      
 copy ..\state45\unod.* .
 copy ..\state45\press.* .
 copy ..\state45\unodb.* .
 copy ..\state45\unods.* .
 copy ..\state45\coor0.* .
 copy ..\state45\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state46 state47
 cd state46     
 copy ..\dual45\uhat.* .
 copy ..\state45\fnew.??? force.???
 copy ..\state45\force.??? fold.???
 copy ..\dual44\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual46 dual47
 cd dual46      
 copy ..\state46\unod.* .
 copy ..\state46\press.* .
 copy ..\state46\unodb.* .
 copy ..\state46\unods.* .
 copy ..\state46\coor0.* .
 copy ..\state46\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state47 state48
 cd state47     
 copy ..\dual46\uhat.* .
 copy ..\state46\fnew.??? force.???
 copy ..\state46\force.??? fold.???
 copy ..\dual45\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual47 dual48
 cd dual47      
 copy ..\state47\unod.* .
 copy ..\state47\press.* .
 copy ..\state47\unodb.* .
 copy ..\state47\unods.* .
 copy ..\state47\coor0.* .
 copy ..\state47\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state48 state49
 cd state48     
 copy ..\dual47\uhat.* .
 copy ..\state47\fnew.??? force.???
 copy ..\state47\force.??? fold.???
 copy ..\dual46\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual48 dual49
 cd dual48      
 copy ..\state48\unod.* .
 copy ..\state48\press.* .
 copy ..\state48\unodb.* .
 copy ..\state48\unods.* .
 copy ..\state48\coor0.* .
 copy ..\state48\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state49 state50
 cd state49     
 copy ..\dual48\uhat.* .
 copy ..\state48\fnew.??? force.???
 copy ..\state48\force.??? fold.???
 copy ..\dual47\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual49 dual50
 cd dual49      
 copy ..\state49\unod.* .
 copy ..\state49\press.* .
 copy ..\state49\unodb.* .
 copy ..\state49\unods.* .
 copy ..\state49\coor0.* .
 copy ..\state49\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state50 state51
 cd state50     
 copy ..\dual49\uhat.* .
 copy ..\state49\fnew.??? force.???
 copy ..\state49\force.??? fold.???
 copy ..\dual48\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual50 dual51
 cd dual50      
 copy ..\state50\unod.* .
 copy ..\state50\press.* .
 copy ..\state50\unodb.* .
 copy ..\state50\unods.* .
 copy ..\state50\coor0.* .
 copy ..\state50\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state51 state52
 cd state51     
 copy ..\dual50\uhat.* .
 copy ..\state50\fnew.??? force.???
 copy ..\state50\force.??? fold.???
 copy ..\dual49\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual51 dual52
 cd dual51      
 copy ..\state51\unod.* .
 copy ..\state51\press.* .
 copy ..\state51\unodb.* .
 copy ..\state51\unods.* .
 copy ..\state51\coor0.* .
 copy ..\state51\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state52 state53
 cd state52     
 copy ..\dual51\uhat.* .
 copy ..\state51\fnew.??? force.???
 copy ..\state51\force.??? fold.???
 copy ..\dual50\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual52 dual53
 cd dual52      
 copy ..\state52\unod.* .
 copy ..\state52\press.* .
 copy ..\state52\unodb.* .
 copy ..\state52\unods.* .
 copy ..\state52\coor0.* .
 copy ..\state52\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state53 state54
 cd state53     
 copy ..\dual52\uhat.* .
 copy ..\state52\fnew.??? force.???
 copy ..\state52\force.??? fold.???
 copy ..\dual51\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual53 dual54
 cd dual53      
 copy ..\state53\unod.* .
 copy ..\state53\press.* .
 copy ..\state53\unodb.* .
 copy ..\state53\unods.* .
 copy ..\state53\coor0.* .
 copy ..\state53\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state54 state55
 cd state54     
 copy ..\dual53\uhat.* .
 copy ..\state53\fnew.??? force.???
 copy ..\state53\force.??? fold.???
 copy ..\dual52\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual54 dual55
 cd dual54      
 copy ..\state54\unod.* .
 copy ..\state54\press.* .
 copy ..\state54\unodb.* .
 copy ..\state54\unods.* .
 copy ..\state54\coor0.* .
 copy ..\state54\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state55 state56
 cd state55     
 copy ..\dual54\uhat.* .
 copy ..\state54\fnew.??? force.???
 copy ..\state54\force.??? fold.???
 copy ..\dual53\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual55 dual56
 cd dual55      
 copy ..\state55\unod.* .
 copy ..\state55\press.* .
 copy ..\state55\unodb.* .
 copy ..\state55\unods.* .
 copy ..\state55\coor0.* .
 copy ..\state55\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state56 state57
 cd state56     
 copy ..\dual55\uhat.* .
 copy ..\state55\fnew.??? force.???
 copy ..\state55\force.??? fold.???
 copy ..\dual54\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual56 dual57
 cd dual56      
 copy ..\state56\unod.* .
 copy ..\state56\press.* .
 copy ..\state56\unodb.* .
 copy ..\state56\unods.* .
 copy ..\state56\coor0.* .
 copy ..\state56\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state57 state58
 cd state57     
 copy ..\dual56\uhat.* .
 copy ..\state56\fnew.??? force.???
 copy ..\state56\force.??? fold.???
 copy ..\dual55\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual57 dual58
 cd dual57      
 copy ..\state57\unod.* .
 copy ..\state57\press.* .
 copy ..\state57\unodb.* .
 copy ..\state57\unods.* .
 copy ..\state57\coor0.* .
 copy ..\state57\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state58 state59
 cd state58     
 copy ..\dual57\uhat.* .
 copy ..\state57\fnew.??? force.???
 copy ..\state57\force.??? fold.???
 copy ..\dual56\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual58 dual59
 cd dual58      
 copy ..\state58\unod.* .
 copy ..\state58\press.* .
 copy ..\state58\unodb.* .
 copy ..\state58\unods.* .
 copy ..\state58\coor0.* .
 copy ..\state58\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state59 state60
 cd state59     
 copy ..\dual58\uhat.* .
 copy ..\state58\fnew.??? force.???
 copy ..\state58\force.??? fold.???
 copy ..\dual57\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual59 dual60
 cd dual59      
 copy ..\state59\unod.* .
 copy ..\state59\press.* .
 copy ..\state59\unodb.* .
 copy ..\state59\unods.* .
 copy ..\state59\coor0.* .
 copy ..\state59\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state60 state61
 cd state60     
 copy ..\dual59\uhat.* .
 copy ..\state59\fnew.??? force.???
 copy ..\state59\force.??? fold.???
 copy ..\dual58\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual60 dual61
 cd dual60      
 copy ..\state60\unod.* .
 copy ..\state60\press.* .
 copy ..\state60\unodb.* .
 copy ..\state60\unods.* .
 copy ..\state60\coor0.* .
 copy ..\state60\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state61 state62
 cd state61     
 copy ..\dual60\uhat.* .
 copy ..\state60\fnew.??? force.???
 copy ..\state60\force.??? fold.???
 copy ..\dual59\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual61 dual62
 cd dual61      
 copy ..\state61\unod.* .
 copy ..\state61\press.* .
 copy ..\state61\unodb.* .
 copy ..\state61\unods.* .
 copy ..\state61\coor0.* .
 copy ..\state61\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state62 state63
 cd state62     
 copy ..\dual61\uhat.* .
 copy ..\state61\fnew.??? force.???
 copy ..\state61\force.??? fold.???
 copy ..\dual60\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual62 dual63
 cd dual62      
 copy ..\state62\unod.* .
 copy ..\state62\press.* .
 copy ..\state62\unodb.* .
 copy ..\state62\unods.* .
 copy ..\state62\coor0.* .
 copy ..\state62\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state63 state64
 cd state63     
 copy ..\dual62\uhat.* .
 copy ..\state62\fnew.??? force.???
 copy ..\state62\force.??? fold.???
 copy ..\dual61\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual63 dual64
 cd dual63      
 copy ..\state63\unod.* .
 copy ..\state63\press.* .
 copy ..\state63\unodb.* .
 copy ..\state63\unods.* .
 copy ..\state63\coor0.* .
 copy ..\state63\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state64 state65
 cd state64     
 copy ..\dual63\uhat.* .
 copy ..\state63\fnew.??? force.???
 copy ..\state63\force.??? fold.???
 copy ..\dual62\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual64 dual65
 cd dual64      
 copy ..\state64\unod.* .
 copy ..\state64\press.* .
 copy ..\state64\unodb.* .
 copy ..\state64\unods.* .
 copy ..\state64\coor0.* .
 copy ..\state64\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state65 state66
 cd state65     
 copy ..\dual64\uhat.* .
 copy ..\state64\fnew.??? force.???
 copy ..\state64\force.??? fold.???
 copy ..\dual63\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual65 dual66
 cd dual65      
 copy ..\state65\unod.* .
 copy ..\state65\press.* .
 copy ..\state65\unodb.* .
 copy ..\state65\unods.* .
 copy ..\state65\coor0.* .
 copy ..\state65\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state66 state67
 cd state66     
 copy ..\dual65\uhat.* .
 copy ..\state65\fnew.??? force.???
 copy ..\state65\force.??? fold.???
 copy ..\dual64\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual66 dual67
 cd dual66      
 copy ..\state66\unod.* .
 copy ..\state66\press.* .
 copy ..\state66\unodb.* .
 copy ..\state66\unods.* .
 copy ..\state66\coor0.* .
 copy ..\state66\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state67 state68
 cd state67     
 copy ..\dual66\uhat.* .
 copy ..\state66\fnew.??? force.???
 copy ..\state66\force.??? fold.???
 copy ..\dual65\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual67 dual68
 cd dual67      
 copy ..\state67\unod.* .
 copy ..\state67\press.* .
 copy ..\state67\unodb.* .
 copy ..\state67\unods.* .
 copy ..\state67\coor0.* .
 copy ..\state67\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state68 state69
 cd state68     
 copy ..\dual67\uhat.* .
 copy ..\state67\fnew.??? force.???
 copy ..\state67\force.??? fold.???
 copy ..\dual66\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual68 dual69
 cd dual68      
 copy ..\state68\unod.* .
 copy ..\state68\press.* .
 copy ..\state68\unodb.* .
 copy ..\state68\unods.* .
 copy ..\state68\coor0.* .
 copy ..\state68\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state69 state70
 cd state69     
 copy ..\dual68\uhat.* .
 copy ..\state68\fnew.??? force.???
 copy ..\state68\force.??? fold.???
 copy ..\dual67\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual69 dual70
 cd dual69      
 copy ..\state69\unod.* .
 copy ..\state69\press.* .
 copy ..\state69\unodb.* .
 copy ..\state69\unods.* .
 copy ..\state69\coor0.* .
 copy ..\state69\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state70 state71
 cd state70     
 copy ..\dual69\uhat.* .
 copy ..\state69\fnew.??? force.???
 copy ..\state69\force.??? fold.???
 copy ..\dual68\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual70 dual71
 cd dual70      
 copy ..\state70\unod.* .
 copy ..\state70\press.* .
 copy ..\state70\unodb.* .
 copy ..\state70\unods.* .
 copy ..\state70\coor0.* .
 copy ..\state70\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state71 state72
 cd state71     
 copy ..\dual70\uhat.* .
 copy ..\state70\fnew.??? force.???
 copy ..\state70\force.??? fold.???
 copy ..\dual69\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual71 dual72
 cd dual71      
 copy ..\state71\unod.* .
 copy ..\state71\press.* .
 copy ..\state71\unodb.* .
 copy ..\state71\unods.* .
 copy ..\state71\coor0.* .
 copy ..\state71\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state72 state73
 cd state72     
 copy ..\dual71\uhat.* .
 copy ..\state71\fnew.??? force.???
 copy ..\state71\force.??? fold.???
 copy ..\dual70\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual72 dual73
 cd dual72      
 copy ..\state72\unod.* .
 copy ..\state72\press.* .
 copy ..\state72\unodb.* .
 copy ..\state72\unods.* .
 copy ..\state72\coor0.* .
 copy ..\state72\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state73 state74
 cd state73     
 copy ..\dual72\uhat.* .
 copy ..\state72\fnew.??? force.???
 copy ..\state72\force.??? fold.???
 copy ..\dual71\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual73 dual74
 cd dual73      
 copy ..\state73\unod.* .
 copy ..\state73\press.* .
 copy ..\state73\unodb.* .
 copy ..\state73\unods.* .
 copy ..\state73\coor0.* .
 copy ..\state73\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state74 state75
 cd state74     
 copy ..\dual73\uhat.* .
 copy ..\state73\fnew.??? force.???
 copy ..\state73\force.??? fold.???
 copy ..\dual72\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual74 dual75
 cd dual74      
 copy ..\state74\unod.* .
 copy ..\state74\press.* .
 copy ..\state74\unodb.* .
 copy ..\state74\unods.* .
 copy ..\state74\coor0.* .
 copy ..\state74\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state75 state76
 cd state75     
 copy ..\dual74\uhat.* .
 copy ..\state74\fnew.??? force.???
 copy ..\state74\force.??? fold.???
 copy ..\dual73\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual75 dual76
 cd dual75      
 copy ..\state75\unod.* .
 copy ..\state75\press.* .
 copy ..\state75\unodb.* .
 copy ..\state75\unods.* .
 copy ..\state75\coor0.* .
 copy ..\state75\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state76 state77
 cd state76     
 copy ..\dual75\uhat.* .
 copy ..\state75\fnew.??? force.???
 copy ..\state75\force.??? fold.???
 copy ..\dual74\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual76 dual77
 cd dual76      
 copy ..\state76\unod.* .
 copy ..\state76\press.* .
 copy ..\state76\unodb.* .
 copy ..\state76\unods.* .
 copy ..\state76\coor0.* .
 copy ..\state76\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state77 state78
 cd state77     
 copy ..\dual76\uhat.* .
 copy ..\state76\fnew.??? force.???
 copy ..\state76\force.??? fold.???
 copy ..\dual75\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual77 dual78
 cd dual77      
 copy ..\state77\unod.* .
 copy ..\state77\press.* .
 copy ..\state77\unodb.* .
 copy ..\state77\unods.* .
 copy ..\state77\coor0.* .
 copy ..\state77\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state78 state79
 cd state78     
 copy ..\dual77\uhat.* .
 copy ..\state77\fnew.??? force.???
 copy ..\state77\force.??? fold.???
 copy ..\dual76\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual78 dual79
 cd dual78      
 copy ..\state78\unod.* .
 copy ..\state78\press.* .
 copy ..\state78\unodb.* .
 copy ..\state78\unods.* .
 copy ..\state78\coor0.* .
 copy ..\state78\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state79 state80
 cd state79     
 copy ..\dual78\uhat.* .
 copy ..\state78\fnew.??? force.???
 copy ..\state78\force.??? fold.???
 copy ..\dual77\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual79 dual80
 cd dual79      
 copy ..\state79\unod.* .
 copy ..\state79\press.* .
 copy ..\state79\unodb.* .
 copy ..\state79\unods.* .
 copy ..\state79\coor0.* .
 copy ..\state79\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state80 state81
 cd state80     
 copy ..\dual79\uhat.* .
 copy ..\state79\fnew.??? force.???
 copy ..\state79\force.??? fold.???
 copy ..\dual78\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual80 dual81
 cd dual80      
 copy ..\state80\unod.* .
 copy ..\state80\press.* .
 copy ..\state80\unodb.* .
 copy ..\state80\unods.* .
 copy ..\state80\coor0.* .
 copy ..\state80\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state81 state82
 cd state81     
 copy ..\dual80\uhat.* .
 copy ..\state80\fnew.??? force.???
 copy ..\state80\force.??? fold.???
 copy ..\dual79\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual81 dual82
 cd dual81      
 copy ..\state81\unod.* .
 copy ..\state81\press.* .
 copy ..\state81\unodb.* .
 copy ..\state81\unods.* .
 copy ..\state81\coor0.* .
 copy ..\state81\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state82 state83
 cd state82     
 copy ..\dual81\uhat.* .
 copy ..\state81\fnew.??? force.???
 copy ..\state81\force.??? fold.???
 copy ..\dual80\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual82 dual83
 cd dual82      
 copy ..\state82\unod.* .
 copy ..\state82\press.* .
 copy ..\state82\unodb.* .
 copy ..\state82\unods.* .
 copy ..\state82\coor0.* .
 copy ..\state82\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state83 state84
 cd state83     
 copy ..\dual82\uhat.* .
 copy ..\state82\fnew.??? force.???
 copy ..\state82\force.??? fold.???
 copy ..\dual81\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual83 dual84
 cd dual83      
 copy ..\state83\unod.* .
 copy ..\state83\press.* .
 copy ..\state83\unodb.* .
 copy ..\state83\unods.* .
 copy ..\state83\coor0.* .
 copy ..\state83\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state84 state85
 cd state84     
 copy ..\dual83\uhat.* .
 copy ..\state83\fnew.??? force.???
 copy ..\state83\force.??? fold.???
 copy ..\dual82\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual84 dual85
 cd dual84      
 copy ..\state84\unod.* .
 copy ..\state84\press.* .
 copy ..\state84\unodb.* .
 copy ..\state84\unods.* .
 copy ..\state84\coor0.* .
 copy ..\state84\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state85 state86
 cd state85     
 copy ..\dual84\uhat.* .
 copy ..\state84\fnew.??? force.???
 copy ..\state84\force.??? fold.???
 copy ..\dual83\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual85 dual86
 cd dual85      
 copy ..\state85\unod.* .
 copy ..\state85\press.* .
 copy ..\state85\unodb.* .
 copy ..\state85\unods.* .
 copy ..\state85\coor0.* .
 copy ..\state85\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state86 state87
 cd state86     
 copy ..\dual85\uhat.* .
 copy ..\state85\fnew.??? force.???
 copy ..\state85\force.??? fold.???
 copy ..\dual84\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual86 dual87
 cd dual86      
 copy ..\state86\unod.* .
 copy ..\state86\press.* .
 copy ..\state86\unodb.* .
 copy ..\state86\unods.* .
 copy ..\state86\coor0.* .
 copy ..\state86\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state87 state88
 cd state87     
 copy ..\dual86\uhat.* .
 copy ..\state86\fnew.??? force.???
 copy ..\state86\force.??? fold.???
 copy ..\dual85\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual87 dual88
 cd dual87      
 copy ..\state87\unod.* .
 copy ..\state87\press.* .
 copy ..\state87\unodb.* .
 copy ..\state87\unods.* .
 copy ..\state87\coor0.* .
 copy ..\state87\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state88 state89
 cd state88     
 copy ..\dual87\uhat.* .
 copy ..\state87\fnew.??? force.???
 copy ..\state87\force.??? fold.???
 copy ..\dual86\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual88 dual89
 cd dual88      
 copy ..\state88\unod.* .
 copy ..\state88\press.* .
 copy ..\state88\unodb.* .
 copy ..\state88\unods.* .
 copy ..\state88\coor0.* .
 copy ..\state88\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state89 state90
 cd state89     
 copy ..\dual88\uhat.* .
 copy ..\state88\fnew.??? force.???
 copy ..\state88\force.??? fold.???
 copy ..\dual87\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual89 dual90
 cd dual89      
 copy ..\state89\unod.* .
 copy ..\state89\press.* .
 copy ..\state89\unodb.* .
 copy ..\state89\unods.* .
 copy ..\state89\coor0.* .
 copy ..\state89\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state90 state91
 cd state90     
 copy ..\dual89\uhat.* .
 copy ..\state89\fnew.??? force.???
 copy ..\state89\force.??? fold.???
 copy ..\dual88\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual90 dual91
 cd dual90      
 copy ..\state90\unod.* .
 copy ..\state90\press.* .
 copy ..\state90\unodb.* .
 copy ..\state90\unods.* .
 copy ..\state90\coor0.* .
 copy ..\state90\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state91 state92
 cd state91     
 copy ..\dual90\uhat.* .
 copy ..\state90\fnew.??? force.???
 copy ..\state90\force.??? fold.???
 copy ..\dual89\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual91 dual92
 cd dual91      
 copy ..\state91\unod.* .
 copy ..\state91\press.* .
 copy ..\state91\unodb.* .
 copy ..\state91\unods.* .
 copy ..\state91\coor0.* .
 copy ..\state91\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state92 state93
 cd state92     
 copy ..\dual91\uhat.* .
 copy ..\state91\fnew.??? force.???
 copy ..\state91\force.??? fold.???
 copy ..\dual90\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual92 dual93
 cd dual92      
 copy ..\state92\unod.* .
 copy ..\state92\press.* .
 copy ..\state92\unodb.* .
 copy ..\state92\unods.* .
 copy ..\state92\coor0.* .
 copy ..\state92\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state93 state94
 cd state93     
 copy ..\dual92\uhat.* .
 copy ..\state92\fnew.??? force.???
 copy ..\state92\force.??? fold.???
 copy ..\dual91\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual93 dual94
 cd dual93      
 copy ..\state93\unod.* .
 copy ..\state93\press.* .
 copy ..\state93\unodb.* .
 copy ..\state93\unods.* .
 copy ..\state93\coor0.* .
 copy ..\state93\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state94 state95
 cd state94     
 copy ..\dual93\uhat.* .
 copy ..\state93\fnew.??? force.???
 copy ..\state93\force.??? fold.???
 copy ..\dual92\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual94 dual95
 cd dual94      
 copy ..\state94\unod.* .
 copy ..\state94\press.* .
 copy ..\state94\unodb.* .
 copy ..\state94\unods.* .
 copy ..\state94\coor0.* .
 copy ..\state94\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state95 state96
 cd state95     
 copy ..\dual94\uhat.* .
 copy ..\state94\fnew.??? force.???
 copy ..\state94\force.??? fold.???
 copy ..\dual93\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual95 dual96
 cd dual95      
 copy ..\state95\unod.* .
 copy ..\state95\press.* .
 copy ..\state95\unodb.* .
 copy ..\state95\unods.* .
 copy ..\state95\coor0.* .
 copy ..\state95\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state96 state97
 cd state96     
 copy ..\dual95\uhat.* .
 copy ..\state95\fnew.??? force.???
 copy ..\state95\force.??? fold.???
 copy ..\dual94\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual96 dual97
 cd dual96      
 copy ..\state96\unod.* .
 copy ..\state96\press.* .
 copy ..\state96\unodb.* .
 copy ..\state96\unods.* .
 copy ..\state96\coor0.* .
 copy ..\state96\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state97 state98
 cd state97     
 copy ..\dual96\uhat.* .
 copy ..\state96\fnew.??? force.???
 copy ..\state96\force.??? fold.???
 copy ..\dual95\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual97 dual98
 cd dual97      
 copy ..\state97\unod.* .
 copy ..\state97\press.* .
 copy ..\state97\unodb.* .
 copy ..\state97\unods.* .
 copy ..\state97\coor0.* .
 copy ..\state97\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state98 state99
 cd state98     
 copy ..\dual97\uhat.* .
 copy ..\state97\fnew.??? force.???
 copy ..\state97\force.??? fold.???
 copy ..\dual96\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual98 dual99
 cd dual98      
 copy ..\state98\unod.* .
 copy ..\state98\press.* .
 copy ..\state98\unodb.* .
 copy ..\state98\unods.* .
 copy ..\state98\coor0.* .
 copy ..\state98\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state99 state100
 cd state99     
 copy ..\dual98\uhat.* .
 copy ..\state98\fnew.??? force.???
 copy ..\state98\force.??? fold.???
 copy ..\dual97\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual99 dual100
 cd dual99      
 copy ..\state99\unod.* .
 copy ..\state99\press.* .
 copy ..\state99\unodb.* .
 copy ..\state99\unods.* .
 copy ..\state99\coor0.* .
 copy ..\state99\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state100 state101
 cd state100    
 copy ..\dual99\uhat.* .
 copy ..\state99\fnew.??? force.???
 copy ..\state99\force.??? fold.???
 copy ..\dual98\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual100 dual101
 cd dual100     
 copy ..\state100\unod.* .
 copy ..\state100\press.* .
 copy ..\state100\unodb.* .
 copy ..\state100\unods.* .
 copy ..\state100\coor0.* .
 copy ..\state100\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
