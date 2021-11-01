//
//  main.swift
//  146. LRU 缓存机制
//
//  Created by Tone on 2021/10/20.
//

/*
 运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制 。
 实现 LRUCache 类：

 LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存
 int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
 void put(int key, int value) 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。
  

 进阶：你是否可以在 O(1) 时间复杂度内完成这两种操作？

  

 示例：

 输入
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 输出
 [null, null, null, 1, null, -1, null, -1, 3, 4]

 解释
 LRUCache lRUCache = new LRUCache(2);
 lRUCache.put(1, 1); // 缓存是 {1=1}
 lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
 lRUCache.get(1);    // 返回 1
 lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
 lRUCache.get(2);    // 返回 -1 (未找到)
 lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
 lRUCache.get(1);    // 返回 -1 (未找到)
 lRUCache.get(3);    // 返回 3
 lRUCache.get(4);    // 返回 4
  

 提示：

 1 <= capacity <= 3000
 0 <= key <= 10000
 0 <= value <= 105
 最多调用 2 * 105 次 get 和 put


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/lru-cache
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

/// 创建双向链表类
class DLinkNode {
    var pre: DLinkNode?
    var next: DLinkNode?
    var val: Int?
    var key: Int?
    
    // 构造函数
    init(pre: DLinkNode? = nil,
         next: DLinkNode? = nil,
         val: Int? = nil,
         key: Int? = nil) {
        self.pre = pre
        self.next = next
        self.val = val
        self.key = key
    }
}

class LRUCache {
    
    // 属性构建
    var capacity = 0
    var count = 0
    var first = DLinkNode(val: -1)
    var last = DLinkNode(val: -1)
    
    var hash = Dictionary<Int, DLinkNode>()

    // 实现构造函数
    init(_ capacity: Int) {
        self.capacity = capacity
        
        first.pre = nil
        first.next = last
        
        last.pre = first
        last.next = nil
    }
    
    // 获取
    func get(_ key: Int) -> Int {
        if let node = hash[key] {
            // 每次获取需要将节点移动到头部
            moveToHead(node)
            return node.val!
        } else {
            return -1
        }
    }
    
    // 写入
    func put(_ key: Int, _ value: Int) {
        if let old = hash[key] {
            // 已存在键值,直接修改,并移动到最前位置
            old.val = value
            moveToHead(old)
        } else {
            // 不存在创建新节点
            let new = DLinkNode(val: value, key: key)
            
            if count == capacity {
                // 容量满就移除最后一位节点
                removeLastNode()
            }
            moveToHead(new)
            hash[key] = new
            count += 1
        }
    }
    
    // 删除尾节点
    func removeLastNode() {
        // 移除倒数第二个node
        let theNode = last.pre
        theNode?.pre?.next = last
        last.pre = theNode?.pre
        
        count -= 1
        hash[theNode!.key!] = nil
        
        theNode?.pre = nil
        theNode?.next = nil
    }
    
    //  移动到头节点
    func moveToHead(_ node: DLinkNode) {
        
        // 取出节点
        let pre = node.pre
        let next = node.next
        pre?.next = next
        next?.pre = pre
        
        //置入头节点
        node.pre = first
        node.next = first.next
        
        first.next = node
        node.next?.pre = node
    }
}

