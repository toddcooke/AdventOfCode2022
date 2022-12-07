//
// Created by Todd Cooke on 12/7/22.
//

import Foundation


// create Node

// start at root node
// ls means add all as children to current node
// cd x means change current node to x

// walk tree and get dirs with size < 100000
// sum all dirs with size < 100000


class Node {
    var children: [Node] = []
    var size: Int?
    var parent: Node?

    init(_ children: [Node], parent: Node?) {
        self.children = children
        size = nil
        self.parent = parent
    }

    init(_ size: Int, parent: Node?) {
        self.size = size
        self.parent = parent
    }

}

func day7() {
    let contents = try! String(contentsOfFile: adventDir + "day7.txt")
    let output: [String] = contents.components(separatedBy: "\n")
    let root = Node([], parent: nil)
    var current = root

    for line in output {
        var components = line.components(separatedBy: " ")
        print(line)
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
                }
            } else if components[1] == "ls" {
                // add following lines as children to current
            } else {
                print("Error: command not cd or ls")
                exit(1)
            }
        } else if line.starts(with: "dir") {
            // add Node.dir to current
            current.children.append(Node([], parent: current))
        } else {
            // add Node.file to current
            current.children.append(Node(Int(components[0])!, parent: current))
        }
    }
    print(root)
}