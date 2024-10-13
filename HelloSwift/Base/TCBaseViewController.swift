//
//  TCBaseViewController.swift
//  StudySwiftJichu
//
//  Created by gtc on 2021/4/27.
//  Copyright © 2021 gtc. All rights reserved.
//

import UIKit

class TCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
//            view.backgroundColor = R.color.lightGrey_595959()
        } else {
            // Fallback on earlier versions
        }
        view.backgroundColor = .white
    }
}
