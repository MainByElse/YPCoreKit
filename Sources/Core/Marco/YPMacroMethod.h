//
//  YPMacroMethod.h
//  YPCoreKit
//
//  Created by Else on 2021/4/6.
//

#ifndef YPMacroMethod_h
#define YPMacroMethod_h

#if __has_include(<YPCoreKit/YPUIHelper+Device.h>)
#import <YPCoreKit/YPUIHelper+Device.h>
#else
#import "YPUIHelper+Device.h"
#endif
#if __has_include(<QMUIKit/UIImage+QMUI.h>)
#import <QMUIKit/UIImage+QMUI.h>
#else
#import "UIImage+QMUI.h"
#endif
#if __has_include(<QMUIKit/UIColor+QMUI.h>)
#import <QMUIKit/UIColor+QMUI.h>
#else
#import "UIColor+QMUI.h"
#endif

// 过期
#define YPDeprecated(instead) NS_DEPRECATED(2_0,2_0,2_0,2_0, instead)

#pragma mark - Log
#ifdef DEBUG
#else
#define YPLog(...)
#define NSLog(...)
#endif

#pragma mark - 通用快捷方法

FOUNDATION_STATIC_INLINE NSString * /// 拼接字符串
NSStringFormat(NSString *format, ...) {
    va_list argptr;
    va_start(argptr, format);
    NSString *result = [[NSString alloc] initWithFormat:format arguments:argptr];
    va_end(argptr);
    return result;
}

FOUNDATION_STATIC_INLINE BOOL /// 验证手机号
YPIsValidMobile(NSString *mobile) {
    NSString *matches = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matches];
    return [predicate evaluateWithObject:mobile];
}

FOUNDATION_STATIC_INLINE BOOL
YPIsEmptyString(NSString *string) {
    if (!string || ![string isKindOfClass:NSString.class]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    return NO;
}

FOUNDATION_STATIC_INLINE BOOL
YPIsEmptyArray(NSArray *array) {
    if (!array || ![array isKindOfClass:NSArray.class]) {
        return YES;
    }
    if (array.count == 0) {
        return YES;
    }
    return NO;
}

FOUNDATION_STATIC_INLINE BOOL
YPIsEmptyDictionary(NSDictionary *dict) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class]) {
        return YES;
    }
    if (dict.allKeys.count == 0) {
        return YES;
    }
    return NO;
}

FOUNDATION_STATIC_INLINE BOOL
YPIsEmptyObject(id object) {
    if ([object isKindOfClass:NSString.class]) {
        return YPIsEmptyString(object);
    } else if ([object isKindOfClass:NSArray.class]) {
        return YPIsEmptyArray(object);
    } else if ([object isKindOfClass:NSDictionary.class]) {
        return YPIsEmptyDictionary(object);
    } else {
        if (!object || [object isKindOfClass:NSNull.class]) {
            return YES;
        }
    }
    return NO;
}

FOUNDATION_STATIC_INLINE NSString *
YPString(id value) {
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = value;
        return number.stringValue;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSString *string = value;
        return !YPIsEmptyString(string) ? string : @"";
    }
    return @"";
}

FOUNDATION_STATIC_INLINE NSString *
YPStringFromBool(BOOL value) {
    return value ? @"true" : @"false";
}

#pragma mark - UI相关

UIKIT_STATIC_INLINE CGFloat /// 区分横竖屏
YPUIPreferredValueForOrientation(CGFloat portrait, CGFloat landscape) {
    return !YPUIHelper.isLandscape ? portrait : landscape;
}

UIKIT_STATIC_INLINE CGFloat /// 区分全面屏（iPhone X 系列）和非全面屏
YPUIPreferredValueForNotchedDevice(CGFloat notched, CGFloat other) {
    return YPUIHelper.isNotchedScreen ? notched : other;
}

UIKIT_STATIC_INLINE CGFloat /// 根据iPad设备区分
YPUIPreferredValueForInterfaceIdiom(CGFloat iPad, CGFloat iPhone) {
    return (YPUIHelper.applicationSize.width / YPUIHelper.applicationSize.height <= YPUIHelper.screenSizeFor35Inch.width / YPUIHelper.screenSizeFor35Inch.height ? iPhone : iPad);
}

