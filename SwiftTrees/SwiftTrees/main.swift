//
//  main.swift
//  SwiftTrees
//
//  Created by Dave Spina on 5/1/21.
//

import Foundation

struct Node<Value> {
    var value: Value
    private(set) var children: [Node]
    
    mutating func addChildNode(child: Node) {
        children.append(child)
    }
    
    init(_ value: Value) {
        self.value = value
        children = []
    }
    
    init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }
    
}

