//
//  SecondViewController.m
//  MAInfoMaster
//
//  Created by Nate Lundie on 4/15/14.
//  Copyright (c) 2014 Alastair. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end



@implementation SecondViewController
@synthesize jsonArray;
@synthesize userField;
@synthesize passField;
@synthesize message;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginPressed:(id)sender {
    [self loadJSON];
    
    
}
- (void) loadJSON
{
    NSInteger success = 0;
    jsonArray = [[NSMutableArray alloc] init];
    NSString *firstString = @"http://ma1geek.org/app_users/login.php?n=";
    NSString *secondString = userField.text;
    NSString *thirdString = @"&p=";
    NSString *fourthString = passField.text;
    NSMutableString *urlString = [NSMutableString stringWithString:firstString];
    [urlString appendString:secondString];
    [urlString appendString:thirdString];
    [urlString appendString:fourthString];
    
    
    NSURL * url = [[NSURL alloc] initWithString: urlString];
    
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    NSLog(@"%@", urlData);
    
    NSDictionary *jsonDic = [NSJSONSerialization
                             JSONObjectWithData:urlData
                             options:0
                             error:&error];
    
    NSLog(@"%@", jsonDic);
    success = [jsonDic[@"success"] integerValue];
    //NSDictionary *entreeDic = [jsonDic objectForKey:@"Entree"];
    
    //NSLog(@"Entree length is: %i", [entreeDic count]);
    // NSLog(@"Description: %i", [success]);
    
    /*for(NSDictionary *subMeals in entreeDic){
     NSString *holdString = [NSString stringWithFormat:@"%@", [subMeals objectForKey:@"mealName"]];
     NSLog(@"MealName: %@", holdString);
     [jsonArray addObject:holdString];
     }
     NSLog(@"jsonArray: %@", jsonArray);*/
    if(success == 1)
    {
        //successLabel.text=@"you good";
        [self performSegueWithIdentifier: @"MySegue" sender: self];
        
        
    }
    if(success==2){
        message.text=@"Invalid Password";
    }
    if(success==0)
    {
        message.text=@"invalid email";
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
