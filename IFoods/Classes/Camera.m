//
//  Camera.m
//  NeHe Lesson 04
//
//  Created by Raffaele De Amicis on 21/10/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "Camera.h"
#import "Vec4.h"
#import "gluLookAt.h"
#import "GraphicController.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@implementation Camera

@synthesize m_vUpVector,m_vPosition,m_vView,m_voriginalView,userLocation,vAccuracy,hAccuracy,firstUserLocation;

-(Camera*) init{
	
    self = [super init];
	
	self->userLocation=[[LatLon alloc] init];
	self->firstUserLocation=[[LatLon alloc] init];
	
	
	//[[GLView alloc] initWithFrame:rect];
	self->m_vUpVector = [[Vec4 alloc] init]; 
	self->m_vPosition = [[Vec4 alloc] init]; 
	self->m_vView = [[Vec4 alloc] init]; 
	
	self->m_voriginalView = [[Vec4 alloc] init]; 

	self->isRadar=0;
	
	//self->coeff_Radar=100.0f;
	self->coeff_Radar=100.0f;
	
	//Convert Degrees to Radians formula (all floats)
	double degs = 0;	
	double PI = 3.14159265	;
	double rads = degs * PI / 180.0;
	
	for (int i=0; i<32; i++) {		
		
		rads = degs * PI / 180.0;
  	
		self->cos_table[i] = cosf(rads);
		self->sin_table[i] = sinf(rads);
		
		degs = degs + 11.25;
	
	} 
	
	/*
	[self->m_vPosition setX:-46];	
	[self->m_vPosition setY:1.5];
	[self->m_vPosition setZ:11.1]; 
	*/
	
	[self->m_vPosition setX:0.5];	
	[self->m_vPosition setY:1.5];
	[self->m_vPosition setZ:0]; 
	
	/*
	[self->m_vView setX:0.388];
	[self->m_vView setY:1.5];
	[self->m_vView setZ:-13.42]; 
	*/	
	[self->m_vView setX:0];
	[self->m_vView setY:1.5];
	[self->m_vView setZ:0]; 
	
	
	[self->m_vUpVector setX:0];
	[self->m_vUpVector setY:1];
	[self->m_vUpVector setZ:0]; 
	
	
	[self->m_voriginalView setX:-50];
	[self->m_voriginalView setY:1.5];
	[self->m_voriginalView setZ:50.0]; 
	/*
	[self->m_voriginalView setX:0];
	[self->m_voriginalView setY:1.5];
	[self->m_voriginalView setZ:0.0];
*/
	 return self;
}


-(void) PositionX: (GLfloat)X positionY:(GLfloat)Y  positionZ:(GLfloat)Z 	
			viewX:(GLfloat)vX   viewY:(GLfloat)vY   viewZ:(GLfloat)vZ   
		upvectorX:(GLfloat)uX upvectorY:(GLfloat)uY upvectorZ:(GLfloat)uZ{

	Vec4 *vPosition = [[Vec4 alloc] initX: X Y: Y Z:Z];	
	Vec4 *vView = [[Vec4 alloc] initX: vX Y: vY Z:vZ];	
	Vec4 *vUp = [[Vec4 alloc] initX: uX Y: uY Z:uZ];
			
	[self setM_vView:vView]; 
	[self setM_vUpVector: vUp]; 
	[self setM_vPosition: vPosition]; 
	
}

-(void) Move: (GLfloat)speed{
	
	Vec4 *vVector = [[Vec4 alloc] init]; 
	
	
	vVector = [m_vView minus:m_vPosition]; 
GLfloat newPx = [m_vPosition X] + [vVector X] * speed ;	
	[m_vPosition setX:newPx];
		
	//m_vPosition.z += vVector.z * speed; 
	GLfloat newPz = [m_vPosition Z] + [vVector Z] * speed ;	
	[m_vPosition setZ:newPz];
	
	//m_vView.x += vVector.x * speed; 
	GLfloat newVx = [m_vView X] + [vVector X] * speed ;	
	[m_vView setX:newVx];
	
	//m_vView.z += vVector.z * speed; 
	GLfloat newVz = [m_vView Z] + [vVector Z] * speed ;	
	[m_vView setZ:newVz];
	
	
}



