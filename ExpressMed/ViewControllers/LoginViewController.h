//
//  LoginViewController.h
//  ExpressMed
//
//  Created by Arnel Perez on 9/19/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController <RESideMenuDelegate>
{
        MBProgressHUD *HUB;
}
@property (strong, nonatomic) IBOutlet UITextField *txtUser;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegister:(id)sender;


@end
