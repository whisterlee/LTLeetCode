//
//  main.swift
//  剑指 Offer II 048. 序列化与反序列化二叉树
//
//  Created by Tone on 2021/10/16.
//

/*
 序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。

 请设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。

  

 示例 1：



 输入：root = [1,2,3,null,null,4,5]
 输出：[1,2,3,null,null,4,5]
 示例 2：

 输入：root = []
 输出：[]
 示例 3：

 输入：root = [1]
 输出：[1]
 示例 4：

 输入：root = [1,2]
 输出：[1,2]
  

 提示：

 输入输出格式与 LeetCode 目前使用的方式一致，详情请参阅 LeetCode 序列化二叉树的格式。你并非必须采取这种方式，也可以采用其他的方法解决这个问题。
 树中结点数在范围 [0, 104] 内
 -1000 <= Node.val <= 1000

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/h54YBf
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation


class Codec {
    func serialize(_ root: TreeNode?) -> String {
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
    
    //deserialize function coding by xuanwenchao at 2020.06.16
    func deserialize(_ data: String) -> TreeNode? {
        if data.isEmpty { return nil }
        var arr = data.split(separator: ",")
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
}


