//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"
#import "RWTFlickrSearchResults.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>


@interface RWTFlickrSearchImpl ()

@end

@implementation RWTFlickrSearchImpl

- (id)flickrSearchSignal:(NSString *)searchString
{
    return [[[[RACSignal empty] logAll] delay:2.0]logAll];
}

@end
