//
//  InfoView2.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 02/12/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLES13AppDelegate.h"


@interface InfoView2 : UIView {

	@private
	UIButton *dest1Button;
	UIButton *dest2Button;	
	UIButton *dest3Button;
	UIButton *dest4Button;
	
	
	UIButton *startButton;
	UIButton *lastPathButton;
	
	UITextField *textDestination;
	
	UILabel *posLabel;
	
	UIImageView *gpsImage;
	
	UIButton *upCoeffButton;
	UIButton *downCoeffButton;
	
	UIButton *nextDestButton;
	UIButton *prevDestButton;
	
	UILabel *destinationLabel;
	
@public
	OpenGLES13AppDelegate *mainDel;
	NSTimer *time;
}

@property (nonatomic, retain)  	UIButton *upCoeffButton;
@property (nonatomic, retain)  	UIButton *downCoeffButton;

@property (nonatomic, retain)  	UIButton *nextDestButton;
@property (nonatomic, retain)  	UIButton *prevDestButton;

@property (nonatomic, retain)  	UILabel *posLabel;
@property (nonatomic, retain)  	UIImageView *gpsImage;

@property (nonatomic, retain)  	UIButton *startButton;
@property (nonatomic, retain)  	UIButton *lastPathButton;

@property (nonatomic, retain)  	UIButton *dest1Button;
@property (nonatomic, retain)  	UIButton *dest2Button;
@property (nonatomic, retain)  	UIButton *dest3Button;
@property (nonatomic, retain)  	UIButton *dest4Button;

@property (nonatomic, retain) UITextField *textDestination;


@property (nonatomic, retain)  	UILabel *destinationLabel;

@property (nonatomic, retain)  NSTimer *time;
@property (nonatomic, retain)  OpenGLES13AppDelegate *mainDel;

- (void)startAnimation;
- (void)setUserLocation;
@end
