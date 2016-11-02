//
//  InfoView2.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 02/12/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "InfoView2.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Camera.h"
#import "EAGLView.h"
#import <UIKit/UIKit.h>
#import "PlacesMngt.h"

@implementation InfoView2

@synthesize dest1Button,dest2Button,dest3Button,dest4Button,mainDel,time,
upCoeffButton,downCoeffButton,destinationLabel,posLabel,nextDestButton,prevDestButton,textDestination,startButton,lastPathButton,gpsImage;

PlacesMngt* placeContr;

LocalXYZInfoController* infoContr;
UIActivityIndicatorView* indicator;

- (id)initWithFrame:(CGRect)frame
{   
	//NSLog(@"initWithFrame InfoView");
	if ((self = [super initWithFrame: frame])) {	
		
		infoContr =[[LocalXYZInfoController alloc] init];
		
		placeContr =[[PlacesMngt alloc] init];
		

		//startButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(160, 380, 160, 60)];
		lastPathButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(0, 0, 160, 60)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[lastPathButton addTarget:self action: @selector(lastPath) forControlEvents: UIControlEventTouchUpInside];
		[lastPathButton setTitle:@"Last Path" forState:UIControlStateNormal];
		[lastPathButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		[lastPathButton setFont:[UIFont systemFontOfSize:15]];
		
		//se si commenta è trasparente
		[lastPathButton setBackgroundColor:[UIColor whiteColor]];
		
		[lastPathButton.layer setBorderWidth:5.0];
        [lastPathButton.layer setCornerRadius:5.0];
        [lastPathButton.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		//startButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(160, 380, 160, 60)];
		startButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(160, 0, 160, 60)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[startButton addTarget:self action: @selector(start) forControlEvents: UIControlEventTouchUpInside];
		[startButton setTitle:@"Update Restaurants" forState:UIControlStateNormal];
		[startButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		[startButton setFont:[UIFont systemFontOfSize:15]];
		
		[startButton setBackgroundColor:[UIColor whiteColor]];
		
		[startButton.layer setBorderWidth:5.0];
        [startButton.layer setCornerRadius:5.0];
        [startButton.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		
		
//		upCoeffButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(5, 80, 65, 25)];
	//upCoeffButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(160, 380, 80, 60)];
		upCoeffButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(80, 0, 80, 60)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[upCoeffButton addTarget:self action: @selector(incrCoeff) forControlEvents: UIControlEventTouchUpInside];
		[upCoeffButton setTitle:@"zoom -" forState:UIControlStateNormal];
		[upCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		[upCoeffButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
		[upCoeffButton setBackgroundColor:[UIColor whiteColor]];
		
		[upCoeffButton.layer setBorderWidth:5.0];
        [upCoeffButton.layer setCornerRadius:5.0];
        [upCoeffButton.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		
		//downCoeffButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(240, 380, 80, 60)];
		downCoeffButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(160, 0, 80, 60)];
		[downCoeffButton addTarget:self action: @selector(decrCoeff) forControlEvents: UIControlEventTouchUpInside];
		[downCoeffButton setTitle:@"zoom +" forState:UIControlStateNormal];
		[downCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];	
		[downCoeffButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
		[downCoeffButton setBackgroundColor:[UIColor whiteColor]];			
		[downCoeffButton.layer setBorderWidth:5.0];
        [downCoeffButton.layer setCornerRadius:5.0];
        [downCoeffButton.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		nextDestButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(240, 0, 80, 60)];
		[nextDestButton addTarget:self action: @selector(nextDest) forControlEvents: UIControlEventTouchUpInside];
		[nextDestButton setTitle:@">>" forState:UIControlStateNormal];
		[nextDestButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];	
		[nextDestButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
		[nextDestButton setBackgroundColor:[UIColor whiteColor]];			
		[nextDestButton.layer setBorderWidth:5.0];
        [nextDestButton.layer setCornerRadius:5.0];
        [nextDestButton.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		prevDestButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(0, 0, 80, 60)];
		[prevDestButton addTarget:self action: @selector(prevDest) forControlEvents: UIControlEventTouchUpInside];
		[prevDestButton setTitle:@"<<" forState:UIControlStateNormal];
		[prevDestButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];	
		[prevDestButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
		[prevDestButton setBackgroundColor:[UIColor whiteColor]];			
		[prevDestButton.layer setBorderWidth:5.0];
        [prevDestButton.layer setCornerRadius:5.0];
        [prevDestButton.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		/*
		dest1Button = [[UIButton buttonWithType: UIButtonTypeCustom] init];
		dest1Button.frame=CGRectMake(5, 0, 70, 35);
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[dest1Button addTarget:self action: @selector(dest1) forControlEvents: UIControlEventTouchUpInside];
		[dest1Button setTitle:@"1" forState:UIControlStateNormal];
		[dest1Button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
		[dest1Button setBackgroundColor:[UIColor whiteColor]];
		//[dest1Button setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];
	
		
		//[dest1Button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		dest2Button = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(85, 0, 70, 35)];
		[dest2Button addTarget:self action: @selector(dest2) forControlEvents: UIControlEventTouchUpInside];
		[dest2Button setTitle:@"2" forState:UIControlStateNormal];
		[dest2Button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		[dest2Button setBackgroundColor:[UIColor whiteColor]];
		*/		
		/*
		textDestination = [[UITextField alloc] initWithFrame:CGRectMake(165, 0, 140, 35)];
		textDestination.delegate=self;
		textDestination.placeholder = @"<Enter Destination>";
[textDestination setBackgroundColor:[UIColor whiteColor]];
		*/
		 /*
		dest3Button = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(165, 0, 70, 35)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[dest3Button addTarget:self action: @selector(dest3) forControlEvents: UIControlEventTouchUpInside];
		[dest3Button setTitle:@"3" forState:UIControlStateNormal];
		[dest3Button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		[dest3Button setBackgroundColor:[UIColor whiteColor]];
		
		dest4Button = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(245, 0, 70, 35)];
		[dest4Button addTarget:self action: @selector(dest4) forControlEvents: UIControlEventTouchUpInside];
		[dest4Button setTitle:@"4" forState:UIControlStateNormal];
		[dest4Button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		[dest4Button setBackgroundColor:[UIColor whiteColor]];
		
		*/
		//posLabel = [[UILabel alloc] initWithFrame:CGRectMake(450, 0, 50, 30)];		
		posLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 340, 160,60)];		
		
		
		////////posLabel.hidden=TRUE;
		
		
		//CGPoint labelCenter2 = CGPointMake(150, 390);
		
		//posLabel.center = labelCenter2;
		
		[posLabel setText:@"prova"];
		[posLabel setFont:[UIFont systemFontOfSize:12]];
		posLabel.numberOfLines=0;
		
		//destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 160,60)];		
		destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 430, 320,30)];		
		//	CGPoint callabelCenter = CGPointMake(150, 360);
		//aLabel.center = self.center;
		//	calLabel.center = calLabelCenter;
		//[destinationLabel setFont:mySystemFont];
		
		//[destinationLabel setText:@"destinazione"];
		
		[destinationLabel setBackgroundColor:[UIColor blackColor]];
		destinationLabel.textColor = [UIColor whiteColor];
		//TRASPARENZA
		//destinationLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]; 

		[destinationLabel setFont:[UIFont systemFontOfSize:12]];
		destinationLabel.numberOfLines=0;
		
		
		
		gpsImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 370, 60,60)];	
		//gpsImage = [UIImage imageNamed:@"restaurant.png"];
		[gpsImage setImage:[UIImage imageNamed:@"GPS_no.png"]];
		//[gpsImage setCGImage:imageRef];
		
		
		[self addSubview:gpsImage];

		[self addSubview:destinationLabel];
		
		[self addSubview:startButton];
		[self addSubview:lastPathButton];
		
	//	[self addSubview:upCoeffButton];
	//	[self addSubview:downCoeffButton];
		
		[self addSubview:nextDestButton];
		[self addSubview:prevDestButton];
		
		//[self addSubview:dest1Button];
		//[self addSubview:dest2Button];
	
		//	[self addSubview:dest1Button];
	//		[self addSubview:dest3Button];
	//	[self addSubview:dest4Button];
	//	[self addSubview:textDestination];

		[self addSubview:posLabel];
		
	}
	return self;
}

- (void)dest1 {
	//NSMutableArray* arrayUpdObjects=[infoContr getArrayObjectsWithName:@"directionsRemote.xml"];	
	//NSMutableArray* arrayResults=[infoContr getArrayObjectsWithName:@"directionsRemoteTest.xml"];	
	NSMutableArray* arrayResults=[infoContr getArrayObjectsWithName:@"PlacesTest2.xml"];	
	LatLon* pos=mainDel->glView->camera->userLocation;
	//NSMutableArray* arrayResults=[infoContr receiveArrayObjectsWithDestination:@"Via_San_Giorgio_37_,_38068_Rovereto,_TN,_Italia" UserLocation:pos];
	
	NSMutableArray* arrayPlacemarks=[arrayResults objectAtIndex:0];	
	NSMutableArray* arrayPath=[arrayResults objectAtIndex:1];	
	//arrayUpdObjects=[infoContr receiveArrayObjectsWithDestination:dest UserLocation:userLoc];
	
	
	mainDel->glView->arrayPlacemarks = arrayPlacemarks;
	mainDel->glView->arrayPath = arrayPath;
	//NSMutableArray* array_Objects = [mainDel->glView->infoContr getArrayObjectsWithName:@"directions.xml"];
	//mainDel->glView->arrayUpdObjects = [mainDel->glView->worldContr geodeticArrayToCartesianArray:array_Objects];
}

- (void)dest2 {	
	/*
	LatLon* pos=mainDel->glView->camera->userLocation;
	//NSMutableArray* arrayResults=[infoContr receiveArrayObjectsWithDestination:@"Verona,Italy" UserLocation:pos];
	
	NSMutableArray* arrayResults=[infoContr getArrayObjectsWithName:@"Verona.xml"];	
	NSMutableArray* arrayPlacemarks=[arrayResults objectAtIndex:0];	
	NSMutableArray* arrayPath=[arrayResults objectAtIndex:1];	
		
	mainDel->glView->arrayPlacemarks = arrayPlacemarks;
mainDel->glView->arrayPath = arrayPath;

*/

	//LatLon* pos=mainDel->glView->camera->userLocation;	
	
	//NSMutableArray* arrayResults=[placeContr receiveArrayObjectsWithUserLocation:pos];
	NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"PlacesTest3.xml"];
	
	
	NSMutableArray* arrayPlaces=[arrayResults objectAtIndex:0];
	
	NSLog(@"arrayUpdObjects: %i", [arrayPlaces count]);
	
	mainDel->glView->arrayPlaces = arrayPlaces;


}

- (void)dest3 {
	//NSMutableArray* array_Objects = [mainDel->glView->infoContr getArrayObjectsWithName:@"directions2.xml"];
//mainDel->glView->arrayUpdObjects = [mainDel->glView->worldContr geodeticArrayToCartesianArray:array_Objects];
}

- (void)dest4 {
//	NSMutableArray* array_Objects = [mainDel->glView->infoContr getArrayObjectsWithName:@"directions3.xml"];
//mainDel->glView->arrayUpdObjects = [mainDel->glView->worldContr geodeticArrayToCartesianArray:array_Objects];
}

- (void)incrCoeff {
	NSLog(@"zoom:%f",mainDel->glView->camera->coeff_Radar);
	//mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar*1.5f;
	mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar+500.0f;
	
	
}
- (void)decrCoeff {
	
	//mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar/1.5f;
	if(mainDel->glView->camera->coeff_Radar>500){
		NSLog(@"dist %f",		mainDel->glView->camera->coeff_Radar);
		mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar-500.0f;
	}
}
	- (void)nextDest {
		
		//mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar*1.5f;
		mainDel->glView->worldContr->nextDestinationIndex++;
		//NSLog(@"radar coeff:%f",mainDel->glView->camera->coeff_Radar	);
		
	}
	- (void)prevDest{
		
		//mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar/1.5f;
		if(mainDel->glView->worldContr->nextDestinationIndex>0){
			mainDel->glView->worldContr->nextDestinationIndex--;
		}
		
	}

- (void)start {
		
	CGRect rect = self.superview.frame;	
	indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];	
	CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0); 	
	CGRect frame = CGRectMake(center.x-50, center.y-50, 100, 100);	
	[indicator setFrame:frame];	
	[indicator startAnimating];
	[self  addSubview:indicator];
	
	[NSThread detachNewThreadSelector:@selector(updRestaurantBackgroundJob) toTarget:self withObject:nil]; 

	
	mainDel->glView->graphContr->arrayTextureTextPlace=[mainDel->glView->graphContr getArrayPlaceText:mainDel->glView->arrayPlaces];
	
	 
	 /*
	LatLon* pos=mainDel->glView->camera->userLocation;	
	
	placeContr->userLocation=pos;
	NSMutableArray* arrayResults=[placeContr receiveArrayObjectsWithUserLocation:pos];
	//NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"PlacesTest3.xml"];
	
	
	NSMutableArray* arrayPlaces=[arrayResults objectAtIndex:0];
		
	NSLog(@"arrayUpdObjects: %i", [arrayPlaces count]);
	
	mainDel->glView->arrayPlaces = arrayPlaces;
	
	mainDel->glView->graphContr->arrayTextureTextPlace=[mainDel->glView->graphContr getArrayPlaceText:arrayPlaces];
	*/
		}

-(void)updRestaurantBackgroundJob{

	self.userInteractionEnabled=FALSE;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	
	LatLon* pos=mainDel->glView->camera->userLocation;	
	
	placeContr->userLocation=pos;
	placeContr->firstUserLocation=mainDel->glView->camera->firstUserLocation;	
	NSMutableArray* arrayResults=[placeContr receiveArrayObjectsWithUserLocation:pos];
	//NSMutableArray* arrayResults=[placeContr getArrayObjectsWithName:@"PlacesTest3.xml"];	
	NSMutableArray* arrayPlaces=[arrayResults objectAtIndex:0];	
	NSLog(@"updRestaurantBackgroundJob: %i", [arrayPlaces count]);	
	mainDel->glView->arrayPlaces = arrayPlaces;	
	GraphicController* graphContr = [[GraphicController alloc]init];
//	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
//		glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);	
	//NSMutableArray* places = [graphContr getArrayPlaceText:arrayPlaces];

	//////mainDel->glView->graphContr->arrayTextureTextPlace=[mainDel->glView->graphContr getArrayPlaceText:mainDel->glView->arrayPlaces];
	
	//mainDel->glView->graphContr->arrayTextureTextPlace=places;
	NSLog(@"arrayTextureTextPlace: %i", [mainDel->glView->graphContr->arrayTextureTextPlace count]);	
	
	self.userInteractionEnabled=TRUE;
	
	[pool release];
	[indicator stopAnimating];
}

- (void)lastPath {
	
	CGRect rect = self.superview.frame;	
	indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];	
	CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0); 	
	CGRect frame = CGRectMake(center.x-50, center.y-50, 100, 100);	
	//[indicator setCenter:center];
	[indicator setFrame:frame];	
	//UIProgressView* indicator = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
	[indicator startAnimating];
	//[indicator setCenter:CGPointMake(100, 100)];
	[self  addSubview:indicator];
	
	
	[NSThread detachNewThreadSelector:@selector(lastPathBackgroundJob) toTarget:self withObject:nil]; 

	/*
	LatLon* pos=mainDel->glView->camera->userLocation;	
	infoContr->userLocation=pos;
	NSMutableArray* arrayResults=[infoContr getArrayObjectsWithName:@"LastPath.xml"];	
	
	NSMutableArray* arrayPlacemarks=[arrayResults objectAtIndex:0];	
	NSMutableArray* arrayPath=[arrayResults objectAtIndex:1];	
	//arrayUpdObjects=[infoContr receiveArrayObjectsWithDestination:dest UserLocation:userLoc];	
	
	mainDel->glView->arrayPlacemarks = arrayPlacemarks;
	mainDel->glView->arrayPath = arrayPath;	
	*/
}

