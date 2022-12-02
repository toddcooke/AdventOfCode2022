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

func day1Part2() -> Int {
    var first = -1
    var second = -1
    var third = -1

    let contents = try! String(contentsOfFile: adventDir + "day1.txt")
    let elves = contents.split(separator: "\n\n")

    for elf in elves {
        var total = 0
        for calorie in elf.split(separator: "\n") {
            total += Int(calorie)!
        }
        if total > first {
            third = second
            second = first
            first = total
        } else if total > second {
            third = second
            second = total
        } else if total > third {
            third = total
        }
    }

    return [first, second, third].reduce(0, +)
}