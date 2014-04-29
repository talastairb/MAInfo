//
//  ActivityDetailViewController.h
//  MAInfoMaster
//
//  Created by Geoffrey Owens on 4/29/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
