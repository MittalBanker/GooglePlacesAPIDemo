//
//  MyMapAnnot.h
//  GooglePlacesAPIDemo
//
//  Created by Training on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface MyMapAnnot : NSObject <MKAnnotation> {
   
    
    NSString *pinTitle;
    CLLocationCoordinate2D _theCords;
    
}

-(id)initWithName:(NSString*)_placeName andCoordinates:(CLLocationCoordinate2D)_coordinates;

@end
