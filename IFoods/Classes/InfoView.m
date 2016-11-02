//
//  InfoView.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 10/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "InfoView.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Camera.h"
#import "EAGLView.h"
#import <UIKit/UIKit.h>

#define calibr 0.01f

@implementation InfoView

@synthesize time,mainDel,aLabel,bLabel,cLabel,leftButton,rightButton,calLabel,coeffLabel,angleLabel,upCoeffButton,downCoeffButton,
angleXCoeffLabel,angleXUpCoeffButton,angleXDownCoeffButton,
angleYCoeffLabel,angleYUpCoeffButton,angleYDownCoeffButton,
angleZCoeffLabel,angleZUpCoeffButton,angleZDownCoeffButton,destinationLabel;
;
/*
NSString *text; 
NSString *textPos;
NSString *textTime;
*/
- (id)initWithFrame:(CGRect)frame
{   
	//NSLog(@"initWithFrame InfoView");
	if ((self = [super initWithFrame: frame])) {	
		
		
		 aLabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 0, 300, 30)];		
		CGPoint labelCenter = CGPointMake(150, 420);
		//aLabel.center = self.center;
		aLabel.center = labelCenter;
		UIFont *mySystemFont = [UIFont fontWithName:@"AppleGothic" size:10.0];
		[aLabel setFont:mySystemFont];
		[aLabel setText:@"prova"];
		
		
		bLabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 0, 300, 30)];		
		CGPoint labelCenter2 = CGPointMake(150, 390);
		//aLabel.center = self.center;
		bLabel.center = labelCenter2;
		[bLabel setFont:mySystemFont];
		[bLabel setText:@"prova"];
		
		
		cLabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 0, 300, 30)];		
		CGPoint labelCenter3 = CGPointMake(150, 360);
		//aLabel.center = self.center;
		cLabel.center = labelCenter3;
		[cLabel setFont:mySystemFont];
		[cLabel setText:@"prova"];
		/*
		angleLabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 0, 300, 30)];		
		CGPoint labelCenter3 = CGPointMake(150, 330);
		//aLabel.center = self.center;
		angleLabel.center = labelCenter3;
		[angleLabel setFont:mySystemFont];
		[angleLabel setText:@"prova"];
		*/
		[self addSubview:aLabel];
		[self addSubview:bLabel];
		[self addSubview:cLabel];
		//[self addSubview:angleLabel];
		/*
		text = [[NSString alloc] init]; 
		textPos = [[NSString alloc] init];
		textTime = [[NSString alloc] init];
	*/
			
		leftButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(0, 0, 65, 25)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[leftButton addTarget:self action: @selector(subCal) forControlEvents: UIControlEventTouchDownRepeat];
		[leftButton setTitle:@"Next" forState:UIControlStateNormal];
		[leftButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		rightButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(250, 0, 65, 25)];
		[rightButton addTarget:self action: @selector(addCal) forControlEvents: UIControlEventTouchUpInside];
		[rightButton setTitle:@"Next" forState:UIControlStateNormal];
		[rightButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];

		calLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 180,25)];		
	//	CGPoint callabelCenter = CGPointMake(150, 360);
		//aLabel.center = self.center;
	//	calLabel.center = calLabelCenter;
		[calLabel setFont:mySystemFont];
		[calLabel setText:@"prova"];
		
	[self addSubview:leftButton];
		[self addSubview:rightButton];
		[self addSubview:calLabel];
	
	
	
	
	upCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(0, 25, 65, 25)];
	//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
	[upCoeffButton addTarget:self action: @selector(incrCoeff) forControlEvents: UIControlEventTouchUpInside];
	[upCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
	[upCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
	
	downCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(250, 25, 65, 25)];
	[downCoeffButton addTarget:self action: @selector(decrCoeff) forControlEvents: UIControlEventTouchUpInside];
	[downCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
	[downCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
	
	coeffLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 25, 180,25)];		
	//	CGPoint callabelCenter = CGPointMake(150, 360);
	//aLabel.center = self.center;
	//	calLabel.center = calLabelCenter;
	[coeffLabel setFont:mySystemFont];
	[coeffLabel setText:@"prova"];
	
		
		angleXUpCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(0, 50, 65, 25)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[angleXUpCoeffButton addTarget:self action: @selector(angleXUpCoeff) forControlEvents: UIControlEventTouchUpInside];
		[angleXUpCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
		[angleXUpCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		angleXDownCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(250, 50, 65, 25)];
		[angleXDownCoeffButton addTarget:self action: @selector(angleXDownCoeff) forControlEvents: UIControlEventTouchUpInside];
		[angleXDownCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
		[angleXDownCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		angleXCoeffLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 50, 180,25)];		
		//	CGPoint callabelCenter = CGPointMake(150, 360);
		//aLabel.center = self.center;
		//	calLabel.center = calLabelCenter;
		[angleXCoeffLabel setFont:mySystemFont];
		[angleXCoeffLabel setText:@"prova"];
				
	//	[self addSubview:angleXCoeffLabel];
	//	[self addSubview:angleXUpCoeffButton];
	//	[self addSubview:angleXDownCoeffButton];
		
		angleYUpCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(0, 75, 65, 25)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[angleYUpCoeffButton addTarget:self action: @selector(angleYUpCoeff) forControlEvents: UIControlEventTouchUpInside];
		[angleYUpCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
		[angleYUpCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		angleYDownCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(250, 75, 65, 25)];
		[angleYDownCoeffButton addTarget:self action: @selector(angleYDownCoeff) forControlEvents: UIControlEventTouchUpInside];
		[angleYDownCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
		[angleYDownCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		angleYCoeffLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 75, 180,25)];		
		//	CGPoint callabelCenter = CGPointMake(150, 360);
		//aLabel.center = self.center;
		//	calLabel.center = calLabelCenter;
		[angleYCoeffLabel setFont:mySystemFont];
		[angleYCoeffLabel setText:@"prova"];
		
	//	[self addSubview:angleYCoeffLabel];
	//	[self addSubview:angleYUpCoeffButton];
	//	[self addSubview:angleYDownCoeffButton];

		angleZUpCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(0, 100, 65, 25)];
		//[leftButton addTarget:self action: @selector(testInfo) forControlEvents: UIControlEventTouchUpInside];
		[angleZUpCoeffButton addTarget:self action: @selector(angleZUpCoeff) forControlEvents: UIControlEventTouchUpInside];
		[angleZUpCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
		[angleZUpCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		angleZDownCoeffButton = [[UIButton buttonWithType: UIButtonTypeRoundedRect] initWithFrame:CGRectMake(250, 100, 65, 25)];
		[angleZDownCoeffButton addTarget:self action: @selector(angleZDownCoeff) forControlEvents: UIControlEventTouchUpInside];
		[angleZDownCoeffButton setTitle:@"Next" forState:UIControlStateNormal];
		[angleZDownCoeffButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		
		angleZCoeffLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 100, 180,25)];		
		//	CGPoint callabelCenter = CGPointMake(150, 360);
		//aLabel.center = self.center;
		//	calLabel.center = calLabelCenter;
		[angleZCoeffLabel setFont:mySystemFont];
		[angleZCoeffLabel setText:@"prova"];
		
	//	[self addSubview:angleZCoeffLabel];
	//	[self addSubview:angleZUpCoeffButton];
	//	[self addSubview:angleZDownCoeffButton];
		
		destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 50, 180,25)];		
		//	CGPoint callabelCenter = CGPointMake(150, 360);
		//aLabel.center = self.center;
		//	calLabel.center = calLabelCenter;
		[destinationLabel setFont:mySystemFont];
		[destinationLabel setText:@"destinazione"];
		
		[self addSubview:destinationLabel];
		
	[self addSubview:coeffLabel];
	[self addSubview:upCoeffButton];
	[self addSubview:downCoeffButton];
	
		
	}
	return self;
}


