//
//  NodeCollection.m
//  MapKitTest
//
//  Created by Chinh Le on 6/8/13.
//  Copyright (c) 2013 Chinh Le. All rights reserved.
//

#import "NodeCollection.h"
#import "Node.h"
#import "Reachability.h"

@implementation NodeCollection


-(id)init
{
    if (self = [super init])
    {
        [self setNodeArray:[NSMutableArray new]];
    }
    return self;
}

-(void)parseJsonData:(NSData*) jsonData
{
    if ( jsonData != nil )
    {
        // Get data into an array
        NSError* error;
        NSArray* jsonArray = [NSJSONSerialization
                              JSONObjectWithData:jsonData
                              options:kNilOptions
                              error:&error];
        
        // Iterate the array, convert them into Node object
        for ( NSDictionary *dict in jsonArray)
        {
            Node *newNode = [[Node alloc] initWithDict:dict];
            // Put into our array
            [[self nodeArray] addObject:newNode];
        }
    }
}



@end
