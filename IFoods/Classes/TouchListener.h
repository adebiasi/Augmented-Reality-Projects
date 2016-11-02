//
//  TouchListener.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 28/10/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Camera.h"
#import "EAGLView.h"
#import "DetailsView.h"

//#define WALK_SPEED 0.005
#define WALK_SPEED2 0.0005
#define TURN_SPEED 0.01

@class EAGLView;

@interface TouchListener : UIResponder 
{
@public
	EAGLView* glView;
	

}

@property(readwrite, assign)  EAGLView* glView;

-(void)handleTouches; 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  ;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event ;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(CGPoint) convertPoint2Angles: (CGPoint) point;

@end
