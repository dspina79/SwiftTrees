//
//  main.swift
//  SwiftTrees
//
//  Created by Dave Spina on 5/1/21.
//

import Foundation

final class Node<Value> {
    var value: Value
    private(set) var children: [Node]
    
    func addChildNode(child: Node) {
        children.append(child)
    }
    
    var count: Int {
        return 1 + children.reduce(0) { $0 + $1.count }
    }
    
    init(_ value: Value) {
        self.value = value
        children = []
    }
    
    init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }
    
    init(_ value: Value, @NodeBuilder builder: () -> [Node]) {
        self.value = value
        self.children = builder()
    }
}

class StringTreeBuilder {
    static func printTree(_ n: Node<String>, depth: Int) -> String {
        var result = (depth == 0 ? "" : "|") + String.init(repeating: "--", count: depth) + n.value + "\n"
        
        for c in n.children {
            result += printTree(c, depth: depth + 1)
        }
        
        return result
    }
}

// this can allow for the comparison of two Nodes if their values
// are equatable
extension Node: Equatable where Value: Equatable {
    static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        return lhs.value == rhs.value && rhs.children == lhs.children
    }
    
    
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

extension Node: Hashable where Value: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}

@_functionBuilder
struct NodeBuilder {
    static func buildBlock<Value>(_ children: Node<Value>...) -> [Node<Value>] {
        return children
    }
}
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

let terri = Node("Terri") {
    Node("Gertrude") {
        Node("Steve")
        Node("Louis")
    }
    Node("Peter")
}

print(mother)
print(dean == lynda)
print(dean != lynda)
print(lynda == lynda)
print(terri.count)
print(terri)
print(StringTreeBuilder.printTree(terri, depth: 0))
