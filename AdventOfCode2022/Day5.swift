//
// Created by Todd Cooke on 12/5/22.
//

import Foundation

func day5(partTwo: Bool = false) -> String {
    let contents = try! String(contentsOfFile: adventDir + "day5.txt")
    let split: [String] = contents.components(separatedBy: "\n\n")
    let startingStacks = split[0].components(separatedBy: "\n")
    let procedure = split[1]

    // Set up stacks
    let columnCount = startingStacks[startingStacks.count - 1].components(separatedBy: "   ").count
    var stacks: [[Character]] = []
    for _ in 1...columnCount {
        stacks.append([])
    }
    for (i, line) in startingStacks.enumerated() {
        if i == startingStacks.count - 1 { // skip last line of: 1  2  3
            break
        }
        for (j, item) in line.enumerated() {
            if (j - 1) % 4 == 0 && item.isLetter {
                let index = (j - 1) / 4
                stacks[index].append(item)
            }
        }
    }
    for (i, _) in stacks.enumerated() {
        stacks[i].reverse()
    }

    // Move items
    for line in procedure.components(separatedBy: "\n") {
        let split = line.components(separatedBy: " ")
        let moveCount = Int(split[1])!
        let from = Int(split[3])!
        let to = Int(split[5])!

//        print("stacks pre move:")
//        print(stacks)
        if partTwo {
            let moved = stacks[from - 1].suffix(moveCount)
            stacks[from - 1].removeLast(moveCount)
            stacks[to - 1].append(contentsOf: moved)
        } else {
            for _ in 1...moveCount {
//            print("movecount,from,to")
//            print(moveCount, from, to)
                let moved = stacks[from - 1].popLast()!
                stacks[to - 1].append(moved)
            }
        }
//        print("stacks post move:")
//        print(stacks)
    }

    let topOfStacks: [Character] = stacks.map {
        $0.last!
    }
    return String(topOfStacks)
}