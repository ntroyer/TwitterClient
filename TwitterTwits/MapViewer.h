//
//  MapViewer.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/25/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewer : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mpView;
@property (weak, nonatomic) NSArray *peopleList;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
