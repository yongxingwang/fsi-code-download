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
 
 Xcopy /E /I state101 state102
 cd state101    
 copy ..\dual100\uhat.* .
 copy ..\state100\fnew.??? force.???
 copy ..\state100\force.??? fold.???
 copy ..\dual99\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual101 dual102
 cd dual101     
 copy ..\state101\unod.* .
 copy ..\state101\press.* .
 copy ..\state101\unodb.* .
 copy ..\state101\unods.* .
 copy ..\state101\coor0.* .
 copy ..\state101\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state102 state103
 cd state102    
 copy ..\dual101\uhat.* .
 copy ..\state101\fnew.??? force.???
 copy ..\state101\force.??? fold.???
 copy ..\dual100\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual102 dual103
 cd dual102     
 copy ..\state102\unod.* .
 copy ..\state102\press.* .
 copy ..\state102\unodb.* .
 copy ..\state102\unods.* .
 copy ..\state102\coor0.* .
 copy ..\state102\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state103 state104
 cd state103    
 copy ..\dual102\uhat.* .
 copy ..\state102\fnew.??? force.???
 copy ..\state102\force.??? fold.???
 copy ..\dual101\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual103 dual104
 cd dual103     
 copy ..\state103\unod.* .
 copy ..\state103\press.* .
 copy ..\state103\unodb.* .
 copy ..\state103\unods.* .
 copy ..\state103\coor0.* .
 copy ..\state103\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state104 state105
 cd state104    
 copy ..\dual103\uhat.* .
 copy ..\state103\fnew.??? force.???
 copy ..\state103\force.??? fold.???
 copy ..\dual102\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual104 dual105
 cd dual104     
 copy ..\state104\unod.* .
 copy ..\state104\press.* .
 copy ..\state104\unodb.* .
 copy ..\state104\unods.* .
 copy ..\state104\coor0.* .
 copy ..\state104\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state105 state106
 cd state105    
 copy ..\dual104\uhat.* .
 copy ..\state104\fnew.??? force.???
 copy ..\state104\force.??? fold.???
 copy ..\dual103\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual105 dual106
 cd dual105     
 copy ..\state105\unod.* .
 copy ..\state105\press.* .
 copy ..\state105\unodb.* .
 copy ..\state105\unods.* .
 copy ..\state105\coor0.* .
 copy ..\state105\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state106 state107
 cd state106    
 copy ..\dual105\uhat.* .
 copy ..\state105\fnew.??? force.???
 copy ..\state105\force.??? fold.???
 copy ..\dual104\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual106 dual107
 cd dual106     
 copy ..\state106\unod.* .
 copy ..\state106\press.* .
 copy ..\state106\unodb.* .
 copy ..\state106\unods.* .
 copy ..\state106\coor0.* .
 copy ..\state106\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state107 state108
 cd state107    
 copy ..\dual106\uhat.* .
 copy ..\state106\fnew.??? force.???
 copy ..\state106\force.??? fold.???
 copy ..\dual105\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual107 dual108
 cd dual107     
 copy ..\state107\unod.* .
 copy ..\state107\press.* .
 copy ..\state107\unodb.* .
 copy ..\state107\unods.* .
 copy ..\state107\coor0.* .
 copy ..\state107\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state108 state109
 cd state108    
 copy ..\dual107\uhat.* .
 copy ..\state107\fnew.??? force.???
 copy ..\state107\force.??? fold.???
 copy ..\dual106\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual108 dual109
 cd dual108     
 copy ..\state108\unod.* .
 copy ..\state108\press.* .
 copy ..\state108\unodb.* .
 copy ..\state108\unods.* .
 copy ..\state108\coor0.* .
 copy ..\state108\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state109 state110
 cd state109    
 copy ..\dual108\uhat.* .
 copy ..\state108\fnew.??? force.???
 copy ..\state108\force.??? fold.???
 copy ..\dual107\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual109 dual110
 cd dual109     
 copy ..\state109\unod.* .
 copy ..\state109\press.* .
 copy ..\state109\unodb.* .
 copy ..\state109\unods.* .
 copy ..\state109\coor0.* .
 copy ..\state109\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state110 state111
 cd state110    
 copy ..\dual109\uhat.* .
 copy ..\state109\fnew.??? force.???
 copy ..\state109\force.??? fold.???
 copy ..\dual108\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual110 dual111
 cd dual110     
 copy ..\state110\unod.* .
 copy ..\state110\press.* .
 copy ..\state110\unodb.* .
 copy ..\state110\unods.* .
 copy ..\state110\coor0.* .
 copy ..\state110\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state111 state112
 cd state111    
 copy ..\dual110\uhat.* .
 copy ..\state110\fnew.??? force.???
 copy ..\state110\force.??? fold.???
 copy ..\dual109\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual111 dual112
 cd dual111     
 copy ..\state111\unod.* .
 copy ..\state111\press.* .
 copy ..\state111\unodb.* .
 copy ..\state111\unods.* .
 copy ..\state111\coor0.* .
 copy ..\state111\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state112 state113
 cd state112    
 copy ..\dual111\uhat.* .
 copy ..\state111\fnew.??? force.???
 copy ..\state111\force.??? fold.???
 copy ..\dual110\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual112 dual113
 cd dual112     
 copy ..\state112\unod.* .
 copy ..\state112\press.* .
 copy ..\state112\unodb.* .
 copy ..\state112\unods.* .
 copy ..\state112\coor0.* .
 copy ..\state112\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state113 state114
 cd state113    
 copy ..\dual112\uhat.* .
 copy ..\state112\fnew.??? force.???
 copy ..\state112\force.??? fold.???
 copy ..\dual111\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual113 dual114
 cd dual113     
 copy ..\state113\unod.* .
 copy ..\state113\press.* .
 copy ..\state113\unodb.* .
 copy ..\state113\unods.* .
 copy ..\state113\coor0.* .
 copy ..\state113\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state114 state115
 cd state114    
 copy ..\dual113\uhat.* .
 copy ..\state113\fnew.??? force.???
 copy ..\state113\force.??? fold.???
 copy ..\dual112\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual114 dual115
 cd dual114     
 copy ..\state114\unod.* .
 copy ..\state114\press.* .
 copy ..\state114\unodb.* .
 copy ..\state114\unods.* .
 copy ..\state114\coor0.* .
 copy ..\state114\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state115 state116
 cd state115    
 copy ..\dual114\uhat.* .
 copy ..\state114\fnew.??? force.???
 copy ..\state114\force.??? fold.???
 copy ..\dual113\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual115 dual116
 cd dual115     
 copy ..\state115\unod.* .
 copy ..\state115\press.* .
 copy ..\state115\unodb.* .
 copy ..\state115\unods.* .
 copy ..\state115\coor0.* .
 copy ..\state115\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state116 state117
 cd state116    
 copy ..\dual115\uhat.* .
 copy ..\state115\fnew.??? force.???
 copy ..\state115\force.??? fold.???
 copy ..\dual114\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual116 dual117
 cd dual116     
 copy ..\state116\unod.* .
 copy ..\state116\press.* .
 copy ..\state116\unodb.* .
 copy ..\state116\unods.* .
 copy ..\state116\coor0.* .
 copy ..\state116\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state117 state118
 cd state117    
 copy ..\dual116\uhat.* .
 copy ..\state116\fnew.??? force.???
 copy ..\state116\force.??? fold.???
 copy ..\dual115\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual117 dual118
 cd dual117     
 copy ..\state117\unod.* .
 copy ..\state117\press.* .
 copy ..\state117\unodb.* .
 copy ..\state117\unods.* .
 copy ..\state117\coor0.* .
 copy ..\state117\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state118 state119
 cd state118    
 copy ..\dual117\uhat.* .
 copy ..\state117\fnew.??? force.???
 copy ..\state117\force.??? fold.???
 copy ..\dual116\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual118 dual119
 cd dual118     
 copy ..\state118\unod.* .
 copy ..\state118\press.* .
 copy ..\state118\unodb.* .
 copy ..\state118\unods.* .
 copy ..\state118\coor0.* .
 copy ..\state118\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state119 state120
 cd state119    
 copy ..\dual118\uhat.* .
 copy ..\state118\fnew.??? force.???
 copy ..\state118\force.??? fold.???
 copy ..\dual117\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual119 dual120
 cd dual119     
 copy ..\state119\unod.* .
 copy ..\state119\press.* .
 copy ..\state119\unodb.* .
 copy ..\state119\unods.* .
 copy ..\state119\coor0.* .
 copy ..\state119\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state120 state121
 cd state120    
 copy ..\dual119\uhat.* .
 copy ..\state119\fnew.??? force.???
 copy ..\state119\force.??? fold.???
 copy ..\dual118\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual120 dual121
 cd dual120     
 copy ..\state120\unod.* .
 copy ..\state120\press.* .
 copy ..\state120\unodb.* .
 copy ..\state120\unods.* .
 copy ..\state120\coor0.* .
 copy ..\state120\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state121 state122
 cd state121    
 copy ..\dual120\uhat.* .
 copy ..\state120\fnew.??? force.???
 copy ..\state120\force.??? fold.???
 copy ..\dual119\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual121 dual122
 cd dual121     
 copy ..\state121\unod.* .
 copy ..\state121\press.* .
 copy ..\state121\unodb.* .
 copy ..\state121\unods.* .
 copy ..\state121\coor0.* .
 copy ..\state121\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state122 state123
 cd state122    
 copy ..\dual121\uhat.* .
 copy ..\state121\fnew.??? force.???
 copy ..\state121\force.??? fold.???
 copy ..\dual120\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual122 dual123
 cd dual122     
 copy ..\state122\unod.* .
 copy ..\state122\press.* .
 copy ..\state122\unodb.* .
 copy ..\state122\unods.* .
 copy ..\state122\coor0.* .
 copy ..\state122\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state123 state124
 cd state123    
 copy ..\dual122\uhat.* .
 copy ..\state122\fnew.??? force.???
 copy ..\state122\force.??? fold.???
 copy ..\dual121\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual123 dual124
 cd dual123     
 copy ..\state123\unod.* .
 copy ..\state123\press.* .
 copy ..\state123\unodb.* .
 copy ..\state123\unods.* .
 copy ..\state123\coor0.* .
 copy ..\state123\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state124 state125
 cd state124    
 copy ..\dual123\uhat.* .
 copy ..\state123\fnew.??? force.???
 copy ..\state123\force.??? fold.???
 copy ..\dual122\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual124 dual125
 cd dual124     
 copy ..\state124\unod.* .
 copy ..\state124\press.* .
 copy ..\state124\unodb.* .
 copy ..\state124\unods.* .
 copy ..\state124\coor0.* .
 copy ..\state124\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state125 state126
 cd state125    
 copy ..\dual124\uhat.* .
 copy ..\state124\fnew.??? force.???
 copy ..\state124\force.??? fold.???
 copy ..\dual123\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual125 dual126
 cd dual125     
 copy ..\state125\unod.* .
 copy ..\state125\press.* .
 copy ..\state125\unodb.* .
 copy ..\state125\unods.* .
 copy ..\state125\coor0.* .
 copy ..\state125\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state126 state127
 cd state126    
 copy ..\dual125\uhat.* .
 copy ..\state125\fnew.??? force.???
 copy ..\state125\force.??? fold.???
 copy ..\dual124\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual126 dual127
 cd dual126     
 copy ..\state126\unod.* .
 copy ..\state126\press.* .
 copy ..\state126\unodb.* .
 copy ..\state126\unods.* .
 copy ..\state126\coor0.* .
 copy ..\state126\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state127 state128
 cd state127    
 copy ..\dual126\uhat.* .
 copy ..\state126\fnew.??? force.???
 copy ..\state126\force.??? fold.???
 copy ..\dual125\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual127 dual128
 cd dual127     
 copy ..\state127\unod.* .
 copy ..\state127\press.* .
 copy ..\state127\unodb.* .
 copy ..\state127\unods.* .
 copy ..\state127\coor0.* .
 copy ..\state127\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state128 state129
 cd state128    
 copy ..\dual127\uhat.* .
 copy ..\state127\fnew.??? force.???
 copy ..\state127\force.??? fold.???
 copy ..\dual126\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual128 dual129
 cd dual128     
 copy ..\state128\unod.* .
 copy ..\state128\press.* .
 copy ..\state128\unodb.* .
 copy ..\state128\unods.* .
 copy ..\state128\coor0.* .
 copy ..\state128\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state129 state130
 cd state129    
 copy ..\dual128\uhat.* .
 copy ..\state128\fnew.??? force.???
 copy ..\state128\force.??? fold.???
 copy ..\dual127\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual129 dual130
 cd dual129     
 copy ..\state129\unod.* .
 copy ..\state129\press.* .
 copy ..\state129\unodb.* .
 copy ..\state129\unods.* .
 copy ..\state129\coor0.* .
 copy ..\state129\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state130 state131
 cd state130    
 copy ..\dual129\uhat.* .
 copy ..\state129\fnew.??? force.???
 copy ..\state129\force.??? fold.???
 copy ..\dual128\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual130 dual131
 cd dual130     
 copy ..\state130\unod.* .
 copy ..\state130\press.* .
 copy ..\state130\unodb.* .
 copy ..\state130\unods.* .
 copy ..\state130\coor0.* .
 copy ..\state130\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state131 state132
 cd state131    
 copy ..\dual130\uhat.* .
 copy ..\state130\fnew.??? force.???
 copy ..\state130\force.??? fold.???
 copy ..\dual129\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual131 dual132
 cd dual131     
 copy ..\state131\unod.* .
 copy ..\state131\press.* .
 copy ..\state131\unodb.* .
 copy ..\state131\unods.* .
 copy ..\state131\coor0.* .
 copy ..\state131\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state132 state133
 cd state132    
 copy ..\dual131\uhat.* .
 copy ..\state131\fnew.??? force.???
 copy ..\state131\force.??? fold.???
 copy ..\dual130\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual132 dual133
 cd dual132     
 copy ..\state132\unod.* .
 copy ..\state132\press.* .
 copy ..\state132\unodb.* .
 copy ..\state132\unods.* .
 copy ..\state132\coor0.* .
 copy ..\state132\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state133 state134
 cd state133    
 copy ..\dual132\uhat.* .
 copy ..\state132\fnew.??? force.???
 copy ..\state132\force.??? fold.???
 copy ..\dual131\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual133 dual134
 cd dual133     
 copy ..\state133\unod.* .
 copy ..\state133\press.* .
 copy ..\state133\unodb.* .
 copy ..\state133\unods.* .
 copy ..\state133\coor0.* .
 copy ..\state133\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state134 state135
 cd state134    
 copy ..\dual133\uhat.* .
 copy ..\state133\fnew.??? force.???
 copy ..\state133\force.??? fold.???
 copy ..\dual132\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual134 dual135
 cd dual134     
 copy ..\state134\unod.* .
 copy ..\state134\press.* .
 copy ..\state134\unodb.* .
 copy ..\state134\unods.* .
 copy ..\state134\coor0.* .
 copy ..\state134\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state135 state136
 cd state135    
 copy ..\dual134\uhat.* .
 copy ..\state134\fnew.??? force.???
 copy ..\state134\force.??? fold.???
 copy ..\dual133\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual135 dual136
 cd dual135     
 copy ..\state135\unod.* .
 copy ..\state135\press.* .
 copy ..\state135\unodb.* .
 copy ..\state135\unods.* .
 copy ..\state135\coor0.* .
 copy ..\state135\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state136 state137
 cd state136    
 copy ..\dual135\uhat.* .
 copy ..\state135\fnew.??? force.???
 copy ..\state135\force.??? fold.???
 copy ..\dual134\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual136 dual137
 cd dual136     
 copy ..\state136\unod.* .
 copy ..\state136\press.* .
 copy ..\state136\unodb.* .
 copy ..\state136\unods.* .
 copy ..\state136\coor0.* .
 copy ..\state136\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state137 state138
 cd state137    
 copy ..\dual136\uhat.* .
 copy ..\state136\fnew.??? force.???
 copy ..\state136\force.??? fold.???
 copy ..\dual135\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual137 dual138
 cd dual137     
 copy ..\state137\unod.* .
 copy ..\state137\press.* .
 copy ..\state137\unodb.* .
 copy ..\state137\unods.* .
 copy ..\state137\coor0.* .
 copy ..\state137\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state138 state139
 cd state138    
 copy ..\dual137\uhat.* .
 copy ..\state137\fnew.??? force.???
 copy ..\state137\force.??? fold.???
 copy ..\dual136\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual138 dual139
 cd dual138     
 copy ..\state138\unod.* .
 copy ..\state138\press.* .
 copy ..\state138\unodb.* .
 copy ..\state138\unods.* .
 copy ..\state138\coor0.* .
 copy ..\state138\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state139 state140
 cd state139    
 copy ..\dual138\uhat.* .
 copy ..\state138\fnew.??? force.???
 copy ..\state138\force.??? fold.???
 copy ..\dual137\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual139 dual140
 cd dual139     
 copy ..\state139\unod.* .
 copy ..\state139\press.* .
 copy ..\state139\unodb.* .
 copy ..\state139\unods.* .
 copy ..\state139\coor0.* .
 copy ..\state139\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state140 state141
 cd state140    
 copy ..\dual139\uhat.* .
 copy ..\state139\fnew.??? force.???
 copy ..\state139\force.??? fold.???
 copy ..\dual138\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual140 dual141
 cd dual140     
 copy ..\state140\unod.* .
 copy ..\state140\press.* .
 copy ..\state140\unodb.* .
 copy ..\state140\unods.* .
 copy ..\state140\coor0.* .
 copy ..\state140\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state141 state142
 cd state141    
 copy ..\dual140\uhat.* .
 copy ..\state140\fnew.??? force.???
 copy ..\state140\force.??? fold.???
 copy ..\dual139\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual141 dual142
 cd dual141     
 copy ..\state141\unod.* .
 copy ..\state141\press.* .
 copy ..\state141\unodb.* .
 copy ..\state141\unods.* .
 copy ..\state141\coor0.* .
 copy ..\state141\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state142 state143
 cd state142    
 copy ..\dual141\uhat.* .
 copy ..\state141\fnew.??? force.???
 copy ..\state141\force.??? fold.???
 copy ..\dual140\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual142 dual143
 cd dual142     
 copy ..\state142\unod.* .
 copy ..\state142\press.* .
 copy ..\state142\unodb.* .
 copy ..\state142\unods.* .
 copy ..\state142\coor0.* .
 copy ..\state142\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state143 state144
 cd state143    
 copy ..\dual142\uhat.* .
 copy ..\state142\fnew.??? force.???
 copy ..\state142\force.??? fold.???
 copy ..\dual141\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual143 dual144
 cd dual143     
 copy ..\state143\unod.* .
 copy ..\state143\press.* .
 copy ..\state143\unodb.* .
 copy ..\state143\unods.* .
 copy ..\state143\coor0.* .
 copy ..\state143\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state144 state145
 cd state144    
 copy ..\dual143\uhat.* .
 copy ..\state143\fnew.??? force.???
 copy ..\state143\force.??? fold.???
 copy ..\dual142\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual144 dual145
 cd dual144     
 copy ..\state144\unod.* .
 copy ..\state144\press.* .
 copy ..\state144\unodb.* .
 copy ..\state144\unods.* .
 copy ..\state144\coor0.* .
 copy ..\state144\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state145 state146
 cd state145    
 copy ..\dual144\uhat.* .
 copy ..\state144\fnew.??? force.???
 copy ..\state144\force.??? fold.???
 copy ..\dual143\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual145 dual146
 cd dual145     
 copy ..\state145\unod.* .
 copy ..\state145\press.* .
 copy ..\state145\unodb.* .
 copy ..\state145\unods.* .
 copy ..\state145\coor0.* .
 copy ..\state145\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state146 state147
 cd state146    
 copy ..\dual145\uhat.* .
 copy ..\state145\fnew.??? force.???
 copy ..\state145\force.??? fold.???
 copy ..\dual144\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual146 dual147
 cd dual146     
 copy ..\state146\unod.* .
 copy ..\state146\press.* .
 copy ..\state146\unodb.* .
 copy ..\state146\unods.* .
 copy ..\state146\coor0.* .
 copy ..\state146\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state147 state148
 cd state147    
 copy ..\dual146\uhat.* .
 copy ..\state146\fnew.??? force.???
 copy ..\state146\force.??? fold.???
 copy ..\dual145\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual147 dual148
 cd dual147     
 copy ..\state147\unod.* .
 copy ..\state147\press.* .
 copy ..\state147\unodb.* .
 copy ..\state147\unods.* .
 copy ..\state147\coor0.* .
 copy ..\state147\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state148 state149
 cd state148    
 copy ..\dual147\uhat.* .
 copy ..\state147\fnew.??? force.???
 copy ..\state147\force.??? fold.???
 copy ..\dual146\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual148 dual149
 cd dual148     
 copy ..\state148\unod.* .
 copy ..\state148\press.* .
 copy ..\state148\unodb.* .
 copy ..\state148\unods.* .
 copy ..\state148\coor0.* .
 copy ..\state148\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state149 state150
 cd state149    
 copy ..\dual148\uhat.* .
 copy ..\state148\fnew.??? force.???
 copy ..\state148\force.??? fold.???
 copy ..\dual147\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual149 dual150
 cd dual149     
 copy ..\state149\unod.* .
 copy ..\state149\press.* .
 copy ..\state149\unodb.* .
 copy ..\state149\unods.* .
 copy ..\state149\coor0.* .
 copy ..\state149\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state150 state151
 cd state150    
 copy ..\dual149\uhat.* .
 copy ..\state149\fnew.??? force.???
 copy ..\state149\force.??? fold.???
 copy ..\dual148\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual150 dual151
 cd dual150     
 copy ..\state150\unod.* .
 copy ..\state150\press.* .
 copy ..\state150\unodb.* .
 copy ..\state150\unods.* .
 copy ..\state150\coor0.* .
 copy ..\state150\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state151 state152
 cd state151    
 copy ..\dual150\uhat.* .
 copy ..\state150\fnew.??? force.???
 copy ..\state150\force.??? fold.???
 copy ..\dual149\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual151 dual152
 cd dual151     
 copy ..\state151\unod.* .
 copy ..\state151\press.* .
 copy ..\state151\unodb.* .
 copy ..\state151\unods.* .
 copy ..\state151\coor0.* .
 copy ..\state151\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state152 state153
 cd state152    
 copy ..\dual151\uhat.* .
 copy ..\state151\fnew.??? force.???
 copy ..\state151\force.??? fold.???
 copy ..\dual150\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual152 dual153
 cd dual152     
 copy ..\state152\unod.* .
 copy ..\state152\press.* .
 copy ..\state152\unodb.* .
 copy ..\state152\unods.* .
 copy ..\state152\coor0.* .
 copy ..\state152\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state153 state154
 cd state153    
 copy ..\dual152\uhat.* .
 copy ..\state152\fnew.??? force.???
 copy ..\state152\force.??? fold.???
 copy ..\dual151\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual153 dual154
 cd dual153     
 copy ..\state153\unod.* .
 copy ..\state153\press.* .
 copy ..\state153\unodb.* .
 copy ..\state153\unods.* .
 copy ..\state153\coor0.* .
 copy ..\state153\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state154 state155
 cd state154    
 copy ..\dual153\uhat.* .
 copy ..\state153\fnew.??? force.???
 copy ..\state153\force.??? fold.???
 copy ..\dual152\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual154 dual155
 cd dual154     
 copy ..\state154\unod.* .
 copy ..\state154\press.* .
 copy ..\state154\unodb.* .
 copy ..\state154\unods.* .
 copy ..\state154\coor0.* .
 copy ..\state154\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state155 state156
 cd state155    
 copy ..\dual154\uhat.* .
 copy ..\state154\fnew.??? force.???
 copy ..\state154\force.??? fold.???
 copy ..\dual153\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual155 dual156
 cd dual155     
 copy ..\state155\unod.* .
 copy ..\state155\press.* .
 copy ..\state155\unodb.* .
 copy ..\state155\unods.* .
 copy ..\state155\coor0.* .
 copy ..\state155\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state156 state157
 cd state156    
 copy ..\dual155\uhat.* .
 copy ..\state155\fnew.??? force.???
 copy ..\state155\force.??? fold.???
 copy ..\dual154\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual156 dual157
 cd dual156     
 copy ..\state156\unod.* .
 copy ..\state156\press.* .
 copy ..\state156\unodb.* .
 copy ..\state156\unods.* .
 copy ..\state156\coor0.* .
 copy ..\state156\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state157 state158
 cd state157    
 copy ..\dual156\uhat.* .
 copy ..\state156\fnew.??? force.???
 copy ..\state156\force.??? fold.???
 copy ..\dual155\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual157 dual158
 cd dual157     
 copy ..\state157\unod.* .
 copy ..\state157\press.* .
 copy ..\state157\unodb.* .
 copy ..\state157\unods.* .
 copy ..\state157\coor0.* .
 copy ..\state157\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state158 state159
 cd state158    
 copy ..\dual157\uhat.* .
 copy ..\state157\fnew.??? force.???
 copy ..\state157\force.??? fold.???
 copy ..\dual156\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual158 dual159
 cd dual158     
 copy ..\state158\unod.* .
 copy ..\state158\press.* .
 copy ..\state158\unodb.* .
 copy ..\state158\unods.* .
 copy ..\state158\coor0.* .
 copy ..\state158\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state159 state160
 cd state159    
 copy ..\dual158\uhat.* .
 copy ..\state158\fnew.??? force.???
 copy ..\state158\force.??? fold.???
 copy ..\dual157\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual159 dual160
 cd dual159     
 copy ..\state159\unod.* .
 copy ..\state159\press.* .
 copy ..\state159\unodb.* .
 copy ..\state159\unods.* .
 copy ..\state159\coor0.* .
 copy ..\state159\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state160 state161
 cd state160    
 copy ..\dual159\uhat.* .
 copy ..\state159\fnew.??? force.???
 copy ..\state159\force.??? fold.???
 copy ..\dual158\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual160 dual161
 cd dual160     
 copy ..\state160\unod.* .
 copy ..\state160\press.* .
 copy ..\state160\unodb.* .
 copy ..\state160\unods.* .
 copy ..\state160\coor0.* .
 copy ..\state160\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state161 state162
 cd state161    
 copy ..\dual160\uhat.* .
 copy ..\state160\fnew.??? force.???
 copy ..\state160\force.??? fold.???
 copy ..\dual159\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual161 dual162
 cd dual161     
 copy ..\state161\unod.* .
 copy ..\state161\press.* .
 copy ..\state161\unodb.* .
 copy ..\state161\unods.* .
 copy ..\state161\coor0.* .
 copy ..\state161\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state162 state163
 cd state162    
 copy ..\dual161\uhat.* .
 copy ..\state161\fnew.??? force.???
 copy ..\state161\force.??? fold.???
 copy ..\dual160\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual162 dual163
 cd dual162     
 copy ..\state162\unod.* .
 copy ..\state162\press.* .
 copy ..\state162\unodb.* .
 copy ..\state162\unods.* .
 copy ..\state162\coor0.* .
 copy ..\state162\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state163 state164
 cd state163    
 copy ..\dual162\uhat.* .
 copy ..\state162\fnew.??? force.???
 copy ..\state162\force.??? fold.???
 copy ..\dual161\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual163 dual164
 cd dual163     
 copy ..\state163\unod.* .
 copy ..\state163\press.* .
 copy ..\state163\unodb.* .
 copy ..\state163\unods.* .
 copy ..\state163\coor0.* .
 copy ..\state163\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state164 state165
 cd state164    
 copy ..\dual163\uhat.* .
 copy ..\state163\fnew.??? force.???
 copy ..\state163\force.??? fold.???
 copy ..\dual162\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual164 dual165
 cd dual164     
 copy ..\state164\unod.* .
 copy ..\state164\press.* .
 copy ..\state164\unodb.* .
 copy ..\state164\unods.* .
 copy ..\state164\coor0.* .
 copy ..\state164\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state165 state166
 cd state165    
 copy ..\dual164\uhat.* .
 copy ..\state164\fnew.??? force.???
 copy ..\state164\force.??? fold.???
 copy ..\dual163\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual165 dual166
 cd dual165     
 copy ..\state165\unod.* .
 copy ..\state165\press.* .
 copy ..\state165\unodb.* .
 copy ..\state165\unods.* .
 copy ..\state165\coor0.* .
 copy ..\state165\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state166 state167
 cd state166    
 copy ..\dual165\uhat.* .
 copy ..\state165\fnew.??? force.???
 copy ..\state165\force.??? fold.???
 copy ..\dual164\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual166 dual167
 cd dual166     
 copy ..\state166\unod.* .
 copy ..\state166\press.* .
 copy ..\state166\unodb.* .
 copy ..\state166\unods.* .
 copy ..\state166\coor0.* .
 copy ..\state166\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state167 state168
 cd state167    
 copy ..\dual166\uhat.* .
 copy ..\state166\fnew.??? force.???
 copy ..\state166\force.??? fold.???
 copy ..\dual165\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual167 dual168
 cd dual167     
 copy ..\state167\unod.* .
 copy ..\state167\press.* .
 copy ..\state167\unodb.* .
 copy ..\state167\unods.* .
 copy ..\state167\coor0.* .
 copy ..\state167\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state168 state169
 cd state168    
 copy ..\dual167\uhat.* .
 copy ..\state167\fnew.??? force.???
 copy ..\state167\force.??? fold.???
 copy ..\dual166\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual168 dual169
 cd dual168     
 copy ..\state168\unod.* .
 copy ..\state168\press.* .
 copy ..\state168\unodb.* .
 copy ..\state168\unods.* .
 copy ..\state168\coor0.* .
 copy ..\state168\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state169 state170
 cd state169    
 copy ..\dual168\uhat.* .
 copy ..\state168\fnew.??? force.???
 copy ..\state168\force.??? fold.???
 copy ..\dual167\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual169 dual170
 cd dual169     
 copy ..\state169\unod.* .
 copy ..\state169\press.* .
 copy ..\state169\unodb.* .
 copy ..\state169\unods.* .
 copy ..\state169\coor0.* .
 copy ..\state169\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state170 state171
 cd state170    
 copy ..\dual169\uhat.* .
 copy ..\state169\fnew.??? force.???
 copy ..\state169\force.??? fold.???
 copy ..\dual168\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual170 dual171
 cd dual170     
 copy ..\state170\unod.* .
 copy ..\state170\press.* .
 copy ..\state170\unodb.* .
 copy ..\state170\unods.* .
 copy ..\state170\coor0.* .
 copy ..\state170\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state171 state172
 cd state171    
 copy ..\dual170\uhat.* .
 copy ..\state170\fnew.??? force.???
 copy ..\state170\force.??? fold.???
 copy ..\dual169\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual171 dual172
 cd dual171     
 copy ..\state171\unod.* .
 copy ..\state171\press.* .
 copy ..\state171\unodb.* .
 copy ..\state171\unods.* .
 copy ..\state171\coor0.* .
 copy ..\state171\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state172 state173
 cd state172    
 copy ..\dual171\uhat.* .
 copy ..\state171\fnew.??? force.???
 copy ..\state171\force.??? fold.???
 copy ..\dual170\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual172 dual173
 cd dual172     
 copy ..\state172\unod.* .
 copy ..\state172\press.* .
 copy ..\state172\unodb.* .
 copy ..\state172\unods.* .
 copy ..\state172\coor0.* .
 copy ..\state172\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state173 state174
 cd state173    
 copy ..\dual172\uhat.* .
 copy ..\state172\fnew.??? force.???
 copy ..\state172\force.??? fold.???
 copy ..\dual171\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual173 dual174
 cd dual173     
 copy ..\state173\unod.* .
 copy ..\state173\press.* .
 copy ..\state173\unodb.* .
 copy ..\state173\unods.* .
 copy ..\state173\coor0.* .
 copy ..\state173\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state174 state175
 cd state174    
 copy ..\dual173\uhat.* .
 copy ..\state173\fnew.??? force.???
 copy ..\state173\force.??? fold.???
 copy ..\dual172\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual174 dual175
 cd dual174     
 copy ..\state174\unod.* .
 copy ..\state174\press.* .
 copy ..\state174\unodb.* .
 copy ..\state174\unods.* .
 copy ..\state174\coor0.* .
 copy ..\state174\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state175 state176
 cd state175    
 copy ..\dual174\uhat.* .
 copy ..\state174\fnew.??? force.???
 copy ..\state174\force.??? fold.???
 copy ..\dual173\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual175 dual176
 cd dual175     
 copy ..\state175\unod.* .
 copy ..\state175\press.* .
 copy ..\state175\unodb.* .
 copy ..\state175\unods.* .
 copy ..\state175\coor0.* .
 copy ..\state175\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state176 state177
 cd state176    
 copy ..\dual175\uhat.* .
 copy ..\state175\fnew.??? force.???
 copy ..\state175\force.??? fold.???
 copy ..\dual174\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual176 dual177
 cd dual176     
 copy ..\state176\unod.* .
 copy ..\state176\press.* .
 copy ..\state176\unodb.* .
 copy ..\state176\unods.* .
 copy ..\state176\coor0.* .
 copy ..\state176\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state177 state178
 cd state177    
 copy ..\dual176\uhat.* .
 copy ..\state176\fnew.??? force.???
 copy ..\state176\force.??? fold.???
 copy ..\dual175\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual177 dual178
 cd dual177     
 copy ..\state177\unod.* .
 copy ..\state177\press.* .
 copy ..\state177\unodb.* .
 copy ..\state177\unods.* .
 copy ..\state177\coor0.* .
 copy ..\state177\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state178 state179
 cd state178    
 copy ..\dual177\uhat.* .
 copy ..\state177\fnew.??? force.???
 copy ..\state177\force.??? fold.???
 copy ..\dual176\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual178 dual179
 cd dual178     
 copy ..\state178\unod.* .
 copy ..\state178\press.* .
 copy ..\state178\unodb.* .
 copy ..\state178\unods.* .
 copy ..\state178\coor0.* .
 copy ..\state178\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state179 state180
 cd state179    
 copy ..\dual178\uhat.* .
 copy ..\state178\fnew.??? force.???
 copy ..\state178\force.??? fold.???
 copy ..\dual177\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual179 dual180
 cd dual179     
 copy ..\state179\unod.* .
 copy ..\state179\press.* .
 copy ..\state179\unodb.* .
 copy ..\state179\unods.* .
 copy ..\state179\coor0.* .
 copy ..\state179\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state180 state181
 cd state180    
 copy ..\dual179\uhat.* .
 copy ..\state179\fnew.??? force.???
 copy ..\state179\force.??? fold.???
 copy ..\dual178\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual180 dual181
 cd dual180     
 copy ..\state180\unod.* .
 copy ..\state180\press.* .
 copy ..\state180\unodb.* .
 copy ..\state180\unods.* .
 copy ..\state180\coor0.* .
 copy ..\state180\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state181 state182
 cd state181    
 copy ..\dual180\uhat.* .
 copy ..\state180\fnew.??? force.???
 copy ..\state180\force.??? fold.???
 copy ..\dual179\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual181 dual182
 cd dual181     
 copy ..\state181\unod.* .
 copy ..\state181\press.* .
 copy ..\state181\unodb.* .
 copy ..\state181\unods.* .
 copy ..\state181\coor0.* .
 copy ..\state181\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state182 state183
 cd state182    
 copy ..\dual181\uhat.* .
 copy ..\state181\fnew.??? force.???
 copy ..\state181\force.??? fold.???
 copy ..\dual180\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual182 dual183
 cd dual182     
 copy ..\state182\unod.* .
 copy ..\state182\press.* .
 copy ..\state182\unodb.* .
 copy ..\state182\unods.* .
 copy ..\state182\coor0.* .
 copy ..\state182\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state183 state184
 cd state183    
 copy ..\dual182\uhat.* .
 copy ..\state182\fnew.??? force.???
 copy ..\state182\force.??? fold.???
 copy ..\dual181\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual183 dual184
 cd dual183     
 copy ..\state183\unod.* .
 copy ..\state183\press.* .
 copy ..\state183\unodb.* .
 copy ..\state183\unods.* .
 copy ..\state183\coor0.* .
 copy ..\state183\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state184 state185
 cd state184    
 copy ..\dual183\uhat.* .
 copy ..\state183\fnew.??? force.???
 copy ..\state183\force.??? fold.???
 copy ..\dual182\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual184 dual185
 cd dual184     
 copy ..\state184\unod.* .
 copy ..\state184\press.* .
 copy ..\state184\unodb.* .
 copy ..\state184\unods.* .
 copy ..\state184\coor0.* .
 copy ..\state184\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state185 state186
 cd state185    
 copy ..\dual184\uhat.* .
 copy ..\state184\fnew.??? force.???
 copy ..\state184\force.??? fold.???
 copy ..\dual183\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual185 dual186
 cd dual185     
 copy ..\state185\unod.* .
 copy ..\state185\press.* .
 copy ..\state185\unodb.* .
 copy ..\state185\unods.* .
 copy ..\state185\coor0.* .
 copy ..\state185\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state186 state187
 cd state186    
 copy ..\dual185\uhat.* .
 copy ..\state185\fnew.??? force.???
 copy ..\state185\force.??? fold.???
 copy ..\dual184\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual186 dual187
 cd dual186     
 copy ..\state186\unod.* .
 copy ..\state186\press.* .
 copy ..\state186\unodb.* .
 copy ..\state186\unods.* .
 copy ..\state186\coor0.* .
 copy ..\state186\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state187 state188
 cd state187    
 copy ..\dual186\uhat.* .
 copy ..\state186\fnew.??? force.???
 copy ..\state186\force.??? fold.???
 copy ..\dual185\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual187 dual188
 cd dual187     
 copy ..\state187\unod.* .
 copy ..\state187\press.* .
 copy ..\state187\unodb.* .
 copy ..\state187\unods.* .
 copy ..\state187\coor0.* .
 copy ..\state187\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state188 state189
 cd state188    
 copy ..\dual187\uhat.* .
 copy ..\state187\fnew.??? force.???
 copy ..\state187\force.??? fold.???
 copy ..\dual186\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual188 dual189
 cd dual188     
 copy ..\state188\unod.* .
 copy ..\state188\press.* .
 copy ..\state188\unodb.* .
 copy ..\state188\unods.* .
 copy ..\state188\coor0.* .
 copy ..\state188\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state189 state190
 cd state189    
 copy ..\dual188\uhat.* .
 copy ..\state188\fnew.??? force.???
 copy ..\state188\force.??? fold.???
 copy ..\dual187\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual189 dual190
 cd dual189     
 copy ..\state189\unod.* .
 copy ..\state189\press.* .
 copy ..\state189\unodb.* .
 copy ..\state189\unods.* .
 copy ..\state189\coor0.* .
 copy ..\state189\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state190 state191
 cd state190    
 copy ..\dual189\uhat.* .
 copy ..\state189\fnew.??? force.???
 copy ..\state189\force.??? fold.???
 copy ..\dual188\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual190 dual191
 cd dual190     
 copy ..\state190\unod.* .
 copy ..\state190\press.* .
 copy ..\state190\unodb.* .
 copy ..\state190\unods.* .
 copy ..\state190\coor0.* .
 copy ..\state190\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state191 state192
 cd state191    
 copy ..\dual190\uhat.* .
 copy ..\state190\fnew.??? force.???
 copy ..\state190\force.??? fold.???
 copy ..\dual189\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual191 dual192
 cd dual191     
 copy ..\state191\unod.* .
 copy ..\state191\press.* .
 copy ..\state191\unodb.* .
 copy ..\state191\unods.* .
 copy ..\state191\coor0.* .
 copy ..\state191\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state192 state193
 cd state192    
 copy ..\dual191\uhat.* .
 copy ..\state191\fnew.??? force.???
 copy ..\state191\force.??? fold.???
 copy ..\dual190\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual192 dual193
 cd dual192     
 copy ..\state192\unod.* .
 copy ..\state192\press.* .
 copy ..\state192\unodb.* .
 copy ..\state192\unods.* .
 copy ..\state192\coor0.* .
 copy ..\state192\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state193 state194
 cd state193    
 copy ..\dual192\uhat.* .
 copy ..\state192\fnew.??? force.???
 copy ..\state192\force.??? fold.???
 copy ..\dual191\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual193 dual194
 cd dual193     
 copy ..\state193\unod.* .
 copy ..\state193\press.* .
 copy ..\state193\unodb.* .
 copy ..\state193\unods.* .
 copy ..\state193\coor0.* .
 copy ..\state193\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state194 state195
 cd state194    
 copy ..\dual193\uhat.* .
 copy ..\state193\fnew.??? force.???
 copy ..\state193\force.??? fold.???
 copy ..\dual192\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual194 dual195
 cd dual194     
 copy ..\state194\unod.* .
 copy ..\state194\press.* .
 copy ..\state194\unodb.* .
 copy ..\state194\unods.* .
 copy ..\state194\coor0.* .
 copy ..\state194\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state195 state196
 cd state195    
 copy ..\dual194\uhat.* .
 copy ..\state194\fnew.??? force.???
 copy ..\state194\force.??? fold.???
 copy ..\dual193\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual195 dual196
 cd dual195     
 copy ..\state195\unod.* .
 copy ..\state195\press.* .
 copy ..\state195\unodb.* .
 copy ..\state195\unods.* .
 copy ..\state195\coor0.* .
 copy ..\state195\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state196 state197
 cd state196    
 copy ..\dual195\uhat.* .
 copy ..\state195\fnew.??? force.???
 copy ..\state195\force.??? fold.???
 copy ..\dual194\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual196 dual197
 cd dual196     
 copy ..\state196\unod.* .
 copy ..\state196\press.* .
 copy ..\state196\unodb.* .
 copy ..\state196\unods.* .
 copy ..\state196\coor0.* .
 copy ..\state196\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state197 state198
 cd state197    
 copy ..\dual196\uhat.* .
 copy ..\state196\fnew.??? force.???
 copy ..\state196\force.??? fold.???
 copy ..\dual195\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual197 dual198
 cd dual197     
 copy ..\state197\unod.* .
 copy ..\state197\press.* .
 copy ..\state197\unodb.* .
 copy ..\state197\unods.* .
 copy ..\state197\coor0.* .
 copy ..\state197\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state198 state199
 cd state198    
 copy ..\dual197\uhat.* .
 copy ..\state197\fnew.??? force.???
 copy ..\state197\force.??? fold.???
 copy ..\dual196\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual198 dual199
 cd dual198     
 copy ..\state198\unod.* .
 copy ..\state198\press.* .
 copy ..\state198\unodb.* .
 copy ..\state198\unods.* .
 copy ..\state198\coor0.* .
 copy ..\state198\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state199 state200
 cd state199    
 copy ..\dual198\uhat.* .
 copy ..\state198\fnew.??? force.???
 copy ..\state198\force.??? fold.???
 copy ..\dual197\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual199 dual200
 cd dual199     
 copy ..\state199\unod.* .
 copy ..\state199\press.* .
 copy ..\state199\unodb.* .
 copy ..\state199\unods.* .
 copy ..\state199\coor0.* .
 copy ..\state199\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
 Xcopy /E /I state200 state201
 cd state200    
 copy ..\dual199\uhat.* .
 copy ..\state199\fnew.??? force.???
 copy ..\state199\force.??? fold.???
 copy ..\dual198\uhat.??? uold.???
 call cgm.bat
 cd ..
 
 Xcopy /E /I dual200 dual201
 cd dual200     
 copy ..\state200\unod.* .
 copy ..\state200\press.* .
 copy ..\state200\unodb.* .
 copy ..\state200\unods.* .
 copy ..\state200\coor0.* .
 copy ..\state200\time .
 copy ..\obj.txt .
 call cgm.bat
 copy obj.txt ..\
 cd ..
 
