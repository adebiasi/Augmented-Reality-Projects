//
//  Vector3.h
//  NeHe Lesson 04
//
//  Created by Raffaele De Amicis on 21/10/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>



@interface Vector3 : NSObject {

	GLfloat X;
    GLfloat Y;
    GLfloat Z;
		
}


@property(readwrite, assign) GLfloat X;
@property(readwrite, assign) GLfloat Y;
@property(readwrite, assign) GLfloat Z;

//-(Vector3*) init;

//-(Vector3*) initWithX: (GLfloat) x Y: (GLfloat) y Z:(GLfloat) z;


-(Vector3*) plus: (Vector3*) vector; 
-(Vector3*) minus: (Vector3*) vector; 
-(Vector3*) mult: (GLfloat) num;
+(GLfloat) dotProd: (Vector3*) v1 vector2: (Vector3*) v2;
+(Vector3*) cossProd: (Vector3*) v1 vector2: (Vector3*) v2;

@end
