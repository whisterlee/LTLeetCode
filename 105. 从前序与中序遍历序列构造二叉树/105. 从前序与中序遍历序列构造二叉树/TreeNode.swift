//
//  TreeNode.swift
//  105. 从前序与中序遍历序列构造二叉树
//
//  Created by Tone on 2021/10/16.
//

import Foundation

/// 二叉树
public class TreeNode: CustomStringConvertible {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    private var preorder: [Int] = []
    private var midorder: [Int] = []
    private var lastorder: [Int] = []
    
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    public var description: String {
        return TreeNode.serialize(self)
    }
    /// 二叉树序列化
    static func serialize(_ root: TreeNode?) -> String {
        if root == nil {
            return ""
        }
        var res = [String]() //用来保存结果的数组
        var seq = [TreeNode]() //用来保存节点的队列
        var t = root
        seq.append(t!)
        let s = String(t!.val)
        res.append(s)
        var seq_idx = 0
        while (seq_idx < seq.count){
            t = seq[seq_idx]
            seq_idx += 1
            
            if t!.left != nil {
                seq.append(t!.left!)
                res.append(String(t!.left!.val))
            } else {
                res.append("null")
            }
            if t!.right != nil {
                seq.append(t!.right!)
                res.append(String(t!.right!.val))
            } else {
                res.append("null")
            }
        }
        return res.joined(separator: ",")
    }
    
    /// 二叉树反序列化
    static func deserialize(_ data: String) -> TreeNode? {
        if data.isEmpty { return nil }
        let arr = data.split(separator: ",")
        var seq = [TreeNode]()
        let rootNode = TreeNode(0)
        
        //这两个索引也可以使用swift数组自有的 .first 和 .removeFirst() 来实现，
        //这样可能省两个变量的空间，并且代码更简洁，但是效率上会差的比较多。--友好说明 by xuanwenchao
        var arr_idx = 0
        var seq_idx = 0
        
        if arr.count > 0 && String(arr.first!) != "null" {
            let ele = Int(String(arr[arr_idx]))
            rootNode.val = ele!
            seq.append(rootNode)
            arr_idx += 1
            
            
            while (seq.count > seq_idx && arr.count > arr_idx) {
                let node = seq[seq_idx]
                seq_idx += 1
                let val  = String(arr[arr_idx]) //left
                if val == "null" {
                    node.left = nil
                } else {
                    let leftNode = TreeNode(Int(val)!)
                    leftNode.left = nil
                    leftNode.right = nil
                    node.left = leftNode
                    seq.append(leftNode)
                }
                arr_idx += 1
                
                if arr.count > arr_idx {
                    let val  = String(arr[arr_idx]) //right
                    if val == "null" {
                        node.right = nil
                    } else {
                        let rightNode = TreeNode(Int(val)!)
                        rightNode.left = nil
                        rightNode.right = nil
                        node.right = rightNode
                        seq.append(rightNode)
                    }
                } else {
                    node.right = nil
                }
                
                arr_idx += 1
            }
            
        } else {
            return nil
        }
        
        
        return rootNode
    }
    
    /// 通过二叉树的前序遍历和中序遍历构建二叉树
    static func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard preorder.isEmpty == false,
              preorder.count == inorder.count else {
                  return nil
              }
        
        return myBuildTreee(preorder, 0, preorder.count - 1, inorder, 0, inorder.count - 1)
    }
    
    private static func myBuildTreee(_ preorder: [Int],
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
    
    /// 前序遍历二叉树
    @discardableResult
    func preorderTree() -> [Int] {
        preorder = []
        myPreorderTree(self)
        return preorder
    }
    
    private func myPreorderTree(_ node: TreeNode) {
        preorder.append(node.val)
        if let leftSubTree = node.left {
            myPreorderTree(leftSubTree)
        }
        if let rightSubTree = node.right {
            myPreorderTree(rightSubTree)
        }
    }
    
    /// 中序遍历二叉树
    @discardableResult
    func midorderTree() -> [Int] {
        midorder = []
        myMidorderTree(self)
        
        return midorder
    }
    
    private func myMidorderTree(_ node: TreeNode) {
        if let leftSubTree = node.left {
            myMidorderTree(leftSubTree)
        }
        midorder.append(node.val)
        if let rightSubTree = node.right {
            myMidorderTree(rightSubTree)
        }
    }
    
    /// 后序遍历二叉树
    @discardableResult
    func lastorderTree() -> [Int] {
        lastorder = []
        myLastorderTree(self)
        
        return lastorder
    }
    
    private func myLastorderTree(_ node: TreeNode) {
        if let leftSubTree = node.left {
            myLastorderTree(leftSubTree)
        }
        if let rightSubTree = node.right {
            myLastorderTree(rightSubTree)
        }
        lastorder.append(node.val)
    }
}
 
