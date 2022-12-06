//
// Created by Todd Cooke on 12/6/22.
//

import Foundation

func day6() -> Int {
    let input = try! String(contentsOfFile: adventDir + "day6.txt")
    var stack: [Character] = []

    for (i, char) in input.enumerated() {
        stack.append(char)
        if stack.count == 5 {
            stack.removeFirst()
        }
        if stack.count == 4 {
            let set = Set(stack)
            if set.count == 4 {
                return i + 1
            }
        }
    }

    return -1
}