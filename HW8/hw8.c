#include<stdio.h>
#include<stdlib.h>
#include<time.h>


int main(void)
{
    float a[200][202],b[200][202],c[200][202],sum[200]={0},tmp=0;
    int i=0,k=0;
    struct timespec start,end;
    FILE *fp=NULL,*out=NULL;

    fp=fopen("data.txt","r");
    out=fopen("output.txt","w");

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

    clock_gettime(CLOCK_MONOTONIC, &start);

    for(i=0;i<200;i++)
    {
        for(k=0;k<202;k++)
        {
            sum[i]+=a[i][k]*b[i][k];
            sum[i]+=a[i][k]*c[i][k];
        }
        printf("%.3f\n",sum[i]);
        fprintf(out,"%.3f\n",sum[i]);
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    fprintf(out,"Sec:%ld\n",end.tv_sec-start.tv_sec);
    printf("Sec:%ld\n",end.tv_sec-start.tv_sec);

    fprintf(out,"Nsec:%ld\n",end.tv_nsec-start.tv_nsec);
    printf("Nsec:%ld\n",end.tv_nsec-start.tv_nsec);

    fclose(out);


}
