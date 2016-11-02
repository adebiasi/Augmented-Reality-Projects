//
//  WorldController.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 17/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "WorldController.h"
//#import "Vector3.h"
#import "gluLookAt.h"

#import "GraphicController.h"

@implementation WorldController


#define equatorial_radius 6378137.0f
#define polar_radius 6356752.3f
#define es 0.00669437999013f
//#define DBL_MAX 1.7976931348623158e+308 /* max value */
#define fieldOfV 60.0f

#define DEGREES_TO_RADIANS(__ANGLE) ((__ANGLE) / 180.0 * M_PI)


#define appros 10000;


//#define appros 1000;
//#define appros 1000000000;
/*
#define equatorial_radius 16378137.0f
#define polar_radius 16378137.0f
#define es 0.00f
*/

//double RadToDeg = (180.0/M_PI);
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(x) (180.0 * (x) / M_PI)

const GLfloat cubeVert[] = {-1.0, 1.0, 1.0, -1.0, -1.0, 1.0,1.0, -1.0, 1.0,   1.0, 1.0, 1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0,1.0, 1.0, 1.0, 1.0, 1.0, -1.0,1.0, 1.0, -1.0, 1.0, -1.0, -1.0,   -1.0, -1.0, -1.0,   -1.0, 1.0, -1.0,-1.0, -1.0, 1.0,
1.0, -1.0, 1.0,1.0, -1.0, -1.0,-1.0, -1.0, -1.0,-1.0, 1.0, -1.0, -1.0, 1.0, 1.0,  -1.0, -1.0, 1.0, -1.0, -1.0, -1.0,1.0, 1.0, 1.0, 1.0, 1.0, -1.0,1.0, -1.0, -1.0,1.0, -1.0, 1.0  }; 
const GLfloat placemarkVert[] = 
{
/*
-1.0, 1.0, 1.0, 
-1.0,-1.0, 1.0,
1.0, -1.0,1.0,
1.0, 1.0, 1.0,

-1.0, 1.0,-1.0,
-1.0,1.0, 1.0,
1.0, 1.0, 1.0,
1.0, 1.0, -1.0,

1.0, 1.0, -1.0,
1.0, -1.0, -1.0, 
-1.0, -1.0, -1.0, 
-1.0, 1.0, -1.0,

-1.0, -1.0, 1.0,
1.0, -1.0, 1.0,
1.0, -1.0, -1.0,
-1.0, -1.0, -1.0,

-1.0, 1.0, -1.0,
-1.0, 1.0, 1.0, 
-1.0, -1.0, 1.0,
-1.0, -1.0, -1.0,

1.0, 1.0, 1.0,
1.0, 1.0, -1.0,
1.0, -1.0, -1.0,
1.0, -1.0, 1.0 
 */
1.0, 1.0, -1.0,
1.0, -1.0, -1.0, 
-1.0, -1.0, -1.0, 
-1.0, 1.0, -1.0,

1.0, 1.0, -1.0,
1.0, -1.0, -1.0, 
0.0,0.0,1.0,

1.0, -1.0, -1.0, 
-1.0, -1.0, -1.0, 
0.0,0.0,1.0,

-1.0, -1.0, -1.0, 
-1.0, 1.0, -1.0,
0.0,0.0,1.0,

1.0, 1.0, -1.0,
-1.0, 1.0, -1.0,
0.0,0.0,1.0
 };  
const GLfloat triVert[] = { 0.0f, 1.0f, 0.0f, -1.0f, -1.0f, 0.0f, 1.0f, -1.0f, 0.0f }; 
const GLfloat triVertColors[] = {1.0f, 0.0f, 0.0f, 1.0f,  0.0f, 1.0f, 0.0f, 1.0f,  0.0f, 0.0f, 1.0f, 1.0f  };


const GLfloat objectDistance = 150;

/*
- (Vec4*)geodeticToCartesian: (double)latitude Longitude: (double)longitude Elevation: (double)metersElevation {
	
	double rLat=latitude * M_PI / 180;
	double rLon=longitude * M_PI / 180;
	
		
	double cosLat=cos(rLat);
	double sinLat=sin(rLat);
	
	double cosLon=cos(rLon);
	double sinLon=sin(rLon);
	
	double rpm=equatorial_radius/sqrt(1.0 - es * sinLat * sinLat);
	
	double x = (rpm + metersElevation) * cosLat * sinLon;
	double y = (rpm * (1.0 - es) + metersElevation) * sinLat;
	double z = (rpm + metersElevation) * cosLat * cosLon;
	
	double realX = x;
	double realY = y;
	double realZ = z;
	
	
	int z_val = z/appros;	
	double z_val2=z_val*appros;	
	
	z=z-z_val2;
	
	int y_val = y/appros;	
	double y_val2=y_val*appros;	
	
	y=y-y_val2;
	
	int x_val = x/appros;	
	double x_val2=x_val*appros;	
	
	x=x-x_val2;
	
	Vec4* vec = [[Vec4 alloc] initX:x Y:y Z:z];
	vec.realX=realX;
	vec.realY=realY;
	vec.realZ=realZ;
	
	
	return vec;
}
*/
- (LatLon*)cartesianToGeodetic: (Vec4* )cart {

	double ra2= 1/ (equatorial_radius *equatorial_radius);

	double X = cart->realZ;
	double Y = cart->realX;
	double Z = cart->realY;
	
	double e2 = es;
	double e4 = e2*e2;
	
	double XXpXX= X*X+Y*Y;
	double sqrtXXpXX = sqrt(XXpXX);
	double p = XXpXX * ra2;
	double q = Z*Z*(1-e2)*ra2;
	double r = 1/6.0 * (p+q-e4);
	double s = e4*p*q/(4*r*r*r);
	double t = pow(1+s+sqrt(s*(2+s)),1/3.0);
	double u = r* (1+t+1 / t);
	double v = sqrt(u*u+e4*q);
	double w = e2*(u+v-q) / (2*v);
	double k = sqrt(u+v+w*w)-w;
	double D = k* sqrtXXpXX / (k+e2);
	double lon = 2* atan2(Y,X+sqrtXXpXX);
	double sqrtDDpZZ=sqrt(D*D+Z*Z);
	double lat = 2* atan2(Z, D+sqrtDDpZZ);
	double elevation = (k+e2-1)*sqrtDDpZZ / k;	
	
	
	LatLon* latLon = [[LatLon alloc] initWithLatitude:lat Longitude:lon Altitude:elevation];
	return latLon;
}
/*
- (Vec4*)geodeticToCartesian: (LatLon* )latLon {

	Vec4* cartCoord =[self geodeticToCartesian:[latLon latitude] Longitude:[latLon longitude] Elevation:[latLon altitude]];

	return cartCoord;
}
*/ 
/*
- (void) insertArrayObjects: (NSArray*) arrayPosition{

	//Accessing an Array's contents using NSEnumerator
	NSEnumerator *enumerator = [arrayPosition objectEnumerator];
    //id obj;
	LatLon* latLonObj;
	Vec4* obj;
	
	//GLfloat vVertices[] = {846870.117891f, 4565256.132441f, 4356768.962786f,
	//846877.723534f, 4565256.132441f, 4356767.640066f};
	GLfloat vVertices[[arrayPosition count]*3] ;
	int i=0;
		
	while ( latLonObj = [enumerator nextObject] ) {
		
		if(i!=0){
		[self insertObject:latLonObj];
		}
		
		obj=latLonObj->coord;
		vVertices[i+0]=obj.X;
		vVertices[i+1]=obj.Y;
		vVertices[i+2]=obj.Z;		
				
		i=i+3;		
    }
	
		//glDisable(GL_TEXTURE_2D);
	glColor4f(0.0f,1.0f,0.0f,1.0f);//Change the object color to red
	glLineWidth(30.0f);
	glVertexPointer(3, GL_FLOAT, 0, vVertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	
	//for(int j=0;j++;j<[arrayPosition count]){
	for (int j=0; j < [arrayPosition count]; j++){
	glDrawArrays(GL_LINES, j, 2); 
	}
	
	//glEnable(GL_TEXTURE_2D);
}
*/
-(int) findNearestDest: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser{

	Vec4* user= latlonUser->coord;
	
	int indexSel=0;
	
for (int j=0; j<[arrayPosition count]-1; j++) {
	
	LatLon* latLonObj=[arrayPosition objectAtIndex:j];
	LatLon* latLonObj2=[arrayPosition objectAtIndex:j+1];
	Vec4* obj=latLonObj->coord;
	Vec4*  obj2=latLonObj2->coord;
	
	double dist=[Vec4 distanceVector1:obj Vector2:obj2];
	double distUser=[Vec4 distanceVector1:user Vector2:obj2];

	NSLog(@"index: %i",j);
	NSLog(@"dist: %f",dist);
	NSLog(@"distUser: %f",distUser);
	
	if(distUser<dist){
		NSLog(@"ok");
		indexSel=j+1;
	}	
}
	return indexSel;
}