-(void) Rotate: (GLfloat)rX rotY:(GLfloat)rY rotZ:(GLfloat)rZ{
	
	
	Vec4 *vVector = [[Vec4 alloc] init];
	
	vVector = [m_vView minus:m_vPosition]; 
	
	
	if(rX) { 
		
		GLfloat newVz = [m_vPosition Z] + sin(rX)*[vVector Y] + cos(rX)* [vVector Z]; 
		[m_vView setZ:newVz];
		
		GLfloat newVy = [m_vPosition Y] + cos(rX)*[vVector Y] - sin(rX)*[vVector Z]; 
		[m_vView setY: newVy];
	} 
	if(rY) {
		
		GLfloat newVz = [m_vPosition Z] + sin(rY)*[vVector X] + cos(rY)* [vVector Z]; 
		[m_vView setZ:newVz];
		GLfloat newVx = [m_vPosition X] + cos(rY)*[vVector X] - sin(rY)*[vVector Z]; 
		[m_vView setX: newVx];
		
	} 
	if(rZ) { 
		GLfloat newVx = [m_vPosition X] + sin(rZ)*[vVector Y] + cos(rZ)* [vVector X]; 
		[m_vView setX:newVx];
		GLfloat newVy = [m_vPosition Y] + cos(rZ)*[vVector Y] - sin(rZ)*[vVector X]; 
		[m_vView setY: newVy];
	} 
	
	}


-(void) setAzimuth: (double)rY {
		
	//if(rY!=self->azimuth){
				
		Vec4 *vVector = [[Vec4 alloc] init];
		
		vVector = [m_voriginalView minus:m_vPosition]; 
	
	double newVx = [m_vPosition X] + cos(rY)*[vVector X] - sin(rY)*[vVector Z]; 
	double newVz = [m_vPosition Z] + sin(rY)*[vVector X] + cos(rY)* [vVector Z]; 
		
	[m_vView setX: newVx];
	[m_vView setZ: newVz];
	
	
}

-(void) setAngleView: (double)angle {
		
	if(angle>M_PI_2){
		angle=M_PI_2;
	}
	if(angle<-M_PI_2){
		angle=-M_PI_2;
	}
	
	
		
		Vec4 *vVector = [[Vec4 alloc] init];
		
		vVector = [m_voriginalView minus:m_vPosition]; 
		
		double newVy = [m_vPosition Y] + cos(angle)*[vVector Y] - sin(angle)*[vVector Z]; 				
		double newVz = [m_vPosition Z] + sin(angle)*[vVector Y] + cos(angle)*[vVector Z]; 
		
		[m_vView setY: newVy];
		[m_vView setZ: newVz];
	
}


-(void) refreshAzimuth {	
	[self setAzimuth:self->azimuth];	
}

-(void) refreshAngleView {	
		[self setAngleView:self->angleView];
	
}

-(void) refreshCameraView {	
	
	Vec4 *vVector = [[Vec4 alloc] init];
	vVector = [m_voriginalView minus:m_vPosition]; 
	
	double rY=self->azimuth; 
	
	double newVz = [m_vPosition Z] + sin(rY)*[vVector X] + cos(rY)* [vVector Z]; 	
	double newVx = [m_vPosition X] + cos(rY)*[vVector X] - sin(rY)*[vVector Z]; 
	
		[m_vView setX: newVx];
		[m_vView setZ:newVz];

}

-(void) setLatLon: (LatLon*)latLon {

	Vec4 *XYZ=[GraphicController convertInXYZ:latLon];
	[self setM_vPosition:XYZ];

}

-(void) DoViewTransform2{
	
double angle=self->angleView; 
	glRotatef(-angle*180/M_PI_2, 1, 0, 0);
	
	double angle2=self->azimuth+self->calibrate; 
	glRotatef(angle2*180/M_PI_2, 0, 1, 0);
	
}

-(void) DoRadarViewTransform{
	
	double angle2=self->azimuth+self->calibrate; 
	glRotatef(0*180/M_PI_2, 0, 1, 0);
	glRotatef(angle2*180/M_PI_2, 0, 0, 1);

	
}

-(void) DoViewTransform{
	
	
	GLfloat posX=[m_vPosition X];
	GLfloat posY=[m_vPosition Y];
	GLfloat posZ=[m_vPosition Z];
	
	GLfloat viewX=[m_vView X];
	GLfloat viewY=[m_vView Y];
	GLfloat viewZ=[m_vView Z];

	GLfloat upX=[m_vUpVector X];
	GLfloat upY=[m_vUpVector Y];
	GLfloat upZ=[m_vUpVector Z];
	
gluLookAt(posX , posY, posZ,viewX,viewY, viewZ,upX,upY, upZ); 	
	//gluLookAt(0 , 0, 0,0,0, 0,0,0, 0); 	
}

- (void)dealloc {
    
	
   [super dealloc];
}

-(void) setHAccuracy: (CLLocationAccuracy)acc{

	self->hAccuracy=acc;
}

@end
