//
//  YPUIHelper.swift
//  SwiftDemo
//
//  Created by Else on 2021/9/28.
//  Copyright © 2021 Else丶. All rights reserved.
//

import UIKit
import QMUIKit

class YPUIHelper: NSObject {

}

// MARK: - Device
extension YPUIHelper {
    
    public static let isMac: Bool = {
        isMacCatalystApp || isiOSAppOnMac
    }()
    
    fileprivate static var macCatalystApp = -1
    public static let isMacCatalystApp: Bool = {
        if macCatalystApp < 0 {
            if #available(iOS 13.0, *) {
                macCatalystApp = ProcessInfo.processInfo.isMacCatalystApp ? 1 : 0
            }
        }
        return macCatalystApp > 0
    }()
    
    fileprivate static var iOSAppOnMac = -1
    public static let isiOSAppOnMac: Bool = {
        if iOSAppOnMac < 0 {
            if #available(iOS 14.0, *) {
                iOSAppOnMac = ProcessInfo.processInfo.isiOSAppOnMac ? 1 : 0
            }
        }
        return iOSAppOnMac > 0
    }()
    
    fileprivate static var iPad = -1
    public static let isIPad: Bool = {
        if iPad < 0 {
            iPad = UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0
        }
        return iPad > 0
    }()
    fileprivate static var iPod = -1
    public static let isIPod: Bool = {
        if iPod < 0 {
            iPod = UIDevice.current.model.contains("iPod touch") ? 1 : 0
        }
        return iPod > 0
    }()
    fileprivate static var iPhone = -1
    public static let isIPhone: Bool = {
        if iPhone < 0 {
            iPhone = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 0
        }
        return iPhone > 0
    }()
    public static let isSimulator: Bool = {
        return TARGET_OS_SIMULATOR > 0
    }()
    public static let systemVersion: Double = {
        UIDevice.current.systemVersion.doubleValue
    }()
    public static let isRegularScreen: Bool = {
        return (isIPad || (is67InchScreen || is65InchScreen || is61InchScreen || is55InchScreen))
    }()
    
    public static let deviceModel: String = {
        if isSimulator {
            // 模拟器不返回物理机器信息，但会通过环境变量的方式返回
            return String(format: "%s", getenv("SIMULATOR_MODEL_IDENTIFIER"))
        }
        if !isMacCatalystApp {
            var systemInfo: utsname = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
        }
        return ""
    }()
    
    public static let deviceName: String = {
        let model: String = deviceModel
        var name = "Unknown Device"
        guard model.isEmpty else { return name }
        let dict: Dictionary = [
            // See https://www.theiphonewiki.com/wiki/Models
            "iPhone1,1" : "iPhone 1G",
            "iPhone1,2" : "iPhone 3G",
            "iPhone2,1" : "iPhone 3GS",
            "iPhone3,1" : "iPhone 4 (GSM)",
            "iPhone3,2" : "iPhone 4",
            "iPhone3,3" : "iPhone 4 (CDMA)",
            "iPhone4,1" : "iPhone 4S",
            "iPhone5,1" : "iPhone 5",
            "iPhone5,2" : "iPhone 5",
            "iPhone5,3" : "iPhone 5c",
            "iPhone5,4" : "iPhone 5c",
            "iPhone6,1" : "iPhone 5s",
            "iPhone6,2" : "iPhone 5s",
            "iPhone7,1" : "iPhone 6 Plus",
            "iPhone7,2" : "iPhone 6",
            "iPhone8,1" : "iPhone 6s",
            "iPhone8,2" : "iPhone 6s Plus",
            "iPhone8,4" : "iPhone SE",
            "iPhone9,1" : "iPhone 7",
            "iPhone9,2" : "iPhone 7 Plus",
            "iPhone9,3" : "iPhone 7",
            "iPhone9,4" : "iPhone 7 Plus",
            "iPhone10,1" : "iPhone 8",
            "iPhone10,2" : "iPhone 8 Plus",
            "iPhone10,3" : "iPhone X",
            "iPhone10,4" : "iPhone 8",
            "iPhone10,5" : "iPhone 8 Plus",
            "iPhone10,6" : "iPhone X",
            "iPhone11,2" : "iPhone XS",
            "iPhone11,4" : "iPhone XS Max",
            "iPhone11,6" : "iPhone XS Max CN",
            "iPhone11,8" : "iPhone XR",
            "iPhone12,1" : "iPhone 11",
            "iPhone12,3" : "iPhone 11 Pro",
            "iPhone12,5" : "iPhone 11 Pro Max",
            "iPhone12,8" : "iPhone SE (2nd generation)",
            "iPhone13,1" : "iPhone 12 mini",
            "iPhone13,2" : "iPhone 12",
            "iPhone13,3" : "iPhone 12 Pro",
            "iPhone13,4" : "iPhone 12 Pro Max",
            "iPhone14,2" : "iPhone 13 Pro",
            "iPhone14,3" : "iPhone 13 Pro Max",
            "iPhone14,4" : "iPhone 13 mini",
            "iPhone14,5" : "iPhone 13",
            
            "iPad1,1" : "iPad 1",
            "iPad2,1" : "iPad 2 (WiFi)",
            "iPad2,2" : "iPad 2 (GSM)",
            "iPad2,3" : "iPad 2 (CDMA)",
            "iPad2,4" : "iPad 2",
            "iPad2,5" : "iPad mini 1",
            "iPad2,6" : "iPad mini 1",
            "iPad2,7" : "iPad mini 1",
            "iPad3,1" : "iPad 3 (WiFi)",
            "iPad3,2" : "iPad 3 (4G)",
            "iPad3,3" : "iPad 3 (4G)",
            "iPad3,4" : "iPad 4",
            "iPad3,5" : "iPad 4",
            "iPad3,6" : "iPad 4",
            "iPad4,1" : "iPad Air",
            "iPad4,2" : "iPad Air",
            "iPad4,3" : "iPad Air",
            "iPad4,4" : "iPad mini 2",
            "iPad4,5" : "iPad mini 2",
            "iPad4,6" : "iPad mini 2",
            "iPad4,7" : "iPad mini 3",
            "iPad4,8" : "iPad mini 3",
            "iPad4,9" : "iPad mini 3",
            "iPad5,1" : "iPad mini 4",
            "iPad5,2" : "iPad mini 4",
            "iPad5,3" : "iPad Air 2",
            "iPad5,4" : "iPad Air 2",
            "iPad6,3" : "iPad Pro (9.7 inch)",
            "iPad6,4" : "iPad Pro (9.7 inch)",
            "iPad6,7" : "iPad Pro (12.9 inch)",
            "iPad6,8" : "iPad Pro (12.9 inch)",
            "iPad6,11": "iPad 5 (WiFi)",
            "iPad6,12": "iPad 5 (Cellular)",
            "iPad7,1" : "iPad Pro (12.9 inch, 2nd generation)",
            "iPad7,2" : "iPad Pro (12.9 inch, 2nd generation)",
            "iPad7,3" : "iPad Pro (10.5 inch)",
            "iPad7,4" : "iPad Pro (10.5 inch)",
            "iPad7,5" : "iPad 6 (WiFi)",
            "iPad7,6" : "iPad 6 (Cellular)",
            "iPad7,11": "iPad 7 (WiFi)",
            "iPad7,12": "iPad 7 (Cellular)",
            "iPad8,1" : "iPad Pro (11 inch)",
            "iPad8,2" : "iPad Pro (11 inch)",
            "iPad8,3" : "iPad Pro (11 inch)",
            "iPad8,4" : "iPad Pro (11 inch)",
            "iPad8,5" : "iPad Pro (12.9 inch, 3rd generation)",
            "iPad8,6" : "iPad Pro (12.9 inch, 3rd generation)",
            "iPad8,7" : "iPad Pro (12.9 inch, 3rd generation)",
            "iPad8,8" : "iPad Pro (12.9 inch, 3rd generation)",
            "iPad8,9" : "iPad Pro (11 inch, 2nd generation)",
            "iPad8,10" : "iPad Pro (11 inch, 2nd generation)",
            "iPad8,11" : "iPad Pro (12.9 inch, 4th generation)",
            "iPad8,12" : "iPad Pro (12.9 inch, 4th generation)",
            "iPad11,1" : "iPad mini (5th generation)",
            "iPad11,2" : "iPad mini (5th generation)",
            "iPad11,3" : "iPad Air (3rd generation)",
            "iPad11,4" : "iPad Air (3rd generation)",
            "iPad11,6" : "iPad (WiFi)",
            "iPad11,7" : "iPad (Cellular)",
            "iPad13,1" : "iPad Air (4th generation)",
            "iPad13,2" : "iPad Air (4th generation)",
            
            "iPod1,1" : "iPod touch 1",
            "iPod2,1" : "iPod touch 2",
            "iPod3,1" : "iPod touch 3",
            "iPod4,1" : "iPod touch 4",
            "iPod5,1" : "iPod touch 5",
            "iPod7,1" : "iPod touch 6",
            "iPod9,1" : "iPod touch 7",
            
            "i386" : "Simulator x86",
            "x86_64" : "Simulator x64",
            
            "Watch1,1" : "Apple Watch 38mm",
            "Watch1,2" : "Apple Watch 42mm",
            "Watch2,3" : "Apple Watch Series 2 38mm",
            "Watch2,4" : "Apple Watch Series 2 42mm",
            "Watch2,6" : "Apple Watch Series 1 38mm",
            "Watch2,7" : "Apple Watch Series 1 42mm",
            "Watch3,1" : "Apple Watch Series 3 38mm",
            "Watch3,2" : "Apple Watch Series 3 42mm",
            "Watch3,3" : "Apple Watch Series 3 38mm (LTE)",
            "Watch3,4" : "Apple Watch Series 3 42mm (LTE)",
            "Watch4,1" : "Apple Watch Series 4 40mm",
            "Watch4,2" : "Apple Watch Series 4 44mm",
            "Watch4,3" : "Apple Watch Series 4 40mm (LTE)",
            "Watch4,4" : "Apple Watch Series 4 44mm (LTE)",
            "Watch5,1" : "Apple Watch Series 5 40mm",
            "Watch5,2" : "Apple Watch Series 5 44mm",
            "Watch5,3" : "Apple Watch Series 5 40mm (LTE)",
            "Watch5,4" : "Apple Watch Series 5 44mm (LTE)",
            "Watch5,9" : "Apple Watch SE 40mm",
            "Watch5,10" : "Apple Watch SE 44mm",
            "Watch5,11" : "Apple Watch SE 40mm",
            "Watch5,12" : "Apple Watch SE 44mm",
            "Watch6,1"  : "Apple Watch Series 6 40mm",
            "Watch6,2"  : "Apple Watch Series 6 44mm",
            "Watch6,3"  : "Apple Watch Series 6 40mm",
            "Watch6,4"  : "Apple Watch Series 6 44mm",
            
            "AudioAccessory1,1" : "HomePod",
            "AudioAccessory1,2" : "HomePod",
            "AudioAccessory5,1" : "HomePod mini",
            
            "AirPods1,1" : "AirPods (1st generation)",
            "AirPods2,1" : "AirPods (2nd generation)",
            "iProd8,1"   : "AirPods Pro",
            
            "AppleTV2,1" : "Apple TV 2",
            "AppleTV3,1" : "Apple TV 3",
            "AppleTV3,2" : "Apple TV 3",
            "AppleTV5,3" : "Apple TV 4",
            "AppleTV6,2" : "Apple TV 4K",
        ]
        name = dict[model] ?? model
        if isSimulator {
            name = name.appending(" Simulator")
        }
        return name
    }()
    
    fileprivate static var notchedScreen = -1
    public static let isNotchedScreen: Bool = {
        assert(Thread.isMainThread, "请在主线程调用！")
        if #available(iOS 11.0, *) {
            if notchedScreen < 0 {
                if #available(iOS 12.0, *) {
                    /*
                     检测方式解释/测试要点：
                     1. iOS 11 与 iOS 12 可能行为不同，所以要分别测试。
                     2. 与触发 [RMUIHelper isNotchedScreen] 方法时的进程有关，例如 https://github.com/Tencent/QMUI_iOS/issues/482#issuecomment-456051738 里提到的 [NSObject performSelectorOnMainThread:withObject:waitUntilDone:NO] 就会导致较多的异常。
                     3. iOS 12 下，在非第2点里提到的情况下，iPhone、iPad 均可通过 UIScreen -_peripheryInsets 方法的返回值区分，但如果满足了第2点，则 iPad 无法使用这个方法，这种情况下要依赖第4点。
                     4. iOS 12 下，不管是否满足第2点，不管是什么设备类型，均可以通过一个满屏的 UIWindow 的 rootViewController.view.frame.origin.y 的值来区分，如果是非全面屏，这个值必定为20，如果是全面屏，则可能是24或44等不同的值。但由于创建 UIWindow、UIViewController 等均属于较大消耗，所以只在前面的步骤无法区分的情况下才会使用第4点。
                     5. 对于第4点，经测试与当前设备的方向、是否有勾选 project 里的 General - Hide status bar、当前是否处于来电模式的状态栏这些都没关系。
                     */
                    let peripheryInsetsSelector: Selector = NSSelectorFromString(String(format: "_%@%@", "periphery", "Insets"))
                    var peripheryInsets: UIEdgeInsets = .zero
                    UIScreen.main.qmui_performSelector(toSuperclass: peripheryInsetsSelector, with: peripheryInsets)
                    if peripheryInsets.bottom <= 0 {
                        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
                        peripheryInsets = window.safeAreaInsets
                        if peripheryInsets.bottom <= 0 {
                            /// https://github.com/Tencent/QMUI_iOS/issues/1263
                            let viewController = UIViewController()
                            window.rootViewController = viewController
                            if viewController.view.frame.minY > 20 {
                                peripheryInsets.bottom = 1
                            }
                        }
                    }
                    notchedScreen = peripheryInsets.bottom > 0 ? 1 : 0
                } else {
                    notchedScreen = YPUIHelper.is58InchScreen ? 1 : 0
                }
            }
        } else {
            notchedScreen = 0
        }
        return notchedScreen > 0
    }()
    
    // MARK: ****** 屏幕尺寸 ******
    fileprivate static var inchScreen67 = -1
    public static let is67InchScreen: Bool = {
        if inchScreen67 < 0 {
            inchScreen67 = (deviceSize.width == screenSizeFor67Inch.width && deviceSize.height == screenSizeFor67Inch.height) ? 1 : 0
        }
        return inchScreen67 > 0
    }()
    fileprivate static var inchScreen65 = -1
    public static let is65InchScreen: Bool = {
        if inchScreen65 < 0 {
            inchScreen65 = (deviceSize.width == screenSizeFor65Inch.width && deviceSize.height == screenSizeFor65Inch.height && (deviceModel == "iPhone11,4" || deviceModel == "iPhone11,6" || deviceModel == "iPhone12,5")) ? 1 : 0
        }
        return inchScreen65 > 0
    }()
    fileprivate static var inchScreen61AndiPhone12 = -1
    public static let is61InchScreenAndiPhone12: Bool = {
        if inchScreen61AndiPhone12 < 0 {
            inchScreen61AndiPhone12 = (deviceSize.width == screenSizeFor61InchAndiPhone12.width && deviceSize.height == screenSizeFor61InchAndiPhone12.height && (deviceModel == "iPhone13,2" || deviceModel == "iPhone13,3")) ? 1 : 0
        }
        return inchScreen61AndiPhone12 > 0
    }()
    fileprivate static var inchScreen61 = -1
    public static let is61InchScreen: Bool = {
        if inchScreen61 < 0 {
            inchScreen61 = (deviceSize.width == screenSizeFor61Inch.width && deviceSize.height == screenSizeFor61Inch.height && (deviceModel == "iPhone11,8" || deviceModel == "iPhone12,1")) ? 1 : 0
        }
        return inchScreen61 > 0
    }()
    fileprivate static var inchScreen58 = -1
    public static let is58InchScreen: Bool = {
        if inchScreen58 < 0 {
            // Both iPhone XS and iPhone X share the same actual screen sizes, so no need to compare identifiers
            // iPhone XS 和 iPhone X 的物理尺寸是一致的，因此无需比较机器 Identifier
            inchScreen58 = (deviceSize.width == screenSizeFor58Inch.width && deviceSize.height == screenSizeFor58Inch.height) ? 1 : 0
        }
        return inchScreen58 > 0
    }()
    fileprivate static var inchScreen55 = -1
    public static let is55InchScreen: Bool = {
        if inchScreen55 < 0 {
            inchScreen55 = (deviceSize.width == screenSizeFor55Inch.width && deviceSize.height == screenSizeFor55Inch.height) ? 1 : 0
        }
        return inchScreen55 > 0
    }()
    fileprivate static var inchScreen54 = -1
    public static let is54InchScreen: Bool = {
        if inchScreen54 < 0 {
            inchScreen54 = (deviceSize.width == screenSizeFor54Inch.width && deviceSize.height == screenSizeFor54Inch.height) ? 1 : 0
        }
        return inchScreen54 > 0
    }()
    fileprivate static var inchScreen47 = -1
    public static let is47InchScreen: Bool = {
        if (inchScreen47 < 0) {
            inchScreen47 = (deviceSize.width == screenSizeFor47Inch.width && deviceSize.height == screenSizeFor47Inch.height) ? 1 : 0
        }
        return inchScreen47 > 0
    }()
    fileprivate static var inchScreen40 = -1
    public static let is40InchScreen: Bool = {
        if inchScreen40 < 0 {
            inchScreen40 = (deviceSize.width == screenSizeFor40Inch.width && deviceSize.height == screenSizeFor40Inch.height) ? 1 : 0
        }
        return inchScreen40 > 0
    }()
    fileprivate static var inchScreen35 = -1
    public static let is35InchScreen: Bool = {
        if inchScreen35 < 0 {
            inchScreen35 = (deviceSize.width == screenSizeFor35Inch.width && deviceSize.height == screenSizeFor35Inch.height) ? 1 : 0
        }
        return inchScreen35 > 0
    }()

    // MARK: ****** Size ******
    public static let screenSizeFor67Inch: CGSize = CGSize(width: 428, height: 926)
    public static let screenSizeFor65Inch = CGSize(width: 414, height: 896)
    public static let screenSizeFor61InchAndiPhone12 = CGSize(width: 390, height: 844)
    public static let screenSizeFor61Inch = CGSize(width: 414, height: 896)
    public static let screenSizeFor58Inch = CGSize(width: 375, height: 812)
    public static let screenSizeFor55Inch = CGSize(width: 414, height: 736)
    public static let screenSizeFor54Inch = CGSize(width: 375, height: 812)
    public static let screenSizeFor47Inch = CGSize(width: 375, height: 667)
    public static let screenSizeFor40Inch = CGSize(width: 320, height: 568)
    public static let screenSizeFor35Inch = CGSize(width: 320, height: 480)
}

