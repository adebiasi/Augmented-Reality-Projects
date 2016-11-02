//
//  EAGLView.m
//  OpenGLES13
//
//  Created by Simon Maurice on 24/05/09.
//  Copyright Simon Maurice 2009. All rights reserved.
//



#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import "Texture2D.h"
#import "WorldController.h"
#import "EAGLView.h"
#import "GraphicController.h"
#import "PlacesMngt.h"
#import "Camera.h"
#import "gluLookAt.h"
#import "TouchListener.h"
#import "PLCameraController.h"
#define USE_DEPTH_BUFFER 1
#define DEGREES_TO_RADIANS(__ANGLE) ((__ANGLE) / 180.0 * M_PI)


#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 480
#define NEAR 1
//#define FAR 100
//#define FOV 45
#define ASPECT  (float)SCREEN_WIDTH/(float)SCREEN_HEIGHT

@class GraphicController;

@implementation EAGLView

@synthesize context;
@synthesize animationTimer;
@synthesize animationInterval;
@synthesize eaglLayer;
@synthesize graphContr;
@synthesize infoContr;
@synthesize arrayPlacemarks;
@synthesize arrayPath;
@synthesize arrayPlaces;
@synthesize detailsView;

GLfloat viewSize,orthoViewSize;
CGRect rectView;
 GLfloat zNear = 0.1, zFar = 100000000.0, fieldOfView = 60.0, orthofieldOfView=120.0;

+ (Class)layerClass {
    return [CAEAGLLayer class];
}



- (id)initWithFrame:(CGRect)frame
{   
	
	if ((self = [super initWithFrame: frame])) {	
		
		//CGRect recteaglView = CGRectMake(0, 0, 320, 460);
		CGRect recteaglView = CGRectMake(0, 0, 320, 426);
		//eaglLayer.frame= [self frame]; 		
		self.frame=recteaglView; 
		
		CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
		CGFloat values[4] = {1.0, 1.0, 1.0, 0.0}; 
		CGColorRef white = CGColorCreate(rgbColorspace, values); 		
		CGFloat values2[4] = {0.0, 0.0, 0.0, 0.0}; 
		CGColorRef black = CGColorCreate(rgbColorspace, values2); 		
			
		CALayer *mainLayer = (CALayer *)self.layer;
		
		//NSLog(@"mainLayer %f %f %f %f",mainLayer.frame.size.width,mainLayer.frame.size.height,mainLayer.frame.origin.x,mainLayer.frame.origin.y);
		
		
		mainLayer.backgroundColor=white;
		mainLayer.name=@"MainLayer";
		
				eaglLayer = [CAEAGLLayer layer] ;
		eaglLayer.name=@"eaglLayer";
		[mainLayer addSublayer:eaglLayer];
		
        
		eaglLayer.opaque = NO;		
		eaglLayer.backgroundColor=black;
		
		//CGRect recteaglView = CGRectMake(0, 0, 320, 426);
		
		//eaglLayer.frame= [self frame]; 		
		eaglLayer.frame=recteaglView; 		
		
		//NSLog(@"eaglLayer %f %f %f %f",eaglLayer.frame.size.width,eaglLayer.frame.size.height,eaglLayer.frame.origin.x,eaglLayer.frame.origin.y);
		
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8,
										kEAGLDrawablePropertyColorFormat, nil];
        
		
		
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }
        
		
		camera = [[Camera alloc]init];		
		touchListener = [[TouchListener alloc] init];
		//touchListener.multipleTouchEnabled=TRUE;
		
		infoContr =[[LocalXYZInfoController alloc] init];
		
		//touchListener->glView=self;
		self.multipleTouchEnabled=YES;
		
		[touchListener setGlView:self];
		
		//[self setupView];
		
		}
    return self;
}

