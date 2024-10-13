//
//  LCArrayController.swift
//  HelloSwift
//
//  Created by gtc on 2021/10/8.
//

import Foundation
import UIKit
import RxSwift

class LCArrayController: TCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        var arr = [1, 2]
        var arr2 = [1]
        var arr3 = [1, 2, 3, 5, 6, 7]

        var res = converArray(nums: arr3)
        print(res)
        
        
//        // 取区域的字段信息
////        var newNums = nums[1..<4]
////        var newNums2 = nums[1...4]
////        print(newNums)
//        var duplicates = [5,7,7,8,8,10]
//        var dd = [1,1,2]
//        var len: Int = removeDuplicates(nums: dd)
//        var arr = duplicates[0...len-1]
        
    }
    
    func converArray(nums: [Int]) -> [String] {
        var res = [String]()
        if nums.count == 0 {
            return res
        }
        if nums.count == 1 {
            res.append(String(nums[0]))
            return res
        }
        
        var count = nums.count - 1
        var i = 0
        
        while i <= count {
            var start = i
            var val = nums[i]
            var j = i + 1
            while j <= count && nums[j] == (val + 1) {
                val = nums[j]
                j += 1
            }
            
            
            if (j - i) >= 2 {
                var str = String(nums[i]) + "->" + String(nums[j-1])
                res.append(str)
            } else {
                res.append(String(nums[i]))
            }
            
            i = j
        }
        
        return res
    }
    
    /// 两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map: [Int:Int] = [:]
        for (i, n) in nums.enumerated() {
            if let index = map[target - n] {
                return [index, i]
            }
            map[n] = i
        }
        return []
    }
    
    
    //首先复习一下有序数组的二分查找：【基本二分查找】
    func binarySearch(nums: [Int], target: Int) -> Int {
        var low = 0
        var high = nums.count - 1
        
        // 这里必须是 <=
        while low <= high {
            let mid = low + (high - low)/2
            if nums[mid] == target {
                return mid
            }
            
            if nums[mid] < target {
                low = mid + 1
            } else if nums[mid] > target {
                high = mid - 1
            }
        }
        
        return -1
    }
    
    //二、寻找左侧边界的二分搜索
    func leftbound_binarySearch(nums:[Int], target: Int) -> Int {
        var left = 0
        var right = nums.count //注意
        while left < right { //注意
            let mid = left + (right - left)/2
            if nums[mid] == target {
                right = mid  // [left, right)
            } else if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid //注意
            }
        }
        return left
        
    }

    func rightbound_binarySearch(nums:[Int], target: Int) -> Int {
        var left = 0
        var right = nums.count //注意
        
        // while 循环的终止条件是 left == right
        while left < right { //注意
            let mid = left + (right - left)/2
            if nums[mid] == target {
                left = mid + 1  // [left, right)
            } else if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid //注意
            }
        }
        return left - 1
    }
    
    /* 旋转排序数组中找目标值
     方法三：先根据 nums[mid] 与 nums[lo] 的关系判断 mid 是在左段还是右段，接下来再判断 target 是在 mid 的左边还是右边，从而来调整左右边界 lo 和 hi。
     */
    func search(_ arr: [Int], _ target: Int) -> Int {
        var lo = 0
        var hi = arr.count - 1
        
        while lo <= hi {
            let mid = lo + (hi - lo)/2
            if target == arr[mid] {
                return mid
            }
            
            if arr[lo] <= arr[mid] {
                if arr[lo] <= target && target < arr[mid] {
                    hi = mid - 1
                } else {
                    lo = mid + 1
                }
            } else { // arr[left] > arr[mid], 所以下面是 ||
                if arr[lo] < target || target <= arr[hi] {
                    lo = mid + 1
                } else {
                    hi = mid - 1
                }
            }
        }
        
        return -1
    }
    
    // 寻找旋转排序数组中的最小值 II
    func findMin(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            let mid = left + (right - left)/2
            if nums[mid] < nums[right] {
                right = mid
            } else if nums[mid] > nums[right] {
                left = mid + 1
            } else {
                right -= 1
            }
        }
        
        return nums[left]
    }
    
    
    ///  在排序数组中查找元素的第一个和最后一个位置
    /// - Parameters:
    ///   - nums: <#nums description#>
    ///   - target: <#target description#>
    /// - Returns: <#description#>
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = nums.count - 1
        //! 先二分 找到 最左边的元素：向下取整
        while left < right {
            let mid = (left + right - 1) / 2
            if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            } else {
                right = mid
            }
        }
        
        if left >= nums.count || nums[left] != target {
            return [-1,-1]
        }
        
        //！ 保存 元素
        let firstIndex = left
        
        //! 再二分找到最右边的元素:向上取整
        right = nums.count - 1
        while left < right {
            let mid = (left + right + 1) / 2
            if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            } else {
                left = mid
            }
        }
        return [firstIndex, left]
    }
    
    
    /*给定一个包含 n + 1 个整数的数组 nums ，其数字都在 1 到 n 之间（包括 1 和 n），可知至少存在一个重复的整数。
     假设 nums 只有 一个重复的整数 ，找出 这个重复的数 。
   */
    func findDuplicate(_ nums: [Int]) -> Int {
        var arr = [Int](repeating: 0, count: nums.count)
        
        for num in nums {
            if arr[num] != 0 {
                return num
            }
            
            arr[num] = 1
        }
        
        return -1
    }
    
    // 287. 寻找重复数,设计的解决方案必须不修改数组 nums 且只用常量级 O(1) 的额外空间。
    func findDuplicate2(_ nums: [Int]) -> Int {
        var slow = 0
        var fast = nums.count - 1
        while slow != fast {
            slow = nums[slow]
            fast = nums[nums[fast]]
        }
        
        slow = 0
        while slow != fast {
            slow = nums[slow]
            fast = nums[fast]
        }
        return slow
    }
    
    
    func countBits(_ num: Int) -> [Int] {
        var res = [Int](repeating: 0, count: num + 1)
        for i in 0...num {
            res[i] = countOnes(i)
        }
        return res
    }
    private func countOnes(_ x: Int) -> Int {
        var ones = 0, vx = x
        while vx > 0 {
            vx &= (vx - 1)
            ones += 1
        }
        return ones
    }
    
    //448. 找到所有数组中消失的数字
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var arr = [Int](repeating: 0, count: nums.count+1)
        var res = [Int]()
        for num in nums {
            arr[num] = 1
        }
        
        for i in 1..<arr.count {
            if arr[i] == 0 {
                res.append(i)
            }
        }
        return res
    }
    
    // 两个有序数组找中位数
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var mergearr = nums1 + nums2
        
        mergearr.sort()
        if mergearr.count % 2 == 0 {
            return Double(mergearr[mergearr.count/2 - 1] + mergearr[mergearr.count/2])/2.0
        } else {
            return Double(mergearr[mergearr.count/2])
        }
    }
    
    
    //MARK: ---
    // 215. 数组中的第K个最大元素 , 方案1. 快排,
    // 你必须设计并实现时间复杂度为 O(n) 的算法解决此问题。
    func findKthLargest1(_ nums: [Int], _ k: Int) -> Int {
        return nums.sorted { (a, b) ->Bool in
            return (a > b)
        }[k - 1]
        
        return nums.sorted { return $0 > $1 }[k - 1]
    }
    func findKthLargest2(_ nums: [Int], _ k: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return nums.first!
        }
        var left  = [Int]()
        var right = [Int]()
        let s = nums.first!
        
        for num in nums {
            if num < s {
                left.append(num)
            } else {
                right.append(num)
            }
        }
        
        if right.count == k - 1 {
            return s
        } else if right.count >= k {
            return findKthLargest2(right, k)
        } else {
            return findKthLargest2(left, k - right.count)
        }
    }
    
    // 买卖股票的最佳时机
    func maxProfit(_ prices: [Int]) -> Int {
        // 记录历史最低点和基于历史最点低的最大利润
        var minPrice = Int.max
        var maxProfit = 0
        for price in prices {
            if price < minPrice {
                minPrice = price
            } else if (price - minPrice) > maxProfit {
                maxProfit = price - minPrice
            }
        }
        return maxProfit
    }
    
    //  删除有序数组中的重复项, 返回数组长度: 原地删除
    func removeDuplicates(nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        // 快慢指针
        var i = 0 // i是慢指针,
        var j = 1 // j是快指针
        var newNums = nums
        while j < nums.count {
            if newNums[j] != newNums[i] {
                i += 1
                newNums[i] = newNums[j]
            }
        }
       
        return i + 1
    }
    
    // 删除有序数组中的重复项II 每个元素最多出现两次
    func removeDuplicatesII(nums: [Int]) -> Int {
        var n = nums.count
        if n <= 2 {
            return n
        }
        
        var mNums = nums
        var slow = 2, fast = 2 //数组的前两个数必然可以被保留
        while fast < n {
            //检查上上个应该被保留的元素nums[slow−2]是否和当前待检查元素nums[fast]相同
            if mNums[slow - 2] != mNums[fast] {
                mNums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
            
        }
        return slow
    }
}

