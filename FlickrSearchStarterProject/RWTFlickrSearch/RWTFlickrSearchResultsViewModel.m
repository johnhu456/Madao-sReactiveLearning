//
//  RWTFlickrSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/3.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResultsViewModel.h"
@implementation RWTFlickrSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results services:(id<RWTViewModelServices>)services
{
    if (self = [super init]) {
        _searchResults = results.photos;
        _title = results.searchString;
    }
    return self;
}
@end
