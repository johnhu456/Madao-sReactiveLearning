//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import "RWTSearchResultsTableViewCell.h"
#import "CETableViewBindingHelper.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTSearchResultsViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;

@property (nonatomic, strong) RWTFlickrSearchResultsViewModel *searchResultsModel;

@property (nonatomic, strong) CETableViewBindingHelper *bindingHelper;

@property (nonatomic, assign) CGFloat lastContentOffSetY;

@end

@implementation RWTSearchResultsViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchResultsViewModel *)viewModel
{
    if (self = [super init]){
        _searchResultsModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.searchResultsTable registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"cell"];
//    self.searchResultsTable.dataSource = self;
    [self bindViewModel];
    self.lastContentOffSetY = 64.f;
}

- (void)bindViewModel
{
    self.title = self.searchResultsModel.title;
    UINib *nib = [UINib nibWithNibName:@"RWTSearchResultsTableViewCell" bundle:nil];
    self.bindingHelper = [CETableViewBindingHelper bindingHelperForTableView:self.searchResultsTable sourceSignal:RACObserve(self.searchResultsModel, searchResults) selectionCommand:nil templateCell:nib];
    self.bindingHelper.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *cells = [self.searchResultsTable visibleCells];
    for (RWTSearchResultsTableViewCell *cell in cells) {
        CGFloat value;
        if (self.lastContentOffSetY < self.searchResultsTable.contentOffset.y){
            value = -40 + (cell.frame.origin.y - self.searchResultsTable.contentOffset.y)/5;
        }else
        {
            value = (self.searchResultsTable.contentOffset.y - cell.frame.origin.y)/5;
        }
        self.lastContentOffSetY = self.searchResultsTable.contentOffset.y;
        [cell setParallax:value];
    }
}
@end
