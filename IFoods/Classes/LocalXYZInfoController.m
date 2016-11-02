//
//  LocalXYZInfoController.m
//  OpenGLES13
//
//  Created by Raffaele De Amicis on 16/12/09.
//  Copyright 2009 Fondazione Graphitech. All rights reserved.
//

#import "LocalXYZInfoController.h"
#import "WebServicesViewController.h"
#import "Camera.h"

@implementation LocalXYZInfoController



LatLon *currLatLon;	
NSString *currElement;
NSMutableArray *arrayPlacemarks;   
NSMutableArray *arrayPath;  

NSMutableArray *resultsArray;  
//bool insertCartPos;
//bool insertGeoPos;
bool insertPos;
bool insertName;
bool insertPath;
NSString *posType;

- (NSMutableArray*) receiveArrayObjectsWithLatDest: (double) latDest LonDest: (double) lonDest UserLocation: (LatLon*)userLoc{
	
	arrayPlacemarks = [[NSMutableArray alloc] init];                                     //saves memory for the Array and initializes it.
	arrayPath = [[NSMutableArray alloc] init];  
	resultsArray = [[NSMutableArray alloc] init]; 
	//NSString *pathProgetto = [[NSBundle mainBundle] bundlePath];
	//NSString *path = [[NSString alloc] initWithString:[pathProgetto stringByAppendingPathComponent:name]];
	
	WebServicesViewController* wsViewController = [[WebServicesViewController alloc]init]; 
	//[wsViewController actionGet];
	
	
	//NSLog(@"data%@",[wsViewController getData]);
	
	//NSData* returnData=[wsViewController actionGet];
	
	//[wsViewController sendRequestLatitude:userLoc->latitude Longitude:userLoc->longitude Destination:dest];
	//ll=45.89071,11.034694
	//46.06275,10.137634
	//NSData* returnData=[wsViewController sendRequestLatitude:45.89071 Longitude:11.034694 Destination:dest];
	NSData* returnData=[wsViewController sendRequestLatitude:userLoc->latitude Longitude:userLoc->longitude DestLat:latDest DestLon:lonDest];
	
////	NSLog(@"ricevo %@",returnData);
	
	[returnData writeToFile:[self pathToDataFile] atomically:NO];
	
	
	
	//	NSData* returnData=[wsViewController sendRequestLatitude:45.899865 Longitude:11.033235 Destination:dest];
	
	NSString* aStr;	
	aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
	
//	NSLog(@"------------stringa:%@",aStr);
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
	
	[resultsArray addObject:arrayPlacemarks];
	[resultsArray addObject:arrayPath];
	return resultsArray;
}


- (NSMutableArray*) receiveArrayObjectsWithDestination: (NSString*) dest UserLocation: (LatLon*)userLoc{
	
	arrayPlacemarks = [[NSMutableArray alloc] init];                                     //saves memory for the Array and initializes it.
	arrayPath = [[NSMutableArray alloc] init];  
	resultsArray = [[NSMutableArray alloc] init]; 
	//NSString *pathProgetto = [[NSBundle mainBundle] bundlePath];
	//NSString *path = [[NSString alloc] initWithString:[pathProgetto stringByAppendingPathComponent:name]];
	
	WebServicesViewController* wsViewController = [[WebServicesViewController alloc]init]; 
	//[wsViewController actionGet];
	
	
	//NSLog(@"data%@",[wsViewController getData]);
	
	//NSData* returnData=[wsViewController actionGet];
	
	//[wsViewController sendRequestLatitude:userLoc->latitude Longitude:userLoc->longitude Destination:dest];
	//ll=45.89071,11.034694
	//46.06275,10.137634
	//NSData* returnData=[wsViewController sendRequestLatitude:45.89071 Longitude:11.034694 Destination:dest];
	NSData* returnData=[wsViewController sendRequestLatitude:userLoc->latitude Longitude:userLoc->longitude Destination:dest];

	[returnData writeToFile:[self pathToDataFile] atomically:NO];

	
	
	//	NSData* returnData=[wsViewController sendRequestLatitude:45.899865 Longitude:11.033235 Destination:dest];
	
	NSString* aStr;	
	aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
	
//	NSLog(@"stringa:%@",aStr);
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
	
	[resultsArray addObject:arrayPlacemarks];
	[resultsArray addObject:arrayPath];
	return resultsArray;
}

