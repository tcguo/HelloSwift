//
//  PromiseViewController.swift
//  HelloSwift
//
//  Created by Darius Guo on 2022/1/25.
//

import UIKit
import PromiseKit

enum MyError: Error {
    case nodata
    case nonetwork
}

typealias CompleteBlock = ()

class PromiseViewController: TCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        firstly(execute: T##() -> )
        
//        loadData { (a: String, b: Int) in
//            print(a, b)
//        }
        
        firstly {
            doSomething()
        }.done { res in
            print("2222-res=\(res)")
        }.catch { err in
            if err is MyError {
                switch err {
                case MyError.nodata:
                    print("2222-nodata")
                case MyError.nonetwork:
                    print("2222-nonetwork")
                default:
                    print("2222-default")
                }
            }
        }
    }
    
    
    func loadData(complete: ((String, Int) -> Void)) {
        complete("aa", 12)
    }
    
    func doSomething() -> Promise<String> {
        return Promise<String> { resolver in
            let isSuccess = false
            let success = { (result: Any?) -> Void in
                print("result=%@", result ?? "12")
                resolver.fulfill("dddd")
            }
            
            let failure = { (result: Any?) -> Void in
                print(result as Any)
                resolver.reject(MyError.nodata)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
                if isSuccess {
                    success("success")
                } else {
                    failure("error")
                }
            }
        }
        
    }

}
