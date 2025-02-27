//
//  ThreadIndexController.swift
//  HelloSwift
//
//  Created by Darius Guo on 2025/2/26.
//

import UIKit

class ThreadIndexController: TCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        threeThreadPrintABC()
        mutiRequestOneResult()
    }
    
    
    func threeThreadPrintABC() {
        /**
         三个线程如何交替打印ABC循环100次
         */
        let queue = DispatchQueue(label: "print.abc", attributes: .concurrent)
        var sampare = DispatchSemaphore(value: 0);
        var sampare1 = DispatchSemaphore(value: 0);
        var sampare2 = DispatchSemaphore(value: 0);
        for _ in 0..<100 {
            queue.async {
                print("A", Thread.current)
                sampare.signal()
            }
            queue.async {
                let _ = sampare.wait(timeout: DispatchTime.distantFuture)
                sleep(1)
                print("B", Thread.current)
                sampare1.signal()
            }
            queue.async {
                let _ = sampare1.wait(timeout: DispatchTime.distantFuture)
                print("C", Thread.current)
                sampare2.signal()
            }
            sampare2.wait(timeout: DispatchTime.distantFuture)
        }
    }
    
    func mutiRequestOneResult() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com", attributes: .concurrent)
        
        group.enter()
        queue.async(group: group, execute: DispatchWorkItem(block: {
            Thread.sleep(forTimeInterval: 2)
            print("request one")
            group.leave()
        }))
        
        group.enter()
        queue.async(group: group, execute: DispatchWorkItem(block: {
            Thread.sleep(forTimeInterval: 2)
            print("request two")
            group.leave()
        }))
        
        group.enter()
        queue.async(group: group, execute: DispatchWorkItem(block: {
            Thread.sleep(forTimeInterval: 2)
            print("request three")
            group.leave()
        }))
        
        group.notify(queue: DispatchQueue.main, work: DispatchWorkItem {
            print("all requests has done")
        })
    }

}
