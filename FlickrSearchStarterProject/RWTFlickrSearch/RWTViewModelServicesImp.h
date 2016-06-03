//
//  RWTViewModelServicesImp.h
//  RWTFlickrSearch
//
//  Created by MADAO on 16/6/1.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"
#import "RWTFlickrSearchImpl.h"

@interface RWTViewModelServicesImp : NSObject<RWTViewModelServices>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
