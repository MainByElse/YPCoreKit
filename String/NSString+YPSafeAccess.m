//
//  NSString+YPSafeAccess.m
//  Pods
//
//  Created by Else on 2021/8/19.
//

#import "NSString+YPSafeAccess.h"
#import <QMUIKit/NSString+QMUI.h>

@implementation NSString (YPSafeAccess)

- (BOOL)boolValue {
    NSString *result = self.qmui_trim.lowercaseString;
    if ([result isEqualToString:@"true"] ||
        [result isEqualToString:@"yes"] ||
        [result isEqualToString:@"1"]) {
        return YES;
    }
    if ([result isEqualToString:@"false"] ||
        [result isEqualToString:@"no"] ||
        [result isEqualToString:@"0"]) {
        return NO;
    }
    return NO;
}

@end
