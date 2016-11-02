//
//  Vec4.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 17/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface Vec4 : NSObject {

	@public
	double X;
    double Y;
    double Z;
	
	double realX;
    double realY;
    double realZ;
	
}

@property(readwrite, assign) double X;
@property(readwrite, assign) double Y;
@property(readwrite, assign) double Z;

@property(readwrite, assign) double realX;
@property(readwrite, assign) double realY;
@property(readwrite, assign) double realZ;

-(Vec4*) init;
-(Vec4*) initX: (double) x Y: (double) y Z:(double) z;

+(double) realDistanceVector1: (Vec4*) vector1 Vector2: (Vec4*) vector2;
+(double) distanceVector1: (Vec4*) vector1 Vector2: (Vec4*) vector2;
-(Vec4*) minus: (Vec4*) vector;
+(Vec4*) mix: (double)amount Vector1: (Vec4*) vector1 Vector2: (Vec4*) vector2;
+(Vec4*) mixReal: (double)amount Vector1: (Vec4*) vector1 Vector2: (Vec4*) vector2;
+ (Vec4*)geodeticToCartesian: (double)latitude Longitude: (double)longitude Elevation: (double)metersElevation;
+ (Vec4*)geodeticToCartesian: (double)latitude Longitude: (double)longitude Elevation: (double)metersElevation isUser: (BOOL) isUser userPos: (Vec4*) userPos;
//-(GLfloat) Round: (GLfloat) n dec: (int)decimal_places;
@end
