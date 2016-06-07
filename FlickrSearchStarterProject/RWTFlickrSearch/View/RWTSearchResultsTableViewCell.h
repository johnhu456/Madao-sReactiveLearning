//
//  Created by Colin Eberhardt on 26/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

@import UIKit;
#import <SDWebImage/UIImageView+WebCache.h>
#import "CEReactiveView.h"
#import "RWTFlickrPhoto.h"

@interface RWTSearchResultsTableViewCell : UITableViewCell <CEReactiveView>

- (void)setParallax:(CGFloat)value;

@end