- (void)startAnimation {
	
	NSTimeInterval animationInterval=1.0 / 60.0;
	//NSTimeInterval animationInterval=1000.0 ;
	
	
	 self.time = [NSTimer scheduledTimerWithTimeInterval:animationInterval 
	 target:self 
	 // selector:@selector(printTest)													 
	 selector:@selector(refreshInfo)													 
	 userInfo:nil 
	 repeats:YES];
	
	//[self refreshCamera];
	
}

- (void)angleXUpCoeff {
	
	mainDel->glView->worldContr->countXAngle+=5;
	
}
- (void)angleXDownCoeff {
	
	mainDel->glView->worldContr->countXAngle-=5;
	}

- (void)angleYUpCoeff {
	
	mainDel->glView->worldContr->countYAngle+=5;
	}
- (void)angleYDownCoeff {
	
	mainDel->glView->worldContr->countYAngle-=5;
	}
- (void)angleZUpCoeff {
	
	mainDel->glView->worldContr->countZAngle+=5;
	
}
- (void)angleZDownCoeff {
	
	mainDel->glView->worldContr->countZAngle-=5;
	
}
- (void)addCal {
	
	mainDel->glView->camera->calibrate+=calibr;
}
- (void)subCal {
	
	mainDel->glView->camera->calibrate-=calibr;
	
}

