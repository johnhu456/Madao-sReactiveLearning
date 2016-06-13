//
//  RWTFlickrPhoto.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrPhoto : NSObject

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, assign) NSUInteger favorites;

@property (nonatomic, assign) NSUInteger comments;
@end
