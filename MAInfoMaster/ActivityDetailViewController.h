//
//  ActivityDetailViewController.h
//  MAInfoMaster
//
//  Created by Geoffrey Owens on 4/29/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetails.h"

@interface ActivityDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *BackButton;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *Swiper;
@property ActivityDetails *details;

@end
