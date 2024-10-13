//
//  LCSortController.swift
//  HelloSwift
//
//  Created by gtc on 2021/11/24.
//

import UIKit

class LCSortController: TCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var arr = [2, 12, 3, 5, 1, 18, 13]
        
        // 常用数组api
        arr.firstIndex(of: 12)
        arr.firstIndex { $0 == 13 }
        let lastIdx = arr.lastIndex(of: 18)
        arr.remove(at: 1) // 移除索引对应的值
        arr.removeFirst()
        arr.removeLast()
        arr.insert(10, at: 0)
        
        let sorted = bubbleSort(arr)
        self.jinyingTongSort()
    }
    
    /// 冒泡排序
    func bubbleSort(_ nums: [Int]) -> [Int] {
        var new_nums = nums
        for i in 0..<new_nums.count {
            for j in i+1..<nums.count {
                if new_nums[i] > new_nums[j] {
                    new_nums.swapAt(i, j)
                }
            }
        }
        return new_nums
    }
    
    
    func sortArray(_ nums: [Int]) -> [Int] {
        guard nums.count > 0 else {
            return []
        }
        
        var sortNums = nums
        quickSort(&sortNums, 0, nums.count-1)
        return sortNums
    }
    
    
    /// 快排
    /// - Parameters:
    ///   - nums: <#nums description#>
    ///   - left: <#left description#>
    ///   - right: <#right description#>
    func quickSort(_ nums: inout [Int], _ left: Int, _ right: Int) {
        guard left < right else {
            return
        }
        
        let p = partition(&nums,left,right)
        quickSort(&nums, left, p-1)
        quickSort(&nums, p+1, right)
    }
    
    func partition(_ nums: inout [Int], _ left: Int, _ right: Int) -> Int {
        let key = nums[left]
        var i = left
        var j = right
        
        while i != j {
            while i < j && nums[j] >= key {
                j -= 1
            }
            while i < j && nums[i] <= key {
                i += 1
            }
            
            if i < j {
                nums.swapAt(i,j)
            }
        }
        
        nums[left] = nums[i]
        nums[i] = key
        return i
    }
    
    
    /// 金牌排序
    func jinyingTongSort() {
        struct Student {
            var name: String
            var gold: Int
            var yin: Int
            var tong: Int
        }
        
        let stu = Student(name: "xiao1", gold: 12, yin: 10, tong: 2)
        let stu2 = Student(name: "xiao1", gold: 16, yin: 10, tong: 2)
        let stu3 = Student(name: "xiao1", gold: 16, yin: 10, tong: 3)
        let stu4 = Student(name: "xiao1", gold: 12, yin: 10, tong: 4)
        let stu5 = Student(name: "xiao1", gold: 8, yin: 10, tong: 2)
        let stu6 = Student(name: "xiao1", gold: 8, yin: 9, tong: 2)
        
        var students = [stu, stu2, stu3, stu4, stu5, stu6]
        
        // 原始的方法: 使用冒泡排序
        var new_nums: [Student] = students
        for i in 0..<new_nums.count {
            for j in i+1..<new_nums.count {
                if new_nums[i].gold < new_nums[j].gold {
                    new_nums.swapAt(i, j)
                } else if new_nums[i].gold == new_nums[j].gold, new_nums[i].yin < new_nums[j].yin {
                    new_nums.swapAt(i, j)
                } else if new_nums[i].gold == new_nums[j].gold, new_nums[i].yin == new_nums[j].yin, new_nums[i].tong < new_nums[j].tong {
                    new_nums.swapAt(i, j)
                }
            }
        }
        
        // 系统的方法
        let country = students.sorted { s1, s2 in
            if s1.gold != s2.gold {
                return s1.gold > s2.gold
            } else if s1.yin != s2.yin {
                return s1.yin > s2.yin
            }
            return s1.tong > s2.tong
        }
        
        print(new_nums)
    }
}
