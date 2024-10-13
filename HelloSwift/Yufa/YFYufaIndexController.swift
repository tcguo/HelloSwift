//
//  YFYufaIndexController.swift
//  HelloSwift
//
//  Created by gtc on 2021/11/14.
//

import UIKit

class YFYufaIndexController: TCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        GCDTester.xiaohongshu()
        GCDTester.mutiRequestOneResult()
    }
}

class SomeClass: Equatable {
    var myname:String
    init(name: String) {
        myname = name
    }
    
    //    操作符
    static func == (lhs: SomeClass, rhs: SomeClass) -> Bool {
        return lhs.myname == rhs.myname
    }
}
