//
//  TouchListener.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 28/10/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "TouchListener.h"
#import "Camera.h"
#import "EAGLView.h"


@implementation TouchListener

#define equatorial_radius 6378137.0f
#define polar_radius 6356752.3f
#define es 0.00669437999013f
#define radianToDegrees(x) (180.0 * (x) / M_PI)

@synthesize glView;

double hfieldOfView = 60.0;
double vfieldOfView = 86.25;

CGPoint touchBegin;
CGPoint lastTouch;


- (void)handleTouches{
    	
    if (glView->currentMovement == MTNone) {
        // We're going nowhere, nothing to do here
        return;
    }
    
	/*
	 GLfloat vector[3];
	 
	 vector[0] = center[0] - eye[0];
	 vector[1] = center[1] - eye[1];
	 vector[2] = center[2] - eye[2];
	 */
    switch (glView->currentMovement) {
        case MTWalkForward:{
		//	[glView->camera Move:WALK_SPEED2];
		
			//[glView->camera setAzimuth:0.0];
			
			//[glView->camera Rotate:-TURN_SPEED rotY:0 rotZ:0];
			//GLfloat angl = glView->camera->angleView+TURN_SPEED;
			//GLfloat angl = 0;
					
			//glView->camera->angleView=angl;
			
			//[glView->camera setAngleView:angl];ù
			GLfloat angl = glView->camera->angleView+(TURN_SPEED*4);
			glView->camera->angleView=angl;
			break;
		}
        case MTWAlkBackward:
		{
		//	[glView->camera Move:-WALK_SPEED2];
			//GLfloat angl = 0.1;
			//[glView->camera setAzimuth:1.56];
         // GLfloat angl = glView->camera->angleView-0.0002;
			//[glView->camera Rotate:+TURN_SPEED rotY:0 rotZ:0];
			 //GLfloat angl = glView->camera->angleView-TURN_SPEED;
			
			//glView->camera->angleView=angl;
			
			//[glView->camera setAngleView:angl];
			GLfloat angl = glView->camera->angleView-(TURN_SPEED*4);
			glView->camera->angleView=angl;
			break;
		}
        case MTTurnLeft:
		{
			//GLfloat angl = glView->camera->angleView-TURN_SPEED;
			//GLfloat angl = 0.2;
			//[glView->camera Rotate:0 rotY:-TURN_SPEED rotZ:0];
			//[glView->camera Rotate:-TURN_SPEED rotY:0 rotZ:0];
          GLfloat angl = glView->camera->azimuth-(TURN_SPEED*4);
			glView->camera->azimuth=angl;
			//[glView->camera setAzimuth:2.36];
			//[glView->camera setAngleView:angl];
			break;
		}
        case MTTurnRight:
		{
			//GLfloat angl = 0.3;
		//	 GLfloat angl = glView->camera->angleView+TURN_SPEED;
			//[glView->camera Rotate:TURN_SPEED rotY:0 rotZ:0];
			//[glView->camera Rotate:TURN_SPEED rotY:0 rotZ:TURN_SPEED];
			//[glView->camera Rotate:0 rotY:TURN_SPEED rotZ:0];
			 GLfloat angl = glView->camera->azimuth+(TURN_SPEED*4);
			glView->camera->azimuth=angl;
			//[glView->camera setAzimuth:0.78];
     //   [glView->camera setAngleView:angl];
			break;
		}
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//NSLog(@"touchesBegan");
	
	
	NSMutableArray* selectedPlaces = [[NSMutableArray alloc]init];
	
	UITouch *t = [[touches allObjects] objectAtIndex:0];
	CGPoint touchPos = [t locationInView:t.view];
	if(glView->camera->isRadar==TRUE){
		lastTouch=touchPos;
	touchBegin=touchPos;
	}
	// Detirmine the location on the screen. We are interested in iPhone Screen co-ordinates only, not the world co-ordinates
	//  because we are just trying to handle movement.
	//
	// (0, 0)
	//	+-----------+
	//  |           |
	//  |    160    |
	//  |-----------| 160
	//  |     |     |
	//  |     |     |
	//  |-----------| 320
	//  |           |
	//  |           |
	//	+-----------+ (320, 480)
	//
	//	NSLog(@" touch x:%f y:%f",touchPos.x,touchPos.y);
		
	CGPoint touchAngle = [self convertPoint2Angles:touchPos];
	
	LatLon* userPos = glView->camera->userLocation;
	GLfloat userHAngle =glView->camera->azimuth*180/M_PI_2;	
	GLfloat userVAngle =glView->camera->angleView*180/M_PI_2;
	
	for (int j=0; j < [glView->arrayPlaces count]; j++){

		Place* currPlace = [glView->arrayPlaces objectAtIndex:j];
		//NSLog(@"clicco su %@",currPlace->name);

	double azim2 = [glView->worldContr rhumbAzimuthP1lat:userPos->latitude P1lon:userPos->longitude P2lat:currPlace->latitude P2lon:currPlace->longitude];
		double azim = [glView->worldContr ellipsoidalForwardAzimuthP1Lat:userPos->latitude P1Lon:userPos->longitude P2Lat:currPlace->latitude P2Lon:currPlace->longitude EquatorialRadius:equatorial_radius PolarRadius:polar_radius];	
		if(azim<0){
			azim=(360+azim);
		}	
		if(azim2<0){
			azim2=(360+azim2);
		}	
		
		//NSLog(@"az1: %f az2:%f",azim,azim2);
		//double diff=fabs(azim-p2);		
		
		double hAngle = azim - userHAngle;
		//angle is visible if it is less than 30 and more than -30 (60 degree)
		
			
		
		//double h = fabs(userPos->altitude-currPlace->altitude);		
		double h = userPos->altitude-currPlace->altitude;		
		double ip = [Vec4 realDistanceVector1:userPos->coord Vector2:currPlace->coord];
		double cat = sqrt(ip*ip-h*h);		
		double rapp = cat/ip;		
		//double rapp = 5/7;		
		double alphaAngle = acos(rapp);
		double degAlphaAngle=radianToDegrees(alphaAngle);
		
		if(h>0)	{
			degAlphaAngle=-degAlphaAngle;
		}
		
		double vAngle = degAlphaAngle - userVAngle;
		
		//NSLog(@"name %@ h %f alphaAngle %f vAngle %f",currPlace->name, h,degAlphaAngle,vAngle);
		//////////
		if(hAngle>180){
			hAngle=hAngle-360;
		}
		//////////
		double vDiff=fabs(touchAngle.y-vAngle);
		double hDiff=fabs(touchAngle.x-hAngle);
		
		
//		NSLog(@"%@ hDiff:%f= diff(touchAngle.x %f hAngle %f",currPlace->name,hDiff,touchAngle.x,hAngle);
//		NSLog(@"%@ vDiff:%f= diff(touchAngle.y %f vAngle %f",currPlace->name,vDiff,touchAngle.y,vAngle);
		//NSLog(@"alphaAngle %f ,userVAngle %f",degAlphaAngle,userVAngle);
		//NSLog(@"name:%@ anglevDiff %f ,anglehDiff %f",currPlace->name,vDiff,hDiff);
		//NSLog(@"name:%@ angleOrrizzDiff %f =azim %f - user  %f",currPlace->name,hAngle,azim,userHAngle);
		//NSLog(@"userHAngle:%f hAngle:%f",userHAngle,hAngle);
		//NSLog(@"azim:%f user:%f",azim,userHAngle);
		if(vDiff<10){
			NSLog(@"vdiff ok");
		}
		if(hDiff<10){
			NSLog(@"hdiff ok");
		}
		//if((vDiff<10)&((hDiff<10)|(hDiff>350))){
		if((vDiff<10)&(hDiff<10)){
		//if((vDiff<10)){
			[selectedPlaces addObject:currPlace];
		//	NSLog(@"clicco su %@",currPlace->name);
		}
		//NSLog(@"userVAngle %f alphaAngle %f",userVAngle,alphaAngle);
		//NSLog(@"yAngle %f xAngle %f",vAngle,hAngle);
		//NSLog(@"place %@ horiz %f",currPlace->name, hAngle);
		//NSLog(@"place %@ VAngle %f userVAngle %f",currPlace->name, VAngle, userVAngle);
	}	
	if([selectedPlaces count]>0){
	glView->detailsView.hidden=FALSE;
	
	//glView->detailsView->table->selectedPlaces=glView->arrayPlaces;
		glView->detailsView->table->selectedPlaces=selectedPlaces;
		[glView->detailsView->table reloadData];
	
		
	
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	UIView *theWindow = [glView->detailsView superview];

	[[theWindow layer] addAnimation:animation forKey:@"SwitchToDetailsView"];
	 }
	//[animation release];
	//[theWindow release];
	/*
	if (touchPos.y < 160) {
	
		// We are moving forward
		glView->currentMovement = MTWalkForward;
		
	} else if (touchPos.y > 320) {
		// We are moving backward
		glView->currentMovement = MTWAlkBackward;
		
	} else if (touchPos.x < 160) {
		// Turn left
		glView->currentMovement = MTTurnLeft;
	} else {
		// Turn Right
		glView->currentMovement = MTTurnRight;
	}
	 */
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	NSLog(@"touchesEnded");
	glView->currentMovement = MTNone;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
//	NSLog(@"touchesMoved");
	if(glView->camera->isRadar==TRUE){
	
	UITouch *t = [[touches allObjects] objectAtIndex:0];
	CGPoint touchPos = [t locationInView:t.view];
	
	//double distance = touchPos.y-touchBegin.y;
		double distance = touchPos.y-lastTouch.y;
		
		double bigDistance=distance*50;
		
	//	if(bigDistance<-400){
	//		bigDistance=-400;
	//	}
	//	double diffDistance=distance-lastDistance;
//	NSLog(@"prima: %f adesso: %f",lastTouch.y,touchPos.y);
	//NSLog(@"distance: %f coeff: %f",distance,glView->camera->coeff_Radar);
		if(glView->camera->coeff_Radar>500){
			if(glView->camera->coeff_Radar+bigDistance>0){
			NSLog(@"big distance %f",bigDistance);
		glView->camera->coeff_Radar=glView->camera->coeff_Radar+bigDistance;
			
			}
			lastTouch=touchPos;
				
		}else if(glView->camera->coeff_Radar+distance>0){
			NSLog(@"little distance");
			glView->camera->coeff_Radar=glView->camera->coeff_Radar+distance;
			
			lastTouch=touchPos;
		
		}
		}
}

-(CGPoint) convertAngles2Point: (CGPoint) angles{
	
	double height=[self->glView frame].size.height;
	double width=[self->glView frame].size.width;

	double pointX = ((angles.x+hfieldOfView/2)/hfieldOfView)*width;
	double pointY = ((-angles.y+vfieldOfView/2)/vfieldOfView)*height;
	CGPoint res = CGPointMake(pointX, pointY);
	
	return res;
}
-(CGPoint) convertPoint2Angles: (CGPoint) point{
	
	CGRect windowRect = [[UIScreen mainScreen] applicationFrame];
	
	//double height=self->glView.bounds.size.height;
	//double width=self->glView.bounds.size.width;
	
	
	double height=windowRect.size.height;
	double width=windowRect.size.width;
	
	
	double x1= point.x-(width/2);	
	double xAngle = (x1/(width/2))*hfieldOfView/2;
	
	double y1= point.y-(height/2);	
	double yAngle = -(y1/(height/2))*vfieldOfView/2;
	
	//NSLog(@"xAngle %f",xAngle);
	//NSLog(@"yAngle %f",yAngle);
	CGPoint res = CGPointMake(xAngle, yAngle);
	
	return res;	
	
}


@end