- (void)drawCameraView {
	
//	[self setPerspectiveView];
	//[self setupView];
	
	glLoadIdentity();	
	
	GLfloat angle=self->camera->angleView; 
	GLfloat angle2=self->camera->azimuth+self->camera->calibrate; 
	
	GLfloat angleDegree =angle*180/M_PI_2;
	GLfloat angle2Degree =angle2*180/M_PI_2;
	
	worldContr->orizAngle=angle2Degree;
	worldContr->vertAngle=-angleDegree;
	
	
	 LatLon *userLoc =self->camera->userLocation;
	//	Vec4* vec=[worldContr geodeticToCartesian:userLoc];
	Vec4* vec=userLoc->coord;
	
	//NSLog(@"------pos  %f %f %f %f %f %f",self->camera->userLocation.latitude ,self->camera->userLocation.longitude , self->camera->userLocation.altitude,self->camera->userLocation.coord.X,self->camera->userLocation.coord.Y,self->camera->userLocation.coord.Z);
	
	//Vec4* compassPos=[[Vec4 alloc]initX:1.5 Y:-1.0 Z:-5];
	
	//Vec4* compassPos=[[Vec4 alloc]initX:-0.4 Y:0.3 Z:1];
	/*
	Vec4* compassPos=[[Vec4 alloc]initX:-0.4 Y:0.5 Z:1];
	[worldContr drawLittleCompass:compassPos CompassAngle:angle2Degree Angle:45];
	*/
	//[graphContr drawRadarTextureX:0 Y:0 Z:-140];

	//glMatrixMode(GL_PROJECTION);
	glLoadIdentity();			
glRotatef(-angleDegree, 1, 0, 0);			
	glRotatef(angle2Degree, 0, 1, 0);		
	glRotatef(-90.0f, 1, 0, 0);	
	glRotatef(userLoc->latitude, 1, 0, 0);		
	glRotatef(-userLoc->longitude, 0, 1, 0);
	
	glTranslatef(-vec.X, -vec.Y, -vec.Z);

	//[worldContr insertStartPath:userLoc EndPath:userLoc];
	if([arrayPlacemarks count]!=0){
	//	[self setOrthographicView];
	//	[self setPerspectiveView];
	[worldContr insertArrayPlacemark:arrayPlacemarks PosUser:userLoc AngleCamera:angle2*180/M_PI_2];
	}
	if([arrayPath count]!=0){	
	//	[self setPerspectiveView];
		//[self setOrthographicView];
		[worldContr insertArrayPath:arrayPath PosUser:userLoc AngleCamera:angle2*180/M_PI_2];
	}
	if([arrayPlaces count]!=0){			
		//[self setOrthographicView];
	//	[self setPerspectiveView];

//	NSDate *now = [NSDate date];
		
	[worldContr insertArrayPlaces: arrayPlaces PosUser:userLoc AngleCamera:angle2*180/M_PI_2];
//		NSTimeInterval since = [now timeIntervalSinceNow];
		//NSLog("interval: %f",since );
//		NSLog([NSString stringWithFormat:@"insertArrayPlaces: %f", since]);  
	}
	glLoadIdentity();
	//Vec4* compassPos=[[Vec4 alloc]initX:-0.4 Y:0.5 Z:1];
	Vec4* compassPos=[[Vec4 alloc]initX:-0.8 Y:1.3 Z:2];
	[worldContr drawLittleCompass:compassPos CompassAngle:angle2Degree Angle:45];
	
};


