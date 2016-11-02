//
//  GraphicController.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 05/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "GraphicController.h"
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import "Vec4.h"
#import "LatLon.h"
#import <CoreLocation/CoreLocation.h>
#import "Texture2D.h"

@implementation GraphicController

#define kFontName					@"Arial"
#define infoDistance 1
#define infoScale 0.005f
#define infoHeight 100
#define infoWidth 100
//#define kLabelFontSize				15
//#define kLabelFontSize				8
#define kLabelFontSize				11
Texture2D* _textures[1];
//Texture2D* _textures2[1];
Texture2D* _texturesImages[2];
int testVariable = 0;

const GLfloat floorVertices[] = {-1.0, 1.0, 0.0,     -1.0, -1.0, 0.0,    1.0, -1.0, 0.0,   1.0, 1.0, 0.0     };
const GLfloat floorTC[] = {0.0, 1.0,0.0, 0.0,1.0, 0.0,1.0, 1.0};
const GLfloat quadVertices[] = {-1.0f,  1.0f, 0.0f,
1.0f,  1.0f, 0.0f,
1.0f, -1.0f, 0.0f,
-1.0f, -1.0f, 0.0f};
const GLfloat quadVerticesColors[] = {1.0f, 0.0f, 0.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f,  0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f, 1.0f  };
const GLfloat triVertices[] = { 0.0f, 1.0f, 0.0f, -1.0f, -1.0f, 0.0f, 1.0f, -1.0f, 0.0f }; 
const GLfloat triVertexColors[] = {1.0f, 0.0f, 0.0f, 1.0f,  0.0f, 1.0f, 0.0f, 1.0f,  0.0f, 0.0f, 1.0f, 1.0f  };
const GLfloat cubeVertices[] = {-1.0, 1.0, 1.0, -1.0, -1.0, 1.0,1.0, -1.0, 1.0,   1.0, 1.0, 1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0,1.0, 1.0, 1.0, 1.0, 1.0, -1.0,1.0, 1.0, -1.0, 1.0, -1.0, -1.0,   -1.0, -1.0, -1.0,   -1.0, 1.0, -1.0,-1.0, -1.0, 1.0,
1.0, -1.0, 1.0,1.0, -1.0, -1.0,-1.0, -1.0, -1.0,-1.0, 1.0, -1.0, -1.0, 1.0, 1.0,  -1.0, -1.0, 1.0, -1.0, -1.0, -1.0,1.0, 1.0, 1.0, 1.0, 1.0, -1.0,1.0, -1.0, -1.0,1.0, -1.0, 1.0  };    

- (void)locateRadarObject: (CLLocationDistance)dist Angle: (GLfloat)angle radarCoeff:(GLfloat)coeff{
	
	
	
	dist=dist*coeff;
	
	GLfloat radiants=angle * M_PI / 180;	
//		GLfloat radiants=angle;	
	float distance=dist;	
	//float cos = acosf(radiants);
	float cosin = cosf(radiants);
	GLfloat diffX = distance*cosin;
	
	GLfloat diffY = sqrtf((distance*distance)-(diffX*diffX));
	
	if(radiants>M_PI){
		diffY=-diffY;
	}
		int size=2;
	
	if(dist==0){
	
	}else{
	
		//glColor4f(1,0,0,1);
		
	}
	
	
	//glDisable(GL_TEXTURE_2D);

	// render our text
	//glLoadIdentity();
	glPushMatrix();	
	glTranslatef(diffX,diffY,-4);
	//glRotatef(45, 0, 0, 1);
	
	
	
	GLfloat vertices[720];	
	for (int i = 0; i < 720; i += 2) {
		// x value
		GLfloat rad=i * M_PI / 180;
		vertices[i]=(cos(rad)*size);	// y value
		//GLfloat radiants2=i * M_PI / 180;
		vertices[i+1]=(sin(rad) * size);
		
		/*
		 vertices[i]=(cos((i))*1);	// y value
		 vertices[i+1]=(sin((i)) * 1);
		 */
	}
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glEnableClientState(GL_VERTEX_ARRAY);	
	//glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
	if(dist==0){
			glColor4f(0,1,0,1);
	}else{
		glColor4f(1,0,0,1);
		
	}
	glDrawArrays(GL_TRIANGLE_FAN, 0, 360);
	///////////
	//	glEnable(GL_TEXTURE_2D);
	
	///
	glPopMatrix();
}


