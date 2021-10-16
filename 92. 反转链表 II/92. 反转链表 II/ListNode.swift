//
//  ListNode.swift
//  92. 反转链表 II
//
//  Created by Tone on 2021/9/17.
//

import Foundation

public class ListNode: CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    /// 链表整体的描述
    public var description: String {
        var str = "\(val)"
        str += "->"
        
        var tempNode = next
        while tempNode != nil {
            str += "\(tempNode!.val)"
            str += "->"
            tempNode = tempNode?.next
        }
        str += "NULL"
        
        return str
    }
    
    /// 通过数组构建链表
    static func buildListNode(with array: [Int]) -> ListNode? {
        guard array.isEmpty == false else {
            return nil
        }
        
        var firtNode: ListNode?
        var tempNode: ListNode?
        for item in array {
            let node = ListNode(item)
            if firtNode == nil {
                firtNode = node
                tempNode = firtNode
            } else {
                tempNode?.next = node
                tempNode = node
            }
        }
        
        return firtNode!
    }
}
