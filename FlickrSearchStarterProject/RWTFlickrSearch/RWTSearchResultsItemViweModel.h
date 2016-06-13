//
//  RWTSearchResultsItemViweModel.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/13.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrPhoto.h"
#import "RWTViewModelServices.h"

@interface RWTSearchResultsItemViweModel : NSObject

- (instancetype)initWithPhoto:(RWTFlickrPhoto *)photo services:(id<RWTViewModelServices>)services;

@property (nonatomic, assign) BOOL isVisible;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSNumber *favorites;
@property (nonatomic, strong) NSNumber *comments;
@end