UIKIT_STATIC_INLINE UIFont *
YPUIFontMake(CGFloat size) {
    return [UIFont systemFontOfSize:size];
}

UIKIT_STATIC_INLINE UIFont *
YPUIFontMakeWithWeight(CGFloat size, UIFontWeight weight) {
    return [UIFont systemFontOfSize:size weight:weight];
}

UIKIT_STATIC_INLINE UIFont *
YPUIFontBoldMake(CGFloat size) {
    return [UIFont boldSystemFontOfSize:size];
}

UIKIT_STATIC_INLINE UIFont *
YPUIFontMakeWithName(NSString *name, CGFloat size) {
    return [UIFont fontWithName:name size:size];
}

UIKIT_STATIC_INLINE UIImage *
YPUIImageMake(NSString *name) {
    return [UIImage imageNamed:name];
}

UIKIT_STATIC_INLINE UIImage *
YPUIImageMakeWithSize(NSString *name, CGSize size) {
    return [YPUIImageMake(name) qmui_imageResizedInLimitedSize:size resizingMode:QMUIImageResizingModeScaleToFill scale:UIScreen.mainScreen.scale];
}

UIKIT_STATIC_INLINE UIImage *
YPUIImageMakeWithMode(NSString *name, UIImageRenderingMode mode) {
    return [YPUIImageMake(name) imageWithRenderingMode:mode];
}

UIKIT_STATIC_INLINE UIImage *
YPUIImageMakeWithSizeMode(NSString *name, CGSize size, UIImageRenderingMode mode) {
    return [YPUIImageMakeWithSize(name, size) imageWithRenderingMode:mode];
}

UIKIT_STATIC_INLINE UIImage *
YPUIImageTemplateMake(NSString *name) {
    return YPUIImageMakeWithMode(name, UIImageRenderingModeAlwaysTemplate);
}

UIKIT_STATIC_INLINE UIImage *
YPUIImageTemplateMakeWithSize(NSString *name, CGSize size) {
    return YPUIImageMakeWithSizeMode(name, size, UIImageRenderingModeAlwaysTemplate);
}

UIKIT_STATIC_INLINE UIImage *
YPUIImageMakeWithCorner(NSString *name, CGFloat radius) {
    return [YPUIImageMake(name) qmui_imageWithClippedCornerRadius:radius];
}

UIKIT_STATIC_INLINE UIColor *
YPUIColorMakeWithRGB(CGFloat r, CGFloat g, CGFloat b) {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

UIKIT_STATIC_INLINE UIColor *
YPUIColorMakeWithRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 1.0];
}

UIKIT_STATIC_INLINE UIColor *
YPUIColorMakeWithHex(NSString *hex) {
    return [UIColor qmui_colorWithHexString:hex];
}

#pragma mark - 线程相关

DISPATCH_INLINE void
YPAsyncExecuteOnQueue(dispatch_queue_t queue, dispatch_block_t block) {
    dispatch_async(queue, block);
}

DISPATCH_INLINE void   /// 全局并行队列
YPAsyncExecuteOnGlobalQueue(dispatch_block_t block){
    YPAsyncExecuteOnQueue(dispatch_get_global_queue(0, 0), block);
}

DISPATCH_INLINE void
YPAsyncExecuteOnMainQueue(dispatch_block_t block) {
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {
        block();
    } else {
        YPAsyncExecuteOnQueue(dispatch_get_main_queue(), block);
    }
}

DISPATCH_INLINE void
YPAfterOnMainQueue(CGFloat delayInSeconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

DISPATCH_INLINE dispatch_queue_t
YPCreateSerialQueue(NSString *label) {
    return dispatch_queue_create(label.UTF8String, DISPATCH_QUEUE_SERIAL);
}

DISPATCH_INLINE dispatch_queue_t
YPCreateConcurrentQueue(NSString *label) {
    return dispatch_queue_create(label.UTF8String, DISPATCH_QUEUE_CONCURRENT);
}

#endif /* YPMacroMethod_h */
