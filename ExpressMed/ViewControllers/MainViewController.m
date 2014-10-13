//
//  MainViewController.m
//  ExpressMed
//
//  Created by Arnel Perez on 9/22/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import "MainViewController.h"
#import "ChatViewController.h"
#import "LocationViewController.h"
#import "PharmaViewController.h"
#import "PromosViewController.h"
#import "ReminderViewController.h"
#import "RESideMenu.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize btnMenu,viewPharma;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    [btnMenu addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];

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


- (IBAction)btnPharma:(id)sender {
//    PharmaViewController *homeVC = [[PharmaViewController alloc]initWithNibName:@"PharmaViewController" bundle:[NSBundle mainBundle]];
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController pushViewController:homeVC animated:YES];
    
    viewPharma.hidden = NO;
}

- (IBAction)btnReminder:(id)sender {
    ReminderViewController *homeVC = [[ReminderViewController alloc]initWithNibName:@"ReminderViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)btnLocation:(id)sender {
    LocationViewController *homeVC = [[LocationViewController alloc]initWithNibName:@"LocationViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)btnChat:(id)sender {
    ChatViewController *homeVC = [[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)btnPromo:(id)sender {
    PromosViewController *homeVC = [[PromosViewController alloc]initWithNibName:@"PromosViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)btnNewOrder:(id)sender {
    viewPharma.hidden = YES;
    PharmaViewController *homeVC = [[PharmaViewController alloc]initWithNibName:@"PharmaViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)btnRefill:(id)sender {
    viewPharma.hidden = YES;
    PharmaViewController *homeVC = [[PharmaViewController alloc]initWithNibName:@"PharmaViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)btnModal:(id)sender {
    viewPharma.hidden = YES;
}
@end
