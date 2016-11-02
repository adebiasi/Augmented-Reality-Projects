//
//  Vector3.m
//  NeHe Lesson 04
//
//  Created by Raffaele De Amicis on 21/10/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "Vector3.h"


@implementation Vector3

@synthesize X,Y,Z;

-(Vector3*) init{
    self = [super init];
	
    if ( self ) {
        [self setX: 0];
		[self setY: 0];
		[self setZ: 0];
    }
	
    return self;
}

-(Vector3*) initWithX: (GLfloat) x Y: (GLfloat) y Z:(GLfloat) z{
    self = [super init];
	
    if ( self ) {
        [self setX: x];
		[self setY: y];
		[self setZ: z];
    }
	
    return self;
}


-(Vector3*) plus: (Vector3*) vector
{
	Vector3 *newVector = [[Vector3 alloc] initWithX: [self X]+[vector X] Y: [self Y]+[vector Y] Z:[self Z]+[vector Z]];

	return newVector;
}

-(Vector3*) minus: (Vector3*) vector
{
	Vector3 *newVector = [[Vector3 alloc] initWithX: [self X]-[vector X] Y: [self Y]-[vector Y] Z:[self Z]-[vector Z]];
	
	return newVector;
}

-(Vector3*) mult: (GLfloat) num{

	Vector3 *newVector = [[Vector3 alloc] initWithX: [self X]*num Y: [self Y]*num Z:[self Z]*num];
	
	return newVector;
	
}

+(GLfloat) dotProd: (Vector3*) v1 vector2: (Vector3*) v2{
	
	return [v1 X] * [v2 X] + [v1 Y]*[v2 Y] + [v1 Z]*[v2 Z];
	
}

+(Vector3*) cossProd: (Vector3*) v1 vector2: (Vector3*) v2{

	Vector3 *newVector = [[Vector3 alloc] init];

	[newVector setX: [v1 Y]*[v2 Z] - [v1 Z]*[v2 Y]]; 
	[newVector setY: [v1 Z]*[v2 X] - [v1 X]*[v2 Z]]; 
	[newVector setZ: [v1 X]*[v2 Y] - [v1 Y]*[v2 X]]; 
	
	return newVector;
}

@end
