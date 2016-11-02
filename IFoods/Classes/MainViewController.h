
#import <UIKit/UIKit.h>
#import "Camera.h"

@class GraphView;
@class AccelerometerFilter;

@interface MainViewController : UIViewController<UIAccelerometerDelegate>
{
	
	AccelerometerFilter *filter;
	BOOL useAdaptive;
	
@public
	Camera *camera;
}



-(IBAction)filterSelect:(id)sender;
-(IBAction)adaptiveSelect:(id)sender;

@end