-(void) lastPathBackgroundJob{
	self.userInteractionEnabled=FALSE;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	LatLon* pos=mainDel->glView->camera->firstUserLocation;	
	infoContr->firstUserLocation=pos;
	NSMutableArray* arrayResults=[infoContr getArrayObjectsWithName:@"LastPath.xml"];	
	
	NSMutableArray* arrayPlacemarks=[arrayResults objectAtIndex:0];	
	NSMutableArray* arrayPath=[arrayResults objectAtIndex:1];	
	//arrayUpdObjects=[infoContr receiveArrayObjectsWithDestination:dest UserLocation:userLoc];	
	
	mainDel->glView->arrayPlacemarks = arrayPlacemarks;
	mainDel->glView->arrayPath = arrayPath;	
	
	self.userInteractionEnabled=TRUE;
	
	[pool release];
	[indicator stopAnimating];
	
	
}
- (void)startAnimation {
	
	NSTimeInterval animationInterval=1.0 / 60.0;
	//NSTimeInterval animationInterval=1000.0 ;
	
	
	self.time = [NSTimer scheduledTimerWithTimeInterval:animationInterval 
												 target:self 
				 // selector:@selector(printTest)													 
											   selector:@selector(refreshInfo2)													 
											   userInfo:nil 
												repeats:YES];
	
	//[self refreshCamera];
	
}

