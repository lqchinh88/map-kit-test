//
//  NodeCollection.h
//  MapKitTest
//
//  Created by Chinh Le on 6/8/13.
//  Copyright (c) 2013 Chinh Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface NodeCollection : NSObject

@property NSMutableArray *nodeArray;

-(void)parseJsonData:(NSData*) jsonData;

@end
