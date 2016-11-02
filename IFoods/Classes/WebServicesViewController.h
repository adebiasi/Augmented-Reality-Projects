//
//  WebServicesViewController.h
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 04/12/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebServicesViewController : UIViewController {
	//IBOutlet UITextField *ipAddress;
	//IBOutlet UIActivityIndicatorView *activityIndicator;
	//</strong>
	 
//	<strong> //---web service access---
	NSMutableData *webData;
	
	NSURLConnection *conn;
	
	@public
	NSMutableString *soapResults;
	//</strong>
}

-(NSMutableString*) getData;
-(NSData*) actionGet;
-(void) actionPost;
- (void)transmitXMLRequest:(NSData *)data;
-(NSData*) sendRequestLatitude: (double)lat Longitude: (double)lon Destination: (NSString*)dest;
-(NSData*) sendRequestLatitude: (double)lat Longitude: (double)lon DestLat: (double)destLat DestLon: (double)destLon;
-(NSData*) sendRequestPlacesLatitude: (double)lat Longitude: (double)lon ;

//<strong>
//@property (nonatomic, retain) UITextField *ipAddress;
//@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
//- (IBAction)buttonClicked:(id)sender;
//</strong>
@end