- (NSMutableArray*) getArrayObjectsWithName: (NSString*) name{
	
	arrayPlacemarks = [[NSMutableArray alloc] init];                                     //saves memory for the Array and initializes it.
	arrayPath = [[NSMutableArray alloc] init];
	resultsArray = [[NSMutableArray alloc] init];
	
	NSArray * pathPr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *pathProgetto = [pathPr objectAtIndex:0];

	
	//NSString *pathProgetto = [[NSBundle mainBundle] bundlePath];
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
	
	
	[resultsArray addObject:arrayPlacemarks];
	[resultsArray addObject:arrayPath];
	return resultsArray;
	
	
	
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	currElement=elementName;
	
	
	if ([currElement isEqualToString:@"direction"]){		
		currLatLon = [[LatLon alloc] init];
		insertPath=FALSE;
		insertName=TRUE;
	}
	if ([currElement isEqualToString:@"path"]){		
		currLatLon = [[LatLon alloc] init];
		insertPath=TRUE;
		
	}
	if ([currElement isEqualToString:@"pos"]){
		insertPos=TRUE;		
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
		//NSLog(@"name %@",string);
		if(insertName){
			
			
			
			if(currLatLon.name==NULL){
				currLatLon.name=string;
			}else{
			//currLatLon.name=string;
			currLatLon.name=[NSString stringWithFormat:@"%@%@",currLatLon.name,string];
			}
			}
	}
	
	
	if([currElement isEqualToString:@"pos"]){
		
		if(insertPos){
			if(posType==@"cartesianPosition"){
			//NSLog(@"coord assieme:---%@----",string);
			NSArray *chunks = [string componentsSeparatedByString: @" "];
			
			NSString* tmp;				
			NSEnumerator *nse = [chunks objectEnumerator];
			
			int i=0;
			
			while(tmp = [nse nextObject]) {
				
				//NSLog(@"coord  dell'elemento %i: -%@-",i, tmp);
				if(i==0){				
					currLatLon.coord.X=[tmp floatValue];
				}
				if(i==1){
					currLatLon.coord.Y=[tmp floatValue];
				}
				if(i==2){
					currLatLon.coord.Z=[tmp floatValue];
				}
				i++;
				
			}
			}else{
				//NSLog(@"latlon: %@",string);
				NSArray *chunks = [string componentsSeparatedByString: @" "];
				
				NSString* tmp;				
				NSEnumerator *nse = [chunks objectEnumerator];
				
				int i=0;
				
				while(tmp = [nse nextObject]) {
					
					//NSLog(@"coord  dell'elemento %i: -%@-",i, tmp);
					if(i==0){				
						currLatLon.latitude=[tmp floatValue];
					}
					if(i==1){
						currLatLon.longitude=[tmp floatValue];
					}
					if(i==2){
						currLatLon.altitude=[tmp floatValue];
					}
					i++;
				}
					
			}
		}	
		
	}
	
	
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"direction"]){
		LatLon* insertLatLon = [[LatLon alloc] initWithLatitude:currLatLon.latitude Longitude:currLatLon.longitude Altitude:currLatLon.altitude];
		//inseriscce XYZ
	//	NSLog(@"A.......%f,%f,%f,%f,%f,%f",currLatLon.latitude,currLatLon.longitude,currLatLon.altitude,[currLatLon->coord X],[currLatLon->coord Y],[currLatLon->coord Z]);
		// LatLon* insertLatLon = [[LatLon alloc] init];
//		 Vec4* coordPos = [[Vec4 alloc] init];
		/*
		 coordPos.X=[currLatLon->coord X] ;
		 coordPos.Y=[currLatLon->coord Y] ;
		 coordPos.Z=[currLatLon->coord Z] ;
		 */
		
		//Vec4* coordPos = [Vec4 geodeticToCartesian:currLatLon.latitude Longitude:currLatLon.longitude Elevation:currLatLon.altitude];
	//	NSLog(@"----->>>>parser localxyz %f %f %f %f %f %f",userLocation->coord->X,userLocation->coord->Y,userLocation->coord->Z,userLocation->latitude,userLocation->longitude,userLocation->altitude);
		
		//Vec4* coordPos = [Vec4 geodeticToCartesian: currLatLon.latitude Longitude:currLatLon.longitude Elevation:currLatLon.altitude isUser:FALSE userPos:userLocation->coord];
		Vec4* coordPos = [Vec4 geodeticToCartesian: currLatLon.latitude Longitude:currLatLon.longitude Elevation:currLatLon.altitude isUser:FALSE userPos:firstUserLocation->coord];
		
		 insertLatLon->coord=coordPos;
		 
		
		//NSString *str =[currLatLon.name stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
		
		
		NSString *str = [[NSString alloc] initWithString:@""]; 
		//NSString *str = [[NSString alloc] initWithString:currLatLon.name]; 
		
		str =[currLatLon.name stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
	//	str =[str stringByReplacingOccurrencesOfString:<#(NSString *)target#> withString:<#(NSString *)replacement#>
		//NSLog(@"str %@",str);
		insertLatLon.name=[[NSString alloc] initWithString:str];
		
		[arrayPlacemarks addObject:insertLatLon];
		
		
	}
	if ([elementName isEqualToString:@"pos"]){
		insertPos=FALSE;		
	}
	if ([elementName isEqualToString:@"name"]){
		insertName=FALSE;		
	}
	if ([elementName isEqualToString:@"path"]){
		LatLon* insertLatLon = [[LatLon alloc] initWithLatitude:currLatLon.latitude Longitude:currLatLon.longitude Altitude:currLatLon.altitude];
		//inseriscce XYZ
		//NSLog(@"B.......%f,%f,%f,%f,%f,%f",currLatLon.latitude,currLatLon.longitude,currLatLon.altitude,[currLatLon->coord X],[currLatLon->coord Y],[currLatLon->coord Z]);
		// LatLon* insertLatLon = [[LatLon alloc] init];
		/*
		Vec4* coordPos = [[Vec4 alloc] init];
		coordPos.X=[currLatLon->coord X] ;
		coordPos.Y=[currLatLon->coord Y] ;
		coordPos.Z=[currLatLon->coord Z] ;
		insertLatLon->coord=coordPos;
		*/
			//Vec4* coordPos = [Vec4 geodeticToCartesian:currLatLon.latitude Longitude:currLatLon.longitude Elevation:currLatLon.altitude];
		Vec4* userPos = userLocation->coord;
	//	NSLog(@"parser elementName path %f %f %f",userLocation->coord->X,userLocation->coord->Y,userLocation->coord->Z);
		
		Vec4* coordPos = [Vec4 geodeticToCartesian: currLatLon.latitude Longitude:currLatLon.longitude Elevation:currLatLon.altitude isUser:FALSE userPos:firstUserLocation->coord];
		
		//	insertPlace->coord=coordPos;
		insertLatLon->coord=coordPos;
		
		
		//NSString *str = [[NSString alloc] initWithString:currLatLon.name]; 
		
		insertLatLon.name=@"path";
		
		[arrayPath addObject:insertLatLon];
		//[arrayObjects addObject:insertLatLon];
		
		
	}
	
}

-(NSString *)pathToDataFile
{
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *docDir = [path objectAtIndex:0];
	
	//NSString* docDir = [[NSBundle mainBundle] bundlePath];
	
	NSString *finalPath =  [docDir stringByAppendingPathComponent:@"LastPath.xml"];
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


@end
