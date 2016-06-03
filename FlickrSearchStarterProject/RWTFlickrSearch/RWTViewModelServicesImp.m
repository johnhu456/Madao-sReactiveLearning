//
//  RWTViewModelServicesImp.m
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImp.h"
#import "RWTSearchResultsViewController.h"

@interface RWTViewModelServicesImp()

@property (nonatomic, strong) RWTFlickrSearchImpl *searchServices;

@property (weak, nonatomic) UINavigationController *navigationController;

@end

@implementation RWTViewModelServicesImp

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    if(self = [super init]){
        _searchServices = [[RWTFlickrSearchImpl alloc] init];
        _navigationController = navigationController;
    }
    return self;
}

- (id<RWTFlickerSearch>)getFlickrSearchService
{
    return self.searchServices;
}

- (void)pushViewModel:(id)viewModel
{
//    id viewController;
    if ([viewModel isKindOfClass:[RWTFlickrSearchResultsViewModel class]]) {
        RWTSearchResultsViewController *searchResultViewController = [[RWTSearchResultsViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:searchResultViewController animated:YES];
    }
    else
    {
        @throw [NSException exceptionWithName:@"Wrong ViewModel!" reason:@"an unknown view was pushed!" userInfo:nil];
    }
}
@end
