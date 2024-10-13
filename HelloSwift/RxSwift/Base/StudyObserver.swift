//
//  StudyObserver.swift
//  HelloSwift
//
//  Created by gtc on 2021/9/27.
//

import Foundation
import RxSwift
import NSObject_Rx

class StudyObserver: NSObject {
    func createObserver()  {
        let url = URL.init(string: "https://www.baidu.com")
        URLSession.shared.rx.response(request: URLRequest.init(url: url!))
            // subscribe里面就是一个observer，只是匿名
            .subscribe(onNext: { (data) in
                print(data)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("请求完成")
            }).disposed(by: rx.disposeBag)
        
        // 等价于：
        
        // 创建一个观察者
        let observer: AnyObserver<(response: HTTPURLResponse, data: Data)> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print("Data Task Error: \(error)")
            default:
                break
            }
        }
        
        let url2 = URL.init(string: "https://www.baidu.com")
        URLSession.shared.rx.response(request: URLRequest.init(url: url2!))
            .subscribe(observer).disposed(by: rx.disposeBag) //将观察者和订阅方法分离
    }
}
