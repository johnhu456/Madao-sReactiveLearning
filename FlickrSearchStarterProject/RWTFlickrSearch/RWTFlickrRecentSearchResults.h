//
//  RWTFlickrRecentSearchResults.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/13.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrSearchResults.h"

@interface RWTFlickrRecentSearchResults : NSObject

@property (nonatomic, strong) NSString *searchString;

@property (nonatomic, strong) NSURL *firstPhotoURL;

@property (nonatomic, assign) NSUInteger totalCounts;

- (instancetype)initWithResult:(RWTFlickrSearchResults *)results;

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

- (NSDictionary *)getDictionaryData;

@end
