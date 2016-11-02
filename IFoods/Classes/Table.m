//
//  TableController.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 22/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import "Table.h"
#import "Place.h"
#import "LatLon.h"

@implementation Table
@synthesize glView;

NSMutableArray* arrayResults;
UIActivityIndicatorView* indicator;
- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame: frame])) {	
		NSLog(@"init table");
	arrayData = [[NSArray alloc] initWithObjects:@"iPhone",@"iPod",@"MacBook",@"MacBook Pro",nil];
		//selectedPlaces= [[NSMutableArray alloc] init];
		[self setDelegate:self];	[self setDataSource:self];
		
	}
	return self;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"number");
	return [selectedPlaces count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"cellForRowAtIndexPath");
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	Place* currPlace = (Place*)[selectedPlaces objectAtIndex:indexPath.row];
	
	Vec4* userPos = glView->camera->userLocation->coord;
	
	NSLog(@"userPos tableView %f %f %f",userPos->X,userPos->Y,userPos->Z);
	
	Vec4* placePos = currPlace.coord;
	double distance = [Vec4 realDistanceVector1:userPos Vector2:placePos];
	
	int distKm = distance/1000;	
	distKm=round(distKm);
	
	NSString* name = currPlace.name;
	
	NSString *text = [NSString  stringWithFormat: @"%@ - %i Km", name,distKm]; 
	
	// Set up the cell...
	//cell.text = [arrayData objectAtIndex:indexPath.row];
	cell.text = text;
	return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	NSLog(@"didSelectRowAtIndexPath");
	CGRect rect = self.superview.frame;
	
	 indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0); 

	CGRect frame = CGRectMake(center.x-50, center.y-50, 100, 100);
	
	//[indicator setCenter:center];
	[indicator setFrame:frame];
	
	//UIProgressView* indicator = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
[indicator startAnimating];
	//[indicator setCenter:CGPointMake(100, 100)];
	[self  addSubview:indicator];
	

	
	[NSThread detachNewThreadSelector:@selector(startTheBackgroundJob) toTarget:self withObject:nil]; 
	NSLog(@"start indicator");
	/*
	LatLon* pos = glView->camera->userLocation;
	
	double destLat = ((Place*)[selectedPlaces objectAtIndex:0]).latitude;
	double destLon = ((Place*)[selectedPlaces objectAtIndex:0]).longitude;
	glView->infoContr->userLocation=pos;
	glView->infoContr->firstUserLocation=glView->camera->firstUserLocation;
	arrayResults=[glView->infoContr receiveArrayObjectsWithLatDest:destLat LonDest:destLon UserLocation:pos];
	
	NSMutableArray* arrayPlacemarks=[arrayResults objectAtIndex:0];	
	NSMutableArray* arrayPath=[arrayResults objectAtIndex:1];	
	
	glView->arrayPlacemarks = arrayPlacemarks;
	glView->arrayPath = arrayPath;
	
	if(glView->camera->vAccuracy==-1){
		
		NSLog(@"------non upd pos  %f %f %f %f %f %f",glView->camera->userLocation.latitude ,glView->camera->userLocation.longitude , glView->camera->userLocation.altitude,glView->camera->userLocation.coord.X,glView->camera->userLocation.coord.Y,glView->camera->userLocation.coord.Z);
		
		NSLog(@"GPS non attivo");
		
		LatLon* firstLatLon= ((LatLon*)[arrayPlacemarks objectAtIndex:0]);
		LatLon *firstLatLon2=[[LatLon alloc]initWithLatitude:firstLatLon.latitude Longitude:firstLatLon.longitude Altitude:firstLatLon.altitude+5];	
		//LatLon *firstLatLon2=[[LatLon alloc]initWithLatitude:firstLatLon.latitude Longitude:firstLatLon.longitude Altitude:firstLatLon.altitude];	
		
		Vec4* vec2=[Vec4 geodeticToCartesian:firstLatLon2->latitude Longitude:firstLatLon2->longitude Elevation:firstLatLon2->altitude isUser:FALSE userPos:glView->camera->firstUserLocation->coord];
		
		firstLatLon2->coord=vec2;	
		glView->camera->userLocation=firstLatLon2;
		
		NSLog(@"------get firstLatLon %@ %f %f %f %f %f %f",firstLatLon.name,glView->camera->userLocation.latitude ,glView->camera->userLocation.longitude , glView->camera->userLocation.altitude,glView->camera->userLocation.coord.X,glView->camera->userLocation.coord.Y,glView->camera->userLocation.coord.Z);
		
	}		
	[self superview].hidden=TRUE;
	 */
}


- (void)startTheBackgroundJob{  
	NSLog(@"THREAD");
		self.userInteractionEnabled=FALSE;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	LatLon* pos = glView->camera->userLocation;
	
	double destLat = ((Place*)[selectedPlaces objectAtIndex:0]).latitude;
		double destLon = ((Place*)[selectedPlaces objectAtIndex:0]).longitude;
	glView->infoContr->userLocation=pos;
	glView->infoContr->firstUserLocation=glView->camera->firstUserLocation;
	arrayResults=[glView->infoContr receiveArrayObjectsWithLatDest:destLat LonDest:destLon UserLocation:pos];
	
	NSLog(@"fine receiveArrayObjectsWithLatDest");
	
	NSMutableArray* arrayPlacemarks=[arrayResults objectAtIndex:0];	
	NSMutableArray* arrayPath=[arrayResults objectAtIndex:1];	
	
	glView->arrayPlacemarks = arrayPlacemarks;
	glView->arrayPath = arrayPath;
	
	if(glView->camera->vAccuracy==-1){
		
		NSLog(@"------non upd pos  %f %f %f %f %f %f",glView->camera->userLocation.latitude ,glView->camera->userLocation.longitude , glView->camera->userLocation.altitude,glView->camera->userLocation.coord.X,glView->camera->userLocation.coord.Y,glView->camera->userLocation.coord.Z);
		
		NSLog(@"GPS non attivo");
		
		LatLon* firstLatLon= ((LatLon*)[arrayPlacemarks objectAtIndex:0]);
		LatLon *firstLatLon2=[[LatLon alloc]initWithLatitude:firstLatLon.latitude Longitude:firstLatLon.longitude Altitude:firstLatLon.altitude+5];	
		
		Vec4* vec2=[Vec4 geodeticToCartesian:firstLatLon2->latitude Longitude:firstLatLon2->longitude Elevation:firstLatLon2->altitude isUser:FALSE userPos:glView->camera->firstUserLocation->coord];
		
		firstLatLon2->coord=vec2;	
		glView->camera->userLocation=firstLatLon2;
		
		NSLog(@"------upd pos %@ %f %f %f %f %f %f",firstLatLon.name,glView->camera->userLocation.latitude ,glView->camera->userLocation.longitude , glView->camera->userLocation.altitude,glView->camera->userLocation.coord.X,glView->camera->userLocation.coord.Y,glView->camera->userLocation.coord.Z);
		
			}		
	
	
	self.userInteractionEnabled=TRUE;
	
	[pool release];
	[indicator stopAnimating];
	[self superview].hidden=TRUE;
}

@end
