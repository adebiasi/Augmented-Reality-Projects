//
//  Place.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 12/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import "Place.h"


#define equatorial_radius 6378137.0f
#define polar_radius 6356752.3f
#define es 0.00669437999013f

#define appros 100000;


@implementation Place
@synthesize latitude,longitude,altitude,name,coord,address;

-(Place*) init{
    self = [super init];
	
    if ( self ) {
		
		coord= [[Vec4 alloc] init];
		
		
		coord.X=5;
		coord.Y=5;
		coord.Z=5;
		
        [self setLatitude: 0];
		[self setLongitude: 0];
		[self setAltitude: 0];
    }
	
    return self;
}

-(Place*) initWithLatitude: (double) lat Longitude: (double) lon Altitude:(double) alt{
    self = [super init];
	
    if ( self ) {
		coord= [[Vec4 alloc] init];
		
		coord.X=5;
		coord.Y=5;
		coord.Z=5;
		
		
		
        [self setLatitude: lat];
		[self setLongitude: lon];
	[self setAltitude: alt];    }
	
    return self;
}

- (void)dealloc {
    
	
	[super dealloc];
}


@end
