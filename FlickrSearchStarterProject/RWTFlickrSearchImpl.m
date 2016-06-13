//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"
#import "FHTool.h"
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhoto.h"
#import "RWTFlickrPhotoMetaData.h"

#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

static NSString *const kFlickrAPIKey = @"432658cc965bcf074f4fc25ab5651c9f";
static NSString *const kFlickrSharedSecret = @"0e2bd84b24295abf";

@interface RWTFlickrSearchImpl ()<OFFlickrAPIRequestDelegate>

@property (nonatomic, strong) NSMutableSet *requests;

@property (nonatomic, strong) OFFlickrAPIContext *flickrContext;

@end

@implementation RWTFlickrSearchImpl

- (instancetype)init
{
    if (self = [super init]) {
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:kFlickrAPIKey sharedSecret:kFlickrSharedSecret];
        _requests = [[NSMutableSet alloc] init];
    }
    return self;
}

- (id)flickrSearchSignal:(NSString *)searchString
{
    return [self signalFromAPIMethod:@"flickr.photos.search" arguments:@{@"text":searchString,@"sort":@"interestingness-desc"} transform:^id(NSDictionary *response) {
        RWTFlickrSearchResults *searchResults = [[RWTFlickrSearchResults alloc] init];
        searchResults.searchString = searchString;
        searchResults.totalResults = [[response valueForKeyPath:@"photos.total"] integerValue];
        
        NSArray *photos = [response valueForKeyPath:@"photos.photo"];
        searchResults.photos = [photos linq_select:^id(NSDictionary *value) {
            RWTFlickrPhoto *photo = [[RWTFlickrPhoto alloc] init];
            photo.title = [value valueForKey:@"title"];
            photo.identifier = [value valueForKey:@"id"];
            photo.url = [self.flickrContext photoSourceURLFromDictionary:value size:OFFlickrSmallSize];
            return photo;
        }];
        return searchResults;
    }];
}

- (RACSignal *)flickrImageMetadata:(NSString *)photoId
{
    RACSignal *favorites = [self signalFromAPIMethod:@"flickr.photos.getFavorites" arguments:@{@"photo_id": photoId} transform:^id(NSDictionary *response) {
        NSString *total = [response valueForKeyPath:@"photo.total"];
        return total;
    }];
    
    RACSignal *comments = [self signalFromAPIMethod:@"flickr.photos.getInfo" arguments:@{@"photo_id": photoId} transform:^id(NSDictionary *response) {
        NSString *total = [response valueForKeyPath:@"photo.comments._text"];
        return total;
    }];
    
    return [RACSignal combineLatest:@[favorites,comments] reduce:^id(NSString *favorites,NSString *comments){
        RWTFlickrPhotoMetaData *meta = [[RWTFlickrPhotoMetaData alloc] init];
        meta.comments = [comments integerValue];
        meta.favorites = [favorites integerValue];
        return meta;
    }];
}
- (RACSignal *)signalFromAPIMethod:(NSString *)method arguments:(NSDictionary *)args transform:(id (^)(NSDictionary *response))block
{
    @WEAKSELF;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        OFFlickrAPIRequest *flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];
        @WEAK_OBJ(flickrRequest);
        RACSignal *successSingal = [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:) fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
    
        [[[[successSingal
            filter:^BOOL(RACTuple *tuple) {
            return tuple.first == flickrRequestWeak;
        }]
        map:^id(RACTuple *tuple) {
            return tuple.second;
        }]
        map:block]
        subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        [flickrRequest callAPIMethodWithGET:method arguments:args];
        return [RACDisposable disposableWithBlock:^{
            [weakSelf.requests removeObject:flickrRequest];
        }];
    }];
}

@end
