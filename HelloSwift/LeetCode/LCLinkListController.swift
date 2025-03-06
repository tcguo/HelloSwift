//
//  LCLinkListController.swift
//  HelloSwift
//
//  Created by gtc on 2021/7/22.
//

import UIKit

/// 链表
class LCLinkListController: TCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        var head = createList(nums: [1, 2, 3, 4, 5])
        printList(head: head)
        
        let result = ListManager.removeNthFromEnd(head, 2)
        printList(head: result)
        print("-------")

        
        var nehead = reverseList(head: head, m: 2, n: 4)
        printList(head: nehead)
        
        var head2 = createList(nums: [1,1])
        var reddd = deleteDuplicates(head2)
    }
    
    func createList(nums: [Int]) -> ListNode? {
        var head: ListNode?
        var preNode: ListNode?
        for num in nums {
            if head == nil {
                head = ListNode(val: num, next: nil)
                preNode = head
            } else {
                preNode?.next = ListNode(val: num, next: nil)
                preNode = preNode?.next
            }
        }
        
        return head
    }
    func printList(head: ListNode?) {
        var p: ListNode? = head
        while p != nil {
            print(p?.val)
            p = p?.next
        }
    }
    
    func reverseList2(head: ListNode?) -> ListNode? {
        guard let head else { return head }
        
        var preNode: ListNode?
        var currNode: ListNode? = head
        while currNode != nil {
            let tmp = currNode?.next
            currNode?.next = preNode
            preNode = currNode
            currNode = tmp
        }
        return preNode
    }
    
    // 反转链表
    func reverseList(head: ListNode?) -> ListNode? {
        guard let head = head else { return head }
        
        var preNode: ListNode?
        var currNode: ListNode? = head
        while currNode != nil {
            let tmp = currNode?.next
            currNode?.next = preNode
            preNode = currNode
            currNode = tmp
        }
        return preNode
    }
    
    //「反转以 a 为头结点的链表」其实就是「反转 a 到 null 之间的结点」，那么如果让你「反转 a 到 b 之间的结点」，你会不会？
    func reverse(a: ListNode?, b: ListNode?) -> ListNode? {
        var pre: ListNode?
        var crr: ListNode? = a
        while crr !== b {
            let nxt = crr?.next
            crr?.next = pre
            pre = crr
            crr = nxt
        }
        return pre
    }
    
    // K个一组翻转链表
    func reverseKGroup(_ head: ListNode? , _ k: Int) -> ListNode? {
        guard let head = head else { return head }
        
        let a: ListNode? = head
        var b: ListNode? = head
        for _ in 0..<k {
            if b == nil {
                return head
            }
            
            b = b?.next
        }
        
        let newHead = reverse(a: a, b: b)
        a?.next = reverseKGroup(b, k)
        return newHead
    }
    
    func reverseKGroup2(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let head = head else { return nil }
        
        var a: ListNode? = head
        var b: ListNode? = head
        for _ in 0..<k {
            if b == nil {
                return head
            }
            b = b?.next
        }
        var newHead = reverse(a: a, b: b)
        a?.next = reverseKGroup2(b, k)
        return newHead
    }
    
    // 反转区间链表
    func reverseList(head: ListNode?, m: Int, n: Int) -> ListNode? {
        let dummyNode = ListNode(val: -1)
        dummyNode.next = head
        
        var preNode: ListNode? = dummyNode
        for _ in 0..<m {
            preNode = preNode?.next
        }
        
        var nNode: ListNode? = dummyNode
        for _ in 0..<n {
            nNode = nNode?.next
        }
    
        let leftNode = preNode?.next
        let curr = nNode?.next
        
        preNode?.next = nil
        nNode?.next = nil
        
        
        let retHead = reverseList(head: leftNode)
        preNode?.next = retHead
        leftNode?.next = curr // leftnode 反转之后变成尾节点了
        return dummyNode.next
    }
    
    
    // 给你一个链表的头节点 head ，判断链表中是否有环。
    func hasCycle(head: ListNode?) -> Bool {
        guard let head = head else { return false }
        
        var fast: ListNode? = head
        var slow: ListNode? = head
        
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            
            if fast === slow {
                return true
            }
        }
        return false
    }
    
    //给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            if fast === slow {
                break
            }
        }
        if fast == nil || fast?.next == nil {
            return nil
        }
        
        fast = head
        while fast !== slow {
            fast = fast?.next
            slow = slow?.next
        }
        return fast
    }
    
    // 合并两个有序链表 -- 递归
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard let list1 = list1 else {
            return list2
        }
        guard let list2 = list2 else {
            return list1
        }
        
        if list1.val < list2.val {
            list1.next = mergeTwoLists(list1.next, list2)
            return list1
        } else {
            list2.next = mergeTwoLists(list1, list2.next)
            return list2
        }
    }
    
    // 合并两个有序链表 -- 迭代
    func mergetTwoLists2(list1: ListNode?, list2: ListNode?) -> ListNode? {
        if list1 == nil {
            return list2
        }
        if list2 == nil {
            return list1
        }
        
        var p = list1
        var q = list2
        
        let newHead = ListNode(val: -1)
        var curr: ListNode? = newHead
        while p != nil && q != nil {
            if p!.val < q!.val {
                curr?.next = p
                p = p?.next
            } else {
                curr?.next = q
                q = q?.next
            }
            
            curr = curr?.next
        }
        
        curr?.next = list1 == nil ? list2 : list1
        
        return newHead.next
    }
    
    // 合并k个排序链表
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        let r = lists.count - 1
        return mergeKLists_helper(lists, 0, r)
    }
    
    func mergeKLists_helper(_ lists: [ListNode?], _ l: Int, _ r: Int) -> ListNode? {
        if l == r {
            return lists[l]
        }
        if l > r {
            return nil
        }
        
        let mid = l + (r - l)/2
        return mergeTwoLists(mergeKLists_helper(lists, l, mid), mergeKLists_helper(lists, mid+1, r))
    }
    
    
    // 给你链表的头结点 head ，请将其按 升序 排列并返回 排序后的链表 。
    func sortList(_ head: ListNode?) -> ListNode? {
        
        
        return nil
    }
    
    // 147. 对链表进行插入排序
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        if head == nil && head?.next == nil {
            return head
        }
        
        let newHead = ListNode(val: -1)
        newHead.next = head
        
        var slowNode = head
        var currNode = head?.next
        
        while currNode != nil {
            if currNode!.val >= slowNode!.val {
                currNode = currNode?.next
                slowNode = slowNode?.next
                continue
            }
            
            var tmpNode: ListNode? = newHead
            while (tmpNode?.next!.val)! <= currNode!.val {
                tmpNode = tmpNode?.next
            }
            
            slowNode?.next = currNode?.next
            currNode?.next = tmpNode?.next
            tmpNode?.next =  currNode
            currNode = slowNode?.next
        }
        return newHead.next
    }
    
    
    /*
     234. 回文链表
     第一步，找出中间结点，（此时，如果链表是奇数，则slow停在中心，如果链表是偶数，则停在左中心）
     将后续结点入栈
     从头开始遍历，进行比较。*/
    func isPalindrome(_ head: ListNode?) -> Bool {
        var fast = head
        var slow = head
        while fast?.next != nil && fast?.next?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        //！ 跳到右半区
        slow = slow?.next
        
        var stack = [ListNode]()
        while slow != nil {
            stack.append(slow!)
            slow = slow?.next
        }
        
        slow = head
        while !stack.isEmpty {
            if slow?.val != stack.popLast()!.val {
                return false
            }
            slow = slow?.next
        }
        return true
    }
    
    // 删除倒数第n个节点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummyHead = ListNode(val: -1)
        dummyHead.next = head
        var fast = dummyHead
        var slow = dummyHead
        
        for _ in 0..<n {
            fast = fast.next!
        }
        
        // fast.next不等于ni， fast刚好落在最后一个节点上，
        // 如果 条件是 fast != nil, 则fast最后是指向nil，最后一个节点的next
        while fast.next != nil {
            fast = fast.next!
            slow = slow.next!
        }
        
        slow.next = slow.next!.next
        
        return dummyHead.next
    }
    
    // 相交链表， 1. hash 2. 双指针
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil {
            return nil
        }
        
        var pA: ListNode? = headA
        var pB: ListNode? = headB
        
        while pA !== pB {
            pA = (pA == nil) ? headB : pA?.next
            pB = (pB == nil) ? headA : pB?.next
        }
        return pA
    }
    
    // 删除链表的指定值节点
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        let dummayNode = ListNode(val: -1)
        dummayNode.next = head
        
        var pre: ListNode? = dummayNode
        
        var p: ListNode? = dummayNode.next
        while p != nil {
            if let pp = p, pp.val == val {
                pre?.next = pp.next
                break
            }
            pre = p
            p = p?.next
        }

        return dummayNode.next
    }
    
    func deleteXNode_kaoshi(_ head: ListNode?, _ val: Int) -> ListNode? {
        let newHead = ListNode(val: -1)
        var pre: ListNode? = newHead
        var p: ListNode? = newHead.next
        while p != nil {
            if let pp = p, pp.val == val {
                pre?.next = pp.next
            }
            pre = p
            p = p?.next
        }
        
        return newHead.next
    }
    
    // 两个链表相加
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        var head: ListNode?
        var tail: ListNode?
        var carry = 0
        while l1 != nil || l2 != nil {
            var n1 = l1 != nil ? l1!.val : 0
            var n2 = l2 != nil ? l2!.val : 0
            
            var sum = n1 + n2 + carry
            if head == nil {
                head = ListNode(val: sum % 10)
                tail = head
            } else {
                tail = ListNode(val: sum % 10)
                tail = tail?.next
            }
            carry = sum / 10
            if l1 != nil {
                l1?.next = l1
            }
            if l2 != nil {
                l2?.next = l2
            }
        }
        
        if carry > 0 {
            tail?.next = ListNode(val: carry)
        }
        
        return head
    }
    
    func addTwoList(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        
        var head: ListNode?
        var tail: ListNode?
        var carry: Int = 0
        var p1 = l1
        var p2 = l2
        while p1 != nil || p2 != nil {

            let n1 = p1 != nil ? p1!.val : 0
            let n2 = p2 != nil ? p2!.val : 0
            let sum = n1 + n2 + carry
            if head == nil {
                head = ListNode(val: sum % 10)
                tail = head
            } else {
                tail = ListNode(val: sum % 10)
                tail = tail?.next
            }
            carry = carry/10
            
            if p1 != nil {
                p1 = p1?.next
            }
            
            if p2 != nil {
                p2 = p2?.next
            }
        }
        
        
        if carry > 0 {
            tail?.next = ListNode(val: carry)
        }
        
        return head
    }
    
    
    func testArr() {
        var arr = [Int]()
        arr.append(12)
        arr.append(13)
        arr.append(14)
        arr.append(15)
        
        for (index, num) in arr.enumerated() {
            print("num=\(num), index=\(index)")
        }
        
        if arr.contains(14) {
            
        }
        
        arr.removeLast()
        arr.removeFirst()
        
        arr.insert(25, at: 0)
        
        // reduce
        let res = arr.reduce(0) { partialResult, n in
            return partialResult + n
        }
        
        let res2 = arr.reduce(0) { $0 + $1 }
        
        // map
        let res4 =  arr.map { a in
            return a + 10
        }
        
        // filter
        let res5 = arr.filter { n -> Bool in
            return n % 2 == 0
        }
        
        print(res)
        
    }
    
    func testDict() {
        var dict: [String: String] = [String: String]()
        var dict2 = [Int: String]()
        dict2[1] = "1"
        dict2[2] = "2"
        dict2[3] = "3"
        
        for (key, val) in dict2 {
            print("key=\(key),value=\(val)")
        }
        
        print("----------")
        
        if let num3 = dict2[3] {
            print("num3 exists = \(num3)")
        } else {
            print("num3 not exists")
        }
        
        if dict2[1] != nil {
            
        }
        
        
        dict2.removeValue(forKey: 1)
        dict2.removeAll()
        dict["name"] = "jjjj"
        


    }
    
}

