//
//  LocationViewController.h
//  ExpressMed
//
//  Created by Arnel Perez on 9/23/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet MKMapView* mapView;
    UIToolbar *toolbar;
}
@property(nonatomic,retain)	IBOutlet MKMapView* mapView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)btnBack:(id)sender;

@end
