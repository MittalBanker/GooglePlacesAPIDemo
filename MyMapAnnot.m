//
//  MyMapAnnot.m
//  GooglePlacesAPIDemo
//
//  Created by Training on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyMapAnnot.h"


@implementation MyMapAnnot


-(id)initWithName:(NSString*)_placeName andCoordinates:(CLLocationCoordinate2D)_coordinates
{
        
    pinTitle = _placeName;
    _theCords = _coordinates;
    
    return self;
    
}


-(NSString*)title
{
    return pinTitle;
}

-(CLLocationCoordinate2D)coordinate
{
    
    CLLocationCoordinate2D cords = {_theCords.latitude,_theCords.longitude};
    return cords;
    
}




@end