-(int) findNearestDest2: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser{
	
	Vec4* user= latlonUser->coord;
	
	int indexSel=0;
	double minDist=10000000;;
	
	for (int j=0; j<[arrayPosition count]; j++) {
		
		LatLon* latLonObj=[arrayPosition objectAtIndex:j];
		
		Vec4* obj=latLonObj->coord;
		
		double distUser=[Vec4 distanceVector1:user Vector2:obj];
		
			if(distUser<minDist){			
			minDist=distUser;
			indexSel=j;
		}	
	}
	
		NSLog(@"indexSel: %i",indexSel);
	LatLon* latLonObj=[arrayPosition objectAtIndex:indexSel];
	LatLon* latLonObj2=[arrayPosition objectAtIndex:indexSel+1];
	Vec4* obj=latLonObj->coord;
	Vec4*  obj2=latLonObj2->coord;
	
	double distObj2=[Vec4 distanceVector1:obj Vector2:obj2];
	double distUserObj2=[Vec4 distanceVector1:user Vector2:obj2];
	if(distUserObj2<distObj2){
		indexSel=indexSel+1;
	}
	
	return indexSel;
}


- (void) insertArrayPlacemark: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle{
	
//	int startIndex=[self findNearestDest:arrayPosition PosUser:latlonUser];
	
	////////////
	int startIndex=0;
	///////////
	
	LatLon* dest = [arrayPosition objectAtIndex:startIndex];
	
	if(self->destination!=dest){
		self->destination=dest;
	}
	
	
	LatLon* nextDest;
	
	int nextIndex=self->nextDestinationIndex;
	
	if(nextIndex>[arrayPosition count]-1){
		self->nextDestinationIndex=[arrayPosition count]-1;
		nextIndex=self->nextDestinationIndex;
		
	}
	
	if(nextIndex>startIndex){
		nextDest = [arrayPosition objectAtIndex:nextIndex];
	}else{
		nextDest=dest;
		self->nextDestinationIndex=startIndex;
	}
		
	if(self->nextDestination!=nextDest){
		self->nextDestination=nextDest;
	}
		
	//da user a primo...
	//[self insertNearStartRectangle:latlonUser EndRectangle:nextDest Distance:1000];
		
	for (int j=startIndex; j<[arrayPosition count]; j++) {
				
		LatLon* latLonObj=[arrayPosition objectAtIndex:j];
		//LatLon* latLonObj2=[arrayPosition objectAtIndex:j+1];
//		NSLog(@"nome placemark: %@",[latLonObj name]);
		//[self insertStartPath:latlonUser EndPath:latLonObj];	
		[self insertPlacemark:latLonObj];
		
		//	[self insertNearStartRectangle:latLonObj EndRectangle:latLonObj2 Distance:1000];
		
	}	
	
//	[self insertStartPath:latlonUser EndPath:[arrayPosition objectAtIndex:[arrayPosition count]-1]];
	
}

- (void) insertArrayPath: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle{
	
//	int startIndex=[self findNearestDest:arrayPosition PosUser:latlonUser];
	
	////////////
int	startIndex=0;
	///////////
	
	LatLon* dest = [arrayPosition objectAtIndex:startIndex];
	
	if(self->destination!=dest){
		self->destination=dest;
	}
	
		for (int j=startIndex; j<[arrayPosition count]-1; j++) {
		
		LatLon* latLonObj=[arrayPosition objectAtIndex:j];
		LatLon* latLonObj2=[arrayPosition objectAtIndex:j+1];
		//[self insertStartPath:latlonUser EndPath:latLonObj];	
		[self insertNearStartRectangle:latLonObj EndRectangle:latLonObj2 Distance:1000];
		
	}	
	
}

- (void) insertInRadarArrayPlaces: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle Distance: (double) distance{
	
	int startIndex=0;
	Place* place;
	
	
	for (int j=startIndex; j<[arrayPosition count]; j++) {
		
		place=[arrayPosition objectAtIndex:j];
		
		//	[self insertStartRectangle:latLonObj EndRectangle:latLonObj2 CameraDistance:distance Color:red];
		[self insertInRadarPlace:place Distance:distance];
		
	}	
//[self insertDestination:[arrayPosition objectAtIndex:[arrayPosition count]-1] Distance:distance];
	
}


- (void) insertInRadarArrayPlacemark: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle Distance: (double) distance{
	
//	int startIndex=[self findNearestDest:arrayPosition PosUser:latlonUser];
	
int	startIndex=0;
	
	LatLon* dest = [arrayPosition objectAtIndex:startIndex];
	
	if(self->destination!=dest){
			self->destination=dest;
	}
		
	LatLon* nextDest;
	
	int nextIndex=self->nextDestinationIndex;
	
	if(nextIndex>[arrayPosition count]-1){
		//self->nextDestinationIndex=startIndex;
		//nextIndex=self->nextDestinationIndex;
		self->nextDestinationIndex=[arrayPosition count]-1;
		nextIndex=self->nextDestinationIndex;
	
	}
	
	if(nextIndex>startIndex){
	nextDest = [arrayPosition objectAtIndex:nextIndex];
	}else{
		nextDest=dest;
		self->nextDestinationIndex=startIndex;
	}
	
	
		
	if(self->nextDestination!=nextDest){
		self->nextDestination=nextDest;
			}
	

	CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
	CGFloat valuesB[4] = {0.0, 0.0, 1.0, 0.9}; 
	CGColorRef blue = CGColorCreate(rgbColorspace, valuesB);
	
	//CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
	CGFloat valuesR[4] = {1.0, 0.0, 0.0, 0.9}; 
	
	//CGColorRef red = CGColorCreate(rgbColorspace, valuesR);
	
	[self insertInRadarStartRectangle:latlonUser EndRectangle:nextDest CameraDistance:distance Color:blue];
		
	
	LatLon* latLonObj;
	//LatLon* latLonObj2;
	
	for (int j=startIndex; j<[arrayPosition count]; j++) {
		
		 latLonObj=[arrayPosition objectAtIndex:j];
		// latLonObj2=[arrayPosition objectAtIndex:j+1];
		
	//	[self insertStartRectangle:latLonObj EndRectangle:latLonObj2 CameraDistance:distance Color:red];
		//[self insertInRadarDestination:latLonObj Distance:distance];
		[self insertInRadarIconDestination:latLonObj Distance:distance];
		
	}	
	
	//[self insertInRadarDestination:[arrayPosition objectAtIndex:[arrayPosition count]-1] Distance:distance];

}

