//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTSearchResultsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;

@property (nonatomic, weak) RWTFlickrSearchResultsViewModel *searchResultsModel;

@end

@implementation RWTSearchResultsViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchResultsViewModel *)viewModel
{
    if (self = [super init]){
        _searchResultsModel = viewModel;
    }
    return self;
}
@end
