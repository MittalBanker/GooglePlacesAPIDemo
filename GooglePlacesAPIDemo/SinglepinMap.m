//
//  SinglepinMap.m
//  Foodzilla
//
//  Created by digicorp on 09/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SinglepinMap.h"
#import <QuartzCore/QuartzCore.h>


@implementation SinglepinMap
@synthesize mapView;
@synthesize dForMap;
@synthesize call;
@synthesize arrMap;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	if (call==1) {
		MKCoordinateRegion region;
		MKCoordinateSpan span;
		span.latitudeDelta=0.2;
		span.longitudeDelta=0.2;
		
		CLLocationCoordinate2D location;
		
        
		float lati;
        float longi;
        if([self.arrMap count]>0)
        {
            dForMap  = [self.arrMap objectAtIndex:0];
        lati=[[dForMap valueForKey:@"latitude"]floatValue];
		
        longi=[[dForMap valueForKey:@"longitude"]floatValue];
		}
        
       
		location.latitude = lati ;
		location.longitude = longi;
		
        MKCoordinateSpan spn = {0.01,0.01};
        MKCoordinateRegion reg = {location,spn};
       
      		
		[mapView setRegion:reg animated:TRUE];
		[mapView regionThatFits:reg];
		
		myview.hidden=TRUE;
		[self.navigationItem setTitle:@"Map"];
		[mapView removeAnnotations:mapView.annotations];
		
		
		
        for(int i =0 ;i<[self.arrMap count]>0;i++)
        {
        dForMap  = [self.arrMap objectAtIndex:i];
		Place* home = [[[Place alloc] init] autorelease];
        home.name = [dForMap valueForKey:@"address"];
        home.description = [dForMap valueForKey:@"address"];
		home.latitude = [[dForMap valueForKey:@"latitude"]floatValue];
		home.longitude = [[dForMap valueForKey:@"longitude"]floatValue];
		PlaceMark* from = [[[PlaceMark alloc] initWithPlace:home] autorelease];		
		[mapView addAnnotation:from];
		}
		
	}
	
	
}
- (void)viewWillAppear:(BOOL)animated {
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	CLLocationCoordinate2D location;
	float lati;
    float longi;
    if([self.arrMap count]>0)
    {
        dForMap  = [self.arrMap objectAtIndex:0];
        lati=[[dForMap valueForKey:@"latitude"]floatValue];
		
        longi=[[dForMap valueForKey:@"longitude"]floatValue];
    }
		location.latitude = lati ;
	location.latitude = lati ;
    location.longitude = longi;
    
    MKCoordinateSpan spn = {0.01,0.01};
    MKCoordinateRegion reg = {location,span};
    
    
    
    [mapView setRegion:reg animated:TRUE];
    [mapView regionThatFits:reg];
	myview.hidden=TRUE;
	
	[mapView removeAnnotations:mapView.annotations];
	

	
    for(int i =0 ;i<[self.arrMap count]>0;i++)
    {
        dForMap  = [self.arrMap objectAtIndex:i];
		Place* home = [[[Place alloc] init] autorelease];
		home.name = [dForMap valueForKey:@"address"];
        home.description = [dForMap valueForKey:@"address"];
		home.latitude = [[dForMap valueForKey:@"latitude"]floatValue];
		home.longitude = [[dForMap valueForKey:@"longitude"]floatValue];
		PlaceMark* from = [[[PlaceMark alloc] initWithPlace:home] autorelease];
		[mapView addAnnotation:from];
    }
    curled = FALSE;
    [self centerMap];
    [mapView setUserInteractionEnabled:YES];
    UIBarButtonItem *b=[[UIBarButtonItem alloc] initWithTitle:@"Map mode" style:UIBarButtonItemStylePlain target:self action:@selector(btnCurl:)];
	self.navigationItem.rightBarButtonItem=b;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
}                                                                                              

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
	
	if (annotation == mapView.userLocation) 
		return nil;
	
	MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: @"asdf"];
	
	if (pin == nil)
		pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"asdf"] autorelease];
	else
		pin.annotation = annotation;
	pin.userInteractionEnabled = YES;
	UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; 
	[disclosureButton setFrame:CGRectMake(0, 0, 30, 30)];
	
	//pin.rightCalloutAccessoryView = disclosureButton;
	pin.pinColor = MKPinAnnotationColorRed;
	pin.animatesDrop = YES;
	[pin setEnabled:YES];
	[pin setCanShowCallout:YES];
	
	
	return pin;
	
}





-(void) centerMap 
{
	
	MKCoordinateRegion region;
	
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 120;
	CLLocationDegrees minLon = 150;
	
	
		Place* home = [[[Place alloc] init] autorelease];
		home.latitude = [[dForMap valueForKey:@"latitude"]floatValue];
		home.longitude =[[dForMap valueForKey:@"longitude"]floatValue];

		PlaceMark* from = [[[PlaceMark alloc] initWithPlace:home] autorelease];		
		
		CLLocation* currentLocation = (CLLocation*)from ;
		if(currentLocation.coordinate.latitude > maxLat)
			maxLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.latitude < minLat)
			minLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.longitude > maxLon)
			maxLon = currentLocation.coordinate.longitude;
		if(currentLocation.coordinate.longitude < minLon)
			minLon = currentLocation.coordinate.longitude;
		
		region.center.latitude     = (maxLat + minLat) / 2;
		region.center.longitude    = (maxLon + minLon) / 2;
		region.span.latitudeDelta  =  maxLat - minLat;
		region.span.longitudeDelta = maxLon - minLon;
	
	
	
	[mapView setRegion:region animated:YES];
	
}


-(IBAction)btnCurl:(id)sender{
	[self performCurl];
}
-(IBAction)btnCurlDown:(id)sender{
	[self performCurl];
}

-(void)performCurl{
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self]; [animation setDuration:0.5];
	[animation setTimingFunction:UIViewAnimationCurveEaseInOut];
	if (!curled){
		animation.type = @"pageCurl"; animation.fillMode = kCAFillModeForwards;
		animation.endProgress = 0.65; myview.hidden=NO; [self.view addSubview:myview]; 
    } else {
		animation.type = @"pageUnCurl"; animation.fillMode = kCAFillModeBackwards;
		animation.startProgress = 0.35; myview.hidden=YES;
	}
	[animation setRemovedOnCompletion:NO];
	[[self view] exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	[[[self view] layer] addAnimation:animation forKey:@"pageCurlAnimation"];
	// Disable user interaction where necessary
	if (!curled) {
		[mapView setUserInteractionEnabled:NO];
	} else {
		[self.navigationController.navigationBar setUserInteractionEnabled:YES];
		[mapView setUserInteractionEnabled:YES];
	}	
	curled = !curled;
}

-(IBAction)btnSegChanged:(id)sender{
    UIButton *btnSegmentchanged = (UIButton*)sender;
    int tag = btnSegmentchanged.tag;
	
	if(tag==1){
        [imgSegment setImage:[UIImage imageNamed:@"map_segment1.png"]];
		[mapView setMapType:MKMapTypeStandard];
    }
    else if(tag==2){
        [imgSegment setImage:[UIImage imageNamed:@"satellite.png"]];
		[mapView setMapType:MKMapTypeSatellite];
    }
    else if(tag==3)
    {
        [imgSegment setImage:[UIImage imageNamed:@"hybrid.png"]];
		[mapView setMapType:MKMapTypeHybrid];
    }
    
	[self performCurl];
}




/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.mapView=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [super dealloc];
	self.mapView = nil;
}
#pragma User Actions
-(IBAction)BackAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