- (void) insertInRadarArrayPath: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angle Distance: (double) distance{
	
//	int startIndex=[self findNearestDest:arrayPosition PosUser:latlonUser];
	
int	startIndex=0;
	
	LatLon* dest = [arrayPosition objectAtIndex:startIndex];
	
	if(self->destination!=dest){
		self->destination=dest;
	}
	

	CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
	CGFloat valuesB[4] = {0.0, 0.0, 1.0, 0.9}; 
//	CGColorRef blue = CGColorCreate(rgbColorspace, valuesB);
	
	//CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
	CGFloat valuesR[4] = {1.0, 0.0, 0.0, 0.9}; 
	CGColorRef red = CGColorCreate(rgbColorspace, valuesR);
	
	//[self insertStartRectangle:latlonUser EndRectangle:nextDest CameraDistance:distance Color:blue];
	
	
	LatLon* latLonObj;
	LatLon* latLonObj2;
	
	for (int j=startIndex; j<[arrayPosition count]-1; j++) {
		
		latLonObj=[arrayPosition objectAtIndex:j];
		latLonObj2=[arrayPosition objectAtIndex:j+1];
		
		[self insertInRadarStartRectangle:latLonObj EndRectangle:latLonObj2 CameraDistance:distance Color:red];
		//[self insertDestination:latLonObj Distance:distance];
		
	}	
	
}



- (void) insertArrayPlaces: (NSArray*) arrayPosition PosUser: (LatLon*)latlonUser AngleCamera: (double) angleCamera{
	


		for (int j=0; j<[arrayPosition count]; j++) {
			
		Place* place=[arrayPosition objectAtIndex:j];
		//NSDate *now = [NSDate date];
			[self insertPlace:place UserPos:latlonUser Index:j];
			
		//	NSTimeInterval since = [now timeIntervalSinceNow];
			//NSLog("interval: %f",since );
		//	NSLog([NSString stringWithFormat:@"insertPlace: %f", since]);  
		//	[self insertRealPlace:place UserPos:latlonUser];
			
	}	
	
	
}




- (void) insertArrayStreet: (NSArray*) arrayPosition AngleCamera: (double) angle{
	LatLon* latLonStart=[arrayPosition objectAtIndex:0];
	
	for (int j=1; j<[arrayPosition count]-1; j++) {
		
		LatLon* latLonObj=[arrayPosition objectAtIndex:j];
		LatLon* latLonObj2=[arrayPosition objectAtIndex:j+1];
	//	double azim = [self rhumbAzimuthP1:latLonObj P2:latLonObj2];
			
	//	if([self isVisible:azim AngleCamera:angle]==TRUE){
			[self insertStartPath:latLonStart EndPath:latLonObj];
			[self insertNearStartRectangle:latLonObj EndRectangle:latLonObj2 Distance:100000];
			
	//	}
	}	
	
	

}

- (void) insertArrayPath: (NSArray*) arrayPosition AngleCamera: (double) angle{
	
	LatLon* latLonStart=[arrayPosition objectAtIndex:0];
//	Vec4* start = latLonStart->coord;
	
	for (int j=1; j<[arrayPosition count]; j++) {
		
		LatLon* latLonObj=[arrayPosition objectAtIndex:j];
		//Vec4* obj=latLonObj->coord;
		
		double azim = [self rhumbAzimuthP1:latLonStart P2:latLonObj];
		
		
		
		if([self isVisible:azim AngleCamera:angle]==TRUE){
		
	//	if(latLonObj.altitude==1.5){
		[self insertStartPath:latLonStart EndPath:latLonObj];
		[self insertNearStartRectangle:latLonStart EndRectangle:latLonObj Distance:100];
	
		
		}
	}	
		
		
	}
/*
- (void) insertStartPath2: (LatLon*) start EndPath: (LatLon*) endLatLon{
	glPushMatrix();	
	Vec4* end = endLatLon->coord;		
	glTranslatef([end X],[end Y],[end Z]);	
	glRotatef(countXAngle, 1, 0, 0);
	glRotatef(countYAngle, 0, 1, 0);
	glRotatef(countZAngle, 0, 0, 1);	
	glRotatef(endLatLon->longitude, 0, 1, 0);
	glRotatef(-endLatLon->latitude, 1, 0, 0);		
	glRotatef(90, 1, 0, 0);		
	//glDisable(GL_TEXTURE_2D);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState (GL_COLOR_ARRAY);
	glColorPointer (4, GL_FLOAT, 0, triVertColors);
	glVertexPointer(3, GL_FLOAT, 0, triVert); 
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
	glDisableClientState (GL_COLOR_ARRAY);	
	//glEnable(GL_TEXTURE_2D);	
	//	glPopMatrix();	
	glPopMatrix();
}
*/
- (void) insertInRadarUser: (LatLon*) userLatLon Distance: (double) distance{
	/*
	glPushMatrix();	
	Vec4* user = userLatLon->coord;	
	glTranslatef([user X],[user Y],[user Z]);	
	glRotatef(userLatLon->longitude, 0, 1, 0);
	glRotatef(-userLatLon->latitude, 1, 0, 0);		
	double initLat=1.0;
	double initDistance=10;
double lat=distance*initLat/initDistance;	
	glEnableClientState(GL_VERTEX_ARRAY);	
	[self DrawCircle:20 Size:lat/2 Center:user Filled:TRUE];	
	glDisableClientState(GL_VERTEX_ARRAY);
	glPopMatrix();
	*/
	glPushMatrix();	
	
	Vec4* dest = userLatLon->coord;	
	glTranslatef([dest X],[dest Y],[dest Z]);	
	
	glRotatef(userLatLon->longitude, 0, 1, 0);
	glRotatef(-userLatLon->latitude, 1, 0, 0);	
	glRotatef(-self->orizAngle, 0, 0, 1);	
	
		
	double initscale=0.02;
	double initDistance=10;
	double scale=distance*initscale/initDistance;
	
	glScalef(scale, scale, scale);
	
	[graphContr drawInRadarUserIcon];	
	glPopMatrix();
}


- (void) insertInRadarPlace: (Place*) place Distance: (double) distance{
	glPushMatrix();
	
	Vec4* dest = place->coord;	
	
//	NSLog(@"place in radar %f %f %f",[dest X],[dest Y],[dest Z]);
			
	glTranslatef([dest X],[dest Y],[dest Z]);	
	
	glRotatef(place->longitude, 0, 1, 0);
	glRotatef(-place->latitude, 1, 0, 0);		
	
	glRotatef(-self->orizAngle, 0, 0, 1);	
	
	
	//double initAltitude=400;
	double initAltitude=cameraClass->userLocation->altitude;
	double diffAltitude=initAltitude-place->altitude;
	
	
	double altExp=diffAltitude/initAltitude;
	double altScale=pow(2, altExp);

	distance=distance+diffAltitude;
	
	double initscale=0.02;
	double initDistance=10;
	double scale=distance*initscale/initDistance;

	
	glScalef(scale, scale, scale);
	//glScalef(altScale*scale, altScale*scale, altScale*scale);
	
	[graphContr drawInRadarPlaceIcon];
			
	glPopMatrix();
}

- (void) insertInRadarIconDestination: (LatLon*) destLatLon Distance: (double) distance{
	glPushMatrix();
	
	Vec4* dest = destLatLon->coord;	
	glTranslatef([dest X],[dest Y],[dest Z]);	
	
	glRotatef(destLatLon->longitude, 0, 1, 0);
	glRotatef(-destLatLon->latitude, 1, 0, 0);		
	
	glRotatef(-self->orizAngle, 0, 0, 1);	
	double initAltitude=cameraClass->userLocation->altitude;
	double diffAltitude=initAltitude-destLatLon->altitude;
	
	
	double altExp=diffAltitude/initAltitude;
	double altScale=pow(2, altExp);
	
	distance=distance+diffAltitude;
	
	double initscale=0.02;
	double initDistance=10;
	double scale=distance*initscale/initDistance;
	
	
			
	glScalef(scale, scale, scale);
	
	[graphContr drawInRadarPlacemarkIcon];
	
	glPopMatrix();
}


