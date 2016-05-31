//
//  RWSearchFormViewController.m
//  TwitterInstant
//
//  Created by Colin Eberhardt on 02/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWSearchFormViewController.h"
#import "RWSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FHTool.h"

@interface RWSearchFormViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (strong, nonatomic) RWSearchResultsViewController *resultsViewController;

@end

@implementation RWSearchFormViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"Twitter Instant";
  
  [self styleTextField:self.searchText];
  
  self.resultsViewController = self.splitViewController.viewControllers[1];
    
    @WEAKSELF;
    //Signal
    RACSignal *backgroundSignal = [self.searchText.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 3);
    }];
                                   
    RACDisposable *subscription = [backgroundSignal subscribeNext:^(NSNumber *valid) {
        weakSelf.searchText.backgroundColor = [valid boolValue]? [UIColor whiteColor] : [UIColor yellowColor];
    }];
    
    //取消信号订阅。
    [subscription dispose];
    
  
}

- (void)styleTextField:(UITextField *)textField {
  CALayer *textFieldLayer = textField.layer;
  textFieldLayer.borderColor = [UIColor grayColor].CGColor;
  textFieldLayer.borderWidth = 2.0f;
  textFieldLayer.cornerRadius = 0.0f;
}

@end
