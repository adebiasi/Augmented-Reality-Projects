//
//  PlacesMngt.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 12/01/10.
//  Copyright 2010 Fondazione Graphitech. All rights reserved.
//

#import "PlacesMngt.h"
#import "WebServicesViewController.h"

@implementation PlacesMngt

Place *currPlace;	
NSString *currElement;

NSMutableArray *arrayPlaces;  
NSMutableArray *resultsArray;  

bool insertPos;
bool insertName;
bool insertAddress;
NSString *posType;


- (NSMutableArray*) receiveArrayObjectsWithUserLocation: (LatLon*)userLoc{

	//NSLog(@"in recieveArrayObject");
	
arrayPlaces = [[NSMutableArray alloc] init];                
resultsArray = [[NSMutableArray alloc] init]; 

WebServicesViewController* wsViewController = [[WebServicesViewController alloc]init]; 

	//NSData* returnData=[wsViewController sendRequestPlacesLatitude:45.899865 Longitude:11.033235];
	NSData* returnData=[wsViewController sendRequestPlacesLatitude:userLoc->latitude Longitude:userLoc->longitude];

	[returnData writeToFile:[self pathToDataFile] atomically:NO];

	
	
NSString* aStr;	
aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];

//NSLog(@"RESULT...................:%@",aStr);
//Bisogna convertire il file in una NSURL altrimenti non funziona  
//NSURL *xmlURL = [NSURL fileURLWithPath:path];  
// Creiamo il parser  
NSXMLParser *parser = [[ NSXMLParser alloc] initWithData:returnData];  
//NSXMLParser *parser = [[ NSXMLParser alloc] initWithContentsOfURL:xmlURL];  
// Il delegato del parser e' la classe stessa (self)  
[parser setDelegate:self];  

[parser setShouldProcessNamespaces:YES];
//Effettuiamo il parser 
BOOL success = [parser parse];
//controlliamo come è andata l'operazione
if(success == YES){
	NSLog(@"parsing corretto");
	//parsing corretto
} else {
	NSLog(@"parsing non corretto");
	//c'è stato qualche errore...
}
// Rilasciamo l'oggetto NSXMLParser  
[parser release];

currElement=@"";

[resultsArray addObject:arrayPlaces];
return resultsArray;
}

-(NSString *)pathToDataFile
{
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *docDir = [path objectAtIndex:0];
	
	//NSString* docDir = [[NSBundle mainBundle] bundlePath];
	
	NSString *finalPath =  [docDir stringByAppendingPathComponent:@"Restaurant.xml"];
    NSLog(@"finalPath:%@",finalPath);
	
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:finalPath];
	
	if(success) {
		NSLog(@"Already Exit");
	} else {
	NSLog(@"NOT Exit");
	}
	
	return finalPath;
}


