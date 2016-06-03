//
//  RWTFlickrSearchResultsViewModel.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/3.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrSearchResults.h"
#import "RWTViewModelServices.h"

@interface RWTFlickrSearchResultsViewModel : NSObject

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results services:(id<RWTViewModelServices>)services;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *searchResults;

@end
