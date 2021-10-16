//
//  main.swift
//  92. 反转链表 II
//
//  Created by Tone on 2021/9/17.
//

import Foundation

/*
 给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
  

 示例 1：


 输入：head = [1,2,3,4,5], left = 2, right = 4
 输出：[1,4,3,2,5]
 示例 2：

 输入：head = [5], left = 1, right = 1
 输出：[5]
  

 提示：

 链表中节点数目为 n
 1 <= n <= 500
 -500 <= Node.val <= 500
 1 <= left <= right <= n
  

 进阶： 你可以使用一趟扫描完成反转吗？



 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-linked-list-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/// 递归反转
class Solution1 {
    /// 后驱节点
    var successor: ListNode?
    
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        if left == 1 {
            return reverseN(head, right)
        }
        
        /*
         left之前的节点不需要处理,递归分解出子节点
         */
        head?.next = reverseBetween(head?.next, left - 1, right - 1)
        
        return head
    }
    
    /// 反转链表的前n个节点
    func reverseN(_ head: ListNode?, _ n: Int) -> ListNode? {
        if n == 1 {
            successor = head?.next
            return head
        }
        /* 递归分解链表 */
        let last = reverseN(head?.next, n - 1)
        /* 当前节点的next,还指向反转后的链表的尾结点 */
        head?.next?.next = head
        head?.next = successor
        return last
    }
}

var arr = [1,2,3,4,5]
var head: ListNode?
var preNode: ListNode?
for i in 0..<arr.count {
    let node = ListNode(arr[i])
    if head == nil {
        head = node
    } else {
        preNode?.next = node
    }
    preNode = node
}
print("输入: \(head!)")
let left = 2
let right = 4

let solution = Solution1()
var result = solution.reverseBetween(head, left, right)
print("输出: \(result?.description ?? "NULL")")