- (void)drawObjectX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z  {
	glPushMatrix();	
	glTranslatef(x,y,z);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState (GL_COLOR_ARRAY);
	glColorPointer (4, GL_FLOAT, 0, quadVerticesColors);
	glVertexPointer(3, GL_FLOAT, 0, quadVertices);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4); 
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState (GL_COLOR_ARRAY);
	glPopMatrix();
	
}

- (void)drawInfo: (NSString*) info {

	float shadowColor[4] = {0.0,0.0,0.0,1.0};
	
   _textures[0]  = [[Texture2D alloc] initWithString:info
						//		  dimensions:CGSizeMake(50, 50)
						  dimensions:CGSizeMake(1, 1)
								   alignment:UITextAlignmentLeft
										font:[UIFont fontWithName:@"Helvetica" size:kLabelFontSize]
								shadowOffset:CGSizeMake(1.0,-1.0)
								  shadowBlur:0.0
								 shadowColor:shadowColor];
	
	
	
	//NSString* testString = [NSString stringWithFormat: @"distance: %i", 122]; // increase our counterNSString* testString = [NSString stringWithFormat: info]; // increase our counter
	
	/////_textures[0] = [[Texture2D alloc] initWithString:info dimensions:CGSizeMake(100, 30) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
		
	//glColor4f(1,1,1,1);
	//glColor4f(1,0,0,1);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);	
	glEnable(GL_BLEND);	
	glEnable(GL_TEXTURE_2D);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//glColor4f(1,0,1,1);
	//NSDate *now = [NSDate date];
	[_textures[0] drawAtPoint:CGPointMake(0,0)];
	//NSTimeInterval since = [now timeIntervalSinceNow];
	//NSLog([NSString stringWithFormat:@"[_textures[0] drawAtPoint:CGPointMake(0,0)];: %f", since]); 
	
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	//[_textures[0] release];
	[_textures[0] dealloc];
}

- (void)drawPlaceInfo: (NSInteger) placeIndex {
	
	/*
	float shadowColor[4] = {0.0,0.0,0.0,1.0};
	
	_textures[0]  = [[Texture2D alloc] initWithString:info
					 //		  dimensions:CGSizeMake(50, 50)
										   dimensions:CGSizeMake(1, 1)
											alignment:UITextAlignmentLeft
												 font:[UIFont fontWithName:@"Helvetica" size:kLabelFontSize]
										 shadowOffset:CGSizeMake(1.0,-1.0)
										   shadowBlur:0.0
										  shadowColor:shadowColor];
	*/
	
	
	//NSString* testString = [NSString stringWithFormat: @"distance: %i", 122]; // increase our counterNSString* testString = [NSString stringWithFormat: info]; // increase our counter
	
	/////_textures[0] = [[Texture2D alloc] initWithString:info dimensions:CGSizeMake(100, 30) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
	
	//glColor4f(1,1,1,1);
	//glColor4f(1,0,0,1);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);	
	glEnable(GL_BLEND);	
	glEnable(GL_TEXTURE_2D);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//glColor4f(1,0,1,1);
	//NSDate *now = [NSDate date];
	[[arrayTextureTextPlace objectAtIndex:placeIndex] drawAtPoint:CGPointMake(0,0)];
	//NSTimeInterval since = [now timeIntervalSinceNow];
	//NSLog([NSString stringWithFormat:@"[_textures[0] drawAtPoint:CGPointMake(0,0)];: %f", since]); 
	
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	//[_textures[0] release];
	//[_textures[0] dealloc];
}


