//
//  SLExpandableTableViewController.m
//  SLExpandableTableViewTests
//
//  Created by Oliver Letterer on 19.02.14.
//  Copyright 2014 Sparrow-Labs. All rights reserved.
//

#import "SAATableViewController.h"
#import <SLExpandableTableView.h>
#import "ActivityDetails.h"
#import "ActivityDetailViewController.h"



@interface SAATableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *firstSectionStrings;
@property (nonatomic, strong) NSArray *secondSectionStrings;

@property (nonatomic, strong) NSMutableArray *sectionsArray;

@property (nonatomic, strong) NSMutableIndexSet *expandableSections;

@end

@implementation SAATableViewController {
    NSMutableArray *eventNames;
    NSMutableArray *eventDetails;
    NSMutableArray *eventTimes;
    NSMutableArray *events;
    int selectedRow;
}

#pragma mark - setters and getters

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style
{
    // Load activities
    eventNames = [[NSMutableArray alloc] init];
    eventDetails =[[NSMutableArray alloc] init];
    eventTimes =[[NSMutableArray alloc] init];
    events = [[NSMutableArray alloc] init];
    
    // URL of the activities
    NSURL * url = [[NSURL alloc] initWithString:@"http://www.saa.ma1geek.org/getActivities.php?date=2014-03-21"];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:60];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:urlData
                                                            options:0
                                                              error:&error];
    
    NSDictionary *activityDic = [jsonDic objectForKey:@"Activities"];
    
    //NSLog(@"Number of activities: %i", [activityDic count]);
    //NSLog(@"Description: %@", [activityDic description]);
    //NSLog(@"%@", activityDic);
    NSLog(@"%@", urlData);
    NSLog(@"%@", jsonDic);
    
    for(NSDictionary *activities in activityDic){
        NSString *eventNameString = [NSString stringWithFormat:@"%@",
                                    [activities objectForKey:@"eventName"]];
        NSString *description = [NSString stringWithFormat:@"%@",
                                [activities objectForKey:@"eventDescription"]];
        NSString *loc = [NSString stringWithFormat:@"%@",
                        [activities objectForKey:@"eventLocation"]];
        NSString *time = [NSString stringWithFormat:@"%@ - %@", [activities objectForKey:@"startTime"], [activities objectForKey:@"endTime"]];
        [events addObject:[[ActivityDetails alloc] initWithName:[NSString stringWithString:eventNameString]
                                                           date:[NSString stringWithString:time]
                                                           desc:[NSString stringWithString:description]
                                                       location:[NSString stringWithString:loc]]];
        
    }
    NSLog(@"Event array: %@", events);

    if (self = [super initWithStyle:style]) {
        NSLog(@"number of events:%i",[eventNames count]);
        _expandableSections = [NSMutableIndexSet indexSet];
    } else
        NSLog(@"Unable to initialize with style.");
    return self;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)loadView
{
    NSLog(@"%@", @"TVC loadView");
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self initWithStyle:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = tableView;
}


#pragma mark - SLExpandableTableViewDatasource

- (BOOL)tableView:(SLExpandableTableView *)tableView canExpandSection:(NSInteger)section
{
    return YES;
}

- (BOOL)tableView:(SLExpandableTableView *)tableView needsToDownloadDataForExpandableSection:(NSInteger)section
{
    return ![self.expandableSections containsIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Loading cell");
    static NSString *CellIdentifier = @"TableViewControllerHeaderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    ActivityDetails *ad = [events objectAtIndex:[indexPath indexAtPosition:0]];
    NSString *fieldLabel = ad.activityName;
    cell.textLabel.text = fieldLabel;
    NSLog(@"Loading cell with %@",fieldLabel);
    return cell;
}

#pragma mark - SLExpandableTableViewDelegate

- (void)tableView:(SLExpandableTableView *)tableView downloadDataForExpandableSection:(NSInteger)section
{
    // download data here
    [self.expandableSections addIndex:section];
    [tableView expandSection:section animated:YES];
}

- (void)tableView:(SLExpandableTableView *)tableView didCollapseSection:(NSUInteger)section animated:(BOOL)animated
{
    [self.expandableSections removeIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return events.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return eventNames.count;
    return 1;
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.detailTextLabel.text = eventTimes[indexPath.section];
    cell.textLabel.text = eventDetails[indexPath.section];

    return cell;
}*/
#pragma mark - Segue Controls
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"detailSegue"])
    {
        // Get reference to the destination view controller
        ActivityDetailViewController *vc = [segue destinationViewController];
        NSLog(@"%i", selectedRow);
        // Pass any objects to the view controller here, like...
        [vc setDetails:[events objectAtIndex:selectedRow]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.someProperty = [eventNames objectAtIndex:indexPath.row];
    NSLog(@"Selected row %i",[indexPath indexAtPosition:0]);
    selectedRow = [indexPath indexAtPosition:0];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
    
}

#pragma mark - UITableViewDelegate

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}*/

#pragma mark - Private category implementation ()

@end