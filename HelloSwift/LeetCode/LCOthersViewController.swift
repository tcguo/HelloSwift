//
//  LCOthersViewController.swift
//  HelloSwift
//
//  Created by gtc on 2021/10/8.
//

import UIKit

class LCOthersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        var nums = [12, 23, 34, 34, 4, 5, 22, 49]
        quickSort(nums: &nums)
        
    }
    
    // MARK: -
    // 找出查找两个子视图的共同父视图
    func findCommonSuperView(view1: UIView, view2: UIView) -> [UIView] {

        let firstSuperViews = findAllSuperView(view1)
        let secSuperViews = findAllSuperView(view2)
        
        var i = 0
        var results: [UIView] = []
        while i < min(firstSuperViews.count, secSuperViews.count) {
            let sup1 = firstSuperViews[firstSuperViews.count - i - 1]
            let sup2 = secSuperViews[secSuperViews.count - i - 1]
            if sup1 == sup2 {
                results.append(sup1)
                i += 1
            } else {
                break
            }
        }
        
        return results
    }
    
    private func findAllSuperView(_ view: UIView) -> [UIView] {
        var tem = view.superview
        var arr: [UIView] = []
        while tem != nil {
            if let superview = tem {
                arr.append(superview)
                tem = superview
            }
        }
        
        return arr
    }
    
    // MARK: -
    func isValid(s: String) -> Bool {
        if s.isEmpty {
            return false
        }
        
        let map = [ "}": "{", "]": "[", ")": "(" ]
        var stack: [String] = []
        
        for ss in s {
            let key = String(ss)
            if key == "{" || key == "[" || key == "(" {
                stack.append(key)
            } else if !stack.isEmpty && map[key] == stack.last {
                stack.removeLast()
            } else {
                return false
            }
            
        }
        return stack.isEmpty
    }
    
    // 数组中最大子数组和
    func maxTotalInArr(nums: [Int]) -> Int {
        var sum = 0
        var maxVal = nums[0]
        
        for num in  nums {
            if sum > 0 {
                sum += num
            } else {
                sum = num
            }
            maxVal = max(sum, maxVal)
        }
        return maxVal
    }
    
    // 快排
    func quickSort(nums: inout [Int]) {
        let length = nums.count - 1
        quickSort(nums: &nums, left: 0, right: length)
        print(nums)
    }
    
    func quickSort(nums: inout [Int], left: Int, right: Int) {
        if left < right {
            let middle = partition(nums: &nums, left: left, right: right)
            quickSort(nums: &nums, left: left, right: middle-1)
            quickSort(nums: &nums, left: middle+1, right: right)
        }
    }
    
    func partition(nums: inout [Int], left: Int, right: Int) -> Int {
        var i = left
        var j = right
        let key = nums[i]
        
        while i < j {
            while i < j && nums[j] >= key {
                j -= 1
            }
            nums[i] = nums[j]
            while i < j && nums[i] <= key {
                i += 1
            }
            nums[j] = nums[i]
        }
        
        nums[i] = key
        return i
    }
    
    
    // 136. 只出现一次的数字，其他数字出现2次. 思路：异或
    func permute(_ nums: [Int]) -> [[Int]] {
        var num = 0
        for n in nums {
            num = num^n
        }
        return []
    }
    
    //69. X的平方根 Sqrt(x)
    func mySqrt(_ x: Int) -> Int {
        var l = 0
        var h = x
        var res = 0

        while l <= h {
            let mid = l + (x - l)/2
            if Int64(mid*mid) <= x {
                l = mid + 1
                res = l
            } else {
                h = mid - 1
            }
        }
        return res
    }
    
    //7. 整数反转
    func reverse(_ x: Int) -> Int {

        var sum = 0
        var a = 0
        var num = x
        while num != 0 {
            a = num % 10
            num /= 10
            sum = sum * 10 + a
            if (Double(sum) < pow(-2, 31)) || (Double(sum) > (pow(2, 31) - 1)) {
                return 0
            }
        }
        
        return sum
    }
    
    
    // 42. 接雨水
    func trap(_ height: [Int]) -> Int {
        if height.count == 0 {
            return 0
        }
        let n = height.count
        var left = 0, right = n - 1
        var ans = 0
        var l_max = height[0]
        var r_max = height[n-1]
        
        while left <= right {
            l_max = max(l_max, height[left])
            r_max = max(r_max, height[right])
            
            // ans += min(l_max, r_max) - height[i]
            if l_max < r_max {
                ans += l_max - height[left]
                left += 1
            } else {
                ans += r_max - height[right]
                right -= 1
            }
        }
        
        return ans
    }
}


