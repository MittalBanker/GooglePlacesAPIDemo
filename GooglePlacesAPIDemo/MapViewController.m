//
//  MapViewController.m
//  GooglePlacesAPIDemo
//
//  Created by Training on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bankName:(NSString*)_name andCoordinates:(CLLocationCoordinate2D)bankcords
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bankName = _name;
        globalCords = bankcords;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    mpView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    
    mapAnnotObject = [[MyMapAnnot alloc]initWithName:bankName andCoordinates:globalCords];
    
    CLLocationCoordinate2D cord = {globalCords.latitude,globalCords.longitude};
    MKCoordinateSpan spn = {0.01,0.01};
    MKCoordinateRegion reg = {cord,spn};
    
    [mpView setRegion:reg];
  
    [mpView addAnnotation:mapAnnotObject];
    [self.view addSubview:mpView];
    
    
    
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