- (void)drawRadarView3 {
//	[self setPerspectiveView];
		
	//[graphContr drawRadarTextureX:0 Y:0 Z:-140];
	[graphContr drawRadarTextureX:0 Y:0 Z:-120];
	
	GLfloat angle=self->camera->angleView; 
	GLfloat angle2=self->camera->azimuth+self->camera->calibrate; 
	
	LatLon *userLoc =self->camera->userLocation;
		GLfloat coeff=self->camera->coeff_Radar;
	//NSLog(@"coeff %f",coeff);
	LatLon *radarLoc=[[LatLon alloc]initWithLatitude:userLoc.latitude Longitude:userLoc.longitude Altitude:userLoc.altitude+coeff];
	
	
	//Vec4* vec2=[Vec4 geodeticToCartesian:radarLoc->latitude Longitude:radarLoc->longitude Elevation:radarLoc->altitude];
	//	Vec4* vec2=[Vec4 geodeticToCartesian:radarLoc->latitude Longitude:radarLoc->longitude Elevation:radarLoc->altitude isUser:FALSE userPos:radarLoc];
//	NSLog(@"---->drawRadarView3 userLoccccc %f %f %f %f %f %f",userLoc->coord->X,userLoc->coord->Y,userLoc->coord->Z,userLoc->latitude,userLoc->longitude,userLoc->altitude);
	
	//Vec4* vec2=[Vec4 geodeticToCartesian:radarLoc->latitude Longitude:radarLoc->longitude Elevation:radarLoc->altitude isUser:FALSE userPos:userLoc->coord];
	Vec4* vec2=[Vec4 geodeticToCartesian:radarLoc->latitude Longitude:radarLoc->longitude Elevation:radarLoc->altitude isUser:FALSE userPos:self->camera->firstUserLocation->coord];
	
//	NSLog(@"drawRadarView3 %f %f %f",vec2->X,vec2->Y,vec2->Z);
	/*
	glLoadIdentity();	
	//Vec4* compassPos=[[Vec4 alloc]initX:-0.8 Y:0.5 Z:2];
	Vec4* compassPos=[[Vec4 alloc]initX:-0.8 Y:1.0 Z:2];
	[worldContr drawLittleCompass:compassPos CompassAngle:angle2*180/M_PI_2 Angle:0];
	*/
	glLoadIdentity();	
			
	worldContr->orizAngle=angle2*180/M_PI_2;
	worldContr->vertAngle=-angle*180/M_PI_2;
		
	glRotatef(angle2*180/M_PI_2, 0, 0, 1);	
		
	glRotatef(userLoc->latitude, 1, 0, 0);	
	glRotatef(-userLoc->longitude, 0, 1, 0);
	
	
	glTranslatef(-vec2.X, -vec2.Y, -vec2.Z);
	[worldContr insertInRadarUser:userLoc Distance:coeff];
	
	
	if([arrayPlacemarks count]!=0){
	[worldContr insertInRadarArrayPlacemark:arrayPlacemarks PosUser:userLoc AngleCamera:angle2*180/M_PI_2 Distance:coeff];
	}
	if([arrayPath count]!=0){
		[worldContr insertInRadarArrayPath:arrayPath PosUser:userLoc AngleCamera:angle2*180/M_PI_2 Distance:coeff];
	}
	if([arrayPlaces count]!=0){
	//	NSLog(@"palces not null");
		[worldContr insertInRadarArrayPlaces:arrayPlaces PosUser:userLoc AngleCamera:angle2*180/M_PI_2 Distance:coeff];
	}
	
	glLoadIdentity();	
	//Vec4* compassPos=[[Vec4 alloc]initX:-0.8 Y:0.5 Z:2];
	Vec4* compassPos=[[Vec4 alloc]initX:-0.8 Y:1.3 Z:2];
	[worldContr drawLittleCompass:compassPos CompassAngle:angle2*180/M_PI_2 Angle:0];
};


- (void)drawView {
	
	//[self setPerspectiveView];
	  
	[EAGLContext setCurrentContext:context];
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
 	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		
	glLoadIdentity();	
	
	[self handleTouches];
	
		
	if(self->camera->isRadar==0){	
	[self drawCameraView];				
	}else{		
		[self drawRadarView3];		
	}
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
	
	
}


- (void)layoutSubviews {
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
    [self drawView];
}


- (BOOL)createFramebuffer {
    
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    //[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)eaglLayer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    if (USE_DEPTH_BUFFER) {
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    }
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

- (void)setupView {
	
	graphContr = [[GraphicController alloc] init];
	worldContr = [[WorldController alloc] init];
	
	graphContr->placeTexture=[[Texture2D alloc] initWithImage: [UIImage imageNamed:@"restaurant.png"]];
	graphContr->placemarkTexture=[[Texture2D alloc] initWithImage: [UIImage imageNamed:@"indicazione2.png"]];
	graphContr->userTexture=[[Texture2D alloc] initWithImage: [UIImage imageNamed:@"user.png"]];
	NSLog(@"");
	worldContr->graphContr=graphContr;
	worldContr->cameraClass=self->camera;
	
	rectView = self.bounds;
	//rectView = CGRectMake(0, 1, 320, 426);
//	rectView = self->camera->;
	
	glViewport(0, 0, rectView.size.width, rectView.size.height);
	
	    
	viewSize = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);	
	orthoViewSize = zNear * tanf(DEGREES_TO_RADIANS(orthofieldOfView) / 2.0);	
	orthoViewSize =  orthoViewSize*100;
	//viewSize=viewSize+10;
	//NSLog(@"viewSize:%f",viewSize);
	
	[self setPerspectiveView];
		
	[graphContr setTexture];
	
		
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	///////////
	//glEnable(GL_TEXTURE_2D);
	glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);	
	////////
		
