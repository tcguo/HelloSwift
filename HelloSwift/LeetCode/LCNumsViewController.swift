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
        var res = thoundsSep(num: 1234567)
        print("res = ", res);
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
    
    /// 千分位
    /// - Parameter num: <#num description#>
    /// - Returns: <#description#>
    func thoundsSep(num: Int) -> String {
        let stringNumber = digitsFromInt(num);
    
        var count = 0
        var arr: [String] = []
        
        for number in stringNumber.reversed() {
            if count == 3 {
                arr.append(",")
                count = 0
            }
            count += 1
            arr.append(String(number));
        }
        
        return arr.reversed().joined()
    }
    func digitsFromInt(_ number: Int) -> [Int] {
        let n = abs(number)
        if n < 10 {
            return [n]
        } else {
            return digitsFromInt(n / 10) + [n % 10]
        }
    }
    
    /// 方法三：手动实现（学习算法用）
    func addThousandSeparator(to number: Int) -> String {
        let numberString = String(number)
        var result = ""
        var count = 0
        for char in numberString.reversed() {
            if count != 0 && count % 3 == 0 {
                result.append(",")
            }
            result.append(char)
            count += 1
        }
        
        return String(result.reversed())
    }

    // 使用示例
//    let largeNumber = 1234567890
//    let formattedNumber = addThousandSeparator(to: largeNumber) // "1,234,567,890"
}



