//
//  ShowViewController.m
//  GooglePlacesAPIDemo
//
//  Created by mittal on 5/15/13.
//
//

#import "ShowViewController.h"
#import "PlacesTableViewController.h"
#import "SinglepinMap.h"
#define TAG_CUSTOMMENU 9999
@interface ShowViewController ()

@end

@implementation ShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Search";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)gotoMaps:(id)sender{
    
    NSMutableArray *array = [[NSMutableArray alloc ] init];
    [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:LATTITUDE,@"latitude",LANGITUDE,@"longitude",ADDRESS,@"address",nil]];
    SinglepinMap *locations_View = [[ SinglepinMap alloc] initWithNibName:@"SinglepinMap" bundle:nil];
    locations_View.arrMap = array;
    // locations_View.arrMap = [  ;
    [self.navigationController pushViewController:locations_View animated:YES];

}

-(IBAction)gotoNearByLocations:(id)sender{
    CustomMenuView *oldCustomMenu = (CustomMenuView*)[self.view viewWithTag:TAG_CUSTOMMENU];
    if (oldCustomMenu != nil) {
        [oldCustomMenu removeFromSuperview];
    }
    else{
        CustomMenuView *cMenu = [[CustomMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
        cMenu.tag = TAG_CUSTOMMENU;
        
        [cMenu setOptionsWithTitles:[NSArray arrayWithObjects:@"Restaurant",@"Bank",@"School",@"Hospital",nil] andPosition:CGPointMake(24, 60) andArrowPosition:CustomMenuArrowAlignmentRight];
        
        
        cMenu.delegate = self;
        
        [self.view addSubview:cMenu];
    }
    
    
    
}
#pragma mark - Custom menu view delegate method

- (void)CustomMenuButtonTappedWithTitle:(NSString*)title{
    NSString * Search;
    
    if ([title isEqualToString:@"Hotel"]) {
 
    }
    else if ([title isEqualToString:@"Bank"]) {
      
    }
    else if ([title isEqualToString:@"School"]) {
       
    }
    else
    {
        
    }
    Search = [title lowercaseString];
    
    PlacesTableViewController *obj = [[PlacesTableViewController alloc] init];
    
    
    obj.searchField = Search;
    [self.navigationController pushViewController:obj animated:YES];
    
}
@end
