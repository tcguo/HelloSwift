//
//  Block.swift
//  HelloSwift
//
//  Created by gtc on 2023/8/10.
//

import Foundation

// 起个别名
typealias FirstName =  String
struct TestBlock {
    typealias CompleteBlock = ((String) -> Void)?
    var name: FirstName = ""
    var didSelectBlock: ((Int) -> Void)?
    var didSelectBlock2: (() -> Void)? // 无参数
    var completion: (String) -> Void
    
    func testBlock() {
        let someClosuer: CompleteBlock = { (name: String) in
            print("hello,", name)
        }
        someClosuer?("world")
    }
    
    func download(progressHandler: @escaping (Progress) -> Void) -> NSURLRequest? {
        progressHandler(Progress(totalUnitCount: 12))
        
        return nil
    }
    
//    func download2(progressHandler: @escaping ((Progress) -> Void)?) -> NSURLRequest? {
//        progressHandler?(Progress(totalUnitCount: 12))
//        return nil
//    }
}

