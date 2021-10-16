//
//  main.swift
//  206. 反转链表
//
//  Created by Tone on 2021/9/17.
//

/*
 给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
  

 示例 1：


 输入：head = [1,2,3,4,5]
 输出：[5,4,3,2,1]
 示例 2：


 输入：head = [1,2]
 输出：[2,1]
 示例 3：

 输入：head = []
 输出：[]
  

 提示：

 链表中节点的数目范围是 [0, 5000]
 -5000 <= Node.val <= 5000
  

 进阶：链表可以选用迭代或递归方式完成反转。你能否用两种方法解决这道题？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation


/// 递归反转整个链表
class Solution1 {
    func reverseList(_ head: ListNode?) -> ListNode? {
        /* 结束条件 */
        if head?.next == nil {
            return head
        }
        /*
         将链表分为head 和 子链表
         子链表反转后,得到反转后的头,用变量last接收
         */
        let last = reverseList(head?.next)
        /*
         此时head.next 还是指向子链表反转后的最后一位
         将子链表反转后的最后一位的next指向head
         */
        head?.next?.next = head
        /*
         反转后的最后一位,需指向nil
         */
        head?.next = nil
        
        return last
    }
}

/// 循环翻转
class Solution2 {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var newHead: ListNode?
        var cur = head
        while cur != nil {
            // 1 记录即将断开的节点
            let tmp = cur?.next
            // 2 翻转
            cur?.next = newHead
            // 3 重制
            newHead = cur
            cur = tmp
        }
        
        return newHead
    }
}

let arr = [1, 2, 3, 4, 5]
let head = ListNode.buildListNode(with: arr)
print("输入: \(head!)")

let solution = Solution2()
var result = solution.reverseList(head)
print("输出: \(result?.description ?? "NULL")")