extension LCLinkListController {
    // 删除排序链表中的重复元素 II, 输入：head = [1,2,3,3,4,4,5] 输出：[1,2,5] -- 自己的思路
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var dummyNode = ListNode(val: -1)
        dummyNode.next = head
        var p = dummyNode.next
        var curr: ListNode? = dummyNode
        
        while p != nil {
            var val = p?.val
            var hasSame = false
            while p?.next != nil && p?.next?.val == val {
                hasSame = true
                p = p?.next
            }
            
            if !hasSame {
                curr?.next = p
                curr = curr?.next
            } else {
                curr?.next = nil
            }
            
            p = p?.next
        }
        return dummyNode.next
    }
    
    // 删除排序链表中的重复元素 II - 别人的答案
    func deleteDuplicates2(_ head: ListNode?) -> ListNode? {
        var dum: ListNode = ListNode(val: 0, next: nil)
        // 这个的作用就是因为链接有可能头结点也需要删除，所以需要一个临时节点指向0的节点
        dum.next = head  // 将临时节点0 的next 指向head
        var cur = dum
        while (cur.next != nil && cur.next?.next != nil) {
            if cur.next!.val == cur.next!.next!.val {
                let x = cur.next?.val
                while (cur.next != nil && cur.next?.val == x) { // 循环遍历删除重复的节点
                    cur.next = cur.next?.next
                }
            } else {
                cur = cur.next!
            }
            
        }
        return dum.next
    }
    
    //  删除排序链表中的重复元素 II - 书上的
    func deleteDuplicates3(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
           return nil
        }
        var slow = head
        var fast = head.next
        while fast != nil {
           if fast!.val != slow.val {
               slow.next = fast
               slow = slow.next!
           }
           fast = fast!.next
        }
        
        slow.next = nil
        return head
    }
}


