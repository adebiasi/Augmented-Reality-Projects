//
//  Timer.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 05/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Camera.h"
#import "GPSController.h"
#import "EAGLView.h"
#import <CoreLocation/CoreLocation.h> 
#import <CoreLocation/CLLocationManagerDelegate.h> 


@class OpenGLES13AppDelegate;



@interface GPSController : NSObject <CLLocationManagerDelegate> {

	@public
	OpenGLES13AppDelegate *mainDel;
	NSTimer *time;
	
	CLLocationManager *locmanager;
	
}

@property (nonatomic, retain)  OpenGLES13AppDelegate *mainDel;
@property (nonatomic, retain)  NSTimer *time;
@property (nonatomic, retain)  CLLocationManager *locmanager;

//- (Vec4*)geodeticToCartesian: (double)latitude Longitude: (double)longitude Elevation: (double)metersElevation ;

//- (Vec4*)geodeticToCartesian: (LatLon* )coord ;

- (void)printTest;
- (void)startAnimation;
-(double)getAltitudeWithoutGPS: (Vec4*) userPos;
@end
