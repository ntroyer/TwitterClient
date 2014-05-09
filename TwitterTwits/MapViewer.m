//
//  MapViewer.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/25/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import "MapViewer.h"
#import "PersonModel.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "TweetListTableViewController.h"

@interface MapViewer ()

@end

@implementation MapViewer

@synthesize mpView;
@synthesize peopleList;
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Map";
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
        // Custom initialization
        // mkmapview has a protocol called mkmapviewdelegate
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mpView.delegate = self;
    for (PersonModel *p in peopleList){
        CLGeocoder *geo = [[CLGeocoder alloc] init];
        [geo geocodeAddressString:p.location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error){
                NSLog(@"Error %@", error.description);
            } else {
                NSString *title = [NSString stringWithFormat:@"%lu tweets", (unsigned long)[p.tweets count]];
                CLPlacemark *curPlacemark = [placemarks lastObject];
                CLLocationDegrees lat = curPlacemark.location.coordinate.latitude;
                CLLocationDegrees longitude = curPlacemark.location.coordinate.longitude;
                CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat, longitude);
                MKPointAnnotation *annote = [[MKPointAnnotation alloc] init];
                [annote setCoordinate:coor];
                [annote setTitle:p.name];
                [annote setSubtitle:title];
                [mpView addAnnotation:annote];
            }
        }];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *) mapView:(MKMapView *)sender viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *AnnotationIdentifier = @"AnnotationIdentifier";
    NSLog(@"This is getting called");
    
    MKPinAnnotationView *customView = [[MKPinAnnotationView alloc] init];
    
    customView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    UIButton *tweetsButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [tweetsButton addTarget:self action:nil forControlEvents:UIControlEventAllTouchEvents];
    
    customView.enabled = YES;
    customView.pinColor = MKPinAnnotationColorPurple;
    customView.canShowCallout = YES;
    //customView.leftCalloutAccessoryView =
    customView.rightCalloutAccessoryView = tweetsButton;
    
    return customView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    NSString *pushPerson = view.annotation.title;
    for(PersonModel *j in self.peopleList){
        if ([j.name isEqualToString:pushPerson]){
            NSMutableArray *personArr = [[NSMutableArray alloc] init];
            [personArr addObject:j];
            TweetListTableViewController *tweetList = [[TweetListTableViewController alloc] initWithStyle:UITableViewStylePlain tweets:j.tweets people:personArr];
            
            [self.navigationController pushViewController:tweetList animated:NO];
            
        }
    }
}

@end
