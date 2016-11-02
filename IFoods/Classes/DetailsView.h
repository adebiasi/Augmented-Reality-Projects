//
//  DetailsView.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 22/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Table.h"
#import "ViewController.h"

@class Table;
@class EAGLView;

@interface DetailsView : UIView  {

	@public
	Table *table;
	ViewController *viewController;
	UILabel* title;	
	UIButton* exitButton;
}
//@property (nonatomic, retain)  Table *table;
//@property (nonatomic, retain)  	ViewController *viewController;
//- (id)initWithFrame:(CGRect)frame;
- (void)setGLView: (EAGLView*) view;

@end

