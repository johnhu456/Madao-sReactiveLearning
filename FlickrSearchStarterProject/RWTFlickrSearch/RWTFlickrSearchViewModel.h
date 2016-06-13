//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTViewModelServices.h"

@interface RWTFlickrSearchViewModel : NSObject

@property (nonatomic, strong) NSString *searchText;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableArray *recentSearches;

@property (nonatomic, strong) RACCommand *excuteSearch;

- (instancetype)initWithServices:(id<RWTViewModelServices>)services;

@end