class MinStack {
    var stack = [Int]()
    var minStack = [Int]()
    init() {

    }
    
    func push(_ val: Int) {
        if !stack.isEmpty {
            stack.append(val)
            return
        }
        
        if let top = minStack.last  {
            if val < top {
                minStack.append(val)
            } else {
                let tmp = minStack.popLast()
                minStack.append(val)
                minStack.append(tmp!)
            }
        } else {
            minStack.append(val)
        }
        
        stack.append(val)
    }
    
    func pop() {
        let val = stack.popLast()
        if let valu = val {
            if let lastIndex = minStack.lastIndex(of: valu) {
                minStack.remove(at: lastIndex)
            }
        }
        
    }
    
    func top() -> Int {
        if stack.isEmpty {
            return -1
        }
        return stack.last!
    }
    
    func getMin() -> Int {
        if !minStack.isEmpty {
            return -1
        }
        return minStack.popLast()!
    }
}


class DoubleNode {
    var key: Int = 0
    var value: Int = 0
    var prenode: DoubleNode?
    var next: DoubleNode?
}

class LRUCache {
    // hash + 双向链表(自定义个DoubleLinkedList)
    var list: [Int] = []
    var capactiy = 0
    var hashMap: [Int: Int] = [:]
    
    init(_ capacity: Int) {
        self.capactiy = capacity
    }
    
    func get(_ key: Int) -> Int {
        if let firstIndex = list.firstIndex(of: key) {
            list.insert(list[firstIndex], at: 0)
            list.remove(at: firstIndex)
            return hashMap[key] ??  -1
        }
        
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        let first = list.first { $0 == key }
        if first == nil {
            if list.count + 1 == capactiy {
                // 移除最久未使用的，tail
                let lastKey = list.removeLast()
                hashMap.removeValue(forKey: lastKey)
            }
            
            // 最新的都插入到Head
            list.insert(value, at: 0)
            hashMap[key] = value
        }
    }
}


class LRUCache2 {
    var capacity: Int = 0
    var linkedList: [Int] = []
    var hashMap: [Int: Int] = [:]
    
    init() {}
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func put(_ key: Int, _ val: Int) {
        if let _ = linkedList.first { $0 == key } {
            return
        }
        
        if linkedList.count + 1 > capacity {
            let removedKey = linkedList.removeLast()
            hashMap.removeValue(forKey: removedKey)
            
            linkedList.insert(key, at: 0)
            hashMap[key] = val
        }
    }
    
    func get(_ key: Int) -> Int {
        if let firstIndex = linkedList.firstIndex(of: key) {
            linkedList.insert(linkedList[firstIndex], at: 0)
            linkedList.remove(at: firstIndex)
            return hashMap[key] ??  -1
        }
        return -1
    }
}

extension LCOthersViewController {
    //算法之约瑟夫环问题：有n个人排成一列或是一圈，从编号为k的人开始报数，数到m的那个人出列
    func josephRingMethod(n: Int, m: Int) -> Int {
        var list: [Int] = []
        for i in 1...n {
            list.append(i)
        }
        var index = m - 1;  //初始化，index指向第一个出列的人
        while list.count != 0 {
            //用 **索引 % 链表长度** 进行取余操作，避免下标越界
            index = index % list.count
            print( "\(list[index]) 号出列")
            list.remove(at: index)
            
            //返回最后剩下的人的编号
            if list.count == 1 {
                return list.first!
            }
            index += m - 1
            
        }
       
        return -1
        
    }
    
}
