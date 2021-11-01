//
//  main.swift
//  25. K 个一组翻转链表
//
//  Created by Tone on 2021/9/17.
//

import Foundation
/*
 给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。

 k 是一个正整数，它的值小于或等于链表的长度。

 如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。

 进阶：

 你可以设计一个只使用常数额外空间的算法来解决此问题吗？
 你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
  

 示例 1：


 输入：head = [1,2,3,4,5], k = 2
 输出：[2,1,4,3,5]
 示例 2：


 输入：head = [1,2,3,4,5], k = 3
 输出：[3,2,1,4,5]
 示例 3：

 输入：head = [1,2,3,4,5], k = 1
 输出：[1,2,3,4,5]
 示例 4：

 输入：head = [1], k = 1
 输出：[1]
 提示：

 列表中节点的数量在范围 sz 内
 1 <= sz <= 5000
 0 <= Node.val <= 1000
 1 <= k <= sz

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-nodes-in-k-group
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


/// 递归反转
class Solution1 {
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        let a: ListNode? = head
        var b: ListNode? = head
        for _ in 1...k {
            if b == nil {
                return head
            }
            b = b?.next
        }
        
        let newHead = reverse(a, b)
        head?.next = reverseKGroup(b, k)
        
        return newHead
        
    }
    
    /// 翻转链表节点范围[a, b)的节点
    func reverse(_ a: ListNode?, _ b: ListNode?) -> ListNode? {
        var pre: ListNode? = nil
        var cur: ListNode? = a
        var next: ListNode? = a
        while cur !== b {
            next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        
        return pre
    }
}

var arr = [1,2,3,4,5]
var head = ListNode.buildListNode(with: arr)
let k = 2
print("输入: head = \(head!), k = \(k)")

let solution = Solution1()
var result = solution.reverseKGroup(head, k)
print("输出: \(result?.description ?? "NULL")")

