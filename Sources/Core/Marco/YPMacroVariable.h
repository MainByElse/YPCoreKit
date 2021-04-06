//
//  YPMacroVariable.h
//  YPCoreKit
//
//  Created by Else on 2021/4/6.
//

#ifndef YPMacroVariable_h
#define YPMacroVariable_h

// 判断当前是否是测试环境
#ifdef DEBUG
#define IS_TEST YES
#else
#define IS_TEST NO
#endif

#pragma mark - 线程相关
#define GlobalConcurrentQueue dispatch_get_global_queue(0, 0)
#define MainQueue dispatch_get_main_queue()

#pragma mark - weakify、strongify

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* YPMacroVariable_h */
