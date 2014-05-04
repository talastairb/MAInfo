//
//  ViewController.h
//  DatabaseReader
//
//  Created by Taveras, Helson on 3/4/14.
//  Copyright (c) 2014 Taveras, Helson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableArray *jsonArray;
}
- (IBAction)onButtonPress:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property id objectReturnedFromJSON;
- (void) printURL;
@end
