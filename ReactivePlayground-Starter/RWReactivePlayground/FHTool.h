//
//  FHTool.h
//  FHColorTool
//
//  Created by MADAO on 15/12/29.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma mark - 字体部分

#define FH_FONT_SYSTEM_WITH_SIZE(x) [UIFont systemFontOfSize:x]
#define FH_FONT_STHeitiSC_LIGHT(x) [UIFont fontWithName:@"STHeitiSC-Light" size:x]

#pragma mark - 颜色部分

#define FH_COLOR_WITH(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define FH_HEX_COLOR(x)

#pragma mark - WeakSelf
#define WEAK_SELF __weak typeof(self) weakSelf = self 

#define WEAKSELF \
autoreleasepool{} \
__weak typeof(self) weakSelf = self

#define WEAK_OBJ(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

#pragma mark - Debug

#ifndef __OPTIMIZE__
# define MYLog(...) NSLog(__VA_ARGS__)
#else
# define MYLog(...)
#endif

#pragma mark - OSVersionCompile
/**文字对齐方式适应版本*/
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    #define FHTextAlignmentCenter NSTextAlignmentCenter
    #define FHTextAlignmentLeft NSTextAlignmentLeft
    #define FHTextAlignmentRight NSTextAlignmentRight
#else
    #define FHTextAlignmentCenter UITextAlignmentCenter
    #define FHTextAlignmentLeft UITextAlignmentLeft 
    #define FHTextAlignmentRight UITextAlignmentRight
#endif

/**文字大小*/
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define FH_TEXTSIZE(text, font) [text length] > 0 ? [text \
    sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
    #define FH_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#pragma mark - Runtime

#define GET_IVAR_WITH_CLASS(x) NSLog(@"Getting Ivar List In Class:%@================",NSStringFromClass(x));\
                                unsigned int count1 = 0;\
                                Ivar *var1 = class_copyIvarList([x class], &count1);\
                                for (int i = 0 ;i < count1 ;i++) {\
                                Ivar _var = *(var1 + i);\
                                NSLog(@"Name:%s----- Type:%s",ivar_getName(_var),ivar_getTypeEncoding(_var));\
}

@interface FHTool : NSObject

/**获取当前Window对象*/
+ (UIWindow *)getCurrentWindow;

/**获取屏幕宽度*/
+ (CGFloat)getWindowWidth;

/**获取屏幕高度*/

+ (CGFloat)getWindowHeight;

/**获取对象所有的Value值，打印输出*/
+ (void)getAllIvarValueWithObject:(id)obj;

#pragma makr - NSArraySort
/**排列数组*/
+ (NSArray *)sortUsingDescriptorDictionary:(NSDictionary *)descriptorDic withArray:(NSArray *)sortArray;

@end
