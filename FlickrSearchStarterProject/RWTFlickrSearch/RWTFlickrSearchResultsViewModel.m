//
//  RWTFlickrSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/3.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResultsViewModel.h"
#import "RWTFlickrPhoto.h"

@implementation RWTFlickrSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results services:(id<RWTViewModelServices>)services
{
    if (self = [super init]) {
        _searchResults = results.photos;
        _title = results.searchString;
        RWTFlickrPhoto *photo = [_searchResults firstObject];
        RACSignal *metaDataSignal = [[services getFlickrSearchService] flickrImageMetadata:photo.identifier];
        [metaDataSignal subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }
    return self;
}
@end
