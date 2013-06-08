//
//  ViewController.m
//  MapKitTest
//
//  Created by Chinh Le on 6/7/13.
//  Copyright (c) 2013 Chinh Le. All rights reserved.
//

#import "ViewController.h"

#define METERS_PER_MILE 1609.344

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Load nodes and display annotations
    [self loadNodes];
    [self displayNodes];
    
    // Zoom to fit all annotations
    [self zoomToFitMapAnnotations:_mapView];
}

// ------------------------------------------------------------
// Class methods
// ------------------------------------------------------------

-(void)loadNodes
{
    _nodeCollection = [[NodeCollection alloc ]init];
    [_nodeCollection loadNodeArrayFrom:@"https://dl.dropboxusercontent.com/u/11295402/MiniEval/locations.json" fromFileIfFail:@"nodes"];
}

-(void)displayNodes
{
    // Clear all current annotation for clearer view
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    // Put annotations onto map
    for ( Node *node in _nodeCollection.nodeArray )
    {
        [_mapView addAnnotation:node];
    }
}

-(void)zoomToFitMapAnnotations:(MKMapView*)mapView
{
    if([mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id <MKAnnotation> annotation in mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}

// ------------------------------------------------------------
// MKMapViewDelegate methods
// ------------------------------------------------------------

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(Node*)annotation
{
    static NSString *identifier = @"Node";
    if ([annotation isKindOfClass:[Node class]])
    {
        // Dequeue annotations to reuse
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:[annotation imageName]];
            annotationView.centerOffset = CGPointMake(0, -(annotationView.image.size.height / 2)); // Offset the center to show the pin pointing to the location
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
