//
//  UserDefaultConfig.swift
//  HelloSwift
//
//  Created by gtc on 2021/6/29.
//

import Foundation


@propertyWrapper
struct UserDefaultWapper<T> {
    let key: String
    let defaultVal: T
    
    init(key: String, defaultVal: T) {
        self.key = key
        self.defaultVal = defaultVal
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultVal
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

class UserDefaultConfig {
    @UserDefaultWapper(key: "has_show_guide", defaultVal: false)
    static var hasShownGuide:Bool
    
    @UserDefaultWapper(key: "has_show_animated", defaultVal: false)
    static var hasShownAnimated: Bool
    
    @UserDefaultWapper(key: "original_name", defaultVal: "guotianchi")
    static var originalName: String
}

func testWrapper() {
    UserDefaultConfig.hasShownGuide = false
    print(UserDefaultConfig.hasShownGuide)
    UserDefaultConfig.hasShownGuide = true
    print(UserDefaultConfig.hasShownGuide)
    
    UserDefaultConfig.originalName = "guo"
    UserDefaultConfig.originalName = "guo2"
    
    print(UserDefaults.standard.string(forKey: "original_name"))
}



