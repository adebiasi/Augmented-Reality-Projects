
#import "Camera.h"
#import <CoreLocation/CoreLocation.h>

@class Camera;

@interface TeslameterViewController : UIViewController <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	NSDate *startTime; 
	NSTimeInterval refreshInterval;
	
	@public
	Camera *camera;
}

@property NSTimeInterval refreshInterval;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSDate *startTime; 
//@property(readwrite, assign) Camera *camera;

@end

