
#import "TeslameterViewController.h"

@implementation TeslameterViewController



@synthesize locationManager,startTime,refreshInterval;

//NSDate *startTime ;

-(TeslameterViewController*) init{
    
		self = [super init];
			
	return self;
}


- (void)viewDidLoad {
	
	//startTime = [NSDate date];  
	
	[super viewDidLoad];
	
	// setup the location manager
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	
	// refreshInterval = 1.0 / 60.0;
	
	// check if the hardware has a compass
	if (locationManager.headingAvailable == NO) {
		// No compass is available. This application cannot function without a compass, 
        // so a dialog will be displayed and no magnetic data will be measured.
        self.locationManager = nil;
        UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"No Compass!" message:@"This device does not have the ability to measure magnetic fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noCompassAlert show];
        [noCompassAlert release];
	} else {
        // heading service configuration
        locationManager.headingFilter = kCLHeadingFilterNone;
        
        // setup delegate callbacks
        locationManager.delegate = self;
        
     	self->startTime =[[NSDate alloc] init];
		
		
        [locationManager startUpdatingHeading];
    }
}

- (void)viewDidUnload {
   
}

- (void)dealloc {
	
	[locationManager stopUpdatingHeading];
    [locationManager release];
	[super dealloc];
}

// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
			 NSTimeInterval elapsedTime = [self->startTime timeIntervalSinceNow];  
	

	
	
	if(-elapsedTime>refreshInterval){
	
  	//GLfloat val=fmod(heading.magneticHeading + 90.0, 360.0) * ((M_PI / 360.0));
		GLfloat val=fmod(heading.magneticHeading , 360.0) * ((M_PI / 360.0));
		
		camera->azimuth=val;
		camera->refreshCompassInterval=-elapsedTime;
		//self->startTime = [NSDate date];  
	
		[self->startTime dealloc];
		self->startTime =[[NSDate alloc] init];
		//	self->startTime =[NSDate init];
	}
	
}

// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        // This error indicates that the user has denied the application's request to use location services.
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
    }
}

@end
