//
//  FLIKViewController.m
//  MAInfoMaster
//
//  Created by Neil Chandra on 4/29/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import "FLIKViewController.h"

@interface FLIKViewController ()

@end

@implementation FLIKViewController

@synthesize jsonArray;
@synthesize colorArray;
@synthesize dateString;

//synthesize lunch arrays
@synthesize lunchEntrees;
@synthesize lunchDessert;
@synthesize lunchFlikLive;
@synthesize lunchSides;
@synthesize lunchSoups;

const int numberOfSections = 3;
const int entreeSection = 0;
const int sideSection = 1;
const int flikLiveSection = 2;

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
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setDate];
    
    [self loadEntrees];
    [self loadSides];
    [self loadFlikLive];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDate {
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [DateFormatter stringFromDate:[NSDate date]];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return numberOfSections;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:  (NSInteger)section
{
    
    switch (section){
        case entreeSection:
            
            return [lunchEntrees count];
            
            break;
            
        case sideSection:
            
            return [lunchSides count];
            
            break;
            
        case flikLiveSection:
            
            return [lunchFlikLive count];
        
            break;
        default:
            
            return 3;
            
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:   (NSInteger)section
{
    switch (section){
        case entreeSection:
            return @"Entrees";
            break;
            
        case sideSection:
            return @"Sides";
            break;
            
        case flikLiveSection:
            return @"Flik Live";
            break;
        
        default:
            return 0;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    switch (indexPath.section)
    {
        case entreeSection:
            cell.textLabel.text = [lunchEntrees objectAtIndex:indexPath.row];
            break;
        case sideSection:
            cell.textLabel.text = [lunchSides objectAtIndex:indexPath.row];
            break;
        case flikLiveSection:
            cell.textLabel.text = [lunchFlikLive objectAtIndex:indexPath.row];
            
    }
    return cell;
}

- (void) loadEntrees
{
    lunchEntrees = [[NSMutableArray alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://flik.ma1geek.org/getMeals.php?type=Entree&date=%@&time=Lunch", dateString]];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    //NSLog(@"%@", urlData);
    
    NSDictionary *jsonDic = [NSJSONSerialization
                             JSONObjectWithData:urlData
                             options:0
                             error:&error];
    
    //NSLog(@"%@", jsonDic);
    NSDictionary *entreeDic = [jsonDic objectForKey:@"Entree"];
    
   // NSLog(@"Entree length is: %x", (unsigned int)[entreeDic count]);
   // NSLog(@"Description: %@", [entreeDic description]);
    
    for(NSDictionary *subMeals in entreeDic){
        NSString *holdString = [NSString stringWithFormat:@"%@", [subMeals objectForKey:@"mealName"]];
        //NSLog(@"MealName: %@", holdString);
        [lunchEntrees addObject:holdString];
    }
    NSLog(@"lunchEntrees: %@", lunchEntrees);
    
    
}
- (void) loadSides
{
    lunchSides = [[NSMutableArray alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://flik.ma1geek.org/getMeals.php?type=Side&date=%@&time=Lunch", dateString]];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    //NSLog(@"%@", urlData);
    
    NSDictionary *jsonDic = [NSJSONSerialization
                             JSONObjectWithData:urlData
                             options:0
                             error:&error];
    
   /// NSLog(@"%@", jsonDic);
    NSDictionary *sidesDic = [jsonDic objectForKey:@"Side"];
    
   // NSLog(@"Sides length is: %x", (unsigned int)[sidesDic count]);
    //NSLog(@"Description: %@", [sidesDic description]);
    
    for(NSDictionary *subMeals in sidesDic){
        NSString *holdString = [NSString stringWithFormat:@"%@", [subMeals objectForKey:@"mealName"]];
        //NSLog(@"MealName: %@", holdString);
        [lunchSides addObject:holdString];
    }
    NSLog(@"lunchSides: %@", lunchSides);
    
    
}

- (void) loadFlikLive
{
    lunchFlikLive = [[NSMutableArray alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://flik.ma1geek.org/getMeals.php?type=Flik+Live&date=%@&time=Lunch", dateString]];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
   // NSLog(@"%@", urlData);
    
    NSDictionary *jsonDic = [NSJSONSerialization
                             JSONObjectWithData:urlData
                             options:0
                             error:&error];
    
   // NSLog(@"%@", jsonDic);
    NSDictionary *flikLiveDic = [jsonDic objectForKey:@"Flik Live"];
    
    //NSLog(@"Sides length is: %x", (unsigned int)[flikLiveDic count]);
    //NSLog(@"Description: %@", [flikLiveDic description]);
    
    for(NSDictionary *subMeals in flikLiveDic){
        NSString *holdString = [NSString stringWithFormat:@"%@", [subMeals objectForKey:@"mealName"]];
        //NSLog(@"MealName: %@", holdString);
        [lunchFlikLive addObject:holdString];
    }
    NSLog(@"lunchFlikLive: %@", lunchFlikLive);
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
