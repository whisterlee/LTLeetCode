//
//  main.swift
//  509. 斐波那契数
//
//  Created by Tone on 2021/6/9.
//

import Foundation

/*
 写一个函数，输入 n ，求斐波那契（Fibonacci）数列的第 n 项（即 F(N)）。斐波那契数列的定义如下：

 F(0) = 0,   F(1) = 1
 F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
 斐波那契数列由 0 和 1 开始，之后的斐波那契数就是由之前的两数相加而得出。

 答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

  

 示例 1：

 输入：n = 2
 输出：1
 示例 2：

 输入：n = 5
 输出：5
  

 提示：

 0 <= n <= 100

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/fei-bo-na-qi-shu-lie-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution {
    
    
    func fib1(_ n: Int) -> Int {
        if n <= 1 {
            return n
        }
        
        return fib1(n - 1) + fib1(n - 2)
    }
    
    func fib2(_ n: Int) -> Int {
        if n <= 1 {
            return n
        }
        
        var first: Int = 0
        var second: Int = 1
        for _ in 0..<n - 1 {
            let temp = (first + second) % 1000000007
            first = second
            second = temp
        }
        
        return second
    }
}

let solution = Solution()
for i in 0..<47 {
    print(solution.fib2(i), terminator: " ")
}
print("")