- (void) insertInRadarDestination: (LatLon*) destLatLon Distance: (double) distance{
	glPushMatrix();
	
	Vec4* dest = destLatLon->coord;
	
	
	glTranslatef([dest X],[dest Y],[dest Z]);
	
	glRotatef(destLatLon->longitude, 0, 1, 0);
	glRotatef(-destLatLon->latitude, 1, 0, 0);	
	
	double initLat=0.2;
	double initDistance=10;
	double lat=distance*initLat/initDistance;
	
	const GLfloat destVert[] = {
		-lat, lat, lat, 
		-lat, -lat, lat,
		lat, -lat, lat,   
		
		lat, lat, lat, 
		-lat, lat, -lat, 
		-lat, lat, lat,
		
		lat, lat, lat, 
		lat, lat, -lat,
		lat, lat, -lat, 
		
		lat, -lat, -lat,  
		-lat, -lat, -lat,  
		-lat, lat, -lat,
		
		-lat,-lat, lat,
		lat, -lat, lat,
		lat, -lat, -lat,
		
		-lat, -lat, -lat,
		-lat,lat, -lat, 
		-lat,lat, lat, 
		
		-lat, -lat, lat,		
		-lat, -lat, -lat,
		lat, lat, lat,
		
		lat,lat, -lat,
		lat, -lat, -lat,
	lat, -lat, lat  };    
	
	
	
	//glDisable(GL_TEXTURE_2D);
	
	
	//glDisable(GL_BLEND);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glVertexPointer(3, GL_FLOAT, 0, destVert);	
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
	
	
	//glEnable(GL_TEXTURE_2D);
	
	glPopMatrix();
}

-(void) insertPlacemark: (LatLon*) placemark{

	glPushMatrix();
	
	Vec4* end = placemark->coord;
	
	glTranslatef([end X],[end Y],[end Z]);
	
	glRotatef(placemark->longitude, 0, 1, 0);
	glRotatef(-placemark->latitude, 1, 0, 0);	
	
	
	////glDisable(GL_TEXTURE_2D);
	
	
	/////glDisable(GL_BLEND);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	
	
	glVertexPointer(3, GL_FLOAT, 0, placemarkVert);	
	// Draw the front face in Red	
	glColor4f(1.0, 1.0, 0.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);

	// Draw the top face in green	
	//glColor4f(0.0, 1.0, 0.0, 1.0);	
	glDrawArrays(GL_TRIANGLE_FAN, 4, 3);
	// Draw the rear face in Blue	
    //glColor4f(0.0, 0.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 7, 3);
	// Draw the bottom face	
    //glColor4f(1.0, 1.0, 0.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 10, 3);	
    // Draw the left face	
    //glColor4f(0.0, 1.0, 1.0, 1.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 13, 3);	
    // Draw the right face	
 //   glColor4f(1.0, 0.0, 1.0, 1.0);	
   // glDrawArrays(GL_TRIANGLE_FAN, 20, 4);
	
	
	
	glDisableClientState(GL_VERTEX_ARRAY);
	////glEnable(GL_TEXTURE_2D);
	
	glPopMatrix();
	

}
- (void) insertStartPath: (LatLon*) start EndPath: (LatLon*) endLatLon{
	glPushMatrix();
	
	Vec4* end = endLatLon->coord;
	
	glTranslatef([end X],[end Y],[end Z]);
			
	glRotatef(endLatLon->longitude, 0, 1, 0);
glRotatef(-endLatLon->latitude, 1, 0, 0);	
	
	
	////glDisable(GL_TEXTURE_2D);
	
		
	/////glDisable(GL_BLEND);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	
	
	glVertexPointer(3, GL_FLOAT, 0, cubeVert);	
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
	////glEnable(GL_TEXTURE_2D);
		
	glPopMatrix();
}
/*
- (void) insertStartCylinder2: (LatLon*) start EndCylinder: (LatLon*) end{
		
	GLfloat frontCircle[36];            // Now have X, y, Z	
    GLfloat rearCircle[36];	
    float radius = 0.5;
	
	Vec4* obj=start->coord;
	Vec4*  obj2=end->coord;
			
    int i = 0;
	
    for (float angle = 0; angle < 2*M_PI; angle += 0.630) {		
        frontCircle[i] = obj.X + radius * cos(angle);       // X		
        frontCircle[i+1] = obj.Y + radius * sin(angle);     // Y		
        frontCircle[i+2] = obj.Z;           // Z, somewhere off behind the viewer
		
        rearCircle[i] = obj2.X + radius * cos(angle);       // X	
        rearCircle[i+1] = obj2.Y + radius * sin(angle);     // Y		
        rearCircle[i+2] = obj2.Z;           // Z, somewhere off behind the viewer	
        i += 3;
		
    }
	
    frontCircle[30] = frontCircle[0];	
    frontCircle[31] = frontCircle[1];	
    frontCircle[32] = frontCircle[2];	
    rearCircle[30] = rearCircle[0];	
    rearCircle[31] = rearCircle[1];	
    rearCircle[32] = rearCircle[2];	
	
	//glDisable(GL_TEXTURE_2D);
	
	
    glPushMatrix();	

	glVertexPointer(3, GL_FLOAT, 0, frontCircle);	
    
	//color BLU
	glColor4f(0.0, 0.0, 1.0, 0.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 0, 11);	
	
	
    glVertexPointer(3, GL_FLOAT, 0, rearCircle);	
    //color Rosso
	glColor4f(1.0, 0.0, 0.0, 0.0);	
    glDrawArrays(GL_TRIANGLE_FAN, 0, 11);	
	
    GLfloat side[12];	
    glVertexPointer(3, GL_FLOAT, 0, side);	
	//color Giallo
    glColor4f(1.0, 1.0, 0.0, 0.0);	
    // For each section we need to form a quad with the two front and two rear sets of vertices
	
    for (int i = 0; i < 10; i++) {
		
        side[0] = frontCircle[i*3];		
        side[1] = frontCircle[i*3+1];		
        side[2] = frontCircle[i*3+2];
		
        side[3] = frontCircle[i*3+3];		
        side[4] = frontCircle[i*3+4];		
        side[5] = frontCircle[i*3+5];
		
        side[6] = rearCircle[i*3];		
        side[7] = rearCircle[i*3+1];		
        side[8] = rearCircle[i*3+2];	
		
        side[9] = rearCircle[i*3+3];		
        side[10] = rearCircle[i*3+4];		
        side[11] = rearCircle[i*3+5];		
		//// glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
		
    }
	glPopMatrix();
	
	//glEnable(GL_TEXTURE_2D);
	
	
}
*/
-(bool) isVisible: (double) angle AngleCamera: (double) camera{

double p1=angle;
	double p2=(camera);
	
	//double p1=fabs(angle);
	//double p2=fabs(camera);

	
	if(angle<0){
		p1=(360+angle);
	}
	
	
		double diff=fabs(p1-p2);

	if(diff<fieldOfV/2){
		return TRUE;
	}

	return FALSE;

}

