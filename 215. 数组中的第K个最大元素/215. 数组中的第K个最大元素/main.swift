//
//  main.swift
//  215. 数组中的第K个最大元素
//
//  Created by Tone on 2021/8/16.
//

import Foundation

/*
 给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。

 请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。

  

 示例 1:

 输入: [3,2,1,5,6,4] 和 k = 2
 输出: 5
 示例 2:

 输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
 输出: 4
  

 提示：

 1 <= k <= nums.length <= 104
 -104 <= nums[i] <= 104

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/kth-largest-element-in-an-array
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class Solution {
    var curNums: [Int] = [] {
        didSet {
            print(curNums)
        }
    }
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        print("----------sort begin------------")
        curNums = nums
        
        /* 对nums进行排序 */
        sortNums(0, curNums.count - 1)
        print("-----------sort end-------------")
        return curNums[curNums.count - k]
    }
    
    /* 排序 */
    func sortNums(_  beginIndex: Int, _ endIndex: Int) {
        guard endIndex - beginIndex > 0 else {
            return
        }
        
        /* 取中间数组的下标,并将nums按照中间值左右分开 */
        let midIndex = getMidIndex(beginIndex, endIndex)
        sortNums(beginIndex, midIndex - 1)
        sortNums(midIndex + 1, endIndex)
    }
    
    func getMidIndex(_  beginIndex: Int, _ endIndex: Int) -> Int {
        var curBeginIndex = beginIndex
        var curEndIndex = endIndex
        
        let center = curNums[beginIndex]
        while curBeginIndex < curEndIndex {
            /* 右侧排序 */
            while curBeginIndex < curEndIndex {
                if curNums[curEndIndex] > center { //右边元素大于center //*
                    curEndIndex -= 1
                } else {
                    /* 右边元素 <= center */
                    print("右侧排序")
                    curNums[curBeginIndex] = curNums[curEndIndex]
                    curBeginIndex += 1
                    break
                }
            }
            
            /* 左侧排序 */
            while curBeginIndex < curEndIndex {
                if curNums[curBeginIndex] < center {
                    curBeginIndex += 1
                } else {
                    print("左侧排序")
                    curNums[curEndIndex] = curNums[curBeginIndex]
                    curEndIndex -= 1
                    break
                }
            }
        }
        
        /* 将保存的中间值，存入中间位置。*/
        print("复原中间值")
        curNums[curBeginIndex] = center
        return curBeginIndex // 返回center
    }
}

class Solution2 {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        
    }
}

let nums = [3,2,1,5,6,4]
let k = 2
let res = Solution().findKthLargest(nums, k)
print("输入: nums = \(nums), k = \(k)")
print("输出: \(res)")
