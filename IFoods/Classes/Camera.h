//
//  Camera.h
//  NeHe Lesson 04
//
//  Created by Raffaele De Amicis on 21/10/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vec4.h"
#import "LatLon.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <CoreLocation/CoreLocation.h>


@interface Camera : NSObject {

	
	Vec4* m_voriginalView;      // indica il punto di vista (la direzione)
	
	Vec4* m_vPosition;  // posizione della camera 
	Vec4* m_vView;      // indica il punto di vista (la direzione)
	Vec4* m_vUpVector;  // indica la direzione up 
	
	
	
	@public
	LatLon* userLocation;
	LatLon* firstUserLocation;
	double azimuth;
	//GLfloat angleView;
	double angleView;
	
	GLfloat calibrate;	
	CLLocationAccuracy hAccuracy;
	CLLocationAccuracy vAccuracy;
	//GLfloat accuracy;
	
	NSTimeInterval refreshCompassInterval;
	NSTimeInterval refreshVirtualViewInterval;
	
	
	
	int isRadar;
	GLfloat coeff_Radar;	
	
	double y_angle;
	
	GLfloat cos_table[32];
	GLfloat sin_table[32];
}

@property(readwrite, assign) Vec4* m_vPosition;
@property(readwrite, assign) Vec4* m_vView;
@property(readwrite, assign) Vec4* m_vUpVector;
@property(readwrite, assign) Vec4* m_voriginalView;

@property(readwrite, assign) LatLon* userLocation;
@property(readwrite, assign) LatLon* firstUserLocation;
@property(readwrite, assign) CLLocationAccuracy hAccuracy;
@property(readwrite, assign) CLLocationAccuracy vAccuracy;

-(Camera*) init;

-(void) PositionX: (GLfloat)X positionY:(GLfloat)Y  positionZ:(GLfloat)Z  
			viewX:(GLfloat)vX   viewY:(GLfloat)vY   viewZ:(GLfloat)vZ   
		upvectorX:(GLfloat)uX upvectorY:(GLfloat)uY upvectorZ:(GLfloat)uZ; 
-(void) Move: (GLfloat)speed; 
-(void) Rotate:(GLfloat)X rotY:(GLfloat)Y rotZ:(GLfloat)Z; 
-(void) DoViewTransform; 
-(void) DoViewTransform2; 
-(void) DoRadarViewTransform;


-(void) setAzimuth: (double)rY;
-(void) setAngleView: (double)angle;
-(void) setLatLon: (LatLon*)latlon;
-(void) setHAccuracy: (CLLocationAccuracy)hAcc;


-(void) refreshAzimuth ;
-(void) refreshAngleView ;
-(void) refreshCameraView ; 

@end
