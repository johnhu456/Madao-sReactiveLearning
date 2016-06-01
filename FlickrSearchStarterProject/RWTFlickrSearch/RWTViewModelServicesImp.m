//
//  RWTViewModelServicesImp.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImp.h"

@interface RWTViewModelServicesImp()

@property (nonatomic, strong) RWTFlickrSearchImpl *searchServices;

@end

@implementation RWTViewModelServicesImp

- (instancetype)init
{
    if(self = [super init]){
        _searchServices = [[RWTFlickrSearchImpl alloc] init];
    }
    return self;
}

- (id<RWTFlickerSearch>)getFlickrSearchService
{
    return self.searchServices;
}
@end
