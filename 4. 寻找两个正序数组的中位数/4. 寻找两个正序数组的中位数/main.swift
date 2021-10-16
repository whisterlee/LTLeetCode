//
//  main.swift
//  4. 寻找两个正序数组的中位数
//
//  Created by Tone on 2021/9/2.
//
/*
 给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。

 示例 1：

 输入：nums1 = [1,3], nums2 = [2]
 输出：2.00000
 解释：合并数组 = [1,2,3] ，中位数 2
 示例 2：

 输入：nums1 = [1,2], nums2 = [3,4]
 输出：2.50000
 解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5
 示例 3：

 输入：nums1 = [0,0], nums2 = [0,0]
 输出：0.00000
 示例 4：

 输入：nums1 = [], nums2 = [1]
 输出：1.00000
 示例 5：

 输入：nums1 = [2], nums2 = []
 输出：2.00000
  

 提示：

 nums1.length == m
 nums2.length == n
 0 <= m <= 1000
 0 <= n <= 1000
 1 <= m + n <= 2000
 -106 <= nums1[i], nums2[i] <= 106
  

 进阶：你能设计一个时间复杂度为 O(log (m+n)) 的算法解决此问题吗？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/median-of-two-sorted-arrays
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

/// 暴力解法：时间复杂度为 O(nlog(n))，不满足要求
class Solution1 {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        /* 两个数组合并 */
        var arr = nums1 + nums2
        if arr.count <= 1 {
            return arr.first == nil ? 0 : Double(arr.first!)
        }
        /* 对两个数组排序 */
        arr = arr.sorted(by: <)
        
        if arr.count % 2 == 0 {
            /* 偶数 */
            return Double(arr[arr.count / 2] + arr[arr.count / 2 - 1]) / 2
        } else {
            return Double(arr[arr.count / 2])
        }
    }
}

// TODO: 二分查找
class Solution2 {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        return 0
    }
}

let solution = Solution1()
let nums1 = [1,2], nums2 = [3,4]
let result = solution.findMedianSortedArrays(nums1, nums2)
print("输入：nums1 = \(nums1), nums2 = \(nums2)")
print("输出：\(result)")

