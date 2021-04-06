//
//  YPUIHelper.h
//  YPCoreKit
//
//  Created by Else on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPUIHelper : NSObject

/**
 用一个 identifier 标记某一段 block，使其对应 identifier 只会被运行一次
 @param identifier 唯一的标记，建议在 identifier 里添加当前这段业务的特有名称，例如用于 swizzle 的可以加“swizzled”前缀，以避免与其他业务共用同一个 identifier 引发 bug
 @param block 要执行的一段逻辑
 */
+ (BOOL)executeOnceWithIdentifier:(NSString *)identifier usingBlock:(void (NS_NOESCAPE ^)(void))block;

/** 判断当前版本号和目标版本号
 @param currentVersion 当前版本号
 @param targetVersion 目标版本号
 */
+ (NSComparisonResult)compareSystemVersion:(NSString *)currentVersion toVersion:(NSString *)targetVersion;

@end

NS_ASSUME_NONNULL_END
