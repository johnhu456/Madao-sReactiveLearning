//
//  RWTFlickrRecentSearchResults.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/13.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrRecentSearchResults.h"
#import "RWTFlickrPhoto.h"

@implementation RWTFlickrRecentSearchResults

- (instancetype)initWithResult:(RWTFlickrSearchResults *)results
{
    if (self = [super init]) {
        _searchString = results.searchString;
        _totalCounts = results.totalResults;
        RWTFlickrPhoto *firstPhoto = [results.photos firstObject];
        _firstPhotoURL = firstPhoto.url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary
{
    if (self = [super init]) {
        _searchString = [otherDictionary valueForKey: @"searchString"];
        _totalCounts = [[otherDictionary valueForKey:@"totalCounts"] integerValue];
        _firstPhotoURL = [NSURL URLWithString:[otherDictionary valueForKey:@"firstPhotoUrl"]];
    }
    return self;
}

-(NSDictionary *)getDictionaryData
{
    NSNumber *searchCounts;
    if (_totalCounts == 0) {
        searchCounts = [NSNumber numberWithInteger:0];
    }
    else
    {
        searchCounts = [NSNumber numberWithInteger:_totalCounts];
    }
    NSString *urlString;
    if (_firstPhotoURL == nil) {
        urlString = @"";
    }
    else
    {
        urlString = [_firstPhotoURL absoluteString];
    }
    return @{
             @"searchString":_searchString,
             @"totalCounts":searchCounts,
             @"firstPhotoUrl":urlString
             };
}

@end
