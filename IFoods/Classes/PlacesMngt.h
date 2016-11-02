//
//  PlacesMngt.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 12/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "LatLon.h"


@interface PlacesMngt : NSObject {

	@public
	LatLon* userLocation;
	LatLon* firstUserLocation;
}

- (NSMutableArray*) receiveArrayObjectsWithUserLocation: (LatLon*)userLoc;
- (NSMutableArray*) getArrayObjectsWithName: (NSString*) name;

-(NSString *)pathToDataFile;
@end
