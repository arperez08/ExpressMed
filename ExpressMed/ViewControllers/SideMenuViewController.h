//
//  SideMenuViewController.h
//  ExpressMed
//
//  Created by Arnel Perez on 9/22/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController
{
    IBOutlet UILabel *lblWecome;
    NSMutableDictionary *userData;
}

- (IBAction)btnLogout:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblWecome;


@end
