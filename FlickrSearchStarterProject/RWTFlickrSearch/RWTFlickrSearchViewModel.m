//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import "RWTFlickrSearchResultsViewModel.h"
#import "FHTool.h"

@interface RWTFlickrSearchViewModel()

@property (nonatomic, weak) id<RWTViewModelServices> services;

@end

@implementation RWTFlickrSearchViewModel

- (instancetype)initWithServices:(id<RWTViewModelServices>)services
{
    if (self = [super init]) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.title = @"Flickr Search";
    RACSignal *validSearchSignal = [[RACObserve(self, searchText) map:^id(NSString *text) {
        return @(text.length > 3);
    }] distinctUntilChanged];
    
    [validSearchSignal subscribeNext:^(NSNumber *valid) {
        NSLog(@"%@",[valid boolValue] ? @"YES" : @"NO");
    }];

    self.excuteSearch = [[RACCommand alloc] initWithEnabled:validSearchSignal signalBlock:^RACSignal *(id input) {
        return [self excuteSearchSignal];
    }];
}

- (RACSignal *)excuteSearchSignal{
    @WEAKSELF;
    return [[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText] doNext:^(id result) {
        RWTFlickrSearchResultsViewModel *resultsViewModel = [[RWTFlickrSearchResultsViewModel alloc] initWithSearchResults:result services:weakSelf.services];
        [weakSelf.services pushViewModel:resultsViewModel];
    }];
}
@end
