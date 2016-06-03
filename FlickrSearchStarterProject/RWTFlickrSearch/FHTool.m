//
//  FHTool.m
//  FHColorTool
//
//  Created by MADAO on 15/12/29.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "FHTool.h"

@implementation FHTool

+ (UIWindow *)getCurrentWindow
{
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    return window;
}

+ (CGFloat)getWindowWidth
{
    return [[self class] getCurrentWindow].frame.size.width;
}

+ (CGFloat)getWindowHeight
{
    return [[self class] getCurrentWindow].frame.size.height;
}

+ (void)getAllIvarValueWithObject:(id)obj
{
    unsigned int count1 = 0;
    Ivar *var1 = class_copyIvarList([obj class], &count1);
    for (int i = 0 ;i < count1 ;i++) {
        Ivar _var = *(var1 + i);
        NSLog(@"Name:%s---------Value:%@",ivar_getName(_var),[obj valueForKeyPath:[[NSString alloc]initWithUTF8String:ivar_getName(_var)]]);
    }
}

+ (NSArray *)sortUsingDescriptorDictionary:(NSDictionary *)descriptorDic withArray:(NSArray *)sortArray;
{
    NSMutableArray *descriptorArray = [[NSMutableArray alloc] init];
    for (NSString *key in descriptorDic.allKeys) {
        NSSortDescriptor *newDescriptor;
        if ([key isKindOfClass:[NSNull class]]) {
            newDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:[descriptorDic[key] boolValue]];
        }else{
            newDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:[descriptorDic[key] boolValue]];
        }
        [descriptorArray addObject:newDescriptor];
    }
    return [sortArray sortedArrayUsingDescriptors:[descriptorArray copy]];
}

@end
