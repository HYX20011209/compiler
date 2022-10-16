#include <stdio.h>
int fuc1(int a)
{
	while(1)
	{
		if (a==1)
			break;
		else
			continue;
	}
	return 5;
}

int main()
{
	float a;
	a=3.3;
	int i=1;
	while(i==1)
	{
		i++;
	}
	if(i==2)
		i=3;
	else
		i=4;
	int j;
	j=fuc1(1);
	return 0;
}
