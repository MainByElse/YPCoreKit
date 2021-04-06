//
//  YPCoreKitCompatible.swift
//  YPCoreKit
//
//  Created by Else on 2021/4/6.
//

import Foundation

public struct YPCoreKitWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol YPCoreKitCompatible { }

extension YPCoreKitCompatible {
    public var yp: YPCoreKitWrapper<Self> {
        get { return YPCoreKitWrapper(self) }
        set { }
    }
    public static var yp: YPCoreKitWrapper<Self>.Type {
        get { YPCoreKitWrapper<Self>.self }
        set { }
    }
}

// 对所有对象生效
extension NSObject: YPCoreKitCompatible { }

