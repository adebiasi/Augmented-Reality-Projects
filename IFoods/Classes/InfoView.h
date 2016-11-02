//
//  InfoView.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 10/11/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLES13AppDelegate.h"


@interface InfoView : UIView {

	
@private
   	UILabel *aLabel;
	UILabel *bLabel;
	UILabel *cLabel;
	UILabel *calLabel;
	UILabel *coeffLabel;
	
	UILabel *angleLabel;
	
	UIButton *leftButton;
		UIButton *rightButton;
	
	UIButton *upCoeffButton;
	UIButton *downCoeffButton;
	/*
	UILabel *angleXCoeffLabel;
	UIButton *angleXUpCoeffButton;
	UIButton *angleXDownCoeffButton;
	
	UILabel *angleXCoeffLabel;
	UIButton *angleXUpCoeffButton;
	UIButton *angleXDownCoeffButton;
	*/
	UILabel *destinationLabel;
	
	UILabel *angleXCoeffLabel;
	UIButton *angleXUpCoeffButton;
	UIButton *angleXDownCoeffButton;
	
	UILabel *angleYCoeffLabel;
	UIButton *angleYUpCoeffButton;
	UIButton *angleYDownCoeffButton;
	
	UILabel *angleZCoeffLabel;
	UIButton *angleZUpCoeffButton;
	UIButton *angleZDownCoeffButton;
@public
	OpenGLES13AppDelegate *mainDel;
	NSTimer *time;
		
}

@property (nonatomic, retain)  NSTimer *time;
@property (nonatomic, retain)  	UILabel *aLabel;
@property (nonatomic, retain)  	UILabel *bLabel;
@property (nonatomic, retain)  	UILabel *cLabel;
@property (nonatomic, retain)  	UILabel *calLabel;
@property (nonatomic, retain)  	UILabel *coeffLabel;


//@property (nonatomic, retain)  	UILabel *coeffLabel;
@property (nonatomic, retain)  	UILabel *angleLabel;

@property (nonatomic, retain)  	UIButton *leftButton;
@property (nonatomic, retain)  	UIButton *rightButton;
@property (nonatomic, retain)  	UIButton *upCoeffButton;
@property (nonatomic, retain)  	UIButton *downCoeffButton;

@property (nonatomic, retain)  	UILabel *destinationLabel;

@property (nonatomic, retain)  	UIButton *angleXUpCoeffButton;
@property (nonatomic, retain)  	UIButton *angleXDownCoeffButton;
@property (nonatomic, retain)  	UILabel *angleXCoeffLabel;

@property (nonatomic, retain)  	UIButton *angleYUpCoeffButton;
@property (nonatomic, retain)  	UIButton *angleYDownCoeffButton;
@property (nonatomic, retain)  	UILabel *angleYCoeffLabel;

@property (nonatomic, retain)  	UIButton *angleZUpCoeffButton;
@property (nonatomic, retain)  	UIButton *angleZDownCoeffButton;
@property (nonatomic, retain)  	UILabel *angleZCoeffLabel;


@property (nonatomic, retain)  OpenGLES13AppDelegate *mainDel;

- (void)startAnimation;
@end
