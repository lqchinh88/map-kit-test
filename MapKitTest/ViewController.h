//
//  ViewController.h
//  MapKitTest
//
//  Created by Chinh Le on 6/7/13.
//  Copyright (c) 2013 Chinh Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NodeCollection.h"

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NodeCollection *nodeCollection;

@end
