//
//  RWTDataManager.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/13.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTDataManager.h"

@implementation RWTDataManager

+ (instancetype)sharedManager
{
    static RWTDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RWTDataManager alloc] init];
    });
    [manager createPath];
    return manager;
}

- (void)createPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[[self class] cachePath]]) {
        [manager createFileAtPath:[[self class] cachePath] contents:nil attributes:nil];
    }
}

+ (NSString *)cachePath
{
    NSLog(@"%@",NSHomeDirectory());
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [filePath stringByAppendingPathComponent:@"recentSearch.plist"];
}

#pragma mark - PublicMethod
- (void)writeRecentSearch:(RWTFlickrRecentSearchResults *)recentSearch{
    NSMutableDictionary *plistDic = [[NSDictionary dictionaryWithContentsOfFile:[[self class] cachePath]] mutableCopy];
    if (plistDic == nil) {
        plistDic = [[NSMutableDictionary alloc] init];
        [plistDic setValue:[NSMutableArray new] forKey:@"data"];
    }
    NSDictionary *newRecentSearchDic = [recentSearch getDictionaryData];
    NSMutableArray *dataArray = [plistDic valueForKey:@"data"];
    if (dataArray == nil){
        dataArray = [[NSMutableArray alloc] init];
    }
    [dataArray addObject:newRecentSearchDic];
    [plistDic setValue:dataArray forKey:@"data"];
    [plistDic writeToFile:[[self class] cachePath] atomically:YES];
}

+ (NSArray *)getRecentSearches{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    NSArray *dataArray = [[[NSDictionary alloc] initWithContentsOfFile:[[self class] cachePath]] valueForKey:@"data"];
    for (NSDictionary *resultsDic in dataArray) {
        [mutableArray addObject:[[RWTFlickrRecentSearchResults alloc] initWithDictionary:resultsDic]];
    }
    return [mutableArray copy];
}
@end
