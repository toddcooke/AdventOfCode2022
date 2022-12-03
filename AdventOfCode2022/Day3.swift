//
// Created by Todd Cooke on 12/3/22.
//

import Foundation

/**
 # one rucksack:
 vJrwpWtwJgWrhcsFMMfFFhFp
 first compartment second compartment
 vJrwpWtwJgWr      hcsFMMfFFhFp
 Lowercase item types a through z have priorities 1 through 26.
 Uppercase item types A through Z have priorities 27 through 52.
 */
func day3() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day3.txt")
    let rucksacks = contents.split(separator: "\n")
    var prioritySum = 0
    for (i, rucksack) in rucksacks.enumerated() {
        var compartment1: Set<Character> = []
        var compartment2: Set<Character> = []
        for (j, item) in rucksack.enumerated() {
            if j < rucksack.count / 2 {
                compartment1.insert(item)
            } else {
                compartment2.insert(item)
            }
        }
        guard let inBoth = compartment1.intersection(compartment2).first else {
            continue
        }
        let unicodeValue = inBoth.asciiValue!
        let val = {
            if inBoth.isLowercase {
                return Int(unicodeValue) - 96
            } else if inBoth.isUppercase {
                return Int(unicodeValue) - 38
            } else {
                print("not upper or lowercase")
                exit(1)
            }
        }()
        prioritySum += val
    }
    return prioritySum

}