/*  aclh()£ºget the position of the non-zero elements in the global matrix(*mht);
    get the number of non-zero elments in every row (*numcol)  
*/
int aclh(neq,numcol,mht,nd,lm,maxcol)
int neq,*numcol,*mht,nd,*lm,maxcol;
{
    int i,j,k,ni,nj;
    for (i=1; i<=nd; ++i)
    {
        ni = lm[i];
        for (j=1; j<=nd; ++j)
        {
            nj = lm[j];
            for (k=1; k<=numcol[ni]; ++k)
                if (nj==mht[(ni-1)*maxcol+k-1]) goto l300;
            numcol[ni] = numcol[ni]+1;
            k = numcol[ni];
            mht[(ni-1)*maxcol+k-1] = nj;
            if (numcol[ni]>maxcol)
            {
                // write(*,*) 'exeet maxcol ....',numcol(ni),' > ',maxcol
                return 1;
            }
l300:
            continue;
        }
    }
    return 0;
}
/*  bclh()£ºordering elements in *mht, stored in na().
    numcol(i)=The first postion (of all the non-zero elments) of very row i 
*/
void bclh(neq,numcol,mht,na,jdiag,lmi,maxcol)
int neq,*numcol,*mht,*na,*jdiag,*lmi,maxcol;
{
    void order(int,int *);
    int n,nn,i,li,nsum,j;
    for (n=1; n<=neq; ++n)
    {
        li = numcol[n];
        for (i=1; i<=li; ++i)
        {
            lmi[i] = mht[(n-1)*maxcol+i-1];
        }
        order(li,lmi);
        for (i=1; i<=li; ++i)
        {
            mht[(n-1)*maxcol+i-1] = lmi[i];
        }
    }
    nsum = 0;
    for (n=1; n<=neq; ++n)
    {
        for (i=1; i<=numcol[n]; ++i)
        {
            na[nsum] = mht[(n-1)*maxcol+i-1];
            nsum = nsum+1;
        }
    }
    for (n=1; n<=neq; ++n)
    {
        numcol[n] += numcol[n-1];
    }
    for (i=0; i<neq; i++)
    {
        for (j=numcol[i]; j<numcol[i+1]; j++)
        {
            if(na[j]==(i+1)) goto l200;
        }
l200:
        jdiag[i]=j+1;
    }
    return;
}
/* Ordering from minimum to maximum */
void order(nd,lm)
int nd,*lm;
{
    int i,j,j0,ls;
    for (i=1; i<=nd; ++i)
    {
        ls = lm[i]+1;
        for (j=i; j<=nd; ++j)
        {
            if (lm[j]<=ls)
            {
                ls = lm[j];
                j0 = j;
            }
        }
        lm[j0] = lm[i];
        lm[i]  = ls;
    }
    return;
}
