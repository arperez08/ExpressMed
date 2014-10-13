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
#import "RegistrationViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txtPassword,txtUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [txtUser resignFirstResponder];
    [txtPassword resignFirstResponder];
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

-(BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus currrentStatus = [reachability currentReachabilityStatus];
    return currrentStatus;
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
    [self dismissKeyboard];
    
    if ([txtUser.text isEqualToString:@""]) {
        [self alertStatus:@"Please input your Username." :@"Error"];

    }
    else if ([txtPassword.text isEqualToString:@""]){
        [self alertStatus:@"Please input your Password." :@"Error"];

    }
    else {
        if ([self connected] == NotReachable){
            [self alertStatus:@"No Network Connection" :@"Notification"];
        }
        else{
            HUB = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:HUB];
            HUB.labelText = @"Retrieving and validating data…";
            [HUB showWhileExecuting:@selector(userLogin) onTarget:self withObject:nil animated:YES];
        }
    }
}

- (void) userLogin{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"AuthenGetUser"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtUser.text forKey:@"strUserName"];
    [request setPostValue:txtPassword.text forKey:@"strUserPassm"];
    [request setPostValue:@"0" forKey:@"intAuthType"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData: %@",responseData);
        NSMutableArray *arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dictData = [arrayData objectAtIndex:0];
        NSString *strStatus = [NSString stringWithFormat:@"%@",[dictData objectForKey:@"strStatus"]];
        if ([strStatus isEqualToString:@"Success"]) {
            NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
            [userLogin setObject:txtUser.text forKey:@"Username"];
            [userLogin setObject:txtPassword.text forKey:@"Password"];
            [self getUserData];
        }
        else{
            [self alertStatus:@"Please check your Username or Password." :@"Error"];
        }
    }
    else{
        [self alertStatus:@"A connection failure occurred." :@"Error"];
        NSLog(@"error: %@",error);
    }
}

- (void) getUserData{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"AuthenGetUser"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtUser.text forKey:@"strUserName"];
    [request setPostValue:txtPassword.text forKey:@"strUserPassm"];
    [request setPostValue:@"1" forKey:@"intAuthType"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData UserData: %@",responseData);
        NSMutableArray *arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dictData = [arrayData objectAtIndex:0];
        if (!dictData) {
            [self alertStatus:@"connection lost contact." :@"Error"];
        }
        else{
            NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
            [userLogin setObject:dictData forKey:@"userData"];
            MainViewController *homeVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
            SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
            RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:homeVC
                                                                            leftMenuViewController:leftMenuViewController
                                                                           rightMenuViewController:nil];
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:sideMenuViewController animated:YES];
        }
    }
}

- (IBAction)btnRegister:(id)sender {
    RegistrationViewController *homeVC = [[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}
@end