- (void)drawTextX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z Num:(NSInteger) num {
	//	per il testo
	
	//testString = [NSString stringWithFormat: @"distance: %i", testVariable++]; // increase our counter
	NSString* testString = [NSString stringWithFormat: @"ind: %f", x]; // increase our counter
	_textures[num] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(25, 10) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
//	  _textures[0] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(200, 50) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
	
	
	glPushMatrix();	
	//glTranslatef(0,0,-4);
	glTranslatef(x,y,z);
	
		
	
	glColor4f(1,1,1,1);
	//glColor4f(0,0,0,1);
		glEnableClientState(GL_VERTEX_ARRAY);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	/////////glDisable(GL_LIGHTING);
	
	glEnable(GL_BLEND);
		
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	[_textures[num] drawAtPoint:CGPointMake(0,0)];
	//	[textures[num] drawAtPoint:CGPointMake(0,0)];
	
	glColor4f(0,0,0,1);
	//glColor4f(1,1,1,1);
	glTranslatef(0,0,-4);
	[_textures[num] drawAtPoint:CGPointMake(0,0)];	
	//[textures[num] drawAtPoint:CGPointMake(0,0)];	
	
	//glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	glDisable(GL_BLEND);
		glDisableClientState(GL_VERTEX_ARRAY);
		glDisableClientState(GL_TEXTURE_COORD_ARRAY);		
	glPopMatrix();
	
}

- (void)drawObjectTextureX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z  {
	glPushMatrix();	
	glTranslatef(x,y,z);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	//glEnable(GL_TEXTURE_2D);
	
	Texture2D* radarTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"restaurant.png"]];	// render an image to texture, instead
	[radarTexture drawAtPoint:CGPointMake(0,0)];
	
	//glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	glPopMatrix();
	
}

- (void)drawPlaceIcon  {
	
	//	NSDate *now = [NSDate date];
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
	
 glColor4f(0.0, 0.0, 1.0, 1.0);	
	//Texture2D* placeTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"restaurant2.png"]];	// render an image to texture, instead
/////	glScalef(4, 4, 4);
//	Texture2D* placeTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"restaurant_verySmall.png"]];	// render an image to texture, instead
	//Texture2D* placeTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"indicazione2.png"]];	// render an image to texture, instead
//	NSDate *now = [NSDate date];
	
	[placeTexture drawAtPoint:CGPointMake(0,0)];
	
//	NSTimeInterval since = [now timeIntervalSinceNow];
//	NSLog([NSString stringWithFormat:@"[placeTexture drawAtPoint:CGPointMake(0,0)]; %f", since]);  
/////	glScalef(0.25, 0.25, 0.25);
	
	
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	//NSTimeInterval since = [now timeIntervalSinceNow];
	//	NSLog([NSString stringWithFormat:@"drawPlaceIcon %f", since]);  
	
	//[placeTexture release];
	//[placeTexture dealloc];
}

- (void)drawInRadarPlaceIcon  {
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
//	Texture2D* placeTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"restaurant.png"]];	// render an image to texture, instead
	
	[placeTexture drawAtPoint:CGPointMake(0,0)];
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	//[placeTexture release];
//	[placeTexture dealloc];
}

- (void)drawInRadarUserIcon  {
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_BLEND);	
	glEnable(GL_TEXTURE_2D);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//	Texture2D* placeTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"restaurant.png"]];	// render an image to texture, instead
	
	[userTexture drawAtPoint:CGPointMake(0,0)];
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	//[placeTexture release];
	//	[placeTexture dealloc];
}


- (void)drawInRadarPlacemarkIcon  {
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_BLEND);	
	glEnable(GL_TEXTURE_2D);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//Texture2D* placeTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"indicazione2.png"]];	// render an image to texture, instead
	
	[placemarkTexture drawAtPoint:CGPointMake(0,0)];
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	//[placeTexture release];
//	[placeTexture dealloc];
}


