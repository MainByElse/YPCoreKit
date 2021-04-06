//
//  YPUIHelper.m
//  YPCoreKit
//
//  Created by Else on 2021/4/6.
//

#import "YPUIHelper.h"
#import <os/lock.h>

@implementation YPUIHelper

+ (BOOL)executeOnceWithIdentifier:(NSString *)identifier usingBlock:(void (NS_NOESCAPE ^)(void))block {
    if (!block || identifier.length <= 0) return NO;
    static dispatch_once_t onceToken;
    static NSMutableSet<NSString *> *executedIdentifiers;
    static os_unfair_lock lock;
    dispatch_once(&onceToken, ^{
        executedIdentifiers = [NSMutableSet set];
        lock = OS_UNFAIR_LOCK_INIT;
    });
    os_unfair_lock_lock(&lock);
    BOOL result = NO;
    if (![executedIdentifiers containsObject:identifier]) {
        [executedIdentifiers addObject:identifier];
        block();
        result = YES;
    }
    os_unfair_lock_unlock(&lock);
    return result;
}

+ (NSComparisonResult)compareSystemVersion:(NSString *)currentVersion toVersion:(NSString *)targetVersion {
    NSParameterAssert(currentVersion && targetVersion);
    if ([currentVersion componentsSeparatedByString:@"."].count == 2 && [targetVersion componentsSeparatedByString:@"."].count == 2) {
        double fromVersion = currentVersion.doubleValue * 100;
        double toVersion = targetVersion.doubleValue * 100;
        if (fromVersion == toVersion) {
            return NSOrderedSame;
        }
        return fromVersion > toVersion ? NSOrderedDescending : NSOrderedAscending;
    }
    return [currentVersion compare:targetVersion options:NSNumericSearch];
}

@end
