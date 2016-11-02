//
//  OpenGLES13AppDelegate.m
//  OpenGLES13
//
//  Created by Simon Maurice on 24/05/09.
//  Copyright Simon Maurice 2009. All rights reserved.
//

#import "OpenGLES13AppDelegate.h"
#import "EAGLView.h"
#import "InfoView.h"
#import "InfoView2.h"
#import "DetailsView.h"
#import "TouchListener.h"
#import "Camera.h"
#import "TeslameterViewController.h"
#import "MainViewController.h"
#import "PLCameraController.h"
#import "GPSController.h"
#import "WebServicesViewController.h";

@implementation OpenGLES13AppDelegate

@synthesize window;
@synthesize glView;
@synthesize touchListener;




- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	
	CGRect windowRect = [[UIScreen mainScreen] applicationFrame];
	
	UIWindow *mainWindow = [[UIWindow alloc] initWithFrame:windowRect];
	[mainWindow setBackgroundColor:[UIColor blackColor]];
	
	GPSController *timer =[[GPSController alloc]init];	
	timer->mainDel=self;
	;
///	[timer startAnimation];
	
	
	PLCameraController *cameraController = [(id)objc_getClass("PLCameraController") performSelector:@selector(sharedInstance)];
	cameraController = [cameraController retain];
	[cameraController setDelegate:self];
	[cameraController setFocusDisabled:YES];
	//[cameraController setCaptureAtFullResolution:NO];
	[cameraController setDontShowFocus:YES];	
	UIView *previewView = [cameraController performSelector:@selector(previewView)];
	[mainWindow addSubview:previewView];
	[cameraController performSelector:@selector(startPreview)];
	[cameraController performSelector:@selector(setCameraMode:) withObject:0];
	sleep(2);
	
	// Override point for customization after application launch
    [window makeKeyAndVisible];
	
	/******
	CGRect infoWindow = CGRectMake(0, 0, 320, 60 );	
	//InfoView2 *infoView = [[InfoView2 alloc] initWithFrame:infoWindow]; 	
	InfoView2 *infoView = [[InfoView2 alloc] initWithFrame:infoWindow]; 	
	
	infoView.opaque = NO ;
	infoView.alpha = 1.0 ; 	
	infoView.mainDel=self;
	
	 [infoView startAnimation];

	 **********/
	
		
	EAGLView *eAGLView = [[EAGLView alloc] initWithFrame:windowRect]; 	
	glView=eAGLView;	
	glView.opaque = NO ;
	glView.alpha = 1.0 ; 	
	glView.userInteractionEnabled=YES;
	glView.animationInterval = 0.05;
	
	//glView.multipleTouchEnabled=YES;
	
	////////[glView startAnimation];
	
	self.glView=glView;
	
	///////*************////
	CGRect infoWindow = CGRectMake(0, 0, 320, 60 );	
	//InfoView2 *infoView = [[InfoView2 alloc] initWithFrame:infoWindow]; 	
	InfoView2 *infoView = [[InfoView2 alloc] initWithFrame:infoWindow]; 	
	
	infoView.opaque = NO ;
	infoView.alpha = 1.0 ; 	
	infoView.mainDel=self;
	[infoView startAnimation];

	///////*************////
	
	CGRect detailsRect = CGRectMake(0, 0, 320, 460 );
	
	
	DetailsView *detailsView = [[DetailsView alloc] initWithFrame:detailsRect]; 
	detailsView.hidden=TRUE;
	detailsView->table->glView=glView;
	
	
	glView->detailsView=detailsView;

	
	TeslameterViewController *teslaController=[[TeslameterViewController alloc] init]; 
	teslaController.refreshInterval= 0.05;
	Camera *cam=glView->camera;
		teslaController->camera=cam;
	
	[teslaController viewDidLoad]; 
	
	
	
	MainViewController *accelController =[[MainViewController alloc] init];
		accelController->camera=cam;
	[accelController viewDidLoad];
		
	[mainWindow addSubview:previewView];
	[mainWindow addSubview:glView];	
	
	[mainWindow addSubview:infoView];
	[mainWindow addSubview:detailsView];
	/*
	NSLog(@"previewView: %f %f %f %f ",previewView.bounds.size.height ,previewView.bounds.size.width,previewView.bounds.origin.x,previewView.bounds.origin.y);
	NSLog(@"previewView2: %f %f %f %f ",previewView.frame.size.height ,previewView.frame.size.width,previewView.frame.origin.x,previewView.frame.origin.y);
	NSLog(@"glView: %f %f %f %f ",glView.frame.size.height ,glView.frame.size.width,glView.frame.origin.x,glView.frame.origin.y);
	NSLog(@"infoWindow: %f %f %f %f ",infoWindow.size.height ,infoWindow.size.width,infoWindow.origin.x,infoWindow.origin.y);
	NSLog(@"windowRect: %f %f %f %f ",windowRect.size.height ,windowRect.size.width,windowRect.origin.x,windowRect.origin.y);
	*/
	
	
    [self setWindow:mainWindow];
	
	
	//////////////
	[timer startAnimation];
	
	
  [mainWindow makeKeyAndVisible];
	
		
	
	[infoView setUserLocation];
	[detailsView setGLView:eAGLView];
	[glView setupView];
	[glView startAnimation];
	//[timer release];
	//[cameraController release];
	//[teslaController release];
	//[accelController release];
    [mainWindow release];
	[previewView release];
	

}


- (void)applicationWillResignActive:(UIApplication *)application {
//	NSLog(@"applicationDidBecomeActive");
	//glView.animationInterval = 1.0 / 5.0;
	//glView.animationInterval = 1.0 / 500.0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//	NSLog(@"applicationWillResignActive");
	//glView.animationInterval = 1.0 / 60.0;
	//glView.animationInterval = 1.0 / 6000.0;
}


- (void)dealloc {
	[window release];
	[glView release];
	[touchListener release];
	[super dealloc];
}

@end
