//
//  PlacesTableViewController.m
//  GooglePlacesAPIDemo
//
//  Created by Training on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "SinglepinMap.h"
//#define PlacesURL @"https://maps.googleapis.com/maps/api/place/search/xml?"
#define PlacesURL @"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?"

#define RADIUS @"500"



//location=34.0522222,-118.2427778&radius=500&types=bank&sensor=false&key=AIzaSyAgOK0X0Pmwc2BlONmyiHzn5NiKPk_QJqg

@implementation PlacesTableViewController
@synthesize searchField;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        placesOutputArray = [[NSMutableArray alloc]init];
        
        
    }
    
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    
}
-(void)ParseXML_of_Google_PlacesAPI
{
    NSString *strSearchWord =  [[[[[PlacesURL stringByAppendingString:[NSString stringWithFormat:@"location=%@,%@",LATTITUDE,LANGITUDE]] stringByAppendingString:[NSString stringWithFormat:@"&radius=%@",RADIUS]]stringByAppendingString:[NSString stringWithFormat:@"&types=%@",searchField ]] stringByAppendingString:[NSString stringWithFormat:@"&sensor=%@",@"false"]] stringByAppendingString:[NSString stringWithFormat:@"&key=%@",GOOGLEAPIKEY]];
   
    NSURL *googlePlacesURL = [NSURL URLWithString:strSearchWord];
    NSData *xmlData = [NSData dataWithContentsOfURL:googlePlacesURL];
    xmlDocument = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    
    NSArray *arr = [xmlDocument.rootElement elementsForName:@"result"];
    
    for(GDataXMLElement *e in arr )
    {
        [placesOutputArray addObject:e];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = [NSString stringWithFormat:@"Near By %@",[self.searchField capitalizedString]];
    [self ParseXML_of_Google_PlacesAPI];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [placesOutputArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[[placesOutputArray objectAtIndex:indexPath.row] childAtIndex:0] stringValue];
    
    cell.detailTextLabel.text = [[[placesOutputArray objectAtIndex:indexPath.row] childAtIndex:1] stringValue];

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSString *str = [[[placesOutputArray objectAtIndex:indexPath.row] childAtIndex:0] stringValue];
    
    //parsing for latitude and longitude
    
   // double lat = [[[[[[[[placesOutputArray objectAtIndex:indexPath.row]elementsForName:@"geometry"] objectAtIndex:0] elementsForName:@"location"] objectAtIndex:0] childAtIndex:0]stringValue]doubleValue];
    NSString *lat = [[[[[[[placesOutputArray objectAtIndex:indexPath.row]elementsForName:@"geometry"] objectAtIndex:0] elementsForName:@"location"] objectAtIndex:0] childAtIndex:0]stringValue];
    NSString *lng = [[[[[[[placesOutputArray objectAtIndex:indexPath.row]elementsForName:@"geometry"] objectAtIndex:0] elementsForName:@"location"] objectAtIndex:0] childAtIndex:1]stringValue];
    NSString *address = [[[placesOutputArray objectAtIndex:indexPath.row] childAtIndex:0] stringValue];
    
    
    
  //  double lng = [[[[[[[[placesOutputArray objectAtIndex:indexPath.row]elementsForName:@"geometry"] objectAtIndex:0] elementsForName:@"location"] objectAtIndex:0] childAtIndex:1] stringValue] doubleValue];
    
  //  CLLocationCoordinate2D _cords = {lat,lng};
    
    
//   mapViewC = [[MapViewController alloc]initWithNibName:nil bundle:nil bankName:str andCoordinates:_cords];
//    
//    [self.navigationController pushViewController:mapViewC animated:YES];
    NSMutableArray *array = [[NSMutableArray alloc ] init];
    [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:lat,@"latitude",lng,@"longitude",address,@"address",nil]];
    SinglepinMap *locations_View = [[ SinglepinMap alloc] initWithNibName:@"SinglepinMap" bundle:nil];
    locations_View.arrMap = array;
   // locations_View.arrMap = [  ;
    [self.navigationController pushViewController:locations_View animated:YES];
    
}

@end