- (void)drawObjectTexture2X: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z  {
	glPushMatrix();	
	glTranslatef(x,y,z);
	
	glTexCoordPointer(2, GL_FLOAT, 0, floorTC);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glBindTexture(GL_TEXTURE_2D, textures[1]);	
	glEnable(GL_TEXTURE_2D);	
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glVertexPointer(3, GL_FLOAT, 0, quadVertices);	
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4); 	
	
	glDisableClientState(GL_VERTEX_ARRAY);	
	glDisable(GL_TEXTURE_2D);	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	
	glPopMatrix();
	
}


- (void)drawRadarTextureX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z  {
	glPushMatrix();	
	glTranslatef(x,y,z);
	
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
	
	Texture2D* radarTexture = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"griglia.png"]];	// render an image to texture, instead
	[radarTexture drawAtPoint:CGPointMake(0,0)];

	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	glDisable(GL_TEXTURE_2D);	

	glPopMatrix();
	
	[radarTexture release];
}


- (void)drawObjectTextureWithLatLon: (LatLon*)latLonPlace yourPos: (LatLon*)latLonUser  NumObj: (NSInteger) num{

	CLLocation* locPlace = [[CLLocation alloc]initWithLatitude:latLonPlace.latitude longitude:latLonPlace.longitude];
	CLLocation* locUser = [[CLLocation alloc]initWithLatitude:latLonUser.latitude longitude:latLonUser.longitude];
	
	GLfloat x1=latLonUser.latitude;
	GLfloat y1=latLonUser.longitude;
	
	GLfloat x2=latLonPlace.latitude;
	GLfloat y2=latLonPlace.longitude;
	GLfloat diffX =x2 - x1;
	GLfloat diffY =y2 - y1;
	
	GLfloat tan= atan2f(diffY, diffX);
	
	GLfloat pim = M_PI_2;
	
	tan=tan-pim;
	GLfloat angle=tan *  (180.0/M_PI  );
	
	CLLocationDistance distance = [locUser getDistanceFrom:locPlace];
	
	[self drawObjectTextureWithDistance:distance Angle:angle];
	
	
	NSString *testString = [NSString stringWithFormat: @"%@ \nlatLon:\n%f,%f \ndistance: %f\n angle: %f\n-\n-\n-\n-\n-",latLonPlace.name,latLonPlace.latitude,latLonPlace.longitude, distance,angle]; // increase our counter
	//_textures[0] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(200, 50) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
	
	//_textures[num] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(infoWidth, infoHeight) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
	_textures[num] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(infoWidth, infoHeight) alignment:UITextAlignmentCenter fontName:@"Arial-BoldMT" fontSize:kLabelFontSize]; // update our texture with the new counter value
	//_textures2[num] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(infoWidth, infoHeight) alignment:UITextAlignmentCenter fontName:@"Arial-BoldMT" fontSize:kLabelFontSize]; // update our texture with the new counter value
	
	//[self drawInfoWithDistance:150 Angle:angle Num:num];
	
	
	[self drawInfoWithDistance:infoDistance Angle:angle Num:num];
	
	[locPlace release];
	[locUser release];
	testString=nil;
	[testString release];
	[_textures[num] dealloc];
	


}
- (void)drawObjectWithLatLon: (LatLon*)latLonPlace yourPos: (LatLon*)latLonUser NumObj: (NSInteger) num{	
	CLLocation* locPlace = [[CLLocation alloc]initWithLatitude:latLonPlace.latitude longitude:latLonPlace.longitude];
	CLLocation* locUser = [[CLLocation alloc]initWithLatitude:latLonUser.latitude longitude:latLonUser.longitude];
	
	GLfloat x1=latLonUser.latitude;
	GLfloat y1=latLonUser.longitude;	
	GLfloat x2=latLonPlace.latitude;
	GLfloat y2=latLonPlace.longitude;
	GLfloat diffX =x2 - x1;
	GLfloat diffY =y2 - y1;	
	GLfloat tan= atan2f(diffY, diffX);	
	GLfloat pim = M_PI_2;	
	tan=tan-pim;
		GLfloat angle=tan *  (180.0/M_PI  );
	
	CLLocationDistance distance = [locUser getDistanceFrom:locPlace];

	[self drawObjectWithDistance:distance Angle:angle];
	
	
	NSString *testString = [NSString stringWithFormat: @"%@ \nlatLon:\n%f,%f \ndistance: %f\n angle: %f\n-\n-\n-\n-\n-",latLonPlace.name,latLonPlace.latitude,latLonPlace.longitude, distance,angle]; // increase our counter
	//_textures[0] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(200, 50) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
	_textures[num] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(infoWidth, infoHeight) alignment:UITextAlignmentCenter fontName:@"Arial-BoldMT" fontSize:kLabelFontSize]; // update our texture with the new counter value
		//[self drawInfoWithDistance:150 Angle:angle Num:num];
	
	
	[self drawInfoWithDistance:infoDistance Angle:angle Num:num];
	
	[locPlace release];
	[locUser release];