-(double) ellipsoidalForwardAzimuthP1Lat: (double) fromLat P1Lon: (double) fromLon P2Lat: (double) toLat P2Lon: (double) toLon EquatorialRadius: (double) eqRad PolarRadius: (double) polRad{

	// Calculate flattening
	 double f = (eqRad - polRad) / eqRad; // flattening
	
	// Calculate reduced latitudes and related sines/cosines
	// double U1 = atan( (1.0 - f) * tan(degreesToRadian(from->latitude)) );
	 double U1 = atan( (1.0 - f) * tan(degreesToRadian(fromLat)) );
	 double cU1 = cos(U1);
	 double sU1 = sin(U1);
	
	// double U2 = atan( (1.0 - f) * tan(degreesToRadian(to->latitude)) );
	 double U2 = atan( (1.0 - f) * tan(degreesToRadian(toLat)) );
	 double cU2 = cos(U2);
	double sU2 = sin(U2);
	
	// Calculate difference in longitude
	// double L = degreesToRadian(to->longitude - from->longitude);
	 double L = degreesToRadian(toLon - fromLon);
	
	// Vincenty's Formula for Forward Azimuth 
	// iterate until change in lambda is negligible (e.g. 1e-12 ~= 0.06mm)
	// first approximation
	double lambda = L;
	double sLambda = sin(lambda);
	double cLambda = cos(lambda);
	
	// dummy value to ensure 
	
	//double lambda_prev = Double.MAX_VALUE;
	
	//double lambda_prev = 100000000;
	double lambda_prev = DBL_MAX;
	int count = 0;
	while ( fabs(lambda - lambda_prev) > 1e-12 && count++ < 100) {
		// Store old lambda
		lambda_prev = lambda;
		// Calculate new lambda
		
		double sSigma = sqrt( pow(cU2*sLambda, 2) 
								  + pow(cU1 * sU2 - sU1 * cU2 * cLambda, 2) ); 
		double cSigma = sU1 * sU2 + cU1 * cU2 * cLambda;
		double sigma = atan2(sSigma, cSigma);
		double sAlpha = cU1 * cU2 * sLambda / sSigma;
		double cAlpha2 = 1 - sAlpha * sAlpha; // trig identity
		// As cAlpha2 approaches zeros, set cSigmam2 to zero to converge on a solution
		double cSigmam2;
		if ( fabs(cAlpha2) < 1e-6 ) {
			cSigmam2 = 0;
		} else {
			cSigmam2 = cSigma - 2*sU1*sU2/cAlpha2;
		}
		double c = f / 16 * cAlpha2 * (4 + f * (4 - 3 * cAlpha2));
		
		lambda = L + (1 - c) * f * sAlpha * (sigma + c * sSigma * (cSigmam2 + c * cSigma * (-1+2*cSigmam2)));
		sLambda = sin(lambda);
		cLambda = cos(lambda);
	}
	
	return radianToDegrees(atan2(cU2*sLambda, cU1*sU2 - sU1*cU2*cLambda));
	

}

-(double) rhumbAzimuthP1: (LatLon*) p1 P2: (LatLon*) p2{

	double lat1 = degreesToRadian(p1.latitude);
	double lon1 = degreesToRadian(p1.longitude);
	double lat2 = degreesToRadian(p2.latitude);
	double lon2 = degreesToRadian(p2.longitude);
	
	double dLon = lon2 - lon1;
	double dPhi = logf(tan(lat2 / 2.0 + M_PI / 4.0) / tan(lat1 / 2.0 + M_PI / 4.0) );

	if(fabs(dLon) > M_PI){
		if(dLon>0){
			dLon=-(2*M_PI - dLon);
		}else{
		dLon=(2*M_PI + dLon);
		}		
	}
	
	double azimuthRadians = atan2(dLon, dPhi);	
	double azimuthDegrees = radianToDegrees(azimuthRadians);	
	return azimuthDegrees;
	
}

-(double) rhumbAzimuthP1lat: (double) p1lat P1lon: (double) p1lon P2lat: (double) p2lat P2lon: (double) p2lon{
	
	double lat1 = degreesToRadian(p1lat);
	double lon1 = degreesToRadian(p1lon);
	double lat2 = degreesToRadian(p2lat);
	double lon2 = degreesToRadian(p2lon);
	
	double dLon = lon2 - lon1;
	double dPhi = logf(tan(lat2 / 2.0 + M_PI / 4.0) / tan(lat1 / 2.0 + M_PI / 4.0) );
	
	if(fabs(dLon) > M_PI){
		if(dLon>0){
			dLon=-(2*M_PI - dLon);
		}else{
			dLon=(2*M_PI + dLon);
		}		
	}
	
	double azimuthRadians = atan2(dLon, dPhi);	
	double azimuthDegrees = radianToDegrees(azimuthRadians);	
	return azimuthDegrees;
	
}


- (void) insertNearStartRectangle: (LatLon*) start EndRectangle: (LatLon*) end Distance: (double)shortDistance{
	glPushMatrix();
	
	
	Vec4* obj=start->coord;
	Vec4*  obj2=end->coord;
	double dist=[Vec4 distanceVector1:obj Vector2:obj2];
	
	//nearDist : dist = rapp : 1
	double rapp = shortDistance/dist;
	
	if(rapp>1){
		rapp=1;
		shortDistance=dist;
	}
	
	Vec4* obj2b = [Vec4 mix:rapp Vector1:obj Vector2:obj2];
	Vec4* midObj = [Vec4 mix:0.5f Vector1:obj Vector2:obj2b];
	
	double alt = end.altitude-start.altitude;
	
	double angleAlt =asin(alt/shortDistance);
	double angleAltDegr = radianToDegrees(angleAlt);
	
	
	glTranslatef([midObj X],[midObj Y],[midObj Z]);
		
	//rilasciare obj2b e midObj
	[obj2b release];
	[midObj release];
	
	glRotatef(start->longitude, 0, 1, 0);
	glRotatef(-start->latitude, 1, 0, 0);	
	
	
	//double azim = [self ellipsoidalForwardAzimuthP1:start P2:end EquatorialRadius:equatorial_radius PolarRadius:polar_radius];
	double azim = [self ellipsoidalForwardAzimuthP1Lat:start->latitude P1Lon:start->longitude P2Lat:end->latitude P2Lon:end->longitude EquatorialRadius:equatorial_radius PolarRadius:polar_radius];
	
	
	glRotatef(90, 1, 0, 0);
		glRotatef(-azim, 0, 1, 0);
	

		glRotatef(angleAltDegr, 1, 0, 0);
	
	
	
	 //normale
	GLfloat vertices[] = {
		-2.0, 0.0,-shortDistance/2,
		2.0, 0.0,-shortDistance/2,
		2.0, 0.0,+shortDistance/2,
		-2.0, 0.0,+shortDistance/2
	};
	
	
	//glDisable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);     // Turn blending On
	glBlendFunc(GL_SRC_ALPHA, GL_ONE);     // (Type of blending) Set the blending function for translucency 
	//glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	//	glEnableClientState (GL_COLOR_ARRAY);
	
	
    glPushMatrix();		
	//color Blue
    glColor4f(0.0, 0.0, 1.0, 0.8);		
	
	glVertexPointer(3, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4); 	
	glPopMatrix();		
	
	glDisableClientState(GL_VERTEX_ARRAY);
	//glEnable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);     // Turn blending On
	
			
	glPopMatrix();
	
}

