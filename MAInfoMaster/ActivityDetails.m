//
//  ActivityDetails.m
//  MAInfoMaster
//
//  Created by Geoffrey Owens on 4/29/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import "ActivityDetails.h"

@implementation ActivityDetails
@synthesize activityDate;
@synthesize activityDescription;
@synthesize signUp;
@synthesize activityLocation;
@synthesize activityName;
-(id) initWithName:(NSString *)name date:(NSString *)date desc:(NSString *)desc location:(NSString *)loc {
    self = [super init];
    activityName = [NSString stringWithString:name];
    activityDate = [NSString stringWithString:date];
    activityDescription = [NSString stringWithString:desc];
    //signUp = su;
    activityLocation = [NSString stringWithString:loc];
    return self;
}
@end

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
