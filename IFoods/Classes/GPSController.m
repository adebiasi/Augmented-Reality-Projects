//
//  Timer.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 05/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "GPSController.h"

#import "Camera.h"
#import "GPSController.h"
#import "EAGLView.h"
#import "LatLon.h"
#import "OpenGLES13AppDelegate.h"
#import <CoreLocation/CoreLocation.h> 
#import <CoreLocation/CLLocationManagerDelegate.h> 
#import "PlacesMngt.h"


#define equatorial_radius 6378137.0f
#define polar_radius 6356752.3f
#define es 0.00669437999013f

#define appros 100000;

@implementation GPSController

BOOL firstGPSRequest=TRUE;
PlacesMngt* placeContr;

@synthesize mainDel,time,locmanager;

-(GPSController*) init{
	  self = [super init];
	
	CLLocationManager *locman = [[CLLocationManager alloc] init]; 
	[locman setDelegate:self]; 
	[locman setDesiredAccuracy:kCLLocationAccuracyBest];
	[locman setDistanceFilter:kCLDistanceFilterNone];
	//[locman setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
	
	
	self.locmanager=locman;
	
	 return self;
}

- (void)printTest {
	
	}

- (void)refreshCamera {
	

	[self.locmanager startUpdatingLocation];
	
	
	}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
	NSLog(@"Error: %@", error);
	
	NSString *GPSerr = [NSString stringWithFormat: @"GPS Error:%@",error];	
	
	
	UIAlertView *alertNO = [[UIAlertView alloc] initWithTitle:nil message:GPSerr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
	[alertNO show]; 
	[alertNO release]; 
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
    // timeout that will stop the location manager to save power.
	
    if ([error code] != kCLErrorLocationUnknown) {
       // [self stopUpdatingLocation:NSLocalizedString(@"Error", @"Error")];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{ 
	CLLocationCoordinate2D loc = [newLocation coordinate];
	
//	CLLocationDistance dist = [newLocation getDistanceFrom:newLocation];
		double lat=loc.latitude;
	double lon=loc.longitude;
	double alt=newLocation.altitude;

	
	
	
	NSLog(@"alt:%f, acc:%f",alt,newLocation.verticalAccuracy);

//	NSLog(@"horizontalAcc:%f",newLocation.horizontalAccuracy);
	//LatLon *latLon =  [[LatLon alloc] initWithLatitude:10.0694 Longitude:10.0505 Altitude:0.0f];		

//	if(newLocation.horizontalAccuracy<=1000000){
	if(TRUE){
	
	LatLon *latLon = [[LatLon alloc] initWithLatitude:lat Longitude:lon Altitude:alt];	
	//		Vec4* vec=[Vec4 geodeticToCartesian:latLon->latitude Longitude:latLon->longitude Elevation:latLon->altitude];
	Vec4* vec=[Vec4 geodeticToCartesian:latLon->latitude Longitude:latLon->longitude Elevation:latLon->altitude isUser:TRUE userPos:NULL];
		
		
		
		if(firstGPSRequest==TRUE){
			NSLog(@"prima richiesta");
			placeContr =[[PlacesMngt alloc] init];
/*
			NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"Restaurant.xml"];		
			mainDel->glView->arrayPlaces=[arrayResults objectAtIndex:0];			
			mainDel->glView->graphContr->arrayTextureTextPlace=[mainDel->glView->graphContr getArrayPlaceText:mainDel->glView->arrayPlaces];
*/			
			
			/*
			PlacesMngt* placeContr =[[PlacesMngt alloc] init];
						
			
			NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"Restaurant.xml"];
			
			mainDel->glView->arrayPlaces=[arrayResults objectAtIndex:0];
			
			mainDel->glView->graphContr->arrayTextureTextPlace=[mainDel->glView->graphContr getArrayPlaceText:mainDel->glView->arrayPlaces];
			*/
			//NSLog(@"n° arrayPlaces: %i", [arrayPlaces count]);
			NSLog(@"n° arrayTextPlace: %i", [mainDel->glView->graphContr->arrayTextureTextPlace count]);
			
			
			if(alt==0){
			NSLog(@"alt è -1");
			NSLog(@"%f %f %f",vec->X,vec->Y,vec->Z);
		double approssAltitude=[self getAltitudeWithoutGPS:vec];
		
			NSLog(@"alt appros: %f",approssAltitude);
			
		latLon = [[LatLon alloc] initWithLatitude:lat Longitude:lon Altitude:approssAltitude];	
		//vec=[Vec4 geodeticToCartesian:latLon->latitude Longitude:latLon->longitude Elevation:approssAltitude];
			vec=[Vec4 geodeticToCartesian:latLon->latitude Longitude:latLon->longitude Elevation:approssAltitude isUser:TRUE userPos:NULL];
			
						}
			
			latLon->coord=vec;
			NSLog(@"LOCATION SET!!!!");
			mainDel->glView->camera.userLocation=latLon;
			mainDel->glView->camera.firstUserLocation=latLon;
			
			//PlacesMngt* placeContr =[[PlacesMngt alloc] init];
			
			
			placeContr->userLocation=mainDel->glView->camera->userLocation;
			placeContr->firstUserLocation=mainDel->glView->camera->userLocation;
			
			//NSMutableArray* arrayResults=[placeContr receiveArrayObjectsWithUserLocation:pos];
					///////////////// 
			
		//	PlacesMngt* placeContr =[[PlacesMngt alloc] init];
			
			NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"Restaurant.xml"];		
			mainDel->glView->arrayPlaces=[arrayResults objectAtIndex:0];			
			mainDel->glView->graphContr->arrayTextureTextPlace=[mainDel->glView->graphContr getArrayPlaceText:mainDel->glView->arrayPlaces];
			
			//NSLog(@"n° arrayPlaces: %i", [arrayPlaces count]);
			NSLog(@"n° arrayTextPlace: %i", [mainDel->glView->graphContr->arrayTextureTextPlace count]);
			
			 /////////////////////
			
			
			firstGPSRequest=FALSE;
		}else{
						NSLog(@"altra richiesta");
			vec=[Vec4 geodeticToCartesian:latLon->latitude Longitude:latLon->longitude Elevation:latLon->altitude isUser:FALSE userPos:mainDel->glView->camera->firstUserLocation->coord];
			latLon->coord=vec;
			mainDel->glView->camera.userLocation=latLon;
			placeContr->userLocation=mainDel->glView->camera->userLocation;
		
			if([mainDel->glView->arrayPlacemarks count]!=0){
				
				int startIndex=[mainDel->glView->worldContr findNearestDest2:mainDel->glView->arrayPlacemarks PosUser:latLon];
				mainDel->glView->worldContr->nextDestIndex=startIndex; 
			}
		}
		/*
		if(alt!=0){
	latLon->coord=vec;
	mainDel->glView->camera.userLocation=latLon;
		}
		*/
	mainDel->glView->camera.hAccuracy=newLocation.horizontalAccuracy;
		mainDel->glView->camera.vAccuracy=newLocation.verticalAccuracy;
		
		
	}	
	}

