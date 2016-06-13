//
//  Created by Colin Eberhardt on 26/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTSearchResultsItemViweModel.h"
#import "FHTool.h"

@interface RWTSearchResultsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *favouritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentsIcon;
@property (weak, nonatomic) IBOutlet UIImageView *favouritesIcon;

@end

@implementation RWTSearchResultsTableViewCell

- (void)setParallax:(CGFloat)value
{
    self.imageThumbnailView.transform = CGAffineTransformMakeTranslation(0, value);
}

- (void)bindViewModel:(id)viewModel
{
    @WEAKSELF;
    RWTSearchResultsItemViweModel *photoViewModel = viewModel;
    
    [RACObserve(photoViewModel, favorites) subscribeNext:^(NSNumber *favorites) {
        weakSelf.favouritesLabel.text = [favorites stringValue];
    }];
    
    [RACObserve(photoViewModel, comments) subscribeNext:^(NSNumber *comments) {
        weakSelf.commentsLabel.text = [comments stringValue];
    }];
    
    photoViewModel.isVisible = YES;
    @WEAK_OBJ(photoViewModel);
    [self.rac_prepareForReuseSignal subscribeNext:^(id x) {
        photoViewModelWeak.isVisible = NO;
        weakSelf.favouritesLabel.text = @"0";
        weakSelf.commentsLabel.text = @"0";
    }];
    self.layer.masksToBounds = YES;
    RWTFlickrPhoto *photo = viewModel;
    self.titleLabel.text = photo.title;
    self.imageThumbnailView.layer.masksToBounds = YES;
    self.imageThumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageThumbnailView sd_setImageWithURL:photo.url];
}

@end