- (void)incrCoeff {
	
	//mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar*1.5f;
	mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar+100.0f;
	
}
- (void)decrCoeff {
	
	//mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar/1.5f;
	if(mainDel->glView->camera->coeff_Radar>0){
	mainDel->glView->camera->coeff_Radar=mainDel->glView->camera->coeff_Radar-100.0f;
	}
	
}

- (void)refreshInfo {
	
	LatLon* pos=mainDel->glView->camera->userLocation;
	NSTimeInterval comp=mainDel->glView->camera->refreshCompassInterval;
	NSTimeInterval view=mainDel->glView->camera->refreshVirtualViewInterval;

	
	GLfloat az=mainDel->glView->camera->azimuth;
	GLfloat va=mainDel->glView->camera->angleView;
	GLfloat cal=mainDel->glView->camera->calibrate;
	CLLocationAccuracy hAcc=mainDel->glView->camera->hAccuracy;
	//CLLocationAccuracy vAcc=mainDel->glView->camera->vAccuracy;
	int isRadar=mainDel->glView->camera->isRadar;
GLfloat angle=mainDel->glView->camera->y_angle;
	GLfloat radar=mainDel->glView->camera->coeff_Radar;
	
	GLfloat angleXCoeff=mainDel->glView->worldContr->countXAngle;
	GLfloat angleYCoeff=mainDel->glView->worldContr->countYAngle;
	GLfloat angleZCoeff=mainDel->glView->worldContr->countZAngle;
	
	NSString *text = [NSString  stringWithFormat: @"Azim:%f   VertAngl:%f isRadar:%i An:%f", az,va,isRadar,angle]; 
	NSString *textPos = [NSString  stringWithFormat: @"Latitude:%f   Longitude:%f Accuracy:%f", pos.latitude,pos.longitude,hAcc];
	NSString *textTime = [NSString stringWithFormat: @"CompassRefreshInterval:%f   ViewRefreshInterval:%f", comp,view];
	
	NSString *textCal = [NSString stringWithFormat: @"Calibrate:%f", cal];
	
	
	NSString *textRadar = [NSString stringWithFormat: @"ScaleRadar:%f", radar];
	
	NSString *textXAngleCoeff = [NSString stringWithFormat: @"AngleX:%f", angleXCoeff];
	NSString *textYAngleCoeff = [NSString stringWithFormat: @"AngleY:%f", angleYCoeff];
	NSString *textZAngleCoeff = [NSString stringWithFormat: @"AngleZ:%f", angleZCoeff];
	
	[aLabel setText:text];
	
		//NSString *textPos = [[NSString alloc]NSString stringWithFormat: @"Latitude:%f   Longitude:%f", pos.latitude,pos.longitude];
	
	[bLabel setText:textPos];
	
	
		
	[cLabel setText:textTime];
	
	[calLabel setText:textCal];
	[coeffLabel setText:textRadar];
	
	[angleXCoeffLabel setText:textXAngleCoeff];
	[angleYCoeffLabel setText:textYAngleCoeff];
	[angleZCoeffLabel setText:textZAngleCoeff];
	
	NSString *dest = [NSString stringWithFormat: @"Dest:%@", [mainDel->glView->worldContr->destination name]];
	
	[destinationLabel setText:dest];
	
	 text=nil;
	 textPos=nil;
	 textTime=nil;
	textCal=nil;
	textRadar=nil;
	[text release];
	[textPos release];
	[textTime release];
	[textCal release];
	[textRadar release];
	
	}

- (void)dealloc {
   	[super dealloc];
}


@end