// MARK: - LayoutGuide
extension YPUIHelper {
    public static let statusBarStyleDarkContent: UIStatusBarStyle = {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }()
    public static let statusBarHeight: CGFloat = {
        assert(Thread.isMainThread, "请在主线程调用！")
        let isStatusBarHidden = UIApplication.shared.isStatusBarHidden
        if ((isNotchedScreen && isStatusBarHidden) || isMacCatalystApp) {
            let insets: UIEdgeInsets = safeAreaInsetsForDeviceWithNotch
            return insets.top
        } else {
            return UIApplication.shared.statusBarFrame.maxY
        }
    }()
    public static let navigationBarHeight: CGFloat = {
        (isIPad ? (systemVersion >= 12.0 ? 50 : 44) : (isLandscape ? (isRegularScreen ? 44 : 32) : 44))
    }()
    public static let navigationContentTop: CGFloat = {
        statusBarHeight + navigationBarHeight
    }()
    public static let toolBarHeight: CGFloat = {
        (isIPad ? (isNotchedScreen ? 70 : (systemVersion >= 12.0 ? 50 : 44)) : (isLandscape ? (isRegularScreen ? 44 : 32) : 44) + safeAreaInsetsForDeviceWithNotch.bottom)
    }()
    public static let tabBarHeight: CGFloat = {
        (isIPad ? (isNotchedScreen ? 65 : (systemVersion >= 12.0 ? 50 : 49)) : (isLandscape ? (isRegularScreen ? 49 : 32) : 49) + safeAreaInsetsForDeviceWithNotch.bottom)
    }()
    public static let safeAreaInsetsForDeviceWithNotch: UIEdgeInsets = {
        assert(Thread.isMainThread, "请在主线程调用！")
        var insets: UIEdgeInsets = .zero
        if #available(iOS 11, *) {
            let window: UIWindow = UIApplication.yp_KeyWindow
            insets = window.safeAreaInsets
        }
        return insets
    }()
    fileprivate static var pixelone: CGFloat = -1
    public static let pixelOne: CGFloat = {
        if pixelone < 0 {
            pixelone = 1 / UIScreen.main.scale
        }
        return pixelone
    }()
    public static let isLandscape: Bool = {
        UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    }()
    public static let isLandscapeDevice: Bool = {
        UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
    }()
    public static let screenSize: CGSize = {
        UIScreen.main.bounds.size
    }()
    public static let deviceSize: CGSize = {
        CGSize(width: min(screenSize.width, screenSize.height),
               height: max(screenSize.width, screenSize.height))
    }()
    public static let applicationSize: CGSize = {
        let applicationFrame = UIScreen.main.applicationFrame
        /// applicationFrame 在 iPad 下返回的 size 要比 window 实际的 size 小，这个差值体现在 origin 上，所以用 origin + size 修正得到正确的大小。
        return CGSize(width: applicationFrame.size.width + applicationFrame.origin.x,
                      height: applicationFrame.size.height + applicationFrame.origin.y)
    }()
}