- (void)refreshInfo2 {
	
	LatLon* pos=mainDel->glView->camera->userLocation;	
	CLLocationAccuracy hAcc=mainDel->glView->camera->hAccuracy;
	CLLocationAccuracy vAcc=mainDel->glView->camera->vAccuracy;

	GLfloat nord=mainDel->glView->camera->azimuth;
	
	NSString *textPos = [NSString  stringWithFormat: @"Lat:%f Lon:%f Alt:%f\n vAc:%i,hAc:%i Nord:%f", pos.latitude,pos.longitude,pos.altitude,(int)vAcc,(int)hAcc,nord];
	[posLabel setText:textPos];
	
	if(vAcc==-1){
		[gpsImage setImage:[UIImage imageNamed:@"GPS_off.png"]];
	}else if(hAcc>50000){
		[gpsImage setImage:[UIImage imageNamed:@"GPS_no.png"]];
	}else if(hAcc>1000){
		[gpsImage setImage:[UIImage imageNamed:@"GPS_med.png"]];
	}else{
		[gpsImage setImage:[UIImage imageNamed:@"GPS_ok.png"]];
	}
	
	if(mainDel->glView->camera->isRadar==FALSE){
	//	upCoeffButton.hidden=TRUE;
	//	downCoeffButton.hidden=TRUE;
		nextDestButton.hidden=TRUE;
		prevDestButton.hidden=TRUE;
		
		startButton.hidden=FALSE;
		lastPathButton.hidden=FALSE;
		if([mainDel->glView->arrayPlacemarks count]!=0){
		
		//int startIndex=[mainDel->glView->worldContr findNearestDest2:mainDel->glView->arrayPlacemarks PosUser:pos];
			int startIndex=mainDel->glView->worldContr->nextDestIndex;
		LatLon* nextDest = [mainDel->glView->arrayPlacemarks objectAtIndex:startIndex];
		NSString *dest = [NSString stringWithFormat: @"N°:%i,  Dest:%@",startIndex, [nextDest name]];	
		[destinationLabel setText:dest];	
		}
		
	}else{
		if([mainDel->glView->worldContr->nextDestination name]!=NULL){	
	NSString *dest = [NSString stringWithFormat: @"N°:%i,  Dest:%@",mainDel->glView->worldContr->nextDestinationIndex, [mainDel->glView->worldContr->nextDestination name]];	
	[destinationLabel setText:dest];	
	}
		
//	upCoeffButton.hidden=FALSE;
//		downCoeffButton.hidden=FALSE;
		nextDestButton.hidden=FALSE;
		prevDestButton.hidden=FALSE;
		
		startButton.hidden=TRUE;
		lastPathButton.hidden=TRUE;
	}
	
}

