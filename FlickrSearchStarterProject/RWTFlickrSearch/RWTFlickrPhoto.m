//
//  RWTFlickrPhoto.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrPhoto.h"

@implementation RWTFlickrPhoto

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@:favorites:%lu,comments:%lu",self.title,self.favorites,self.comments];
}
@end
