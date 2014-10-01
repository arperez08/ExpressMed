//
//  LocationViewController.m
//  ExpressMed
//
//  Created by Arnel Perez on 9/23/14.
//  Copyright (c) 2014 Arnel Perez. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize mapView, toolBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Satellite"
                                   style:UIBarButtonItemStyleBordered
                                   target: self
                                   action:@selector(changeMapType:)];
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, nil];
    toolBar.items = buttons;
    
    mapView.showsUserLocation = YES;
    NSMutableArray* annotations=[[NSMutableArray alloc] init];
    
    NSLog(@"%lu",(unsigned long)[annotations count]);
    MKMapRect flyTo = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        }
        else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    // Position the map so that all overlays and annotations are visible on screen.
    mapView.visibleMapRect = flyTo;
    
}

- (void) changeMapType: (id)sender {
    if (mapView.mapType == MKMapTypeStandard)
    {
        //mapView.mapType = MKMapTypeSatellite;
        mapView.mapType = MKMapTypeHybrid;
        UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]
                                       initWithTitle: @"Standard"
                                       style:UIBarButtonItemStyleBordered
                                       target: self
                                       action:@selector(changeMapType:)];
        NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, nil];
        toolBar.items = buttons;
    }
    else{
        mapView.mapType = MKMapTypeStandard;
        UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]
                                       initWithTitle: @"Satellite"
                                       style:UIBarButtonItemStyleBordered
                                       target: self
                                       action:@selector(changeMapType:)];
        NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, nil];
        toolBar.items = buttons;
    }
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

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
