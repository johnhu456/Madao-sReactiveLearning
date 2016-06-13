
//
//  Created by Colin Eberhardt on 24/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTRecentSearchItemTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTFlickrRecentSearchResults.h"
#import "FHTool.h"

#import <UIImageView+WebCache.h>

@interface RWTRecentSearchItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalResultsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end

@implementation RWTRecentSearchItemTableViewCell

- (void)bindViewModel:(id)viewModel
{
    self.thumbnailImage.layer.masksToBounds = YES;
    RWTFlickrRecentSearchResults *resultsModel = viewModel;
    self.searchLabel.text = resultsModel.searchString;
    self.totalResultsLabel.text = [NSString stringWithFormat:@"%lu",resultsModel.totalCounts];
    self.thumbnailImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.thumbnailImage sd_setImageWithURL:resultsModel.firstPhotoURL];
}
@end