- (void) insertInRadarStartRectangle: (LatLon*) start EndRectangle: (LatLon*) end CameraDistance: (double) distance Color: (CGColorRef) color{

	glPushMatrix();
	
	
	Vec4* obj=start->coord;
	Vec4*  obj2=end->coord;
	double dist=[Vec4 distanceVector1:obj Vector2:obj2];
	
	//NSLog(@"dist: %f",dist);
	
	Vec4* midObj = [Vec4 mix:0.5f Vector1:obj Vector2:obj2];
	
	double midLatitude=(start->latitude+end->latitude)/2;
	double midLongitude=(start->longitude+end->longitude)/2;
	
	double alt = end.altitude-start.altitude;
	
	double angleAlt =asin(alt/dist);
	double angleAltDegr = radianToDegrees(angleAlt);
	
	
	glTranslatef([midObj X],[midObj Y],[midObj Z]);
	
	[midObj release];
	//[obj release];
	//[obj2 release];
	//glRotatef(start->longitude, 0, 1, 0);
	//glRotatef(-start->latitude, 1, 0, 0);	
	
	glRotatef(midLongitude, 0, 1, 0);
	glRotatef(-midLatitude, 1, 0, 0);	
	
	//NSLog(@"midLat:%f, midLon:%f, midAlt:%f",midLatitude,midLongitude,alt);
	//NSLog(@"2_>Lat:%f,Lon:%f",end->latitude,end->longitude);
	
	
	//double azim = [self ellipsoidalForwardAzimuthP1:start P2:end EquatorialRadius:equatorial_radius PolarRadius:polar_radius];
	double azim = [self ellipsoidalForwardAzimuthP1Lat:start->latitude P1Lon:start->longitude P2Lat:end->latitude P2Lon:end->longitude EquatorialRadius:equatorial_radius PolarRadius:polar_radius];
	//NSLog(@"azim:%f",azim);
	
	glRotatef(90, 1, 0, 0);
	
	glRotatef(-azim, 0, 1, 0);
	
	//NSLog(@"altangle:%f",angleAltDegr);
	glRotatef(angleAltDegr, 1, 0, 0);
	
	
	double initLat=0.1;
	double initDistance=10;
	double lat=distance*initLat/initDistance;
	/*
	//basso
	GLfloat updVertices[] = {
		-lat, -1,-dist/2,
		lat, -1,-dist/2,
		lat, -1,+dist/2,
		-lat, -1,+dist/2
	};
	 */
	//normale
	GLfloat updVertices[] = {
		-lat, 0,-dist/2,
		lat, 0,-dist/2,
		lat, 0,+dist/2,
		-lat, 0,+dist/2
	};	
	
	
	//glDisable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);     // Turn blending On
	glBlendFunc(GL_SRC_ALPHA, GL_ONE);     // (Type of blending) Set the blending function for translucency 
	
	glEnableClientState(GL_VERTEX_ARRAY);
	//	glEnableClientState (GL_COLOR_ARRAY);
	
	
    glPushMatrix();		
	//color rosso
	const CGFloat *components = CGColorGetComponents(color);
	CGFloat red = components[0];
	CGFloat green = components[1];
	CGFloat blue = components[2];
	CGFloat alpha = components[3];
    
	//glColor4f(1.0, 0.0, 0.0, 0.9);		
	glColor4f(red, green, blue, alpha);		
	glVertexPointer(3, GL_FLOAT, 0, updVertices);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4); 	
	glPopMatrix();		
	
	glDisableClientState(GL_VERTEX_ARRAY);
	//glEnable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);     // Turn blending On
	
		
	glPopMatrix();
	
	
}
/*
- (void) insertStartRectangle: (LatLon*) start EndRectangle: (LatLon*) end{
	glPushMatrix();	
	Vec4* obj=start->coord;
	Vec4*  obj2=end->coord;
	double dist=[obj distanceVector1:obj Vector2:obj2];
		
	Vec4* midObj = [obj mix:0.5f Vector1:obj Vector2:obj2];
	
	double alt = end.altitude-start.altitude;
	
	double angleAlt =asin(alt/dist);
	double angleAltDegr = radianToDegrees(angleAlt);
	
	
	glTranslatef([midObj X],[midObj Y],[midObj Z]);
	
	[midObj release];
	
	glRotatef(start->longitude, 0, 1, 0);
	glRotatef(-start->latitude, 1, 0, 0);		
	//double azim = [self ellipsoidalForwardAzimuthP1:start P2:end EquatorialRadius:equatorial_radius PolarRadius:polar_radius];
	double azim = [self ellipsoidalForwardAzimuthP1Lat:start->latitude P1Lon:start->longitude P2Lat:end->latitude P2Lon:end->longitude EquatorialRadius:equatorial_radius PolarRadius:polar_radius];
	
	glRotatef(90, 1, 0, 0);
	glRotatef(-azim, 0, 1, 0);	
	glRotatef(angleAltDegr, 1, 0, 0);
	
	
	 //normale
	// GLfloat vertices[] = {
	 //-2.0, 0,-shortDistance/2,
	 //2.0, 0,-shortDistance/2,
	 //2.0, 0,+shortDistance/2,
	 //-2.0, 0,+shortDistance/2
	 //};
	 
	//basso
	GLfloat vertices[] = {
		-2.0, -1,-dist/2,
		2.0, -1,-dist/2,
		2.0, -1,+dist/2,
		-2.0, -1,+dist/2
	};
	
	
	glDisable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);     // Turn blending On
	glBlendFunc(GL_SRC_ALPHA, GL_ONE);     // (Type of blending) Set the blending function for translucency 
	
	glEnableClientState(GL_VERTEX_ARRAY);
	//	glEnableClientState (GL_COLOR_ARRAY);
	
	
    glPushMatrix();		
	//color Giallo
    glColor4f(0.0, 0.0, 1.0, 0.3);		
	glVertexPointer(3, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4); 	
	glPopMatrix();		
	
	
	glEnable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);     // Turn blending On	
	
	glPushMatrix();		
	
	for (int j = 0; j < dist; j=j+2) {		
		
		GLfloat triVertices[] = {
			-1.0, -1,j-dist/2+2,
			+1.0, -1,j-dist/2+2,
			0.0, -1,j-dist/2,		
		};
		
	//	glDisable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);     // Turn blending On
		glBlendFunc(GL_SRC_ALPHA, GL_ONE);     // (Type of blending) Set the blending function for translucency 
		
		glEnableClientState(GL_VERTEX_ARRAY);
		glColor4f(1.0, 1.0, 1.0, 0.3);	
		glVertexPointer(3, GL_FLOAT, 0, triVertices); 
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
	//	glEnable(GL_TEXTURE_2D);
		glDisable(GL_BLEND);     // Turn blending On
	}
	
	glPopMatrix();	
	glPopMatrix();
	
}
*/
-(Vec4*) calculateNearPosition: (Vec4*) user ObjectPosition: (Vec4*) object{

	//NSLog(@"user--->%f,%f,%f,%f,%f,%f",user->X,user->Y,user->Z,user->realX,user->realY,user->Z);
	//NSLog(@"object------>%f,%f,%f,%f,%f,%f",object->X,object->Y,object->Z,object->realX,object->realY,object->Z);
	
	double realDistanceX = (user->realX)-(object->realX);
		double realDistanceY = (user->realY)-(object->realY);
		double realDistanceZ = (user->realZ)-(object->realZ);

	double realDistance = [Vec4 realDistanceVector1:user Vector2:object];	
	
	//NSLog(@"realDistance: %f",realDistance);
	
	double distConst=objectDistance/realDistance;
	
	
	
	double nearDistanceX = distConst*realDistanceX;
	double nearDistanceY = distConst*realDistanceY;
	double nearDistanceZ = distConst*realDistanceZ;
	
	if(nearDistanceX<0){
		nearDistanceX=nearDistanceX*-1;
	}
	if(nearDistanceY<0){
		nearDistanceY=nearDistanceY*-1;
	}
	if(nearDistanceZ<0){
		nearDistanceZ=nearDistanceZ*-1;
	}
	
	//NSLog(@"nearDistance: %f,%f,%f",nearDistanceX,nearDistanceY,nearDistanceZ);
	
	double nearPositionX;
	double nearPositionY;
	double nearPositionZ;
	
	if(user->realX<object->realX){
	 nearPositionX = user->X+nearDistanceX;
	}else{
	nearPositionX = user->X-nearDistanceX;
	}
	if(user->realY<object->realY){
		nearPositionY = user->Y+nearDistanceY;
	}else{
		nearPositionY = user->Y-nearDistanceY;
	}
	if(user->realZ<object->realZ){
		nearPositionZ = user->Z+nearDistanceZ;
	}else{
		nearPositionZ = user->Z-nearDistanceZ;
	}
		
	
	Vec4* res = [[Vec4 alloc] initX:nearPositionX Y:nearPositionY Z:nearPositionZ];
	
	
	return res;
}

