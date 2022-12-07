//
// Created by Todd Cooke on 12/7/22.
//

import Foundation

// start at root node

// ls means add all as children to current node
// cd x means change current node to x

// walk tree and get dirs with size < 100000
// sum all dirs with size < 100000

class Node: CustomStringConvertible {
    var description: String {
        "\(name) \(size) \(!children.isEmpty)"
    }

    var children: [Node] = []
    var size: Int
    var parent: Node?
    var name: String

    init(name: String, children: [Node], parent: Node?) { // dirs
        self.children = children
        self.size = 0
        self.parent = parent
        self.name = name
    }

    init(name: String, size: Int, parent: Node?) { // files
        self.size = size
        self.parent = parent
        self.name = name
    }


}

/// https://www.geeksforgeeks.org/generic-tree-level-order-traversal/
func sumDirSize(root: Node) {
    var q: [Node] = []
    q.append(root)
    while !q.isEmpty {
        var n = q.count
        while n > 0 {
            let p = q.removeFirst()
            print(p)
            for c in p.children {
                q.append(c)
            }
            if p.children.isEmpty {
                // propagate size to parent dirs
                var par: Node? = p.parent
                while par != nil {
                    // TODO: this seems to not work correctly
                    p.parent!.size += p.size
                    par = p.parent
                }
            }
            n -= 1
        }
    }
}

func sumDirsOver100k(root: Node) -> Int {
    var sum = 0
    var toSum: [Node] = []
    var q: [Node] = []
    q.append(root)
    while !q.isEmpty {
        var n = q.count
        while n > 0 {
            let p = q.removeFirst()
            print(p)
            if !p.children.isEmpty && p.size <= 100000 {
                sum += p.size
                toSum.append(p)
            }
            for c in p.children {
                q.append(c)
            }
            n -= 1
        }
    }
    print(toSum)
    return sum
}

func day7() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day7.txt")
    let output: [String] = contents.components(separatedBy: "\n")
    let root = Node(name: "/", children: [], parent: nil)
    var current = root

    for line in output {
        let components = line.components(separatedBy: " ")
        if line.starts(with: "$") {
            if components[1] == "cd" {
                if components[2] == "/" {
                    // make current = root
                    current = root
                } else if components[2] == ".." {
                    // make current = current.parent
                    current = current.parent!
                } else {
                    // make current = components[2]
                    current = current.children.first {
                        $0.name == components[2]
                    }!
                }
            } else if components[1] == "ls" {
                // add following lines as children to current
            } else {
                print("Error: command not cd or ls")
                exit(1)
            }
        } else if line.starts(with: "dir") {
            // add Node.dir to current
            current.children.append(Node(name: components[1], children: [], parent: current))
        } else {
            // add Node.file to current
            current.children.append(Node(name: components[1], size: Int(components[0])!, parent: current))
        }
    }

    sumDirSize(root: root)
    print()
    return sumDirsOver100k(root: root)
}