//
//  MapViewController.h
//  GooglePlacesAPIDemo
//
//  Created by Training on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "MyMapAnnot.h"


@interface MapViewController : UIViewController {
    
    
    MKMapView *mpView;
    MyMapAnnot *mapAnnotObject;
    NSString *bankName;
    CLLocationCoordinate2D globalCords;
    
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bankName:(NSString*)_name andCoordinates:(CLLocationCoordinate2D)bankcords;

@end
