//
//  SinglepinMap.h
//  Foodzilla
//
//  Created by digicorp on 09/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Place.h"
#import "PlaceMark.h"

@interface SinglepinMap : UIViewController {
	IBOutlet UIView *myview;
	NSMutableDictionary *dForMap;
    NSMutableArray *arrMap;
	IBOutlet UISegmentedControl *segMain;
	BOOL curled;
	int call;
    IBOutlet UIImageView *imgSegment;
}
@property(nonatomic,readwrite)int call;
@property(nonatomic,assign)NSMutableDictionary *dForMap;
@property(nonatomic,retain)NSMutableArray *arrMap;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
-(void)performCurl;
-(IBAction)btnSegChanged:(id)sender;
-(void) centerMap;
@end
