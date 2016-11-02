
#import "MainViewController.h"
#import "AccelerometerFilter.h"

#define kUpdateFrequency	60.0

@interface MainViewController()

// Sets up a new filter. Since the filter's class matters and not a particular instance
// we just pass in the class and -changeFilter: will setup the proper filter.
-(void)changeFilter:(Class)filterClass;

@end

@implementation MainViewController
-(MainViewController*) init{
  	self = [super init];
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view.
-(void)viewDidLoad
{
	[super viewDidLoad];
	useAdaptive = NO;
	[self changeFilter:[LowpassFilter class]];
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / kUpdateFrequency];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
		
}

-(void)viewDidUnload
{
	[super viewDidUnload];
	
}

// UIAccelerometerDelegate method, called when the device accelerates.
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	// Update the accelerometer graph view
		
	camera->y_angle=acceleration.y;
	//if((acceleration.y<0.3f)&(acceleration.y>-0.3f)){
	if((acceleration.y<0.5f)&(acceleration.y>-0.5f)){
		camera->isRadar=1;
	}else{
	
	camera->isRadar=0;
	}
	
	[filter addAcceleration:acceleration];
	
	//GLfloat val=fmod(acceleration.x + 1.0, 2.0) * (2 * (M_PI / 360.0));
	
	//GLfloat val=acceleration.z *M_PI_2;
//	GLfloat val=((acceleration.z)/2 *M_PI);
	GLfloat val=filter.z *M_PI_4;
		camera->angleView=val;
	//}
	
	

}

-(void)changeFilter:(Class)filterClass
{
	// Ensure that the new filter class is different from the current one...
	if(filterClass != [filter class])
	{
		// And if it is, release the old one and create a new one.
		[filter release];
		filter = [[filterClass alloc] initWithSampleRate:kUpdateFrequency cutoffFrequency:5.0];
		// Set the adaptive flag
		filter.adaptive = useAdaptive;
		// And update the filterLabel with the new filter name.
	}
}


-(IBAction)filterSelect:(id)sender
{
	if([sender selectedSegmentIndex] == 0)
	{
		// Index 0 of the segment selects the lowpass filter
		[self changeFilter:[LowpassFilter class]];
	}
	else
	{
		// Index 1 of the segment selects the highpass filter
		[self changeFilter:[HighpassFilter class]];
	}

	// Inform accessibility clients that the filter has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(IBAction)adaptiveSelect:(id)sender
{
	// Index 1 is to use the adaptive filter, so if selected then set useAdaptive appropriately
	useAdaptive = [sender selectedSegmentIndex] == 1;
	// and update our filter and filterLabel
	filter.adaptive = useAdaptive;
		
	// Inform accessibility clients that the adaptive selection has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(void)dealloc
{
	// clean up everything.
	//NSLog(@"dealloc MainViewController");
	[super dealloc];
}

@end
