//
//  Vec4.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 17/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "Vec4.h"


@implementation Vec4

#define equatorial_radius 6378137.0f
#define polar_radius 6356752.3f
#define es 0.00669437999013f

#define appros 1000000;

@synthesize X,Y,Z,realX,realY,realZ;

-(Vec4*) init{
    self = [super init];
	
    if ( self ) {
        [self setX: 0.0];
		[self setY: 0.0];
		[self setZ: 0.0];
    }
	
    return self;
}

-(Vec4*) initX: (double) x Y: (double) y Z:(double) z{
    self = [super init];
	
	
    if ( self ) {
        [self setX: x];
		[self setY: y];
		[self setZ: z];
    }
	
    return self;
}

-(Vec4*) minus: (Vec4*) vector
{
	Vec4 *newVector = [[Vec4 alloc] initX: [self X]-[vector X] Y: [self Y]-[vector Y] Z:[self Z]-[vector Z]];
	
	return newVector;
}

+(double) distanceVector1: (Vec4*) vector1 Vector2: (Vec4*) vector2{

	double diffX = vector1.X - vector2.X;
	double diffY = vector1.Y - vector2.Y;	
	double diffZ = vector1.Z - vector2.Z;
	
	double res= (diffX*diffX)+(diffY*diffY)+(diffZ*diffZ);
	
	return sqrt(res);

}

+(double) realDistanceVector1: (Vec4*) vector1 Vector2: (Vec4*) vector2{
	
	double diffX = vector1.realX - vector2.realX;
	double diffY = vector1.realY - vector2.realY;	
	double diffZ = vector1.realZ - vector2.realZ;
	
	double res= (diffX*diffX)+(diffY*diffY)+(diffZ*diffZ);
	
	return sqrt(res);
	
}

+(Vec4*) mix: (double)amount Vector1: (Vec4*) vector1 Vector2: (Vec4*) vector2
{
	if(amount<0.0f){
		return vector1;
	}else if (amount>1.0f){
		return vector2;
	}
	
	double t1 = 1.0 - amount;
	
	double x=(vector1.X * t1)+(vector2.X * amount);
	double y=(vector1.Y * t1)+(vector2.Y * amount);
	double z=(vector1.Z * t1)+(vector2.Z * amount);
	
	Vec4 *newVector = [[Vec4 alloc] initX: x Y: y Z:z];
	
	newVector.realX=vector1.realX;
	newVector.realY=vector1.realY;
	newVector.realZ=vector1.realZ;
	
	return newVector;
}

+(Vec4*) mixReal: (double)amount Vector1: (Vec4*) vector1 Vector2: (Vec4*) vector2
{
	if(amount<0.0f){
		return vector1;
	}else if (amount>1.0f){
		return vector2;
	}
	
	double t1 = 1.0 - amount;
	
	double x=(vector1.realX * t1)+(vector2.realX * amount);
	double y=(vector1.realY * t1)+(vector2.realY * amount);
	double z=(vector1.realZ * t1)+(vector2.realZ * amount);
	
	Vec4 *newVector = [[Vec4 alloc] initX: x Y: y Z:z];
	
	newVector.realX=vector1.realX;
	newVector.realY=vector1.realY;
	newVector.realZ=vector1.realZ;
	
	return newVector;
}


