//
//  PharmaViewController.h
//  ExpressMed
//
//  Created by Arnel Perez on 9/23/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PharmaViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    
}

- (IBAction)btnBack:(id)sender;
- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
