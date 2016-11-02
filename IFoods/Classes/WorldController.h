//
//  WorldController.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 17/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
//#import "Vector3.h"
#import "Vec4.h"
#import "LatLon.h"
#import "Place.h"
#import "GraphicController.h"
#import "Camera.h"
//#import "EAGLView.h"
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import <CoreLocation/CoreLocation.h>

@interface WorldController : NSObject {
@public
	
	
	GraphicController *graphContr;
	Camera *cameraClass;
	
//	EAGLView *eaglView;
	
	GLfloat orizAngle ;
	GLfloat vertAngle;
	
	GLfloat countXAngle;
	GLfloat countYAngle;
	GLfloat countZAngle;
	
	LatLon* destination;
	LatLon* nextDestination;
	int nextDestinationIndex;
	int nextDestIndex;
}

//- (Vec4*)geodeticToCartesian: (double)latitude Longitude: (double)longitude Elevation: (double)metersElevation ;


//- (LatLon*)cartesianToGeodetic: (Vec4* )cart;

//- (void) insertObject: (LatLon*)position;
//- (void) insertArrayObjects: (NSArray*) arrayPosition;

//- (void) insertStartPath2: (LatLon*) start EndPath: (LatLon*) endLatLon;
//- (void) insertStartPath3: (LatLon*) start EndPath: (LatLon*) endLatLon;
//- (void) insertStartCylinder: (LatLon*) start EndCylinder: (LatLon*) end;
//- (void) insertStartCylinder2: (LatLon*) start EndCylinder: (LatLon*) end;
//- (void) insertStartRectangle: (LatLon*) start EndRectangle: (LatLon*) end;
- (void) insertNearStartRectangle: (LatLon*) start EndRectangle: (LatLon*) end Distance: (double)shortDistance;


-(bool) isVisible: (double) angle AngleCamera: (double) camera;

-(double) rhumbAzimuthP1: (LatLon*) p1 P2: (LatLon*) p2;
-(double) rhumbAzimuthP1lat: (double) p1lat P1lon: (double) p1lon P2lat: (double) p2lat P2lon: (double) p2lon;

- (void) insertArrayPath: (NSArray*) arrayPosition AngleCamera: (double) angle;

- (void) insertArrayStreet: (NSArray*) arrayPosition AngleCamera: (double) angle;
- (void) insertStartLine: (LatLon*) start EndLine: (LatLon*) end;



-(void) drawLittleCompass: (Vec4*) center CompassAngle: (double) compassAngle Angle: (double) angle;
-(double) ellipsoidalForwardAzimuthP1Lat: (double) fromLat P1Lon: (double) fromLon P2Lat: (double) toLat P2Lon: (double) toLon EquatorialRadius: (double) eqRad PolarRadius: (double) polRad;

//radarView
- (void) insertInRadarArrayPlacemark: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle Distance: (double) distance;
- (void) insertInRadarArrayPath: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle Distance: (double) distance;
- (void) insertInRadarArrayPlaces: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle Distance: (double) distance;
- (void) insertInRadarPlace: (Place*) place Distance: (double) distance;
- (void) insertInRadarIconDestination: (LatLon*) destLatLon Distance: (double) distance;
//non usata
	- (void) insertInRadarDestination: (LatLon*) destLatLon Distance: (double) distance;
- (void) insertInRadarUser: (LatLon*) userLatLon Distance: (double) distance;
- (void) insertInRadarStartRectangle: (LatLon*) start EndRectangle: (LatLon*) end CameraDistance: (double) distance Color: (CGColorRef) color;
//- (Vec4*)geodeticToCartesian: (LatLon* )coord ;
-(void) DrawCircle: (int) circleSegments Size: (CGFloat) circleSize Center: (Vec4*) center Filled : (bool) filled ;


//Normal View
- (void) insertArrayPlacemark: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle;
- (void) insertArrayPath: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle;
- (void) insertArrayPlaces: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angleCamera;
-(void) insertPlace: (Place*)place UserPos:(LatLon*) latlonUser Index:(NSInteger) indexPlace;
-(void) insertRealPlace: (Place*)place UserPos:(LatLon*) latlonUser;
-(Vec4*) calculateNearPosition: (Vec4*) user ObjectPosition: (Vec4*) object;

-(int) findNearestDest2: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser;
-(int) findNearestDest: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser;
- (void) insertStartPath: (LatLon*) start EndPath: (LatLon*) end;
-(void) insertPlacemark: (LatLon*) placemark;


@end
