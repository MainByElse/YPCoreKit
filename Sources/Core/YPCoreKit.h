//
//  YPCoreKit.h
//  YPCoreKit
//
//  Created by Else on 2021/4/6.
//

#ifndef YPCoreKit_h
#define YPCoreKit_h

#if __has_include(<YPCoreKit/YPCoreKit.h>)

// MARK: Core
#if __has_include(<YPCoreKit/YPCoreKit.h>)
#import <YPCoreKit/YPCoreKit.h>
#endif

#if __has_include(<QMUIKit/QMUIKit.h>)
#import <QMUIKit/QMUIKit.h>
#endif

#if __has_include(<YPCoreKit/YPMacroMethod.h>)
#import <YPCoreKit/YPMacroMethod.h>
#endif

#if __has_include(<YPCoreKit/YPMacroVariable.h>)
#import <YPCoreKit/YPMacroVariable.h>
#endif

#if __has_include(<YPCoreKit/UIApplication+YPUI.h>)
#import <YPCoreKit/UIApplication+YPUI.h>
#endif

#if __has_include(<YPCoreKit/YPUIHelper.h>)
#import <YPCoreKit/YPUIHelper.h>
#endif

#if __has_include(<YPCoreKit/YPUIHelper+Device.h>)
#import <YPCoreKit/YPUIHelper+Device.h>
#endif

#else

#if __has_include("YPCoreKit.h")
#import "YPCoreKit.h"
#endif

#if __has_include("QMUIKit.h")
#import "QMUIKit.h"
#endif

#if __has_include("YPMacroMethod.h")
#import "YPMacroMethod.h"
#endif

#if __has_include("YPMacroVariable.h")
#import "YPMacroVariable.h"
#endif

#if __has_include("UIApplication+YPUI.h")
#import "UIApplication+YPUI.h"
#endif

#if __has_include("YPUIHelper.h")
#import "YPUIHelper.h"
#endif

#if __has_include("YPUIHelper+Device.h")
#import "YPUIHelper+Device.h"
#endif

#endif /* __has_include */

#endif /* YPCoreKit_h */