testString=nil;
	[testString release];
	[_textures[num] dealloc];
	
}

- (void)drawObjectRadarWithLatLon: (LatLon*)latLonPlace yourPos: (LatLon*)latLonUser NumObj: (NSInteger) num radarCoeff:(GLfloat)coeff {	
	CLLocation* locPlace = [[CLLocation alloc]initWithLatitude:latLonPlace.latitude longitude:latLonPlace.longitude];
	CLLocation* locUser = [[CLLocation alloc]initWithLatitude:latLonUser.latitude longitude:latLonUser.longitude];
	
	GLfloat x1=latLonUser.latitude;
	GLfloat y1=latLonUser.longitude;	
	GLfloat x2=latLonPlace.latitude;
	GLfloat y2=latLonPlace.longitude;
	GLfloat diffX =x2 - x1;
	GLfloat diffY =y2 - y1;	
	GLfloat tan= atan2f(diffY, diffX);	
	GLfloat pim = M_PI_2;	
	tan=tan-pim;
	GLfloat angle=tan *  (180.0/M_PI  );
	
	CLLocationDistance distance = [locUser getDistanceFrom:locPlace];
	
	[self locateRadarObject:distance Angle:angle radarCoeff:coeff];
	
	
	//NSString *testString = [NSString stringWithFormat: @"%@ \nlatLon:\n%f,%f \ndistance: %f\n angle: %f\n-\n-\n-\n-\n-",latLonPlace.name,latLonPlace.latitude,latLonPlace.longitude, distance,angle]; // increase our counter
	//_textures[0] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(200, 50) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
//	_textures[num] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(infoWidth, infoHeight) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize]; // update our texture with the new counter value
	//[self drawInfoWithDistance:150 Angle:angle Num:num];
	
	
//	[self drawInfoWithDistance:infoDistance Angle:angle Num:num];
	
	[locPlace release];
	[locUser release];
	//testString=nil;
	//[testString release];
//	[_textures[num] dealloc];
	
}


