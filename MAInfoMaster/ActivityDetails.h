//
//  ActivityDetails.h
//  MAInfoMaster
//
//  Created by Geoffrey Owens on 4/29/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetails : NSObject
@property NSString *activityName;
@property NSString *activityDescription;
@property NSString *activityDate;
@property BOOL signUp;
@property NSString *activityLocation;
-(id) initWithName:(NSString *)name date:(NSString *)date desc:(NSString *)desc location:(NSString *)loc;
@end
