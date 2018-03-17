#include<string.h>
#include<stdio.h>
#include<stdlib.h>

extern char trans(char);

int main()
{
    int len=0,i=0;
    char tmp[1000];

    FILE *fp=NULL,*output=NULL;
    fp=fopen("input.txt","r");
    output=fopen("output.txt","w");

    while(fgets(tmp,1000-1,fp))
    {
        len=strlen(tmp);

        for(i=0;i<len;i++)
        {
            tmp[i]=trans(tmp[i]);
            fprintf(output,"%c",tmp[i]);
        }
    }

    return 0;
}