- (void)drawObjectTextureWithDistance: (CLLocationDistance)distance Angle: (GLfloat)angle{

	glPushMatrix();	
	glRotatef(angle, 0, 1, 0);
	//glTranslatef(distance,0,0);
	glTranslatef(distance,0,0);
	
	glVertexPointer(3, GL_FLOAT, 0, floorVertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_FLOAT, 0, floorTC);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glBindTexture(GL_TEXTURE_2D, textures[1]);
	glEnable(GL_TEXTURE_2D);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	//glEnableClientState (GL_COLOR_ARRAY);
	//glColorPointer (4, GL_FLOAT, 0, quadVerticesColors);
	glVertexPointer(3, GL_FLOAT, 0, quadVertices);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4); 
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState (GL_COLOR_ARRAY);

	//glDisable(GL_TEXTURE_2D);	
	glDisableClientState(GL_VERTEX_ARRAY);	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);	
	glDisable(GL_TEXTURE_2D);

	
	glPopMatrix();

}
- (void)drawObjectWithDistance: (CLLocationDistance)distance Angle: (GLfloat)angle{
	
//	NSLog(@"distance:%f angle:%f",distance,angle);
	
	glPushMatrix();	
	glRotatef(angle, 0, 1, 0);
	//glTranslatef(distance,0,0);
	glTranslatef(distance,0,0);
	
	
	//glDisable(GL_TEXTURE_2D);
	//glScalef(0.5f, 0.5f, 0.5f);
	glEnableClientState(GL_VERTEX_ARRAY);
	//glEnableClientState (GL_COLOR_ARRAY);
	glVertexPointer(3, GL_FLOAT, 0, cubeVertices);	// Draw the front face in Red	
	glColor4f(1.0, 0.0, 0.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	// Draw the top face in green	
	glColor4f(0.0, 1.0, 0.0, 1.0);	
	glDrawArrays(GL_TRIANGLE_FAN, 4, 4);
	// Draw the rear face in Blue	
    glColor4f(0.0, 0.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 8, 4);
	// Draw the bottom face	
    glColor4f(1.0, 1.0, 0.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 12, 4);	
    // Draw the left face	
    glColor4f(0.0, 1.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 16, 4);	
    // Draw the right face	
    glColor4f(1.0, 0.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 20, 4);
		
	
	//glEnable(GL_TEXTURE_2D);
	//glDisableClientState(GL_VERTEX_ARRAY);
	//glDisableClientState (GL_COLOR_ARRAY);
	
	glPopMatrix();
	
	
}

- (void)drawInfoWithDistance: (CLLocationDistance)distance Angle: (GLfloat)angle Num:(NSInteger) num{
	
	glPushMatrix();	
	glRotatef(angle, 0, 1, 0);
	//glTranslatef(distance,0,0);
	glTranslatef(distance,0,0);
	glRotatef(-90, 0, 1, 0);
	
	glScalef(infoScale, infoScale,infoScale);
	//NSString *text = [NSString stringWithFormat: @"Distance:%f", distance]; 
	[self drawTextX:0 Y:0 Z:0  Num:num];
	
		
	glPopMatrix();
	
	//[text dealloc];
}


- (void)drawObjectLatLon: (LatLon*)latLon{
	
	Vec4 *XYZ=[GraphicController convertInXYZ:latLon];
		[self drawObjectX:XYZ.X Y:XYZ.Y Z:XYZ.Z ];
		
}

- (void)drawObjectTextureLatLon: (LatLon*)latLon{
	
	Vec4 *XYZ=[GraphicController convertInXYZ:latLon];
	[self drawObjectTextureX:XYZ.X Y:XYZ.Y Z:XYZ.Z ];
	
}


- (void)drawObject2LatLon: (LatLon*)latLon{
	
	Vec4 *XYZ=[GraphicController convertInXYZ:latLon];
	[self drawObject2X:XYZ.X Y:XYZ.Y Z:XYZ.Z ];
	
}


- (void)drawCubeLatLon: (LatLon*)latLon{
	
	Vec4 *XYZ=[GraphicController convertInXYZ:latLon];
	[self drawCubeX:XYZ.X Y:XYZ.Y Z:XYZ.Z ];
	
}


- (void)drawCubeX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z  {

	glPushMatrix();	
	
	glTranslatef(x,y,z);
		
	
	
	//glScalef(0.5f, 0.5f, 0.5f);
	glEnableClientState(GL_VERTEX_ARRAY);
//glEnableClientState (GL_COLOR_ARRAY);
	glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
	
	
	
	
 
	// Draw the front face in Red	
	glColor4f(1.0, 0.0, 0.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	// Draw the top face in green	
	glColor4f(0.0, 1.0, 0.0, 1.0);	
	glDrawArrays(GL_TRIANGLE_FAN, 4, 4);
	// Draw the rear face in Blue	
    glColor4f(0.0, 0.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 8, 4);
	// Draw the bottom face	
    glColor4f(1.0, 1.0, 0.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 12, 4);	
    // Draw the left face	
    glColor4f(0.0, 1.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 16, 4);	
    // Draw the right face	
    glColor4f(1.0, 0.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 20, 4);
	
	
	glDisableClientState(GL_VERTEX_ARRAY);
	//glDisableClientState (GL_COLOR_ARRAY);
	
	glPopMatrix();

	
}


- (void)drawObject2X: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z  {
// Triangle

glPushMatrix();
 glTranslatef(x,y,z);
	
	glScalef(0.1f, 0.1f, 0.1f);
	
	
glEnableClientState(GL_VERTEX_ARRAY);
glEnableClientState (GL_COLOR_ARRAY);
glColorPointer (4, GL_FLOAT, 0, triVertexColors);
glVertexPointer(3, GL_FLOAT, 0, triVertices); 
glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
glDisableClientState (GL_COLOR_ARRAY);
glPopMatrix();
}
	
- (void)drawFloorX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z {

	
	glPushMatrix();
	glTranslatef(x,y,z);
	glTranslatef(0,0,0);
	
	glRotatef(90, 1, 0, 0);	
	
	glVertexPointer(3, GL_FLOAT, 0, floorVertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_FLOAT, 0, floorTC);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glBindTexture(GL_TEXTURE_2D, textures[1]);
	glEnable(GL_TEXTURE_2D);
	
	
	/*
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 10; j++) {
			
			glPushMatrix();
			{
				glTranslatef(10.0+(j*-2.0), -2.0, -2.0+(i*-2.0));
				glRotatef(-90.0, 1.0, 0.0, 0.0);
				glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			}
			glPopMatrix();
		}
	}
	*/
	
	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 5; j++) {
			
			glPushMatrix();
			{
				glTranslatef(5.0+(j*-2.0), -2.0, -2.0+(i*-2.0));
				glRotatef(-90.0, 1.0, 0.0, 0.0);
				glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			}
			glPopMatrix();
		}
	}
	glDisable(GL_TEXTURE_2D);
	//glDisable(GL_TEXTURE_2D);
	//glDisableClientState(GL_VERTEX_ARRAY);	
	//glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glPopMatrix();

	
}

