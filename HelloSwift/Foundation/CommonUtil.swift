//
//  GlobalDefine.swift
//  HelloSwift
//
//  Created by gtc on 2021/7/1.
//

import Foundation
import UIKit

// MARK: - Const
private func getSafeBottomHeight() -> CGFloat {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.keyWindow!.safeAreaInsets.bottom
    }
    return 0
}
private func getSafeTopHeight() -> CGFloat {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.keyWindow!.safeAreaInsets.top
    }
    return 0
}

public let kScreenWidth    =   UIScreen.main.bounds.width
public let kScreenHeight   =   UIScreen.main.bounds.height
public let kSafeTopHeight = getSafeTopHeight()
public let kSafeBottomHeight = getSafeBottomHeight()

public let isIPhoneX       =   (kSafeTopHeight > 20)
public let kAdapterScale   =   kScreenWidth / 375.0
public let kStatusBarHeight =   (isIPhoneX ? 44.0 : 20.0)
public let kNavigationBarHeight = (isIPhoneX ? 88.0 : 64.0)

// MARK: - Font & Color


// MARK: - Block
public typealias CompletionBlock = ((_ result: Any?, _ error: Error?) -> Void)



// MARK: Extension
public extension Double {
    func adp() -> CGFloat {
        return CGFloat(self) * kAdapterScale
    }
}

public extension CGFloat {
    func adp() -> CGFloat {
        return self * kAdapterScale
    }
}

public extension Int {
    func adp() -> CGFloat {
        return CGFloat(self) * kAdapterScale
    }
}
