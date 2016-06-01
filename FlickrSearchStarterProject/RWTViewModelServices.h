//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickerSearch.h"

@protocol RWTViewModelServices <NSObject>

- (id<RWTFlickerSearch>)getFlickrSearchService;

@end
