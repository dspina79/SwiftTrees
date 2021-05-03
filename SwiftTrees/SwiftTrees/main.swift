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

// this can allow for the comparison of two Nodes if their values
// are equatable
extension Node: Equatable where Value: Equatable {
    func find(_ item: Node) -> Node? {
        if self == item {
            return self
        }
        
        for child in self.children {
            if let match = child.find(item) {
                return match
            }
        }
        
        return nil
    }
    
}
extension Node: Codable where Value: Codable {}
extension Node: Hashable where Value: Hashable {}

var dean = Node("Dean")
var danny = Node("Danny")
dean.addChildNode(child: danny)

var lynda = Node("Lynda")
var meghan = Node("Meghan")
var sam = Node("Samuel")
lynda.addChildNode(child: meghan)
lynda.addChildNode(child: sam)

var mother = Node("Mama Denise")
mother.addChildNode(child: dean)
mother.addChildNode(child: lynda)

print(mother)
print(dean == lynda)
print(dean != lynda)
print(lynda == lynda)
