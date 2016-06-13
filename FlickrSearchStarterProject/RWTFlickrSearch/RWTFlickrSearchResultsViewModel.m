//
//  RWTFlickrSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/3.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResultsViewModel.h"
#import "RWTFlickrPhoto.h"
#import <LinqToObjectiveC.h>
#import "RWTSearchResultsItemViweModel.h"

@implementation RWTFlickrSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results services:(id<RWTViewModelServices>)services
{
    if (self = [super init]) {
        _title = results.searchString;
        _searchResults = [results.photos linq_select:^id(RWTFlickrPhoto *photo) {
            return [[RWTSearchResultsItemViweModel alloc] initWithPhoto:photo services:services];
        }];
    }
    return self;
}
@end
