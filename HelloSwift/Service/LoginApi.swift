//
//  LoginApi.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/4.
//

import Foundation
import Moya

enum LoginApi {
    case login
    case modifypwd
    case resetpwd
    
}

extension LoginApi: TargetType {
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .login:
            return .requestParameters(parameters: [:], encoding: parameterEncoding)
        case .modifypwd:
            return .requestParameters(parameters: [:], encoding: parameterEncoding)
        default:
            return .requestParameters(parameters: [:], encoding: parameterEncoding)
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .modifypwd:
            return "api/modify"
        case .resetpwd:
            return "api/reset"
        }
    }
    var method: Moya.Method {
        .post
    }
        
}
