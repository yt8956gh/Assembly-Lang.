#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<emmintrin.h>
#include<xmmintrin.h>
int main(void)
{
    int i,k;
    float a[256][256] __attribute__ ((aligned(16))); // get float numberber of A matrix from file
    float b[256][256] __attribute__ ((aligned(16))); // get float numberber of B matrix from file
    float c[256][256] __attribute__ ((aligned(16))); // get float numberber of C matrix from file
    float sumABC[4];//tmp
    float sumAB[4],sumAC[4] __attribute__ ((aligned(16))); //tmp for operation
    float Final_sum[256] __attribute__ ((aligned(16)));  //store final result
    float number __attribute__ ((aligned(16)));
    struct timespec start, end;

    __m128 *sumtmp;//tmp for sumABC
    __m128 *A; //tmp for a[][]
    __m128 *B; //tmp for b[][]
    __m128 *C; //tmp for c[][]
    __m128 *AB; //tmp for sumAB[]
    __m128 *AC; //tmp for sumAC[]


    FILE *fp=NULL,*out=NULL;
    fp=fopen("data.txt","r");
    out=fopen("output_SIMD.txt","w");

    if(fp==NULL||out==NULL)
    {
        fprintf(stderr,"File could not exist!\n");
        exit(1);
    }

    for(i=0;i<200;i++)
    {
        for(k=0;k<202;k++)
        {
            fscanf(fp,"%f",&a[i][k]);
        }
    }


    for(i=0;i<200;i++)
    {
        for(k=0;k<202;k++)
        {
            fscanf(fp,"%f",&b[i][k]);
        }
    }


    for(i=0;i<200;i++)
    {
        for(k=0;k<202;k++)
        {
            fscanf(fp,"%f",&c[i][k]);
        }
    }

    fclose(fp);

    AB=(__m128*)sumAB;       //set pointer to the memory
    AC=(__m128*)sumAC;
    sumtmp=(__m128*)sumABC;

    clock_gettime(CLOCK_MONOTONIC, &start);//get time

    for(i=0;i<200;i++)
    {
        A=(__m128*)a[i]; // point memory with __m128 poiter type
        B=(__m128*)b[i];
        C=(__m128*)c[i];

        *AB=_mm_sub_ps(*AB,*AB);//initialize to zero
        *AC=_mm_sub_ps(*AC,*AC);//initialize to zero

        // __m128 _mm_sub_ps (__m128 a, __m128 b)
        // SubtrACt packed single-precision (32-bit) floating-point elements in b 
        // from pACked single-precision (32-bit) floating-point elements in a,
        // and store the results in dst.


        // This loop will exceed 202. However, AB and AC have been initialize to zero,
        // 203 and 204 will not influence final sum.
        for(k=0;k<51;k++)
        {
            *AB=_mm_add_ps(*AB,_mm_mul_ps(A[k],B[k])); // AB+=a[i][j]*b[i][j];
            *AC=_mm_add_ps(*AC,_mm_mul_ps(A[k],C[k])); // AC+=a[i][j]*c[i][j];
            // __m128 _mm_add_ps (__m128 a, __m128 b)
            // Add packed single-precision (32-bit) floating-point elements in a and b,
            // and store the results in dst.
        }

        *sumtmp=_mm_add_ps(*AB,*AC); //sumABC[4]=AB+AC
        Final_sum[i]=sumABC[0]+sumABC[1]+sumABC[2]+sumABC[3];//get sum of singel row in matrix ABC
    }

    clock_gettime(CLOCK_MONOTONIC, &end);


    for(i=0;i<200;i++)
    {
        fprintf(out,"%.2f\n",Final_sum[i]);
        printf("%.2f\n",Final_sum[i]);
    }


    fprintf(out,"Sec:%ld\n",end.tv_sec-start.tv_sec);
    printf("Sec:%ld\n",end.tv_sec-start.tv_sec);

    fprintf(out,"Nsec:%ld\n",end.tv_nsec-start.tv_nsec);
    printf("Nsec:%ld\n",end.tv_nsec-start.tv_nsec);

    fclose(out);

return 0;
}