- (NSMutableArray*) getArrayObjectsWithName: (NSString*) name{
	
	arrayPlaces = [[NSMutableArray alloc] init];                
	resultsArray = [[NSMutableArray alloc] init]; 
	
	//NSString *pathProgetto = [[NSBundle mainBundle] bundlePath];
	NSArray * pathDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *pathProgetto = [pathDir objectAtIndex:0];
	
	//NSString *path = [[NSString alloc] initWithString:[pathProgetto stringByAppendingPathComponent:@"dati.xml"]];
	//NSString *path = [[NSString alloc] initWithString:[pathProgetto stringByAppendingPathComponent:@"directions.xml"]];
	NSString *path = [[NSString alloc] initWithString:[pathProgetto stringByAppendingPathComponent:name]];
	
	//Bisogna convertire il file in una NSURL altrimenti non funziona  
	NSURL *xmlURL = [NSURL fileURLWithPath:path];  
	// Creiamo il parser  
	NSXMLParser *parser = [[ NSXMLParser alloc] initWithContentsOfURL:xmlURL];  
	// Il delegato del parser e' la classe stessa (self)  
	[parser setDelegate:self];  
	
	NSLog(@"xmlURL:%@",xmlURL);
	
	[parser setShouldProcessNamespaces:YES];
	//Effettuiamo il parser 
	BOOL success = [parser parse];
	//controlliamo come è andata l'operazione
	if(success == YES){
		NSLog(@"parsing corretto");
		//parsing corretto
	} else {
		NSLog(@"parsing non corretto");
		//c'è stato qualche errore...
	}
	// Rilasciamo l'oggetto NSXMLParser  
	[parser release];
	
	currElement=@"";
		
	[resultsArray addObject:arrayPlaces];
	return resultsArray;
	}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	currElement=elementName;
	
	
	if ([currElement isEqualToString:@"place"]){		
		currPlace = [[Place alloc] init];		
		insertName=TRUE;
	}
	
	if ([currElement isEqualToString:@"pos"]){
		insertPos=TRUE;		
	}
	if ([currElement isEqualToString:@"address"]){
		insertAddress=TRUE;		
	}
	if ([currElement isEqualToString:@"cartesianPosition"]){
		posType=@"cartesianPosition";		
	}
	if ([currElement isEqualToString:@"geodeticPosition"]){
		posType=@"geodeticPosition";			
	}
	
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	//NSLog(@"%@",string);
	
	if([currElement isEqualToString:@"name"]){
		if(insertName){
			currPlace.name=string;
		}
	}
	
	if([currElement isEqualToString:@"address"]){
		if(insertAddress){
			currPlace.address=string;
		}
	}
	
	
	if([currElement isEqualToString:@"pos"]){
		
		if(insertPos){
			if(posType==@"cartesianPosition"){
				NSLog(@"cartesianPosition");
				NSArray *chunks = [string componentsSeparatedByString: @" "];
				
				NSString* tmp;				
				NSEnumerator *nse = [chunks objectEnumerator];
				
				int i=0;
				
				while(tmp = [nse nextObject]) {
					
					//NSLog(@"coord  dell'elemento %i: -%@-",i, tmp);
					if(i==0){				
						currPlace.coord.X=[tmp floatValue];
					}
					if(i==1){
						currPlace.coord.Y=[tmp floatValue];
					}
					if(i==2){
						currPlace.coord.Z=[tmp floatValue];
					}
					i++;
					
				}
			}else{
				//NSLog(@"geoPosition");
				NSArray *chunks = [string componentsSeparatedByString: @" "];
				
				NSString* tmp;				
				NSEnumerator *nse = [chunks objectEnumerator];
				
				int i=0;
				
				while(tmp = [nse nextObject]) {
					
					//NSLog(@"coord  dell'elemento %i: -%@-",i, tmp);
					if(i==0){				
						currPlace.latitude=[tmp floatValue];
					}
					if(i==1){
						currPlace.longitude=[tmp floatValue];
					}
					if(i==2){
						currPlace.altitude=[tmp floatValue];
					}
					i++;
				}
				
			}
		}	
		
	}
	
	
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"place"]){
		Place* insertPlace = [[Place alloc] initWithLatitude:currPlace.latitude Longitude:currPlace.longitude Altitude:currPlace.altitude];
		//inseriscce XYZ
		NSLog(@"lat.lon.alt.x.y.z.%f,%f,%f,%f,%f,%f",currPlace.latitude,currPlace.longitude,currPlace.altitude,[currPlace->coord X],[currPlace->coord Y],[currPlace->coord Z]);
		// LatLon* insertLatLon = [[LatLon alloc] init];
		/*
		Vec4* coordPos = [[Vec4 alloc] init];
		coordPos.X=[currPlace->coord X] ;
		coordPos.Y=[currPlace->coord Y] ;
		coordPos.Z=[currPlace->coord Z] ;
		*/
		//Vec4* coordPos = [Vec4 geodeticToCartesian:currPlace.latitude Longitude:currPlace.longitude Elevation:currPlace.altitude];
		NSLog(@"place elementName %f %f %f",userLocation->coord->X,userLocation->coord->Y,userLocation->coord->Z);
			
		Vec4* coordPos = [Vec4 geodeticToCartesian: currPlace.latitude Longitude:currPlace.longitude Elevation:currPlace.altitude isUser:FALSE userPos:firstUserLocation->coord];
		
		insertPlace->coord=coordPos;
				
		NSString *str = [[NSString alloc] initWithString:currPlace.name]; 
		
		insertPlace.name=str;
		
		[arrayPlaces addObject:insertPlace];
		
		
	}
	if ([elementName isEqualToString:@"pos"]){
		insertPos=FALSE;		
	}
	if ([elementName isEqualToString:@"name"]){
		insertName=FALSE;		
	}
	if ([elementName isEqualToString:@"address"]){
		insertAddress=FALSE;		
	}
		
}



@end
