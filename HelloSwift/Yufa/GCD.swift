//
//  GCD.swift
//  HelloSwift
//
//  Created by gtc on 2023/8/15.
//

import Foundation


enum GCDTester {
    static func xiaohongshu() {
        let group = Dispatch.DispatchGroup()
        let queue = DispatchQueue.global()
        
        queue.async(group: group, execute: Dispatch.DispatchWorkItem {
            queue.sync(execute: DispatchWorkItem(block: {
                print("1")
            }))
            queue.sync(execute: DispatchWorkItem(block: {
                print("2")
            }))
            queue.sync(execute: DispatchWorkItem(block: {
                print("3")
            }))
        })
        
        queue.async(group: group, execute: DispatchWorkItem {
            print("4")
        })
        
        queue.async(group: group, execute: DispatchWorkItem(block: {
            print("5")
        }))
        
        group.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            print("done")
        }))
        
    }
    
    static func mutiRequestOneResult() {
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
