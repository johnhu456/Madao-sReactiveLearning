//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject

@property (nonatomic, strong) NSString *searchString;

@property (nonatomic, strong) NSArray *photos;

@property (nonatomic) NSInteger totalResults;

@end
