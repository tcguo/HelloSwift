//
//  Test.swift
//  HelloSwift
//
//  Created by Darius Guo on 2022/1/14.
//

import Foundation


typealias CompleteBlock22 = (String) -> Void
typealias Completion22 = (String) -> Void

class Tester {
    func hellow(name: String, complete: (String) -> Void) {
        
    }
    func hellow2(name: String, complete: (String) -> Void, fiish:(String) -> Void) {
        
    }
    
    func testDefer() {
        
        someDeferFunction()
        // 输出
        // if end
        // if defer
        // function end
        // someDeferFunction()-end-2-1
        // someDeferFunction()-end-2-2
        // someDeferFunction()-end-1-1
        // someDeferFunction()-end-1-2
    }
}

func someDeferFunction() {
    defer {
        print("\(#function)-end-1-1")
        print("\(#function)-end-1-2")
    }
    defer {
        print("\(#function)-end-2-1")
        print("\(#function)-end-2-2")
    }
    if true {
        defer {
            print("if defer")
        }
        print("if end")
    }
    print("function end")
}
