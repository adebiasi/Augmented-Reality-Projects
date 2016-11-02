//
//  GraphicController.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 05/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "vec4.h"
#import "LatLon.h"

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import <CoreLocation/CoreLocation.h>

@class Texture2D;
@interface GraphicController : NSObject {

	GLuint textures[10];
	@public
	Texture2D* placeTexture;
	Texture2D* placemarkTexture;
	Texture2D* userTexture;
	NSMutableArray* arrayTextureTextPlace;
}

- (void)drawObjectX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z ;
- (void)drawObject2X: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z ;
- (void)drawFloorX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z ;
- (void)drawCubeX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z;
- (void)drawObjectTextureX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z ;
- (void)drawTextX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z Num:(NSInteger)num ;

- (void)drawRadarTextureX: (GLfloat)x Y: (GLfloat)y Z: (GLfloat)z;
- (void)drawPlaceIcon;
- (void)drawInRadarPlaceIcon;
- (void)drawInRadarPlacemarkIcon;
- (void)drawInfo: (NSString*) info;
- (void)drawPlaceInfo: (NSInteger) placeIndex;
- (void)drawInRadarUserIcon;

- (void)locateRadarObject: (CLLocationDistance)dist Angle: (GLfloat)angle radarCoeff:(GLfloat)coeff;

- (void)drawObjectLatLon: (LatLon*)latLon;
- (void)drawObject2LatLon: (LatLon*)latLon;
- (void)drawCubeLatLon: (LatLon*)latLon;
- (void)drawObjectTextureLatLon: (LatLon*)latLon;

- (void)drawObjectWithLatLon: (LatLon*)latLonPlace yourPos: (LatLon*)latLonUser  NumObj: (NSInteger) num;
- (void)drawObjectWithDistance: (CLLocationDistance)distance Angle: (GLfloat)angle;
- (void)drawObjectTextureWithLatLon: (LatLon*)latLonPlace yourPos: (LatLon*)latLonUser  NumObj: (NSInteger) num;
- (void)drawObjectTextureWithDistance: (CLLocationDistance)distance Angle: (GLfloat)angle;

- (void)drawObjectRadarWithLatLon: (LatLon*)latLonPlace yourPos: (LatLon*)latLonUser NumObj: (NSInteger) num radarCoeff:(GLfloat)coeff;

- (void)drawInfoWithDistance: (CLLocationDistance)distance Angle: (GLfloat)angle Num:(NSInteger) num;

- (void)loadTexture:(NSString *)name intoLocation:(GLuint)location;

/*- (void)setFloorTexture;
- (void)setTestTexture;
- (void)setRadarTexture;
*/
- (void)setTexture;
- (void)setTextTexture;

+ (Vec4*)convertInXYZ:(LatLon*) latLon ;
-(NSMutableArray*) getArrayPlaceText: (NSMutableArray* )arrayPlaces;
@end
