//
//  LCStringController.swift
//  HelloSwift
//
//  Created by gtc on 2021/11/19.
//

import UIKit
import CoreMIDI
import CoreAudio
//import Differentiator

class LCStringController: TCBaseViewController {

    enum Result {
        case Success(Int)
        case Error(Int, String)
        case Fail
        case Notnetwork
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let res = findfirstDisr(str: "gooogle")
//        print(res)
        
        let aa = "ac"
        let ad = "ad"
        if aa.compare(ad) == .orderedAscending{
            print("orderedAscending")
        } else {
            print("orderedAscending")
        }
        
        
        // 字符转数字
        let mynum = myAtoi("-987");
        print("mynum = \(mynum)")
        
        
        let num1 = "123"
        let num2 = "231"
        let sum = addStrings(num1, num2)
        print("sum=\(sum)")
        
    }
    
    // 字符串转数字
    func myAtoi(_ s: String) -> Int {
        var chars:[Character] = Array(s)
        // 判断首字母是否是符号
        while let first = chars.first {
            if !first.isNumber, first != "-" {
                chars.removeFirst()
            } else {
                break
            }
        }
        var isNegative = false
        if let first = chars.first, !first.isNumber, first == "-" {
            isNegative = true
        }
        if isNegative {
           chars.removeFirst()
        }
        
        var sum: Int = 0
        for char in chars {
            if let num = char.wholeNumberValue {
                sum = sum*10 + num
            }
        }
        
        if isNegative {
            sum = -sum
        }
        return sum
    }

    func baseAPI() {
        _ = "ab,cd,e".split(separator: ",")
        let nums: [String] = ["a", "b", "c", "d"]
        _ = nums.joined()
        _ = nums.joined(separator: "-")
    }
    
    /// 第一个不相同的字符,  左右指针夹逼
    func findfirstDisr2(str: String) -> Character? {
        for char in str {
            let start = str.firstIndex(of: char)
            let end = str.lastIndex(of: char)
            if let start = start, let end = end {
                if start == end {
                    return char
                }
            }
        }
        
        return "1"
    }
    
    //3. 无重复字符的最长子串
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var charArr: [Character] = []
        var maxlength: Int = 0
        
        for c in s {
            if charArr.contains(c) {
                charArr.removeAll()
            }
            charArr.append(c)
            if charArr.count > maxlength {
                maxlength = charArr.count
            }
        }
        
        return maxlength;
    }
    
    /// 爬梯子
    func climbStairs(_ n: Int) -> Int {
        if n <= 2 {
            return n
        }
        
        var f: [Int] = []
        f[0] = 0
        f[1] = 1
        f[2] = 2
        
        for i in 3...n {
            f[i] = f[i - 1] + f[i - 2]
        }
        return f[n]
    }
    
    
    /// 反转字符串,  左右指针
    /// - Parameter s: <#s description#>
    /// - Returns: <#description#>
    func reverseString(s: String) -> String {
        var i = 0
        var j = s.count - 1
        
        var chars: [Character] = Array(s)
        while i < j {
            let tmp = chars[j]
            chars[j] = chars[i]
            chars[i] = tmp
            i += 1
            j -= 1
        }
        
        let resust = String(chars)
        return resust
    }
    
    // 字符串压缩  ["a","a","b","b","c","c","c"] -> [a2b2c3]
    func compress(_ chars: inout [Character]) -> Int {
        var res = [Any]()

        var i = 0
        while i < chars.count {
            var j = i + 1
            var count = 0
            while j < chars.count && chars[j] == chars[i] {
                j += 1
                count += 1
            }
            
            if count > 0 {
                res.append(chars[i])
                res.append(count)
            } else {
                res.append(chars[i])
            }
            
            i = j // 往前走
        }
        
        print("res = \(res)")
        return res.count
    }
    
    
    /// 最长回文子串    
    func longestPalindrome(_ s: String) -> String {
       // 中心扩展法
       let cArray = Array(s)
       var center = [0, 0]
       var maxLen = 1
       for i in 0..<(cArray.count - 1) {
           let len1 = maxLength(of:cArray, fromCenter:[i, i])
           let len2 = maxLength(of:cArray, fromCenter:[i, i + 1])
           if len1 > maxLen { maxLen = len1; center = [i, i] }
           if len2 > maxLen { maxLen = len2; center = [i, i + 1] }
       }
       return String(cArray[(center[0] - (maxLen - 1)/2)...(center[1] + (maxLen - 1)/2)])
    }

   func maxLength(of str:[Character], fromCenter center:[Int]) -> Int {
       var left = center[0]
       var right = center[1]
       while left >= 0 && right < str.count && str[left] == str[right] {
           left -= 1; right += 1
       }
       return right - left - 1
   }
    
    
    ///【双指针】回文串问题
    func isPalindrome(_ s: String) -> Bool {
        var left = 0, right = s.count - 1;
        let ss = s.lowercased()
        while (left < right){
            let l = Array(ss)[left]
            let r = Array(ss)[left]
            if (l != r) {
                return false
            } else {
                left += 1
                right -= 1
            }
        }
        return true
    }
    
}

extension LCStringController {
    ///字符串相加
    func addStrings(_ num1: String, _ num2: String) -> String {
        var i: Int = num1.count - 1
        var j: Int = num2.count - 1
        var carry: Int = 0
        let zero: Character = "0"
        var res = ""
        
        var characters1 = Array(num1)
        var characters2 = Array(num2)
        while i >= 0 || j >= 0 {
            let m = i >= 0 ? characters1[i].asciiValue! - zero.asciiValue! : 0
            let n = j >= 0 ? characters2[j].asciiValue! - zero.asciiValue! : 0
            
            let sum = Int(m) + Int(n) + carry
            carry = sum / 10
            res = String(sum % 10) + res
            
            i -= 1
            j -= 1
        }
        
        if carry == 1 {
            res = "1" + res
        }
        return res
        
    }
}

// 对比两个版本号大小
extension String {
    /**
     1、首先把两个版本号按句点（ . ）拆分成数组
     2、对比两个版本号的长度是否一致，如果一致，则利用 compare 函数直接对比
     3、如果不一致，则把较短的版本号后面补 0
     4、最后再用 compare 函数进行对比*/
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        var v1 = versionComponents()
        var v2 = otherVersion.split(separator: ".")
        let diff = v1.count - v2.count
       
        
        if diff == 0 {
            return self.compare(otherVersion, options: .numeric)
        }
        
        if diff > 0 {
            v2.append(contentsOf: (0..<diff).map { _ in "0" })
        } else {
            v1.append(contentsOf: (0..<abs(diff)).map { _ in "0" })
        }
        
        return v1.joined().compare(v2.joined())
    }
    
    func versionComponents() -> [String] {
        components(separatedBy: ".")
    }
}

// 检查字符串是否可以转换为 Int 或 Double:
extension String  {
    var isnumberordouble: Bool { return Int(self) != nil || Double(self) != nil }
    
    func usefulAPI() {
        // 判断char是否是数字
        // "c".isWholeNumber
    }
}

