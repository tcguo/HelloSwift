//
//  ApiManager.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/4.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Alamofire


protocol ApiEnvironment {
    static var dev: String { get }
    static var prod: String { get }
    static var allEnvironment: [String] { get }
    static var defaultEnvironment: String { get }
}

extension ApiEnvironment {
    static var allEnvironment: [String] { [dev, prod] }
    static var defaultEnvironment: String {
        return dev
    }
}

enum ApiBaseUrl {
    enum Api {
        private(set) static var dev = "http://m2u.test.gifshow.com/api-server/"
        private(set) static var prod = "https://m2u-api.getkwai.com/api-server/api/"
        static var url = dev
    }
    enum Passport {
        private(set) static var dev = "https://m2u.test.gifshow.com/api-server/api/"
        private(set) static var prod = "https://m2u-api.getkwai.com/api-server/api/"
        static var url = dev
    }
}

class ApiManager {
    
}

enum ApiMangerHelper {
    static func customRequestClosure(endpoint: Endpoint, closure: (Result<URLRequest, MoyaError>) -> Void) {
        do {
            var request = try endpoint.urlRequest()
            request.httpShouldHandleCookies = true
            request.timeoutInterval = 600
            closure(.success(request))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }
}

let customRequestClosure = { (endpoint: Endpoint, closure: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.httpShouldHandleCookies = true
        request.timeoutInterval = 600
        closure(.success(request))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
    
}

class TargetProviderStore: NSObject {
    static let shared = TargetProviderStore()
    var storeKey: [String: String] = [:]
}

extension TargetType {
    func request() -> Single<Response> {
        return Self.provider.rx.request(self)
    }
    
    func ts_request(complete: @escaping Completion) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            complete("ddd")
        }
    }
    
    static var provider: MoyaProvider<Self> {
        let provider = MoyaProvider<Self>(requestClosure: customRequestClosure, plugins: [NetworkLoggerPlugin()])
        let key = String(describing: Self.self)
        var storeKey = TargetProviderStore.shared.storeKey[key]
        objc_setAssociatedObject(TargetProviderStore.shared, &storeKey, provider, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return provider
    }
}

extension TargetType {
    var baseURL: URL {
        return URL(string: ApiBaseUrl.Api.url) ?? URL(fileURLWithPath: "")
    }
    
    var method: Moya.Method {
        .post
    }
    
    var headers: [String: String]? {
        return nil
    }

    var validationType: ValidationType {
        return .none
    }

    var parameterEncoding: ParameterEncoding {
        if method == .post {
            return JSONEncoding.default
        } else {
            return URLEncoding.default
        }
    }
    
}
