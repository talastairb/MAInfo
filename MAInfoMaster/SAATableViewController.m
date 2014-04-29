//
//  SLExpandableTableViewController.m
//  SLExpandableTableViewTests
//
//  Created by Oliver Letterer on 19.02.14.
//  Copyright 2014 Sparrow-Labs. All rights reserved.
//

#import "SAATableViewController.h"
#import <SLExpandableTableView.h>

@interface SAATableViewController()

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property (nonatomic, readonly) UIExpansionStyle expansionStyle;
- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated;

@end

@implementation SAATableViewController

/*- (NSString *)accessibilityLabel
{
    return self.textLabel.text;
}*/

- (void)setLoading:(BOOL)loading
{
    if (loading != _loading) {
        _loading = loading;
        [self _updateDetailTextLabel];
    }
}

- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated
{
    if (expansionStyle != _expansionStyle) {
        _expansionStyle = expansionStyle;
        [self _updateDetailTextLabel];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /*[self _updateDetailTextLabel];
        self.backgroundColor = [UIColor yellowColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.frame = CGRectMake(10, 20, 100,22);*/
    }
    return self;
}



@end


@interface SAATableViewController () <UITableViewDatasource, SLExpandableTableViewDelegate>

@property (nonatomic, strong) NSArray *firstSectionStrings;
@property (nonatomic, strong) NSArray *secondSectionStrings;

@property (nonatomic, strong) NSMutableArray *sectionsArray;

@property (nonatomic, strong) NSMutableIndexSet *expandableSections;

@end

@implementation SAATableViewController {
    NSMutableArray *eventNames;
    NSMutableArray *eventDetails;
    NSMutableArray *eventTimes;
}

#pragma mark - setters and getters

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style
{
    // Load activities
    eventNames = [[NSMutableArray alloc] init];
    eventDetails =[[NSMutableArray alloc] init];
    eventTimes =[[NSMutableArray alloc] init];
    
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
        NSString *eventNameString = [NSString stringWithFormat:@"%@", [activities objectForKey:@"eventName"]];
            //NSLog(@"EventName: %@", eventNameString);
        [eventNames addObject:eventNameString];
        
        NSString *description = [NSString stringWithFormat:@"%@", [activities objectForKey:@"eventDescription"]];
        [eventDetails addObject:description];
            NSLog(@"Description: %@", description);
        
        NSString *time = [NSString stringWithFormat:@"%@", [activities objectForKey:@"startTime"]];
        [eventTimes addObject:time];
        NSLog(@"Time: %@", time);
    }
    NSLog(@"Event array: %@", eventNames);

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
    SLExpandableTableView *tableView = [[SLExpandableTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self initWithStyle:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = tableView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.someProperty = [eventNames objectAtIndex:indexPath.row];
    NSLog(@"Selected row %i",indexPath.row);
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
    
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

- (UITableViewCell<UIExpandingTableViewCell> *)tableView:(SLExpandableTableView *)tableView expandingCellForSection:(NSInteger)section
{
    static NSString *CellIdentifier = @"TableViewControllerHeaderCell";
    SLExpandableTableViewControllerHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[SLExpandableTableViewControllerHeaderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [eventNames objectAtIndex:section];
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
    return eventNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return eventNames.count;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.detailTextLabel.text = eventTimes[indexPath.section];
    cell.textLabel.text = eventDetails[indexPath.section];

    return cell;
}

#pragma mark - UITableViewDelegate

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}*/

#pragma mark - Private category implementation ()

@end