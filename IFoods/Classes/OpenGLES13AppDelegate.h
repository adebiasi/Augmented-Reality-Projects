//
//  OpenGLES13AppDelegate.h
//  OpenGLES13
//
//  Created by Simon Maurice on 24/05/09.
//  Copyright Simon Maurice 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;
@class TouchListener;
@class TeslameterViewController;

@interface OpenGLES13AppDelegate : NSObject <UIApplicationDelegate> {
   
	@public
	UIWindow *window;
    EAGLView *glView;
	TouchListener * touchListener;
	
}

@property (nonatomic, retain)  UIWindow *window;
@property (nonatomic, retain)  EAGLView *glView;
@property (nonatomic, retain)  TouchListener *touchListener;


@end

