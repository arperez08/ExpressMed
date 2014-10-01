//
//  MainViewController.h
//  ExpressMed
//
//  Created by Arnel Perez on 9/22/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
     IBOutlet UIButton *btnMenu;
}

@property (strong, nonatomic) IBOutlet UIButton *btnMenu;

- (IBAction)btnPharma:(id)sender;
- (IBAction)btnReminder:(id)sender;
- (IBAction)btnLocation:(id)sender;
- (IBAction)btnChat:(id)sender;
- (IBAction)btnPromo:(id)sender;

@end
