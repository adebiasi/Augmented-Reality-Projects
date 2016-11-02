//
//  DetailsView.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 22/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import "DetailsView.h"
#import "Table.h"

@implementation DetailsView

- (id)initWithFrame:(CGRect)frame
{   
	//NSLog(@"initWithFrame InfoView");
	if ((self = [super initWithFrame: frame])) {	
	[self setBackgroundColor:[UIColor lightGrayColor]];
		
		//	viewController = [[ViewController alloc] init];
		//	viewController = [[ViewController alloc] init];
		CGRect tableFrame = CGRectMake(0, 60, 320, 400);
	table = [[Table alloc]initWithFrame:tableFrame];
		
		title = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 240,60)];		
		[title setText:@"Select Restaurant"];
		[title setFont:[UIFont systemFontOfSize:18]];
		title.numberOfLines=0;
		title.textAlignment =  UITextAlignmentCenter;

		[title.layer setBorderWidth:5.0];
        [title.layer setCornerRadius:5.0];
        [title.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		exitButton = [[UIButton buttonWithType: UIButtonTypeCustom] initWithFrame:CGRectMake(0, 0, 80, 60)];
		[exitButton addTarget:self action: @selector(close) forControlEvents: UIControlEventTouchUpInside];
		[exitButton setTitle:@"X" forState:UIControlStateNormal];
		[exitButton setFont:[UIFont systemFontOfSize:40]];
		[exitButton setTitleColor:[UIColor redColor] forState: UIControlStateNormal];	
		//[exitButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
		[exitButton setBackgroundColor:[UIColor whiteColor]];			
		[exitButton.layer setBorderWidth:5.0];
        [exitButton.layer setCornerRadius:5.0];
        [exitButton.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
		
		//[self addSubview:[viewController view]];
		[self addSubview:exitButton];
		[self addSubview:title];
		[self addSubview:table];
		//[self addSubview:viewController.view];
	}
	return self;
}

- (void)close {
	NSLog(@"close");
	
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[self layer] addAnimation:animation forKey:@"SwitchToDetailsView"];
	
	self.hidden=TRUE;
	//NSMutableArray* array_Objects = [mainDel->glView->infoContr getArrayObjectsWithName:@"directions2.xml"];
	//mainDel->glView->arrayUpdObjects = [mainDel->glView->worldContr geodeticArrayToCartesianArray:array_Objects];
}

- (void)setGLView: (EAGLView*) view{
	table->glView=view;
}


@end
