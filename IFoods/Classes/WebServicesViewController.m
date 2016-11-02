//
//  WebServicesViewController.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 04/12/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "WebServicesViewController.h"


@implementation WebServicesViewController

BOOL isFinished;

-(void) actionPost{
	
	isFinished=FALSE;
	
	NSString* place = [NSString stringWithFormat:@"Italy"];
	
NSString *postString = 
[NSString stringWithFormat:@"V4IPAddress=%@", 
 place];
NSLog(postString);

NSURL *url = [NSURL URLWithString: 
			  @"http://www.ecubicle.net/iptocountry.asmx?op=FindCountryAsXml"];
			 // @"http:// www.ecubicle.net/iptocountry.asmx/FindCountryAsXml"];
NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
NSString *msgLength = 
[NSString stringWithFormat:@"%d", [postString length]];

[req addValue:@"application/x-www-form-urlencoded" 
forHTTPHeaderField:@"Content-Type"];
[req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
[req setHTTPMethod:@"POST"];
[req setHTTPBody: [postString 
				   dataUsingEncoding:NSUTF8StringEncoding]];

//[activityIndicator startAnimating];

conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
if (conn) {
	NSLog(@"conn OK");
	webData = [[NSMutableData data] retain];
}    

}

-(NSMutableString*) getData{

	return soapResults;
}

- (void)transmitXMLRequest:(NSData *)data
{
	NSURL *webServiceURL = [NSURL URLWithString:@"http://test.com/xmlResponder"];
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:webServiceURL];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
	[urlRequest setHTTPBody:data];
	
	NSURLConnection *connectionResponse = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
	if (!connectionResponse) {
		NSLog(@"Failed to submit request");
	} else {
		NSLog(@"Request submitted");
		NSLog(@"conn OK");
		webData  = [[NSMutableData alloc] init];
	}
}

//used for getting the road
-(NSData*) sendRequestLatitude: (double)lat Longitude: (double)lon DestLat: (double)destLat DestLon: (double)destLon{
	
	NSString *queryString = 
	[NSString stringWithFormat:
	 //@"http://192.168.253.105:8095/WebService/googleMapsService3.jsp?lat=%f&lon%f&dest=%@",
	 //@"http://192.168.253.105:8095/WebService/IPhoneService_1.jsp?lat=%f&lon=%f&dest=%@",
	
	 
	 @"http://193.205.215.102:8085/SlowFood/IPhoneService_2.jsp?lat=%f&lon=%f&endLat=%f&endLon=%f&level=14",
	 
	 lat,lon,destLat,destLon];
	NSLog(@"URL:%@",queryString);
	NSURL *url = [NSURL URLWithString:queryString];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	[req addValue:@"text/xml; charset=utf-8" 
forHTTPHeaderField:@"Content-Type"];
	[req addValue:0 forHTTPHeaderField:@"Content-Length"];
	[req setHTTPMethod:@"GET"];
	[req setTimeoutInterval:600];
	
	NSURLResponse *resp = nil;
	NSError *err = nil;
	
	NSData *returnData = [ NSURLConnection sendSynchronousRequest: req returningResponse: &resp error: &err ];
	NSString* aStr;
	aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
	NSLog(@"error:%@",err );
	
	/*
	 conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	 if (conn) {
	 NSLog(@"conn OK");
	 webData = [[NSMutableData data] retain];
	 
	 }
	 else{
	 NSLog(@"conn NO");
	 }
	 
	 */
	return returnData;
	
}


//used for getting the road
-(NSData*) sendRequestLatitude: (double)lat Longitude: (double)lon Destination: (NSString*)dest{
		
	NSString *queryString = 
	[NSString stringWithFormat:
		 //@"http://192.168.253.105:8095/WebService/googleMapsService3.jsp?lat=%f&lon%f&dest=%@",
	 //@"http://192.168.253.105:8095/WebService/IPhoneService_1.jsp?lat=%f&lon=%f&dest=%@",
	 @"http://193.205.215.102:8085/SlowFood/IPhoneService_3.jsp?lat=%f&lon=%f&dest=%@&level=9",
	 
	 lat,lon,dest];
	NSLog(@"URL:%@",queryString);
	NSURL *url = [NSURL URLWithString:queryString];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	[req addValue:@"text/xml; charset=utf-8" 
forHTTPHeaderField:@"Content-Type"];
	[req addValue:0 forHTTPHeaderField:@"Content-Length"];
	[req setHTTPMethod:@"GET"];

	
	NSURLResponse *resp = nil;
	NSError *err = nil;
	
	NSData *returnData = [ NSURLConnection sendSynchronousRequest: req returningResponse: &resp error: &err ];
	NSString* aStr;
	aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
	//NSLog(@"returnData:%@",aStr );

	/*
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	if (conn) {
		NSLog(@"conn OK");
		webData = [[NSMutableData data] retain];
		
	}
	else{
		NSLog(@"conn NO");
	}
	
	*/
	return returnData;
	
}

