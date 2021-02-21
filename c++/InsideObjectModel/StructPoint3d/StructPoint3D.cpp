#include<stdio.h>
# if 0
typedef struct point3d
{
	float x;
	float y;
	float z;
}Point3d;

#ifdef MACRO 
#define Point3d_print( pd ) \
		printf("(%g, %g, %g)", pd->x, pd->y, pd->z);
#else
void Point3d_print(const Point3d* pd)
{
	printf("(%g, %g, %g)", pd->x, pd->y, pd->z);
}
#endif

Point3d* get_a_point()
{
	return nullptr;
}

void my_foo()
{
	Point3d* pd = get_a_point();
	//...
	printf("(%g, %g, %g)", pd->x, pd->y, pd->z);
}

#endif