//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CETableViewBindingHelper.h"

@interface RWTSearchResultsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;

@property (nonatomic, strong) RWTFlickrSearchResultsViewModel *searchResultsModel;

@property (nonatomic, strong) CETableViewBindingHelper *bindingHelper;

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
}

- (void)bindViewModel
{
    self.title = self.searchResultsModel.title;
    UINib *nib = [UINib nibWithNibName:@"RWTSearchResultsTableViewCell" bundle:nil];
    self.bindingHelper = [CETableViewBindingHelper bindingHelperForTableView:self.searchResultsTable sourceSignal:RACObserve(self.searchResultsModel, searchResults) selectionCommand:nil templateCell:nib];
}

//#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.searchResultsModel.searchResults.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.textLabel.text = [self.searchResultsModel.searchResults[indexPath.row] title];
//    return cell;
//}
@end
