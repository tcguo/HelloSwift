//
//  ListManager.swift
//  HelloSwift
//
//  Created by gtc on 2023/8/13.
//

import Foundation

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(val: Int) { self.val = val; self.next = nil; }
     public init(val: Int, next: ListNode?) { self.val = val; self.next = next; }
}

struct ListManager {
    // 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
    static func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        // 可以防止头节点被删除, 创建一个虚拟头节点简化操作
        let dummyHead = ListNode(val: -1)
        dummyHead.next = head
        
        var p: ListNode? = dummyHead
        var q: ListNode? = dummyHead
        
        for _ in 0..<n {
            q = q?.next
        }
        
        while q?.next != nil {
            p = p?.next
            q = q?.next
        }
        
        p?.next = p?.next?.next
        return head
    }
}
