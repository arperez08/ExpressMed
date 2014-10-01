//
//  LoginViewController.m
//  ExpressMed
//
//  Created by Arnel Perez on 9/19/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "SideMenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)btnLogin:(id)sender {
//    MainViewController *mvc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
//    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
//    
//    UINavigationController *navigateVC = [[UINavigationController alloc] initWithRootViewController:mvc];
//    UIViewController *leftViewController = smvc;
//    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:navigateVC
//                                                                                    leftViewController:leftViewController
//                                                                                   rightViewController:nil
//                                                                                               options:nil];
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController pushViewController:revealController animated:YES];
    
    MainViewController *homeVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:homeVC
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:sideMenuViewController animated:YES];
}
@end
