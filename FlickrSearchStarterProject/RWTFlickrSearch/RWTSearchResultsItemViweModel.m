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

    RACSignal *visibleSignal = [RACObserve(self, isVisible) skip:1];
    RACSignal *showSignal = [visibleSignal filter:^BOOL(NSNumber *visible) {
        return [visible boolValue];
    }];
    RACSignal *hideSignal = [visibleSignal filter:^BOOL(NSNumber *visible) {
        return ![visible boolValue];
    }];
    [[[showSignal delay:1.0f] takeUntil:hideSignal] subscribeNext:^(id x) {
        [[[weakSelf.services getFlickrSearchService]flickrImageMetadata:self.photo.identifier] subscribeNext:^(RWTFlickrPhotoMetaData *metadata) {
                        weakSelf.favorites = @(metadata.favorites);
                        weakSelf.comments = @(metadata.comments);
        }];
    }];
}
@end
