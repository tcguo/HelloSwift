//
//  test.swift
//  HelloSwift
//
//  Created by gtc on 2021/11/5.
//

import Foundation

typealias Completion = (String) -> Void
typealias CompleteHandler = () -> Void

class Test {
    var didConfirmBlock: ((String) -> Void)?
    final func method() {
        
    }
    
    let aad: [Int] = []
    
    final var name: String  = ""
    
//    var age: Int = nil // nil只能赋值给可选类型

    let a:Int? = .none
    let b: String? = Optional<String>("dd")
    
    func sortname() {
        let animals = ["fish", "cat", "chicken", "dog"]
        let sortedAnimals = animals.sorted(by: { (one: String, two: String) in
            return one < two
        })
        
        didConfirmBlock = { [weak self] aa in
            
        }
    }
    
    func test2()  {
        let uint = UInt(bitPattern: -1) // 将负值给uint
    }
    
    
    /// 函数泛型
    func exchangeNums<T>(nums: inout [T], p: Int, q: Int) {
        let tmp = nums[p]
        nums[p] = nums[q]
        nums[q] = tmp
    }
    
}

final class Test2 {
    
}



