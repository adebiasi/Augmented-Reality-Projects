//
//  LatLon.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 06/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "LatLon.h"


@implementation LatLon

@synthesize latitude,longitude,altitude,name,coord;

-(LatLon*) init{
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

-(LatLon*) initWithLatitude: (double) lat Longitude: (double) lon Altitude:(double) alt{
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
