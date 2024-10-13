//
//  LoginViewModel.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/4.
//

import Foundation
import RxRelay
import RxSwift
import NSObject_Rx

typealias DidBlock = (_ num: Int, _ name: String) -> Void

class LoginViewModel {
    var nameChangeDisplay: PublishRelay<String?> = PublishRelay()
    var loginClickRelay: PublishRelay<Void> = PublishRelay()
    var bag = DisposeBag()
    var age = 12
    var didBtnBlock: (Int, Int) -> Void = { (a: Int, b: Int) in
        let c = a + b
        print("c= \(c)")
    }
    var didBtnBlock2: (Int, Int) -> Void = { a, b in
        let c = a + b
        print("c= \(c)")
    }
    
    var didBlock: DidBlock?
    
    init() {
        bindScript()
    }
    
    func bindScript() {
        nameChangeDisplay.subscribe { [weak self] event in
            
        }
        guard let block = didBlock else {
            return
        }
        block(12, "")
        
        loginClickRelay.subscribe { [weak self] event in
            guard let self = self else { return }

            self.nameChangeDisplay.accept("dddddd")
            self.loginRequest()
        }
        
    }
    
    func loginRequest() {

        
        print("aaa: 请求成功啦")
        
        LoginApi.login.request().mapObject(type: UserInfoModel.self).subscribe { error in
            
        } onError: { _ in
            
        }

        LoginApi.login.request().mapObject(type: UserInfoModel.self).subscribe { userinfo in
            guard let model = userinfo else { return }
            self.nameChangeDisplay.accept(model.token)
        } onError: { err in
            if err is AQApiError {
                
            }
            let error = err as? AQApiError
            switch error {
            case let .serverError(statusCode, msg):
                
                break
            case let .jsonMapping(resp):
                break
            default:
                break
            }
            
            print("err = \(err.localizedDescription)")
        }
        
        //        LoginApi.login.request().subscribe { res in
        //            print(res)
        //            do {
        //                let user = try? JSONDecoder().decode(NetworkBaseData<UserInfoModel>.self, from: res.data)
        //                print(user)
        //            } catch DecodingError.dataCorrupted {
        //
        //            }
        //
        //        } onError: { error in
        //            print(error)
        //        }.disposed(by: bag)
    }
}

struct LoginResult {
    var isok: Bool
    var token: String
}
