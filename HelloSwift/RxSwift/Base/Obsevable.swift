//
//  Obsevable.swift
//  HelloSwift
//
//  Created by gtc on 2021/9/27.
//

import Foundation
import RxSwift
import NSObject_Rx

class StudtyObsevable {
    
    var disposeBag =  DisposeBag()
    
    func crateObservable() {
        // 创建一个序列并监听序列消息发送：
        let ob = Observable<Int>.create { (observer) -> Disposable in
            // “observer.onNext(0) 就代表产生了一个元素，他的值是 0。后面又产生了 9 个元素分别是 1, 2, ... 8, 9 ”
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            
            // 最后用 observer.onCompleted() 表示元素已经全部产生，没有更多元素了。”
            observer.onCompleted()
            return Disposables.create()
        }
        
        ob.subscribe(onNext: { val in
            print("val =\(val)")
        }).disposed(by: disposeBag)
    }
}
