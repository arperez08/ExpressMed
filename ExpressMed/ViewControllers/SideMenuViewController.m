//
//  SideMenuViewController.m
//  ExpressMed
//
//  Created by Arnel Perez on 9/22/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import "SideMenuViewController.h"
#import "LoginViewController.h"
@interface SideMenuViewController ()

@end

@implementation SideMenuViewController
@synthesize lblWecome;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    NSString *firstName = [userData objectForKey:@"strFirstName"];
    NSString *lastName = [userData objectForKey:@"strLastName"];
    
    lblWecome.text = [NSString stringWithFormat:@"Welcome: %@ %@",firstName,lastName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnLogout:(id)sender {
    LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:lvc animated:YES];
}
@end
