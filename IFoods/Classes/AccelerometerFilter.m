
#import "AccelerometerFilter.h"

// Implementation of the basic filter. All it does is mirror input to output.

@implementation AccelerometerFilter

@synthesize x, y, z, adaptive;

-(void)addAcceleration:(UIAcceleration*)accel
{
	x = accel.x;
	y = accel.y;
	z = accel.z;
}

-(NSString*)name
{
	return @"You should not see this";
}

@end

#define kAccelerometerMinStep				0.02
#define kAccelerometerNoiseAttenuation		3.0

GLfloat Norm(GLfloat x, GLfloat y, GLfloat z)
{
	return sqrt(x * x + y * y + z * z);
}

GLfloat Clamp(GLfloat v, GLfloat min, GLfloat max)
{
	if(v > max)
		return max;
	else if(v < min)
		return min;
	else
		return v;
}

// See http://en.wikipedia.org/wiki/Low-pass_filter for details low pass filtering
@implementation LowpassFilter

-(id)initWithSampleRate:(GLfloat)rate cutoffFrequency:(GLfloat)freq
{
	self = [super init];
	if(self != nil)
	{
		GLfloat dt = 1.0 / rate;
		GLfloat RC = 1.0 / freq;
		filterConstant = dt / (dt + RC);
	}
	return self;
}

-(void)addAcceleration:(UIAcceleration*)accel
{
	GLfloat alpha = filterConstant;
	
	if(adaptive)
	{
		GLfloat d = Clamp(fabs(Norm(x, y, z) - Norm(accel.x, accel.y, accel.z)) / kAccelerometerMinStep - 1.0, 0.0, 1.0);
		alpha = (1.0 - d) * filterConstant / kAccelerometerNoiseAttenuation + d * filterConstant;
	}
	
	x = accel.x * alpha + x * (1.0 - alpha);
	y = accel.y * alpha + y * (1.0 - alpha);
	z = accel.z * alpha + z * (1.0 - alpha);
}

-(NSString*)name
{
	return adaptive ? @"Adaptive Lowpass Filter" : @"Lowpass Filter";
}

@end

// See http://en.wikipedia.org/wiki/High-pass_filter for details on high pass filtering
@implementation HighpassFilter

-(id)initWithSampleRate:(GLfloat)rate cutoffFrequency:(GLfloat)freq
{
	self = [super init];
	if(self != nil)
	{
		GLfloat dt = 1.0 / rate;
		GLfloat RC = 1.0 / freq;
		filterConstant = RC / (dt + RC);
	}
	return self;
}

-(void)addAcceleration:(UIAcceleration*)accel
{
	GLfloat alpha = filterConstant;
	
	if(adaptive)
	{
		GLfloat d = Clamp(fabs(Norm(x, y, z) - Norm(accel.x, accel.y, accel.z)) / kAccelerometerMinStep - 1.0, 0.0, 1.0);
		alpha = d * filterConstant / kAccelerometerNoiseAttenuation + (1.0 - d) * filterConstant;
	}
	
	x = alpha * (x + accel.x - lastX);
	y = alpha * (y + accel.y - lastY);
	z = alpha * (z + accel.z - lastZ);
	
	lastX = accel.x;
	lastY = accel.y;
	lastZ = accel.z;
}

-(NSString*)name
{
	return adaptive ? @"Adaptive Highpass Filter" : @"Highpass Filter";
}

@end