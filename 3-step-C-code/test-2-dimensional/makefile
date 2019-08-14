CC = icc
FLAGS = -Wall -c
NAME = CFLAG
OBJS = fsi.c \
gidpre.c gidpre1.c gidmsh.c gidmsh1.c gidres.c gidres1.c \
starta.c startb.c startc.c startf.c epgsub.c bft.c restart.c \
efsia.c efsib.c efsic.c efsid.c efsie.c efsif.c ufsia.c ufsib.c ufsic.c \
aeq9g3.c beq9g3.c ceq9g3.c deq9g3.c eet3.c fet3.c \
solv.c cholesky.c pminres.c pcg.c pcg_solid.c ddjd.c ddtv.c upcoor.c \
cshap.c glvart.c qtcwl.c shap.c \
efsia0.c efsib0.c efsic0.c b0eq9g3.c \
bound.c id.c initial.c
 
 
#SRC = $(wildcard *.c)
obj = $(patsubst %.c,%.o,$(OBJS))
 
 
fsi: $(obj)
	$(CC) $(obj) -o fsi -lm
$(obj):%.o:%.c
	$(CC) -std=c99 -c $< -o $@
 
.PHONY: clean
clean:
	rm fsi *.o *.obj
