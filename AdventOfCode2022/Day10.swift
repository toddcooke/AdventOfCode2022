//
// Created by Todd Cooke on 12/10/22.
//

import Foundation

/**
noop // takes one cycle to complete
addx 3 // addx takes 2 cycles to complete
addx -5
 */
func day10() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day10.txt")
    let instructions: [String] = contents.components(separatedBy: "\n")

    var cycles: [Int] = [1]

    // set cycle values
    for instruction in instructions {
        if instruction.starts(with: "noop") {
            cycles.append(0)
        } else {
            let components = instruction.components(separatedBy: " ")
            cycles.append(0)
            cycles.append(Int(components[1])!)
        }
    }

    // Sum cycle values
    var sum = 0
    var sums: [Int] = []
    for (i, cycle) in cycles.enumerated() {

        if [20, 60, 100, 140, 180, 220].contains(i) {
            sums.append(sum * i)
        }
        sum += cycle
    }

    return sums.reduce(0, +)
}