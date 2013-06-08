//
//  Node.m
//  MapKitTest
//
//  Created by Chinh Le on 6/8/13.
//  Copyright (c) 2013 Chinh Le. All rights reserved.
//

#import "Node.h"

@implementation Node

-(id)initWithDict:(NSDictionary*) nodeDict
{
    if (self = [super init])
    {
        [self setNodeId:(int)[nodeDict objectForKey:@"nodeId"]];
        [self setTitle:[nodeDict objectForKey:@"title"]];
        [self setType:[nodeDict objectForKey:@"type"]];
        [self setLat:[[nodeDict objectForKey:@"lat"] doubleValue]];
        [self setLon:[[nodeDict objectForKey:@"lon"] doubleValue]];
        
        // Create coordinate property
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [self lat];
            coordinate.longitude = [self lon];
            [self setCoordinate:coordinate];
        
        // Set subtitle to Node's type
        [self setSubtitle:_type];
        
        // Decide image name for this node
        NSDictionary *imageNameDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                             @"pin0.png",@"Walk",
                                             @"pin1.png",@"Food and Beverages",
                                             @"pin2.png",@"Locker",
                                             @"pin3.png",@"Attractions",
                                             @"pin4.png",@"Transportation",
                                             @"pin5.png",@"Bus",
                                             nil];
        
        [self setImageName:[imageNameDictionary objectForKey:[self type]]];
        
    }
    
    return self;
}

@end
