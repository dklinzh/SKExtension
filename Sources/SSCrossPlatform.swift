//
//  SSCrossPlatform.swift
//  SpriteSwift
//
//  Created by Daniel Lin on 2020/7/7.
//  Copyright © 2020 dklinzh. All rights reserved.
//

#if os(iOS)
import UIKit

typealias SSWindow = UIWindow
typealias SSViewController = UIViewController
typealias SSFont = UIFont
typealias SSEdgeInsets = UIEdgeInsets
#elseif os(macOS)
import AppKit

typealias SSWindow = NSWindow
typealias SSViewController = NSViewController
typealias SSFont = NSFont
typealias SSEdgeInsets = NSEdgeInsets
#endif

/// Enum describing various platforms that a SpriteKit game can run on.
public enum SSPlatformType {
    /// iPhone
    case phone
    /// iPad
    case pad
    /// Mac
    case desktop

    /// Get the platform type that the game is currently running on
    public static let current: SSPlatformType = {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .phone ? .phone : .pad
        #elseif os(macOS)
        return .desktop
        #endif
    }()
}

/// Enum providing a simplified, platform-agnostic way to handle device orientation.
public enum SSDeviceOrientation {
    /// portrait orientation
    case portrait
    /// landscape orientation
    case landscape

    /// Get the orientation of the device that the game is currently running on
    public static var current: SSDeviceOrientation {
        #if os(iOS)
        return UIDevice.current.orientation.isLandscape ? .landscape : .portrait
        #elseif os(macOS)
        return .landscape
        #endif
    }
}

/// Get the scale of the screen that the game is currently running on.
public func SSScreenScale() -> CGFloat {
    #if os(iOS)
    return UIScreen.main.scale
    #elseif os(macOS)
    return NSScreen.main?.backingScaleFactor ?? 0.0
    #endif
}
