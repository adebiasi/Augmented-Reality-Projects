//
//  LatLon.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 06/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Vec4.h"

@interface LatLon : NSObject {
	
	NSString* name;
	
	@public
	double latitude;
    double longitude;
    double altitude;
	Vec4* coord;
}


@property(readwrite, assign) double latitude;
@property(readwrite, assign) double longitude;
@property(readwrite, assign) double altitude;
@property(readwrite, assign) NSString* name;
@property(readwrite, assign) Vec4* coord;


-(LatLon*) init;

-(LatLon*) initWithLatitude: (double) latitude Longitude: (double) longitude Altitude:(double) altitude;


@end