-(void) insertPlace: (Place*)place UserPos:(LatLon*) latlonUser Index:(NSInteger)placeIndex{

	
	glPushMatrix();	
	
	//		NSDate *now = [NSDate date];

	Vec4* nearPos=[self calculateNearPosition:latlonUser->coord ObjectPosition:place->coord];
	
	//		NSTimeInterval since = [now timeIntervalSinceNow];
	//		NSLog([NSString stringWithFormat:@"nearPos: %f", since]);  
	
	 //glTranslatef(place->coord->X,place->coord->Y,place->coord->Z);
	glTranslatef(nearPos->X,nearPos->Y,nearPos->Z);
			
	
	glRotatef(place->longitude, 0, 1, 0);
	glRotatef(-place->latitude, 1, 0, 0);	
	
	//double azim = [self ellipsoidalForwardAzimuthP1:start P2:end EquatorialRadius:equatorial_radius PolarRadius:polar_radius];
	double azim = [self ellipsoidalForwardAzimuthP1Lat:latlonUser->latitude P1Lon:latlonUser->longitude P2Lat:place->latitude P2Lon:place->longitude EquatorialRadius:equatorial_radius PolarRadius:polar_radius];	
	glRotatef(90, 1, 0, 0);
	
	//double h = fabs(latlonUser->altitude-place->altitude);		
	double h = latlonUser->altitude-place->altitude;		
	double ip = [Vec4 realDistanceVector1:latlonUser->coord Vector2:place->coord];
	double cat = sqrt(ip*ip-h*h);		
	double rapp = cat/ip;		
	//double rapp = 5/7;		
	double alphaAngle = acos(rapp);
	double degAlphaAngle=radianToDegrees(alphaAngle);
	
	
//	NSLog(@"name %@ h: %f angle: %f",place->name,h,degAlphaAngle);
	
	
	glRotatef(-azim, 0, 1, 0);
	
	if(h>0){
		degAlphaAngle=-degAlphaAngle;
	}
	glRotatef(degAlphaAngle, 1, 0, 0);
	
	
	
	
	//	now = [NSDate date];
[graphContr drawPlaceIcon];
	//	 since = [now timeIntervalSinceNow];
	//	NSLog([NSString stringWithFormat:@"drawPlaceIcon: %f", since]);  
	
	//now = [NSDate date];
	double realDistance = [Vec4 realDistanceVector1:place->coord Vector2:latlonUser->coord];
	int distKm = realDistance/1000;	
	distKm=round(distKm);

	 //since = [now timeIntervalSinceNow];
	//NSLog([NSString stringWithFormat:@"realDistance: %f", since]);  
	
	
//	now = [NSDate date];

	//NSString *textInfo = [NSString  stringWithFormat: @"%@  %i Km",place->name, distKm]; 
	//	[graphContr drawInfo:textInfo];
	[graphContr drawPlaceInfo:placeIndex];
	
//	 since = [now timeIntervalSinceNow];
//	NSLog([NSString stringWithFormat:@"drawInfo: %f", since]);  
	
	
	glPopMatrix();
	//[graphContr drawTextX:place->coord->X Y:place->coord->Y Z:place->coord->Z Num:1 ];
	

}

-(void) insertRealPlace: (Place*)place UserPos:(LatLon*) latlonUser{
	
	
	glPushMatrix();	
	
	
	//Vec4* nearPos=[self calculateNearPosition:latlonUser->coord ObjectPosition:place->coord];
	//glTranslatef(nearPos->X,nearPos->Y,nearPos->Z);
	glTranslatef(place->coord->X,place->coord->Y,place->coord->Z);
	
	glRotatef(place->longitude, 0, 1, 0);
	glRotatef(-place->latitude, 1, 0, 0);	
	
	double azim = [self ellipsoidalForwardAzimuthP1Lat:latlonUser->latitude P1Lon:latlonUser->longitude P2Lat:place->latitude P2Lon:place->longitude EquatorialRadius:equatorial_radius PolarRadius:polar_radius];	
	glRotatef(90, 1, 0, 0);
	
	glRotatef(-azim, 0, 1, 0);
	[graphContr drawPlaceIcon];
	
	double realDistance = [Vec4 realDistanceVector1:place->coord Vector2:latlonUser->coord];
	
	int distKm = realDistance/1000;
	
	distKm=round(distKm);
	
	
	
	NSString *textInfo = [NSString  stringWithFormat: @"%@  %i Km",place->name, distKm]; 
	[graphContr drawInfo:textInfo];
	
	glPopMatrix();
	//[graphContr drawTextX:place->coord->X Y:place->coord->Y Z:place->coord->Z Num:1 ];
	
	
}

/*
- (void) insertStartCylinder: (LatLon*) start EndCylinder: (LatLon*) end{

	glPushMatrix();
	
	GLfloat frontCircle[36];            // Now have X, y, Z	
    GLfloat rearCircle[36];	
    float radius = 0.5;
	
	Vec4* obj=start->coord;
	Vec4*  obj2=end->coord;
	
	Vec4* midObj = [obj mix:0.5f Vector1:obj Vector2:obj2];
	
	glTranslatef([midObj X],[midObj Y],[midObj Z]);
	
	[midObj release];
	
	glRotatef(end->longitude, 0, 1, 0);
	glRotatef(-end->latitude, 1, 0, 0);	
	
	glRotatef(90, 1, 0, 0);
	
	double azim = [self rhumbAzimuthP1:start P2:end];
	
	glRotatef(-azim, 0, 1, 0);
	
	double dist=[obj distanceVector1:obj Vector2:obj2];
		
	GLfloat origin[3] = {		
        0.0, -1.0,-dist/2		
    };
	
	GLfloat origin2[3] = {		
        0.0, -1.0,+dist/2		
    };
	
    int i = 0;
	
    for (float angle = 0; angle < 2*M_PI; angle += 0.630) {		
        frontCircle[i] = origin[0] + radius * cos(angle);       // X		
        frontCircle[i+1] = origin[1] + radius * sin(angle);     // Y		
        frontCircle[i+2] = origin[2];           // Z, somewhere off behind the viewer
						
        rearCircle[i] = origin2[0] + radius * cos(angle);       // X	
        rearCircle[i+1] = origin2[1] + radius * sin(angle);     // Y		
        rearCircle[i+2] = origin2[2];           // Z, somewhere off behind the viewer	
        i += 3;
		
    }
		
    frontCircle[30] = frontCircle[0];	
    frontCircle[31] = frontCircle[1];	
    frontCircle[32] = frontCircle[2];	
    rearCircle[30] = rearCircle[0];	
    rearCircle[31] = rearCircle[1];	
    rearCircle[32] = rearCircle[2];	
	
//	glDisable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);     // Turn blending On
	glBlendFunc(GL_SRC_ALPHA, GL_ONE);     // (Type of blending) Set the blending function for translucency 
	
    glPushMatrix();	
 //   rota += 0.5;
		
  //  glTranslatef(0.0, 0.0, -10.0);	
 //   glRotatef(rota, 0.0, 1.0, 0.0);	
   
	
	glVertexPointer(3, GL_FLOAT, 0, frontCircle);	
    
	//color BLU
	glColor4f(0.0, 0.0, 1.0, 0.2);	
    glDrawArrays(GL_TRIANGLE_FAN, 0, 11);	
	
	
    glVertexPointer(3, GL_FLOAT, 0, rearCircle);	
    //color Rosso
	glColor4f(1.0, 0.0, 0.0, 0.2);	
    glDrawArrays(GL_TRIANGLE_FAN, 0, 11);	
	
    GLfloat side[12];	
    glVertexPointer(3, GL_FLOAT, 0, side);	
	//color Giallo
    glColor4f(1.0, 1.0, 0.0, 0.2);	
    // For each section we need to form a quad with the two front and two rear sets of vertices
	
    for (int i = 0; i < 10; i++) {
		
        side[0] = frontCircle[i*3];		
        side[1] = frontCircle[i*3+1];		
        side[2] = frontCircle[i*3+2];
		
        side[3] = frontCircle[i*3+3];		
        side[4] = frontCircle[i*3+4];		
        side[5] = frontCircle[i*3+5];
					
        side[6] = rearCircle[i*3];		
        side[7] = rearCircle[i*3+1];		
        side[8] = rearCircle[i*3+2];	
		
        side[9] = rearCircle[i*3+3];		
        side[10] = rearCircle[i*3+4];		
        side[11] = rearCircle[i*3+5];		
       glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
		
    }
	glPopMatrix();

	//glEnable(GL_TEXTURE_2D);
glDisable(GL_BLEND);     // Turn blending On
	glPopMatrix();
	
}
*/
- (void) insertStartLine: (LatLon*) start EndLine: (LatLon*) end{

	GLfloat vVertices[6] ;
			
		Vec4* obj=start->coord;
		vVertices[0]=obj.X;
		vVertices[1]=obj.Y;
		vVertices[2]=obj.Z;
		
	Vec4*  obj2=end->coord;
	vVertices[3]=obj2.X;
	vVertices[4]=obj2.Y;
	vVertices[5]=obj2.Z;	
    
		
	GLfloat points[36];	
    glEnableClientState(GL_VERTEX_ARRAY);	
    glVertexPointer(3, GL_FLOAT, 0, points);	
    glColor4f(1.0, 1.0, 0.0, 1.0);	
	points[0] = obj2.X;// Circle centre	
	points[1] =obj2.Y;
	points[2] =obj2.Z;
    int i = 2;	
    //float radius = 0.75;	
	float radius = 5;	
    for (float angle = 0; angle < 2*M_PI; angle += 0.630) {		
		i=i+1;
	
        points[i] = obj2.X+ ( radius * cos(angle));	
		i=i+1;
		
        points[i] = obj2.Y+ ( radius * sin(angle));
		i=i+1;
		
		points[i] = obj2.Z;
    }	
	i=i+1;
	
	points[i] = points[3];
	i=i+1;
	
	points[i] = points[4];	
	i=i+1;
	
	points[i] = points[5];	
	
	glDrawArrays(GL_TRIANGLE_FAN, 0, 12);	
		
	
//	glEnable(GL_TEXTURE_2D);
	

}

