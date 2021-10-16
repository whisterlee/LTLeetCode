//
//  main.swift
//  21. 合并两个有序链表
//
//  Created by Tone on 2021/10/16.
//

/*
 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
 
 示例 1：

 输入：l1 = [1,2,4], l2 = [1,3,4]
 输出：[1,1,2,3,4,4]
 示例 2：

 输入：l1 = [], l2 = []
 输出：[]
 示例 3：

 输入：l1 = [], l2 = [0]
 输出：[0]
  

 提示：

 两个链表的节点数目范围是 [0, 50]
 -100 <= Node.val <= 100
 l1 和 l2 均按 非递减顺序 排列


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-two-sorted-lists
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

/// 双指针法
class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1
        var l2 = l2
        var curList: ListNode?
        
        // 1. 创建虚拟头节点。
        let newList = ListNode(-1)
        curList = newList
        
        // 2. 当l1和l2不为空时，比较大小，拼接。
        while l1 != nil && l2 != nil {
            if l1!.val < l2!.val {
                curList!.next = l1
                l1 = l1?.next
            } else {
                curList!.next = l2
                l2 = l2?.next
            }
            curList = curList?.next
        }
        // 3. 当l1或l2为空时，拼接另一个链表剩余元素。
        curList?.next = l1 ?? l2
        
        return newList.next
    }
}

// 递归法
class Solution2 {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        } else if l2 == nil {
            return l1
        } else if l1!.val < l2!.val {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists(l1, l2?.next)
            return l2
        }
    }
}

let arr1 = [1,2,4], arr2 = [1,3,4]
let l1 = ListNode.buildListNode(with: arr1)
let l2 = ListNode.buildListNode(with: arr2)
print("输入: l1 = \(arr1), l2 = \(arr2)")
if let res = Solution2().mergeTwoLists(l1, l2) {
    print("输出: \(res)")
}



