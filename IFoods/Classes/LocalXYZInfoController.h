//
//  LocalXYZInfoController.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 16/12/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LatLon.h"



@interface LocalXYZInfoController : NSObject {
@public
	LatLon* userLocation;
	LatLon* firstUserLocation;
	
}

- (NSMutableArray*) receiveArrayObjectsWithDestination: (NSString*) dest UserLocation: (LatLon*)userLoc;
- (NSMutableArray*) receiveArrayObjectsWithLatDest: (double) latDest LonDest: (double) lonDest UserLocation: (LatLon*)userLoc;
- (NSMutableArray*) getArrayObjectsWithName: (NSString*) name;

@end
