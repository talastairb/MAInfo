//
//  ActivityDetailViewController.m
//  MAInfoMaster
//
//  Created by Geoffrey Owens on 4/29/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetails.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController
@synthesize details;
@synthesize activityNameLabel;
@synthesize timeLocationLabel;
@synthesize descriptionLabel;
- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)swipeLeftRegistered:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [descriptionLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [activityNameLabel setText:[details activityName]];
    NSString *dateLoc = [NSString stringWithFormat:@"%@, %@",[details activityLocation], [details activityDate]];
    [timeLocationLabel setText:dateLoc];
    [descriptionLabel setText:[details activityDescription]];
    [timeLocationLabel sizeToFit];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
}
@end
