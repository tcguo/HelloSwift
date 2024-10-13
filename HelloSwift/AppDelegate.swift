//
//  AppDelegate.swift
//  HelloSwift
//
//  Created by gtc on 2021/4/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        var mainvc = TTMainViewController()
        var naviVC = TCNavigationViewController(rootViewController: mainvc)
//        naviVC.ro
        window?.rootViewController = naviVC
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle
    
}

// 主线程卡顿监控
/*要一个常驻子线程, 可以有效收集主线程卡顿，并且可以控制卡顿上限阈值*/
private final class CantonPingMainThread: Thread {
    private let mainThreadQueue = DispatchQueue.init(label: "APMMonitor.CantonPingMainThread")
    private let cap: CGFloat
    private let catchHandler: () -> Void
    private let semaphore = DispatchSemaphore(value: 0)
    private let lock = NSObject()
    private var _isResponse = true
    private var isResponse: Bool {
        get {
            var ret: Bool = false
            mainThreadQueue.sync {
                ret = _isResponse
            }
            return ret
            
        }
        set {
            mainThreadQueue.async(flags: .barrier) {
                self._isResponse = newValue
            }
        }
    }
    
    init(_ cap: CGFloat, _ handler: @escaping () -> Void) {
        self.cap = cap
        self.catchHandler = handler
        super.init()
        
    }
    override func main() {
        while !isCancelled {
            autoreleasepool {
                isResponse = false
                
                DispatchQueue.main.async {
                    self.isResponse = true
                    self.semaphore.signal()
                }
                
                // 停留阈值时间后，检查标记
                Thread.sleep(forTimeInterval: TimeInterval(cap))
                if !isResponse {
                    catchHandler()
                }
                _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            }
        }
    }
}