- (void)stopUpdatingLocation:(NSString *)state {
   
    [self.locmanager stopUpdatingLocation];
    self.locmanager.delegate = nil;
       
}


- (void)startAnimation {
	
	//NSTimeInterval animationInterval=1.0 / 60.0;
	//NSTimeInterval animationInterval=1000.0 ;
	
	/*
    self.time = [NSTimer scheduledTimerWithTimeInterval:animationInterval 
											target:self 
										 // selector:@selector(printTest)													 
				  selector:@selector(refreshCamera)													 
										  userInfo:nil 
										   repeats:YES];
	*/
	[self refreshCamera];
	
}

-(double)getAltitudeWithoutGPS: (Vec4*) userPos
{
	double minDistance=0;
	double returnAltitude=0;
	
	NSMutableArray* places = mainDel->glView->arrayPlaces;
	
	NSLog(@"NUM places: %i",[places count]);
	
	
	for(int i=0;i<[places count];i++){
		Place* currPlace = (Place*)[places objectAtIndex:i];
		Vec4* vecPlace= (currPlace)->coord;
		double currDistance=[Vec4 realDistanceVector1:vecPlace Vector2:userPos];
		
		if(minDistance==0){
			NSLog(@"if first returnAltitude %@ %f",currPlace->name, returnAltitude);
			minDistance=currDistance;
			returnAltitude=currPlace->altitude;
		}else if(currDistance<minDistance){
			minDistance=currDistance;
			returnAltitude=currPlace->altitude;
			NSLog(@"%@ returnAltitude %f",currPlace->name, returnAltitude);
		}
	}
	
	
	return returnAltitude;
	
}
-(void)dealloc
{
	// clean up everything.
	[super dealloc];
}

@end
