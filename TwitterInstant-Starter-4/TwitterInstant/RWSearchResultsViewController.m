//
//  RWSearchResultsViewController.m
//  TwitterInstant
//
//  Created by Colin Eberhardt on 03/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWSearchResultsViewController.h"
#import "RWTableViewCell.h"
#import "RWTweet.h"

@interface RWSearchResultsViewController ()

@property (nonatomic, strong) NSArray *tweets;
@end

@implementation RWSearchResultsViewController {

}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.tweets = [NSArray array];
  
}

- (void)displayTweets:(NSArray *)tweets {
  self.tweets = tweets;
  [self.tableView reloadData];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
    RWTweet *tweet = self.tweets[indexPath.row];
    cell.twitterStatusText.text = tweet.status;
    if (!cell.twitterAvatarView.image){
        [[[self signalForGetImageWithUrl:tweet.profileImageUrl]
          deliverOn:[RACScheduler mainThreadScheduler]]
         subscribeNext:^(UIImage *image) {
             cell.twitterAvatarView.image = image;
         }];
    }
    cell.twitterUsernameText.text = [NSString stringWithFormat:@"@%@",tweet.username];
  
    return cell;
}

/**获取图片的信号*/
- (RACSignal *)signalForGetImageWithUrl:(NSString *)url{
    RACScheduler *imageScheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:imageData];
        [subscriber sendNext:image];
        [subscriber sendCompleted];
        return nil;
    }]
            subscribeOn:imageScheduler];
}
@end
