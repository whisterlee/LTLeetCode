//
//  main.swift
//  88. 合并两个有序数组
//
//  Created by Tone on 2021/9/2.
//
/*
 给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。

 请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。

 注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。

  

 示例 1：

 输入：nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 输出：[1,2,2,3,5,6]
 解释：需要合并 [1,2,3] 和 [2,5,6] 。
 合并结果是 [1,2,2,3,5,6] ，其中斜体加粗标注的为 nums1 中的元素。
 示例 2：

 输入：nums1 = [1], m = 1, nums2 = [], n = 0
 输出：[1]
 解释：需要合并 [1] 和 [] 。
 合并结果是 [1] 。
 示例 3：

 输入：nums1 = [0], m = 0, nums2 = [1], n = 1
 输出：[1]
 解释：需要合并的数组是 [] 和 [1] 。
 合并结果是 [1] 。
 注意，因为 m = 0 ，所以 nums1 中没有元素。nums1 中仅存的 0 仅仅是为了确保合并结果可以顺利存放到 nums1 中。
  

 提示：

 nums1.length == m + n
 nums2.length == n
 0 <= m, n <= 200
 1 <= m + n <= 200
 -109 <= nums1[i], nums2[j] <= 109
  

 进阶：你可以设计实现一个时间复杂度为 O(m + n) 的算法解决此问题吗？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-sorted-array
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import Foundation

/// 直接合并后排序
class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var subNum1 = nums1
        subNum1.removeSubrange(m..<nums1.count)
        
        var subNum2 = nums2
        subNum2.removeSubrange(n..<nums2.count)
        
        nums1 = (subNum1 + subNum2).sorted(by: <)
    }
}

/// 双指针
class Solution2 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        /// 设置一个指针p1与p2来作为队列的头部指针
        var p1 = 0, p2 = 0
        /// 缓存排序后的队列
        var cur: [Int] = []
        
        while p1 < m || p2 < n {
            if p1 == m {
                cur.append(nums2[p2])
                p2 += 1
            } else if p2 == n {
                cur.append(nums1[p1])
                p1 += 1
            } else {
                if nums1[p1] < nums2[p2] {
                    cur.append(nums1[p1])
                    p1 += 1
                } else {
                    cur.append(nums2[p2])
                    p2 += 1
                }
            }
        }
        
        nums1 = cur
    }
}

/// 逆向双指针
class Solution3 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        /// 设置一个指针p1与p2来作为队列的头部指针
        var p1 = m - 1, p2 = n - 1
        var tail = m + n - 1
        var cur: Int?
        
        while p1 >= 0 || p2 >= 0 {
            if p1 < 0 {
                cur = nums2[p2]
                p2 -= 1
            } else if p2 < 0 {
                cur = nums1[p1]
                p1 -= 1
            } else {
                if nums1[p1] > nums2[p2] {
                    cur = nums1[p1]
                    p1 -= 1
                } else {
                    cur = nums2[p2]
                    p2 -= 1
                }
            }
            
            if let cur = cur {
                nums1[tail] = cur
                tail -= 1
            }
        }
    }
}

let solution = Solution3()
var nums1 = [1,2,3,0,0,0]
let m = 3
let nums2 = [2,5,6]
let n = 3
print("输入：nums1 = \(nums1), m = \(m), nums2 = \(nums2), n = \(n)")
solution.merge(&nums1, m, nums2, n)
print("输出：\(nums1)")
      

