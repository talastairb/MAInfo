//
//  SecondViewController.h
//  MAInfoMaster
//
//  Created by Nate Lundie on 4/15/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *userField;

@property (strong, nonatomic) IBOutlet UITextField *passField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSMutableArray *jsonArray;
@property (strong, nonatomic) IBOutlet UILabel *message;

@end