/*
	//LatLon* pos=self->camera->userLocation;	
	PlacesMngt* placeContr =[[PlacesMngt alloc] init];
	placeContr->userLocation=self->camera->userLocation;

		
	//NSMutableArray* arrayResults=[placeContr receiveArrayObjectsWithUserLocation:pos];
	NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"Restaurant.xml"];
//PlacesMngt* placeContr =[[PlacesMngt alloc] init];
//	NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"PlacesTest3.xml"];
		
	arrayPlaces=[arrayResults objectAtIndex:0];
	
	graphContr->arrayTextureTextPlace=[graphContr getArrayPlaceText:arrayPlaces];
	
	NSLog(@"n° arrayPlaces: %i", [arrayPlaces count]);
	NSLog(@"n° arrayTextPlace: %i", [graphContr->arrayTextureTextPlace count]);
	
*/	
		
	arrayPlacemarks=[[NSMutableArray alloc]init];
	arrayPath=[[NSMutableArray alloc]init];
		}


-(void)setPerspectiveView{
	
		
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	double an = (60*viewSize / (rectView.size.width / rectView.size.height))/viewSize;
	
	//NSLog(@",,%f,%f ..%f",viewSize,viewSize / (rectView.size.width / rectView.size.height),an);
	
	
	glFrustumf(-viewSize, viewSize, -viewSize / (rectView.size.width / rectView.size.height), viewSize / (rectView.size.width / rectView.size.height), zNear, zFar);
	
	//glMatrixMode(GL_PROJECTION);
	//glLoadIdentity();
	//glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), zNear, zFar);
	//	size=40.0f;
	//	glOrthof(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), zNear, zFar);
	glMatrixMode(GL_MODELVIEW);
	//glLoadIdentity();	
	
	}

-(void)setOrthographicView{
	
//	CGRect rect = self.bounds;
	
	//glViewport(0, 0, rect.size.width, rect.size.height);
	
//	const GLfloat zNear = 0.1, zFar = 1000000.0, fieldOfView = 60.0;
  //  GLfloat size;
//	size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);	
	
	glMatrixMode(GL_PROJECTION);
	
	GLfloat	size=10.0f;
		
	glLoadIdentity();
	//NSLog(@"%f,%f,%f,%f,%f,%f",-size, size, -size / (rectView.size.width / rectView.size.height), size / (rectView.size.width / rectView.size.height), zNear, zFar);
	//NSLog(@"%f,%f,%f,%f,%f,%f",-orthoViewSize, orthoViewSize, -orthoViewSize / (rectView.size.width / rectView.size.height), viewSize / (rectView.size.width / rectView.size.height), zNear, zFar);
	//glTranslatef(0, 0, 2.0f);
	//glTranslatef(0, 0, 1.0f);
	//NSLog(@"size:%f orthoViewSize:%f",size,orthoViewSize);
	//glOrthof(-size, size, -size / (rectView.size.width / rectView.size.height), size / (rectView.size.width / rectView.size.height), zNear, zFar);
	glOrthof(-orthoViewSize, orthoViewSize, -orthoViewSize / (rectView.size.width / rectView.size.height), orthoViewSize / (rectView.size.width / rectView.size.height), zNear, zFar);
	//glFrustumf(-viewSize, viewSize, -viewSize / (rectView.size.width / rectView.size.height), viewSize / (rectView.size.width / rectView.size.height), zNear, zFar);
	//glTranslatef(0, 0, 1.0f);
	double constant = 1;

	
	//glOrthof(constant*-viewSize,constant* viewSize,constant* -viewSize / (rectView.size.width / rectView.size.height),constant* viewSize / (rectView.size.width / rectView.size.height), zNear, zFar);
		//glTranslatef(0, 0, 4.0f);
	//glOrthof(constant*-viewSize, constant*viewSize, constant*-viewSize / (rectView.size.width / rectView.size.height), constant*viewSize / (rectView.size.width / rectView.size.height), zNear, zFar);
	//
	glMatrixMode(GL_MODELVIEW);
	//glLoadIdentity();	
	
		
}


- (void)destroyFramebuffer {
    
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}


- (void)startAnimation {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(drawView)
														 userInfo:nil repeats:YES];
	
	self->camera->refreshVirtualViewInterval=animationInterval;
}


- (void)stopAnimation {
    self.animationTimer = nil;
}


- (void)setAnimationTimer:(NSTimer *)newTimer {
    [animationTimer invalidate];
    animationTimer = newTimer;
}


- (void)setAnimationInterval:(NSTimeInterval)interval {
    
    animationInterval = interval;
    if (animationTimer) {
        [self stopAnimation];
        [self startAnimation];
    }
}


- (void)dealloc {
   
    [self stopAnimation];
    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [context release];  
    [super dealloc];
}



- (void)handleTouches {
    [touchListener handleTouches];
  }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[touchListener touchesBegan:touches withEvent:event];	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[touchListener touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[touchListener touchesMoved:touches withEvent:event];
}




@end
