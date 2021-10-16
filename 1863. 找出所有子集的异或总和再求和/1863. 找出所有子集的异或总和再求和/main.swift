//
//  main.swift
//  1863. 找出所有子集的异或总和再求和
//
//  Created by Tone on 2021/6/9.
//

import Foundation

/*
 一个数组的 异或总和 定义为数组中所有元素按位 XOR 的结果；如果数组为 空 ，则异或总和为 0 。

 例如，数组 [2,5,6] 的 异或总和 为 2 XOR 5 XOR 6 = 1 。
 给你一个数组 nums ，请你求出 nums 中每个 子集 的 异或总和 ，计算并返回这些值相加之 和 。

 注意：在本题中，元素 相同 的不同子集应 多次 计数。

 数组 a 是数组 b 的一个 子集 的前提条件是：从 b 删除几个（也可能不删除）元素能够得到 a 。

  

 示例 1：

 输入：nums = [1,3]
 输出：6
 解释：[1,3] 共有 4 个子集：
 - 空子集的异或总和是 0 。
 - [1] 的异或总和为 1 。
 - [3] 的异或总和为 3 。
 - [1,3] 的异或总和为 1 XOR 3 = 2 。
 0 + 1 + 3 + 2 = 6
 示例 2：

 输入：nums = [5,1,6]
 输出：28
 解释：[5,1,6] 共有 8 个子集：
 - 空子集的异或总和是 0 。
 - [5] 的异或总和为 5 。
 - [1] 的异或总和为 1 。
 - [6] 的异或总和为 6 。
 - [5,1] 的异或总和为 5 XOR 1 = 4 。
 - [5,6] 的异或总和为 5 XOR 6 = 3 。
 - [1,6] 的异或总和为 1 XOR 6 = 7 。
 - [5,1,6] 的异或总和为 5 XOR 1 XOR 6 = 2 。
 0 + 5 + 1 + 6 + 4 + 3 + 7 + 2 = 28
 示例 3：

 输入：nums = [3,4,5,6,7,8]
 输出：480
 解释：每个子集的全部异或总和值之和为 480 。
  

 提示：

 1 <= nums.length <= 12
 1 <= nums[i] <= 20

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/sum-of-all-subset-xor-totals
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/*
 递归法枚举子集
 
 从0位开始递归,
 每一次递归都要判断当前位置是否需要加入子集,
 直到第n-1位,将之前所有的结果都合并到res.
 
 时间复杂度: O(2^n)
 空间复杂度: O(n)
 */
class Solution1 {
    
    var res: Int = 0
    var n: Int = 0
    
    
    func subsetXORSum(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        res = 0
        n = nums.count
        dfs(0, 0, nums)
        
        return res
    }
    
    
    /// 递归nums的子集
    ///
    /// 从0位开始递归,
    /// 每一次递归都要判断当前位置是否需要加入子集,
    /// 直到第n-1位,将之前所有的结果都合并到res.
    ///
    /// - Parameters:
    ///   - val: 当前选取部分的异或值
    ///   - idx: 递归当前位置
    ///   - nums: 所有值的数组集合
    func dfs(_ val: Int, _ idx: Int, _ nums: [Int]) {
        // 递归结束条件
        if idx == n {
            res += val
            return
        }
        
        // 当前值有加入子集
        dfs(val^nums[idx], idx + 1, nums)
        // 当前值未加入子集
        dfs(val, idx + 1, nums)
    }
}

/*
 迭代法枚举子集
 
 遍历数组,获取每一个子集
 遍历子集获取每一个子集的异或值,再累加
 
 时间复杂度: O(n2^n)
 空间复杂度: O(2^n)
 */
class Solution2 {
    
    func subsetXORSum(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        // 结果
        var res: Int = 0
        // 子集数组
        var subSets: [[Int]] = []
        
        // 遍历求子集方法
        for num in nums {
            // 防止死循环
            var tmpSubSets = subSets
            for subSet in subSets {
                // 上一轮每一个数组拼接个新元素添加进新数组
                tmpSubSets.append(subSet + [num])
            }
            // 添加新元素形成的单一数组
            tmpSubSets.append([num])
            subSets = tmpSubSets
        }
        // 空子集的异或和始终为0, 这里就没有加入空子集[], 要留意[]也是其子集
        
        // 已有子集求异或和和
        for subSet in subSets {
            if subSet.count == 0 {
                continue
            }
            
            // 遍历每一个子集数组, 求异或
            var temp = subSet[0]
            for i in 1..<subSet.count {
                temp = temp^subSet[i]
            }
            
            res += temp
        }
        
        return res
    }
}

let solution = Solution2()
print("\(solution.subsetXORSum([1, 3]))")

