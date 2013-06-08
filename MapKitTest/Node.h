//
//  Node.h
//  MapKitTest
//
//  Created by Chinh Le on 6/8/13.
//  Copyright (c) 2013 Chinh Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Node : NSObject <MKAnnotation>

@property int nodeId;
@property NSString *title, *subtitle, *type, *imageName;
@property double lat, lon;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

-(id)initWithDict:(NSDictionary*) nodeDict;

@end
