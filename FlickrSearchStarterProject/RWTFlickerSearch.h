//
//  RWTFlickerSearch.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol RWTFlickerSearch <NSObject>

- (RACSignal *)flickrSearchSignal:(NSString *)searchString;

- (RACSignal *)flickrImageMetadata:(NSString *)photoId;

@end
