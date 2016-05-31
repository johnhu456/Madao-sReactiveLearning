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
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "FHTool.h"

typedef NS_ENUM(NSInteger){
    //访问拒绝
    RWTwitterInstantErrorAccessDenied,
    //没有推特账户
    RWTwitterInstantErrorNoTwitterAccounts,
    //无效响应
    RWTwitterInstantErrorInvaildResponse
}RWTwitterInstantError;

static NSString *const RWTwitterInstantDomian = @"TWitterInstant";

@interface RWSearchFormViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (strong, nonatomic) RWSearchResultsViewController *resultsViewController;

@property (nonatomic, strong) ACAccountStore *accountStore;

@property (nonatomic, strong) ACAccountType *twitterAccountType;

@end

@implementation RWSearchFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAccount];
  
    self.title = @"Twitter Instant";
  
    [self styleTextField:self.searchText];
  
    self.resultsViewController = self.splitViewController.viewControllers[1];
    
    @WEAKSELF;
    //搜索Signal
    [[[[[self requestAccessForTwitterSignal] then:^RACSignal *{
        return weakSelf.searchText.rac_textSignal;
    }]
    filter:^BOOL(NSString *text) {
        return text.length > 3;
    }]
    flattenMap:^RACStream *(NSString *text) {
        return [weakSelf siganlForSearchRequestWithText:text];
    }]
    subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    /**处理输入框颜色的Signal*/
    [[self.searchText.rac_textSignal map:^id(NSString *text) {
        return @(text.length>3);
    }]
    subscribeNext:^(NSNumber *vaild) {
        weakSelf.searchText.backgroundColor = [vaild boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];

    
    //取消信号订阅。
//    [subscription dispose];
}

/**设定账号*/
- (void)setupAccount
{
    self.accountStore = [[ACAccountStore alloc] init];
    self.twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
}

/**请求使用微博账号*/
- (RACSignal *)requestAccessForTwitterSignal{
    NSError *accessError = [NSError errorWithDomain:RWTwitterInstantDomian code:RWTwitterInstantErrorAccessDenied userInfo:nil];
    @WEAKSELF;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [weakSelf.accountStore requestAccessToAccountsWithType:self.twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {
            if (!granted) {
                [subscriber sendError:accessError];
            }else{
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
}

/**搜索请求*/
- (SLRequest *)requestForTwitterSearchWithText:(NSString *)text
{
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
    NSDictionary *params = @{@"q":text};
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:params];
    return request;
}

/**创建搜索信号*/
- (RACSignal *)siganlForSearchRequestWithText:(NSString *)text{
    
    /**错误*/
    NSError *noAccountError = [NSError errorWithDomain:RWTwitterInstantDomian code:RWTwitterInstantErrorNoTwitterAccounts userInfo:nil];
    NSError *invalidError = [NSError errorWithDomain:RWTwitterInstantDomian code:RWTwitterInstantErrorInvaildResponse userInfo:nil];
    
    @WEAKSELF;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        /**创建请求*/
        SLRequest *request = [weakSelf requestForTwitterSearchWithText:text];
        
        /**设置账户*/
        NSArray *twitterAccount = [self.accountStore accountsWithAccountType:self.twitterAccountType];
        if (twitterAccount.count == 0) {
            [subscriber sendError:noAccountError];
        }
        else
        {
            [request setAccount:[twitterAccount lastObject]];
        }
        
        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            NSDictionary *requestData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            [subscriber sendNext:requestData];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (void)styleTextField:(UITextField *)textField {
  CALayer *textFieldLayer = textField.layer;
  textFieldLayer.borderColor = [UIColor grayColor].CGColor;
  textFieldLayer.borderWidth = 2.0f;
  textFieldLayer.cornerRadius = 0.0f;
}

@end
