//
//  main.swift
//  236. 二叉树的最近公共祖先
//
//  Created by Tone on 2021/10/16.
//

import Foundation

/*
 给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

 百度百科中最近公共祖先的定义为：“对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

  

 示例 1：


 输入：root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 输出：3
 解释：节点 5 和节点 1 的最近公共祖先是节点 3 。
 示例 2：


 输入：root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 输出：5
 解释：节点 5 和节点 4 的最近公共祖先是节点 5 。因为根据定义最近公共祖先节点可以为节点本身。
 示例 3：

 输入：root = [1,2], p = 1, q = 2
 输出：1
  

 提示：

 树中节点数目在范围 [2, 105] 内。
 -109 <= Node.val <= 109
 所有 Node.val 互不相同 。
 p != q
 p 和 q 均存在于给定的二叉树中。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class Solution {
    /*
     解题思路如下：
     1、当root为空时，返回nil
     2、如果root的值和p或者q的值相等时，直接返回root
     3、递归左右子树，用left和right表示递归求出的结果
     4、如果left是空，说明p和q节点都不在左子树，那么结果就在右子树，返回right
     5、如果right是空，说明p和q节点都不在右子树，那么结果就在左子树，返回left
     6、如果left和right都不为空，说明p和q节点分别在左右子树，那么结果就是root
     */
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil ||
            p?.val == root?.val ||
            q?.val == root?.val {
            return root
        }
            
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left == nil {
            return right
        }
        if right == nil {
            return left
        }
        
        return root
    }
}

let root = TreeNode.deserialize("3,5,1,6,2,0,8,null,null,7,4")!
let p = TreeNode(5)
let q = TreeNode(1)
print("输入：root = [\(root)], p = \(p.val), q = \(q.val)")
if let res = Solution().lowestCommonAncestor(root, p, q) {
    print("输出：\(res.val)")
}