- (void)dealloc {
   	[super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	//NSLog(@"destination:%@",textField.text);
	LatLon* pos=mainDel->glView->camera->userLocation;
	//NSMutableArray* arrayUpdObjects=[infoContr getArrayObjectsWithName:@"directionsRemote.xml"];	
	
	NSString *formattedText=[textField.text stringByReplacingOccurrencesOfString:@" " withString:@"_"];
	
	NSLog(@"formatted destination:%@",formattedText);

	//NSMutableArray* arrayResults=[infoContr receiveArrayObjectsWithDestination:@"via_della_cascata_Povo_Trento" UserLocation:pos];
	NSMutableArray* arrayResults=[infoContr receiveArrayObjectsWithDestination:formattedText UserLocation:pos];
	NSMutableArray* arrayPlacemarks=[arrayResults objectAtIndex:0];
	NSMutableArray* arrayPath=[arrayResults objectAtIndex:1];
	//NSMutableArray* arrayUpdObjects=[infoContr receiveArrayObjectsWithDestination:textField.text UserLocation:pos];
	
	NSLog(@"arrayUpdObjects: %i", [arrayPlacemarks count]);
	
	mainDel->glView->arrayPlacemarks = arrayPlacemarks;
	mainDel->glView->arrayPath = arrayPath;
	
	return NO;
}

- (void)setUserLocation{

	infoContr->userLocation=mainDel->glView->camera->userLocation;

}

@end