- (void)loadTexture:(NSString *)name intoLocation:(GLuint)location {
	
	CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	if (textureImage == nil) {
        NSLog(@"Failed to load texture image");
		return;
    }
	
    NSInteger texWidth = CGImageGetWidth(textureImage);
    NSInteger texHeight = CGImageGetHeight(textureImage);
	
	//NSLog(@"image %@:%i %i",name,texWidth,texHeight);	
	
	GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	
    CGContextRef textureContext = CGBitmapContextCreate(textureData,
														texWidth, texHeight,
														8, texWidth * 4,
														CGImageGetColorSpace(textureImage),
														kCGImageAlphaPremultipliedLast);
	
	// Rotate the image
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	
	glBindTexture(GL_TEXTURE_2D, location);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	
	free(textureData);
	
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	//NSLog(@"image caricata ");
	
}

/*
- (void)setFloorTexture {
	glGenTextures(10, textures);
	[self loadTexture:@"floor.png" intoLocation:textures[0]];
	//[self loadTexture:@"griglia.png" intoLocation:textures[0]];
	
}

- (void)setTestTexture {
	//glGenTextures(10, textures);
	//[self loadTexture:@"forest.jpg" intoLocation:textures[1]];
	[self loadTexture:@"checkerplate.png" intoLocation:textures[1]];
	
}
- (void)setRadarTexture {
	//glGenTextures(10, textures);
	//[self loadTexture:@"forest.jpg" intoLocation:textures[1]];
	[self loadTexture:@"checkerplate.jpg" intoLocation:textures[2]];
	//[self loadTexture:@"griglia.png" intoLocation:textures[2]];
	
}
*/
- (void)setTexture {
	glGenTextures(10, textures);
	[self loadTexture:@"floor.png" intoLocation:textures[0]];
	
	//[self loadTexture:@"checkerplate.png" intoLocation:textures[1]];
	[self loadTexture:@"restaurant.png" intoLocation:textures[1]];
	
	
	[self loadTexture:@"rad.jpg" intoLocation:textures[2]];
	[self loadTexture:@"radar.jpg" intoLocation:textures[3]];
	
	[self loadTexture:@"bamboo.png" intoLocation:textures[4]];
	
	//[self loadTexture:@"griglia2" intoLocation:textures[5]];
	[self loadTexture:@"restaurant.png" intoLocation:textures[5]];
	
	
	[self loadTexture:@"grass.png" intoLocation:textures[6]];
	[self loadTexture:@"lino.png" intoLocation:textures[7]];
	}
	
