//
//  main.swift
//  3. 无重复字符的最长子串
//
//  Created by Tone on 2021/8/31.
//

/*
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。

  

 示例 1:

 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 示例 2:

 输入: s = "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:

 输入: s = "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
 示例 4:

 输入: s = ""
 输出: 0
  

 提示：

 0 <= s.length <= 5 * 104
 s 由英文字母、数字、符号和空格组成


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

/* 临时的存储字符串,遍历查询 */
class Solution1 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s == "" {
            return 0
        }
        
        var maxStr: String = ""
        /* 临时的存储 */
        var curStr: String = ""
        for c in s {
            /* 当碰到重复字符，删除此字符在数组之前所有字符，包括本身 */
            while curStr.contains(c) {
                curStr.remove(at: curStr.startIndex)
            }
            curStr.append(c)
            /* 每次需要重复判断下是否是最大长度 */
            if curStr.count > maxStr.count {
                maxStr = curStr
            }
        }
        
        return maxStr.count
    }
}

/* 临时存储数组,遍历查询 */
class Solution2 {
    func lengthOfLongestSubString(_ s: String) -> Int {
        if s == "" {
            return 0
        }
        
        var array = [Character]()
        var maxCount = 0
        for c in s {
            if let index = array.firstIndex(of: c) {
                maxCount = max(maxCount, array.count)
                /* 从开始位置移除index+1数的数据 */
                array.removeFirst(index + 1)
            }
            
            array.append(c)
        }
        
        return max(maxCount, array.count)
    }
}

/* 滑动窗口法 */
class Solution3 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        /* 记录每个字符的下标位置 */
        var kv: [Character: Int] = [:]
        /// 开始位置
        var start = 0
        /// 结束位置
        var end = 0
        /// 结果
        var ans = 0
        
        for item in s {
            if let record = kv[item] {
                /* 如果之前有存在过字符,开始位置从之前位置的后一位开始 */
                start = max(record + 1, start)
            }
            
            /* 记录字符所在位置 */
            kv[item] = end
            /* 取最长数字 */
            ans = max(end - start + 1, ans)
            /* 每次结束字符后移一位 */
            end += 1
        }
        
        
        return ans
    }
}

let solution = Solution1()
let s = "abcabcbb"
let result = solution.lengthOfLongestSubstring(s)
print("输入: \(s)")
print("输出: \(result)")
