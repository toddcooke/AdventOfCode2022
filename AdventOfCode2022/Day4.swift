//
// Created by Todd Cooke on 12/4/22.
//

import Foundation

extension String {
    func toAssignment() -> Assignment {
        let assignmentParts = self.components(separatedBy: "-")
        return Assignment(
                startSection: Int(assignmentParts.first!)!,
                endSection: Int(assignmentParts.last!)!
        )
    }
}

struct Assignment {
    var startSection: Int
    var endSection: Int

    func fullyContains(other: Assignment) -> Bool {
        endSection - other.endSection >= 0 &&
                other.startSection - startSection >= 0
    }

    func hasSameSection(other: Assignment) -> Bool {
        endSection - other.startSection >= 0 &&
                other.endSection - startSection >= 0
    }
}

func day4() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day4.txt")
    let sectionAssignmentPairs: [String] = contents.components(separatedBy: "\n")
    var fullyContainCount = 0
    for pair in sectionAssignmentPairs {
        let split = pair.components(separatedBy: ",")
        let assignmentOne: Assignment = (split.first?.toAssignment())!
        let assignmentTwo: Assignment = (split.last?.toAssignment())!
        if assignmentOne.fullyContains(other: assignmentTwo) || assignmentTwo.fullyContains(other: assignmentOne) {
            fullyContainCount += 1
        }
    }
    return fullyContainCount
}

func day4Part2() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day4.txt")
    let sectionAssignmentPairs: [String] = contents.components(separatedBy: "\n")
    var fullyContainCount = 0
    for pair in sectionAssignmentPairs {
        let split = pair.components(separatedBy: ",")
        let assignmentOne: Assignment = (split.first?.toAssignment())!
        let assignmentTwo: Assignment = (split.last?.toAssignment())!
        if assignmentOne.hasSameSection(other: assignmentTwo) {
            fullyContainCount += 1
        }
    }
    return fullyContainCount
}
