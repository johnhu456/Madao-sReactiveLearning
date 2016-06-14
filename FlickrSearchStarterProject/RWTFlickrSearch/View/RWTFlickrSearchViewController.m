//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CETableViewBindingHelper.h"

@interface RWTFlickrSearchViewController ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *searchHistoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;

@property (nonatomic, strong) CETableViewBindingHelper *bindingHelper;
@end

@implementation RWTFlickrSearchViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
  
    self.edgesForExtendedLayout = UIRectEdgeNone;
  
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)bindViewModel{
    @WEAKSELF;
    self.title = self.viewModel.title;
    RAC(self.viewModel,searchText) = self.searchTextField.rac_textSignal;
    RAC([UIApplication sharedApplication],networkActivityIndicatorVisible) = self.viewModel.excuteSearch.executing;
    RAC(self.loadingIndicator,hidden) = [self.viewModel.excuteSearch.executing not];
    self.searchButton.rac_command  = self.viewModel.excuteSearch;
    [[self.searchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf.searchTextField resignFirstResponder];
    }];
    
    [[[self.searchTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] filter:^BOOL(UITextField *textField) {
        return textField.text.length;
    }]
     subscribeNext:^(id x) {
        [[weakSelf.viewModel excuteSearch] execute:nil];
    }];
    
    RACCommand *clickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RWTFlickrRecentSearchResults *result = input;
        weakSelf.viewModel.searchText = result.searchString;
        return [[weakSelf.viewModel excuteSearch] execute:nil];
    }];
    
    UINib *nib = [UINib nibWithNibName:@"RWTRecentSearchItemTableViewCell" bundle:nil];
    
    RACSignal *dataSignal = RACObserve(self.viewModel, recentSearches);
    [dataSignal subscribeNext:^(id x) {
        NSLog(@"========%@",x);
    }];
    self.bindingHelper = [CETableViewBindingHelper bindingHelperForTableView:self.searchHistoryTable sourceSignal:dataSignal selectionCommand:clickCommand templateCell:nib];
    self.bindingHelper.delegate = self;
}


@end