/*
- (void) insertStartPath3: (LatLon*) start EndPath: (LatLon*) endLatLon{
	//glPushMatrix();	
	glPushMatrix();	
	Vec4* end = endLatLon->coord;	
	glTranslatef([end X],[end Y],[end Z]);
//	glRotatef(90, 1, 0, 0);		
	glRotatef(countXAngle, 1, 0, 0);
	glRotatef(countYAngle, 0, 1, 0);
	glRotatef(countZAngle, 0, 0, 1);
		glRotatef(-endLatLon->latitude, 1, 0, 0);	
	glRotatef(endLatLon->longitude, 0, 1, 0);	
//	glDisable(GL_TEXTURE_2D);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState (GL_COLOR_ARRAY);
	glColorPointer (4, GL_FLOAT, 0, triVertColors);
	glVertexPointer(3, GL_FLOAT, 0, triVert); 
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
	glDisableClientState (GL_COLOR_ARRAY);	
//	glEnable(GL_TEXTURE_2D);	
	//	glPopMatrix();	
	glPopMatrix();	
	}
*/
	

-(void) DrawEllipse: (int) segments Width: (CGFloat) width Height:( CGFloat) height Center: (Vec4*) center Filled: (bool) filled
{
	//glTranslatef(center.X, center.Y, center.Z);
	//glDisable(GL_TEXTURE_2D);
	//glEnableClientState(GL_VERTEX_ARRAY);
	glColor4f(1, 1, 1, 1);
	
	GLfloat vertices[segments*2];
	int count=0;
	for (GLfloat i = 0; i < 360.0f; i+=(360.0f/segments))
	{
		vertices[count++] = (cos(degreesToRadian(i))*width);
		vertices[count++] = (sin(degreesToRadian(i))*height);
	}
	glVertexPointer (2, GL_FLOAT , 0, vertices); 
	glDrawArrays ((filled) ? GL_TRIANGLE_FAN : GL_LINE_LOOP, 0, segments);
	//glEnable(GL_TEXTURE_2D);
	
}

-(void) DrawCircle: (int) circleSegments Size: (CGFloat) circleSize Center: (Vec4*) center Filled : (bool) filled 
{
	[self DrawEllipse:circleSegments Width:circleSize Height:circleSize Center:center Filled:filled];
}	
/*
- (void) insertObject: (LatLon*) latLonPosition{

	glPushMatrix();	
	
	Vec4* position = latLonPosition->coord;
	
		glTranslatef(position.X,position.Y,position.Z);
		
	glScalef(0.1, 0.1, 0.1);
	
//	glDisable(GL_TEXTURE_2D);
	//glScalef(100.0f, 100.0f, 100.0f);
	glEnableClientState(GL_VERTEX_ARRAY);
	glVertexPointer(3, GL_FLOAT, 0, cubeVert);	
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
	
	
//	glEnable(GL_TEXTURE_2D);
	//glDisableClientState(GL_VERTEX_ARRAY);
	//glDisableClientState (GL_COLOR_ARRAY);
	
	glPopMatrix();
}
*/
void GLDrawEllipse (int segments, CGFloat width, CGFloat height, Vec4* center, bool filled)
{
	glTranslatef(center.X, center.Y, center.Z);
	GLfloat vertices[segments*2];
	int count=0;
	for (GLfloat i = 0; i < 360.0f; i+=(360.0f/segments))
	{
		vertices[count++] = (cos(degreesToRadian(i))*width);
		vertices[count++] = (sin(degreesToRadian(i))*height);
	}
	glVertexPointer (2, GL_FLOAT , 0, vertices); 
	glDrawArrays ((filled) ? GL_TRIANGLE_FAN : GL_LINE_LOOP, 0, segments);
}
void GLDrawCircle (int circleSegments, CGFloat circleSize, Vec4* center, bool filled) 
{
	GLDrawEllipse(circleSegments, circleSize, circleSize, center, filled);
}



-(void) drawLittleCompass: (Vec4*) center CompassAngle: (double) compassAngle Angle: (double) angle{
	
	glPushMatrix();

	double userAngle=atan(center.Z/center.X);
	
	glTranslatef(-center.X, -center.Y, -center.Z);
	
	glRotatef(-20, 0, 1, 0);	
	glRotatef(-angle, 1, 0, 0);
	//glRotatef(-20, 0.0, 1.0, 0.0);
	glRotatef(compassAngle, 0, 0,1 );
	
	
		
	GLfloat triVertices[] = {
		-0.05, -0.2,0,
		+0.05,-0.2, 0,
		0.0, 0.2,0		
	};
	
	
	glEnable(GL_BLEND);     // Turn blending On
	glBlendFunc(GL_SRC_ALPHA, GL_ONE);     // (Type of blending) Set the blending function for translucency 
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glColor4f(1.0, 0.0, 0.0, 1);	
	
	glVertexPointer(3, GL_FLOAT, 0, triVertices); 
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
	
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisable(GL_BLEND);     // Turn blending On
	
	glPopMatrix();
}

@end