//used for getting the list of places
-(NSData*) sendRequestPlacesLatitude: (double)lat Longitude: (double)lon {
	
	NSString *queryString = 
	[NSString stringWithFormat:
	 //@"http://192.168.253.105:8095/WebService/googleMapsService3.jsp?lat=%f&lon%f&dest=%@",
	// @"http://192.168.253.105:8095/WebService/IPhoneService_4.jsp?lat=%f&lon=%f",
	 
	//  @"http://192.168.253.105:8095/IFoods/IPhoneService_4.jsp?lat=%f&lon=%f",
	 
	   @"http://193.205.215.102:8085/SlowFood/IPhoneService_4.jsp?lat=%f&lon=%f",
	 lat,lon];
	//    @"http://193.205.215.102:8085/SlowFood/IPhoneService_4.jsp?lat=42&lon=12"];
	NSLog(@"URL:%@",queryString);
	NSURL *url = [NSURL URLWithString:queryString];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	[req addValue:@"text/xml; charset=utf-8" 
forHTTPHeaderField:@"Content-Type"];
	[req addValue:0 forHTTPHeaderField:@"Content-Length"];
	[req setHTTPMethod:@"GET"];
	
	
	NSURLResponse *resp = nil;
	NSError *err = nil;
	
	NSData *returnData = [ NSURLConnection sendSynchronousRequest: req returningResponse: &resp error: &err ];
	NSString* aStr;
	aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
	//NSLog(@"returnData.......:%@",aStr );
	
	/*
	 conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	 if (conn) {
	 NSLog(@"conn OK");
	 webData = [[NSMutableData data] retain];
	 
	 }
	 else{
	 NSLog(@"conn NO");
	 }
	 
	 */
	return returnData;
	
}


-(NSData*) actionGet{
	NSString* place = [NSString stringWithFormat:@"Italy"];	
	NSString *queryString = 
	[NSString stringWithFormat:
	// @"http://www.ecubicle.net/iptocountry.asmx?op=FindCountryAsXml?V4IPAddress=%@",
	// @"http://www.ecubicle.net/iptocountry.asmx/FindCountryAsXml?V4IPAddress=%@", 
	//@"http://yandex.ru/yandsearch?text=%@",
	// @"http://192.168.253.105:8095/WebService/map2.jsp?text=%@",
	   @"http://192.168.253.105:8095/WebService/googleMapsService3.jsp",
	 place];
	NSLog(@"URL:%@",queryString);
	NSURL *url = [NSURL URLWithString:queryString];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	[req addValue:@"text/xml; charset=utf-8" 
forHTTPHeaderField:@"Content-Type"];
	[req addValue:0 forHTTPHeaderField:@"Content-Length"];
	[req setHTTPMethod:@"GET"];
	//[activityIndicator startAnimating];
	
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	//NSData *returnData = [ NSURLConnection sendSynchronousRequest: req returningResponse: nil error: nil ];
	
	//NSURLResponse *resp = nil;
	//NSError *err = nil;

	//NSData *returnData = [ NSURLConnection sendSynchronousRequest: req returningResponse: &resp error: &err ];
		//NSString* aStr;

	//NSLog(@"Error: %@", err);
	//aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
	//NSLog(@"returnData:%@",aStr );
	//NSLog(error);
	if (conn) {
		NSLog(@"conn OK");
		webData = [[NSMutableData data] retain];
		
			}
	else{
	NSLog(@"conn NO");
	}
	
		
	
	
	//return returnData;
	return NULL;
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc]
						   initWithBytes: [webData mutableBytes]
						   length:[webData length]
						   encoding:NSUTF8StringEncoding];
	//---shows the XML---
	NSLog(theXML);
	soapResults=[[NSMutableString alloc] initWithString:theXML];
	[theXML release];
	//[activityIndicator stopAnimating];
	isFinished=TRUE;
	////parser
	 
	[connection release];
	[webData release];
}

- (void)connection:(NSURLConnection *)connection

  didFailWithError:(NSError *)error

{	
    // release the connection, and the data object	
    [connection release];	
    // receivedData is declared as a method instance elsewhere	
    [webData release];	
    // inform the user
	
    NSLog(@"Connection failed! Error - %@ %@",		  
          [error localizedDescription],		  
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
	NSLog(@"didReceiveData");
    // append the new data to the receivedData	
    // receivedData is declared as a method instance elsewhere	
    [webData appendData:data];
	
}
@end
