//
// Created by Todd Cooke on 12/2/22.
//

import Foundation


func day1() -> Int {
    var mostCals = -1

    let contents = try! String(contentsOfFile: adventDir + "day1.txt")
    let elves = contents.split(separator: "\n\n")

    for elf in elves {
        var total = 0
        for calorie in elf.split(separator: "\n") {
            total += Int(calorie)!
        }
        if total > mostCals {
            mostCals = total
        }
    }

    return mostCals
}