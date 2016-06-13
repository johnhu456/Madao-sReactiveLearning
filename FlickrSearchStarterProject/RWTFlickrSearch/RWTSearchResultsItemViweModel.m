//
//  RWTSearchResultsItemViweModel.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/13.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsItemViweModel.h"
#import <ReactiveCocoa.h>
#import "RWTFlickrPhotoMetaData.h"
#import "FHTool.h"

@interface RWTSearchResultsItemViweModel()

@property (weak, nonatomic) id<RWTViewModelServices> services;
@property (strong, nonatomic) RWTFlickrPhoto *photo;

@end

@implementation RWTSearchResultsItemViweModel

- (instancetype)initWithPhoto:(RWTFlickrPhoto *)photo services:(id<RWTViewModelServices>)services
{
    if (self = [super init]) {
        _photo = photo;
        _services = services;
        _title = photo.title;
        _url = photo.url;
        [self initialize];
    }
    return self;
}

- (void)initialize{
    @WEAKSELF;
    [[RACObserve(self, isVisible) filter:^BOOL(NSNumber *isVisible) {
        return [weakSelf isVisible];
    }] subscribeNext:^(id x) {
        [[[weakSelf.services getFlickrSearchService]flickrImageMetadata:self.photo.identifier] subscribeNext:^(RWTFlickrPhotoMetaData *metadata) {
            weakSelf.favorites = @(metadata.favorites);
            weakSelf.comments = @(metadata.comments);
        }];
    }];
}
@end
