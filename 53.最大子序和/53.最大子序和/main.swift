//
//  main.swift
//  53.最大子序和
//
//  Created by Tone on 2021/8/16.
//

import Foundation

/*
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

  

 示例 1：

 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
 输出：6
 解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
 示例 2：

 输入：nums = [1]
 输出：1
 示例 3：

 输入：nums = [0]
 输出：0
 示例 4：

 输入：nums = [-1]
 输出：-1
 示例 5：

 输入：nums = [-100000]
 输出：-100000
  

 提示：

 1 <= nums.length <= 3 * 104
 -105 <= nums[i] <= 105
  

 进阶：如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的 分治法 求解。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/maximum-subarray
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        /// 记录元素相加的值
        var sum = 0
        /// 记录当前最大和的值
        var res = nums[0]
        for num in nums {
            if sum <= 0 {
                /* 如果 sum <= 0，则说明 sum 对结果无增益效果，需要舍弃，则 sum 直接更新为当前遍历数字 */
                sum = num
            } else {
                /* 如果 sum > 0，则说明 sum 对结果有增益效果，则 sum 保留并加上当前遍历数字 8 */
                sum += num
            }
            
            /* 每次比较 sum 和 ans的大小，将最大值置为result，遍历结束返回结果 */
            res = max(sum, res)
        }
        
        return res
    }
}

let nums = [-2,1,-3,4,-1,2,1,-5,4]
let res = Solution().maxSubArray(nums)
print("输入: nums = \(nums)")
print("输出: \(res)")




