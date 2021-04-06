//
//  UIApplication+YPUI.m
//  YPCoreKit
//
//  Created by Else on 2021/4/6.
//

#import "UIApplication+YPUI.h"
#import "QMUICommonDefines.h"

@implementation UIApplication (YPUI)

- (nullable UIWindow *)yp_keyWindow {
    UIWindow *originalKeyWindow = nil;
    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *connectedScenes = self.connectedScenes;
        for (UIScene *scene in connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        originalKeyWindow = window;
                        break;
                    }
                }
            }
        }
    }
    if (!originalKeyWindow) {
        UIWindow *window = self.windows.firstObject;
        if (window.isKeyWindow) {
            originalKeyWindow = window;
        } else {
            BeginIgnoreDeprecatedWarning
            if (CGRectEqualToRect(self.keyWindow.bounds, UIScreen.mainScreen.bounds)) {
                originalKeyWindow = self.keyWindow;
            } else {
                originalKeyWindow = window;
            }
            EndIgnoreClangWarning
        }
    }
    return originalKeyWindow;
}

@end