extension LCArrayController {
    func maxSubArray(_ nums: [Int]) -> Int {
        var sum = 0
        var maxval: Int = nums[0] // 记录每次最大值
        for num in nums {
            if sum > 0 {
               sum += num
            } else {
                sum = num
            }
            
            maxval = max(maxval, sum)
            maxval = max(maxval, sum)
        }
        return maxval
    }
    
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        for i in 0..<intervals.count {
            for j in (i+1)..<intervals.count {
                
            }
        }
        
        return []
    }
    
    func mergeHeaper(nums1: [Int], nums2: [Int]) -> [Int] {
        var min:Int = min(nums1[0], nums2[0])
        var max:Int = max(nums1[1], nums2[1])
        
        return [min, max]
    }
    
    /**
     给你一个未排序的整数数组 nums ，请你找出其中没有出现的最小的正整数。
     请你实现时间复杂度为 O(n) 并且只使用常数级别额外空间的解决方案。
     */
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var max = Int.min
        var min = Int.max
        
        for num in nums {
            if num < min {
                min = num
            }
            if num > max {
                max = num
            }
        }
        
        var newNums = [Int](repeating: -1, count: max+1)
        
        for num in nums {
            newNums[num] = 1
        }
        
        let resa: [Int] = Array(newNums[min...max])
        for (idx, num) in resa.enumerated() {
            if num == -1 {
                return idx
            }
        }
        return -1
    }
    
    //442. 数组中重复的数据
    /**
     给定一个整数数组 a，其中1 ≤ a[i] ≤ n （n为数组长度）, 其中有些元素出现两次而其他元素出现一次。
     找到所有出现两次的元素。
     你可以不用到任何额外空间并在O(n)时间复杂度内解决这个问题吗？
     */
    // 思路：根据数值找指定索引。如果当前索引的值>0则变负。如果<0则证明出现过
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var newNums = nums
        var res = [Int]()
        for num in newNums {
            let idx: Int = abs(num) - 1
            if newNums[idx] > 0 {
                newNums[idx] = -newNums[idx]
            } else {
                res.append(idx + 1)
            }
        }
        return res
    }
    
    // 交换一次，变成最大数,  23489
    func maximumSwap(_ num: Int) -> Int {
        var res = num
        var numsa = [Int]()
        while res != 0 {
            numsa.append(res % 10)
        }
        
        var nums:[Int] = numsa.reversed()
        var count = nums.count - 1
        var i = 0;
        while i < count {
            var j = count
            var maxval: Int = 0
            var start = 0
            var end  = 0
            while j > i {
                if Int(nums[j] - nums[i]) > maxval {
                    start = i
                    end = j
                    maxval = nums[j] - nums[i]
                }
                j -= 1
            }
            if maxval > 0 {
                nums.swapAt(start, end)
                break
            }
        }
        
        var sum = 0
        for num in nums {
            sum = sum * 10 + num
        }
        return sum
    }
    
    // C++解答
    /**
     class Solution {
     public:
         int maximumSwap(int num) {
             string charArray = to_string(num);
             int n = charArray.size();
             int maxIdx = n - 1;
             int idx1 = -1, idx2 = -1;
             for (int i = n - 1; i >= 0; i--) {
                 if (charArray[i] > charArray[maxIdx]) {
                     maxIdx = i;
                 } else if (charArray[i] < charArray[maxIdx]) {
                     idx1 = i;
                     idx2 = maxIdx;
                 }
             }
             if (idx1 >= 0) {
                 swap(charArray[idx1], charArray[idx2]);
                 return stoi(charArray);
             } else {
                 return num;
             }
         }
     };

     */
    
    //给你一个整型数组 nums ，在数组中找出由三个数组成的最大乘积，并输出这个乘积。
    func maximumProduct(_ nums: [Int]) -> Int {
        let newNums = nums.sorted()
        let count = nums.count
        var maxVal = newNums[count-1] * newNums[count-2] * newNums[count-3]
        
        if newNums[0] < 0 && nums[1] < 0 {
            maxVal = max(maxVal, newNums[0] * newNums[1] * newNums[2])
        }
        return maxVal
    }
    
    
   /* 给定一个按照升序排列的整数数组 nums 和一个目标值 target，找出给定目标值在数组中的开始位置和结束位置。如果 target 不在数组中，返回 [-1,-1]*/
    func searchRange(nums: [Int], target: Int) -> [Int] {
        if nums.count == 0 || nums[0] > target {
            return [-1, -1]
        }
        
        func leftMargin(nums: [Int], target: Int) -> Int {
            var low = 0
            var high = nums.count - 1
            while low <= high {
                let mid = low + (high - low)/2
                if nums[mid] < target {
                    low = mid + 1
                } else if nums[mid] > target {
                    high = mid - 1
                } else if nums[mid] == target {
                    high = mid - 1
                }
            }
            if nums[low] == target {
                return low
            } else {
                return -1
            }
        }
        
        func rightMargin(nums: [Int], target: Int) -> Int {
            var low = 0
            var high = nums.count - 1
            while low <= high {
                let mid = low + (high - low)/2
                if nums[mid] < target {
                    low = mid + 1
                } else if nums[mid] > target {
                    high = mid - 1
                } else if nums[mid] == target {
                    low = mid + 1
                }
            }
            
            if nums[high] == target{
                return high
            }
            return -1;
        }
        
        let left = leftMargin(nums: nums, target: target)
        let rigt = rightMargin(nums: nums, target: target)
        return [left, rigt]
    }
    
}

extension LCArrayController {
    func quickSort(_ list : inout [[Int]], start : Int , end : Int) {
        var i = start
        var j = end
        
        while i < j {
            let sentinel = list[i]
            
            while i != j {
                while i < j && list[j].first! >= sentinel.first! {
                    j -= 1
                }
                list[i] = list[j]
                
                while i < j && list[i].first! <= sentinel.first! {
                    i += 1
                }
                list[j] = list[i]
            }
            
            list[i] = sentinel
            
            quickSort(&list, start: start ,end : j - 1)
            quickSort(&list, start: i + 1, end : end)
        }
        
    }
}