+ (Vec4*)geodeticToCartesian: (double)latitude Longitude: (double)longitude Elevation: (double)metersElevation isUser: (BOOL) isUser userPos: (Vec4*) userPos{

	double rLat=latitude * M_PI / 180;
	double rLon=longitude * M_PI / 180;	
	
	double cosLat=cos(rLat);
	double sinLat=sin(rLat);
	
	double cosLon=cos(rLon);
	double sinLon=sin(rLon);
	
	double rpm=equatorial_radius/sqrt(1.0 - es * sinLat * sinLat);
	
	double x = (rpm + metersElevation) * cosLat * sinLon;
	double y = (rpm * (1.0 - es) + metersElevation) * sinLat;
	double z = (rpm + metersElevation) * cosLat * cosLon;
	
	double realX = x;
	double realY = y;
	double realZ = z;
	
	Vec4* vec = [[Vec4 alloc] init];
	//Vec4* vec = [[Vec4 alloc] initX:realX Y:realY Z:realZ];
	vec.realX=realX;
	vec.realY=realY;
	vec.realZ=realZ;
	
	Vec4* center = [[Vec4 alloc]initX:0 Y:0 Z:0];
	center.realX=0;
		center.realY=0;
		center.realZ=0;
	
	
	
	if(isUser){
		vec = [Vec4 mixReal:0.95 Vector1:vec Vector2:center];
		//NSLog(@"userPos %f %f %f appros: %f %f %f",vec.realX,vec.realY,vec.realZ,vec.X,vec.Y,vec.Z);
	}else{
		double diffX=userPos->realX-userPos.X;
		double diffY=userPos->realY-userPos.Y;
		double diffZ=userPos->realZ-userPos.Z;
		
		//NSLog(@"userPos %f %f %f ",userPos.X,userPos.Y,userPos.Z);
		//NSLog(@"diff %f %f %f ",diffX,diffY,diffZ);
		
		vec.X=realX-diffX;
			vec.Y=realY-diffY;
				vec.Z=realZ-diffZ;
		//NSLog(@"Pos %f %f %f appros: %f %f %f",vec.realX,vec.realY,vec.realZ,vec.X,vec.Y,vec.Z);
	}

	return vec;
}

+ (Vec4*)geodeticToCartesian: (double)latitude Longitude: (double)longitude Elevation: (double)metersElevation {
	
	double rLat=latitude * M_PI / 180;
	double rLon=longitude * M_PI / 180;
	
	
	double cosLat=cos(rLat);
	double sinLat=sin(rLat);
	
	double cosLon=cos(rLon);
	double sinLon=sin(rLon);
	
	double rpm=equatorial_radius/sqrt(1.0 - es * sinLat * sinLat);
	
	double x = (rpm + metersElevation) * cosLat * sinLon;
	double y = (rpm * (1.0 - es) + metersElevation) * sinLat;
	double z = (rpm + metersElevation) * cosLat * cosLon;
	
	double realX = x;
	double realY = y;
	double realZ = z;
	
	/*
	int z_val = z/appros;	
	double z_val2=z_val*appros;		
	double newZ=z-z_val2;	
	int y_val = y/appros;	
	double y_val2=y_val*appros;		
	double newY=y-y_val2;	
	int x_val = x/appros;	
	double x_val2=x_val*appros;		
	double newX=x-x_val2;
	*/
	
		
		
	double newZ=z-4350000;	
	double newY=y-4550000;	
	double newX=x-850000;
	
		//NSLog(@"real %f %f %f",x,y,z);
		//NSLog(@"appr %f %f %f",newX,newY,newZ);
	
		/*
	 double newZ=z/100;	
	 double newY=y/100;	
	 double newX=x/100;
	 */
	/*
	double newZ=(int)z;	
	double newY=(int)y;	
	double newX=(int)x;
	*/
	/*
	double newZ=z;	
	double  newY=y;	
	double newX=x;
	*/
	 /*
	double unity =500000;
	//double unity2=100000;
	double x_resto= 	modf(x, &unity);	
	 unity =500000;
//	NSLog(@"%f / %f",x,unity);
	int xn_val=x/unity;	
	double y_resto= 	modf(y, &unity);
	unity =500000;
	int yn_val=y/unity;	
	double z_resto= 	modf(z, &unity);
	unity =500000;
	int zn_val=z/unity;
	*/
	  //NSLog(@"x: %i volte con resto %f",xn_val,x_resto);
	//NSLog(@"y: %i volte con resto %f",yn_val,y_resto);
	//NSLog(@"z: %i volte con resto %f",zn_val,z_resto);
	//x=realX-850000;
	//y=realY-4500000;
	//z=realZ-4300000;
	
//	NSLog(@"real %f %f %f",realX,realY,realZ);
//	NSLog(@"appr %f %f %f",newX,newY,newZ);
	
	Vec4* vec = [[Vec4 alloc] initX:newX Y:newY Z:newZ];
	//Vec4* vec = [[Vec4 alloc] initX:realX Y:realY Z:realZ];
	vec.realX=realX;
	vec.realY=realY;
	vec.realZ=realZ;
	
	
	return vec;
}


/*
-(GLfloat) Round: (GLfloat) n dec: (int)decimal_places {
    decimal_places = 10^decimal_places;
    return ((GLfloat)((int)(n*decimal_places)))/decimal_places;
}
*/
@end
