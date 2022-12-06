//
// Created by Todd Cooke on 12/6/22.
//

import Foundation

func day6(partTwo: Bool = false) -> Int {
    let input = try! String(contentsOfFile: adventDir + "day6.txt")
    var stack: [Character] = []
    let markerSize = partTwo ? 14 : 4

    for (i, char) in input.enumerated() {
        stack.append(char)
        if stack.count == markerSize + 1 {
            stack.removeFirst()
        }
        if stack.count == markerSize {
            let set = Set(stack)
            if set.count == markerSize {
                return i + 1
            }
        }
    }

    return -1
}