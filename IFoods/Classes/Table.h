//
//  TableController.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 22/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAGLView.h"
@class EAGLView;
@interface Table : UITableView <UITableViewDelegate,UITableViewDataSource>{
NSArray *arrayData;
	@public
	NSMutableArray* selectedPlaces;
	EAGLView* glView;
	
	
}

@property(readwrite, assign)  EAGLView* glView;


@end
