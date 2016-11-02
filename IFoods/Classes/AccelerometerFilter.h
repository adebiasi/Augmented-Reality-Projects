
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
// Basic filter object. 
@interface AccelerometerFilter : NSObject
{
	BOOL adaptive;
	UIAccelerationValue x, y, z;
}

// Add a UIAcceleration to the filter.
-(void)addAcceleration:(UIAcceleration*)accel;

@property(nonatomic, readonly) UIAccelerationValue x;
@property(nonatomic, readonly) UIAccelerationValue y;
@property(nonatomic, readonly) UIAccelerationValue z;

@property(nonatomic, getter=isAdaptive) BOOL adaptive;
@property(nonatomic, readonly) NSString *name;

@end

// A filter class to represent a lowpass filter
@interface LowpassFilter : AccelerometerFilter
{
	GLfloat filterConstant;
	UIAccelerationValue lastX, lastY, lastZ;
}

-(id)initWithSampleRate:(GLfloat)rate cutoffFrequency:(GLfloat)freq;

@end

// A filter class to represent a highpass filter.
@interface HighpassFilter : AccelerometerFilter
{
	GLfloat filterConstant;
	UIAccelerationValue lastX, lastY, lastZ;
}

-(id)initWithSampleRate:(GLfloat)rate cutoffFrequency:(GLfloat)freq;

@end