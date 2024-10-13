//
//  LCNumsViewController.swift
//  HelloSwift
//
//  Created by gtc on 2023/8/13.
//

import UIKit

class LCNumsViewController: TCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// 判断是否是回文数字
    /// - Parameter x: <#x description#>
    /// - Returns: <#description#>
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        
        // 如何不断的一位一位读取int值，通过除以10， 如果得到最后一位的数字，求余
        var num: Int = x //
        var sum = 0
        
        while num != 0 {
            sum = sum*10 + num % 10
            num = num/10
        }
        
        return sum == x
    }
}



