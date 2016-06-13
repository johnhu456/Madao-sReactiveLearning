//
//  RWTDataManager.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/13.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrRecentSearchResults.h"

@interface RWTDataManager : NSObject

+ (instancetype)sharedManager;

+ (NSArray *)getRecentSearches;

- (void)writeRecentSearch:(RWTFlickrRecentSearchResults *)recentSearch;
@end
