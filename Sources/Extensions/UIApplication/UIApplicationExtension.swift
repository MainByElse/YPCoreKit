//
//  UIApplicationExtension.swift
//  SwiftDemo
//
//  Created by Else on 2021/9/29.
//  Copyright © 2021 Else丶. All rights reserved.
//

import UIKit

extension UIApplication {
    public static var yp_KeyWindow: UIWindow = {
        var originalKeyWindow: UIWindow?
        if #available(iOS 13.0, *) {
            let connectedScenes: Set<UIScene> = shared.connectedScenes
            for scene in connectedScenes {
                if (scene.activationState == .foregroundActive && scene.isKind(of: UIWindowScene.self)) {
                    let windowScene: UIWindowScene = scene as! UIWindowScene
                    for window in windowScene.windows {
                        if (window.isKeyWindow) {
                            originalKeyWindow = window
                            break
                        }
                    }
                }
            }
        }
        if originalKeyWindow != nil {
            let window = shared.windows.first
            if ((window?.isKeyWindow) != nil) {
                originalKeyWindow = window
            } else {
                if ((shared.keyWindow?.bounds.equalTo(UIScreen.main.bounds)) != nil) {
                    originalKeyWindow = shared.keyWindow;
                } else {
                    originalKeyWindow = window;
                }
            }
        }
        return originalKeyWindow ?? UIWindow()
    }()
}
