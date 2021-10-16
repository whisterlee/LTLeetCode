//
//  main.swift
//  105. 从前序与中序遍历序列构造二叉树
//
//  Created by Tone on 2021/10/16.
//

import Foundation

/*
 给定一棵树的前序遍历 preorder 与中序遍历  inorder。请构造二叉树并返回其根节点。

  

 示例 1:


 Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
 Output: [3,9,20,null,null,15,7]
 示例 2:

 Input: preorder = [-1], inorder = [-1]
 Output: [-1]
  

 提示:

 1 <= preorder.length <= 3000
 inorder.length == preorder.length
 -3000 <= preorder[i], inorder[i] <= 3000
 preorder 和 inorder 均无重复元素
 inorder 均出现在 preorder
 preorder 保证为二叉树的前序遍历序列
 inorder 保证为二叉树的中序遍历序列


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution {
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard preorder.isEmpty == false,
              preorder.count == inorder.count else {
                  return nil
              }
        
        return myBuildTreee(preorder, 0, preorder.count - 1, inorder, 0, inorder.count - 1)
    }
    
    private func myBuildTreee(_ preorder: [Int],
                              _ preorderLeftIndex: Int,
                              _ preorderRightIndex: Int,
                              _ inorder: [Int],
                              _ inorderLeftIndex: Int,
                              _ inorderRightIndex: Int) -> TreeNode? {
        guard preorderLeftIndex <= preorderRightIndex else {
            return nil
        }
        
        // 前序遍历中的第一个节点就是根节点
        let preoderRootIndex = preorderLeftIndex
        // 在中序遍历中定位根节点
        guard let inorderRootIndex = inorder.firstIndex(of: preorder[preoderRootIndex]) else {
            return nil
        }
        // 得到左子树中的节点数目
        let sizeOfLeftSubTree = inorderRootIndex - inorderLeftIndex
        
        // 先把根节点建立出来
        let root = TreeNode(preorder[preoderRootIndex])
        // 递归地构造左子树，并连接到根节点
        root.left = myBuildTreee(preorder, preorderLeftIndex + 1, preorderLeftIndex + sizeOfLeftSubTree, inorder, inorderLeftIndex, inorderRootIndex - 1)
        // 递归地构造右子树，并连接到根节点
        root.right = myBuildTreee(preorder, preorderLeftIndex + sizeOfLeftSubTree + 1, preorderRightIndex, inorder, inorderRootIndex + 1, inorderRightIndex)
        
        return root
    }
}

let preorder = [3,9,20,15,7]
let inorder = [9,3,15,20,7]
print("输入: preorder = \(preorder), inorder = \(inorder)")
if let result = Solution().buildTree(preorder, inorder) {
    print("输出: \n\(result)")
}