- (void)setTextTexture {
//_textures[0] = [[Texture2D alloc] initWithString:testString dimensions:CGSizeMake(200, 50) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:kLabelFontSize];	// initialize our texture with the text specified in testString
	//_textures[0] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"floor.png"]];	// render an image to texture, instead
	//_textures[1] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"griglia.png"]];	// render an image to texture, instead
	
	_texturesImages[0] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"floor.png"]];	// render an image to texture, instead
	_texturesImages[1] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"griglia.png"]];	// render an image to texture, instead
	
	
	//glBindTexture(GL_TEXTURE_2D, [_textures[0] name]);
	//glBindTexture(GL_TEXTURE_2D, [_textures[1] name]);
	
	glBindTexture(GL_TEXTURE_2D, [_texturesImages[0] name]);	
	glBindTexture(GL_TEXTURE_2D, [_texturesImages[1] name]);
	
glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);	// Linear Filtered
glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);	// Linear Filtered	

}
- (LatLon*)convertInlatLon:(Vec4*) XYZ {
	
	//Vector3 *latLon = [[Vector3 alloc] initWithX: -XYZ.X Y: XYZ.Y Z:XYZ.Z];	
	LatLon *latLon = [[LatLon alloc] initWithLatitude:XYZ.Y Longitude:XYZ.Z Altitude:XYZ.X];	
	return latLon;
	
}
+ (Vec4*)convertInXYZ:(LatLon*) latLon {
	
	Vec4 *XYZ = [[Vec4 alloc] initX: -latLon.latitude Y:latLon.altitude  Z:latLon.longitude];	
	return XYZ;
}

-(NSMutableArray*) getArrayPlaceText: (NSMutableArray* )arrayPlaces{

	NSMutableArray* arTextureTextPlace=[[NSMutableArray alloc]init];
	
	for (int j=0; j<[arrayPlaces count]; j++) {

		Place* currPlace = [arrayPlaces objectAtIndex:j];
		
	NSString *info = [NSString  stringWithFormat: @"%@",currPlace->name]; 
	float shadowColor[4] = {0.0,0.0,0.0,1.0};
	
	Texture2D* texture  = [[Texture2D alloc] initWithString:info
					 		  dimensions:CGSizeMake(50, 50)
										//   dimensions:CGSizeMake(1, 1)
											//alignment:UITextAlignmentLeft
												  alignment: UIBaselineAdjustmentAlignCenters
									//			  alignment: UIBaselineAdjustmentAlignBaselines
													   font:[UIFont fontWithName:@"Helvetica" size:kLabelFontSize]
										 shadowOffset:CGSizeMake(1.0,-1.0)
										   shadowBlur:0.0
										  shadowColor:shadowColor];
	[arTextureTextPlace addObject:texture];
	}
	
	
	return arTextureTextPlace;
}

@end
