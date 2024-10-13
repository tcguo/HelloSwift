//
//  TCNavigationViewController.swift
//  StudySwiftJichu
//
//  Created by gtc on 2021/4/27.
//  Copyright © 2021 gtc. All rights reserved.
//

import UIKit

class TCNavigationViewController: UINavigationController {
    
    override init(rootViewController: UIViewController?) {
        if let rootViewController = rootViewController {
            super.init(rootViewController: rootViewController)
        } else {
            super.init(rootViewController: TTMainViewController())
        }
        
        setNavigationBarHidden(false, animated: true)
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
