//
//  AppDelegate.h
//  DatabaseReader
//
//  Created by Taveras, Helson on 3/4/14.
//  Copyright (c) 2014 Taveras, Helson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TableViewController *viewController;
@end
