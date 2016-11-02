//
//  Place.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 12/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vec4.h"

@interface Place : NSObject {
@public
	NSString* name;
	NSString* address;
	

	double latitude;
    double longitude;
    double altitude;
	Vec4* coord;
}


@property(readwrite, assign) double latitude;
@property(readwrite, assign) double longitude;
@property(readwrite, assign) double altitude;
@property(readwrite, assign) NSString* name;
@property(readwrite, assign) NSString* address;
@property(readwrite, assign) Vec4* coord;


-(Place*) init;

-(Place*) initWithLatitude: (double) latitude Longitude: (double) longitude Altitude:(double) altitude;
@end