//
//  RWTFlickrPhotoMetaData.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/12.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrPhotoMetaData.h"

@implementation RWTFlickrPhotoMetaData

- (NSString *)description
{
    return [NSString stringWithFormat:@"metadata: comments=%lu, favorites=%lu",self.comments,self.favorites];
}
@end
