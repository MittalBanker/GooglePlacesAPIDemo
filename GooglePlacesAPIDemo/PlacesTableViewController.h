//
//  PlacesTableViewController.h
//  GooglePlacesAPIDemo
//
//  Created by Training on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "MapViewController.h"

@interface PlacesTableViewController : UITableViewController {
    
    
    NSMutableArray *placesOutputArray;
    GDataXMLDocument *xmlDocument;
    MapViewController *mapViewC;
    NSString *searchField;
}
@property(nonatomic,retain)NSString *searchField;

-(void)ParseXML_of_Google_PlacesAPI;



@end
