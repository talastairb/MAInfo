//
//  FLIKViewController.h
//  MAInfoMaster
//
//  Created by Neil Chandra on 4/29/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLIKViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *jsonArray;
@property (strong, nonatomic) NSMutableArray *colorArray;
@property (strong, nonatomic) NSString *dateString;


@property (strong, nonatomic) NSMutableArray *lunchEntrees;
@property (strong, nonatomic) NSMutableArray *lunchSides;
@property (strong, nonatomic) NSMutableArray *lunchFlikLive;
@property (strong, nonatomic) NSMutableArray *lunchDessert;
@property (strong, nonatomic) NSMutableArray *lunchSoups;

@end
