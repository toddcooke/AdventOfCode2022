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
    func contains(other: Assignment) -> Bool {
        endSection - other.endSection >= 0 &&
                other.startSection - startSection >= 0
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
        if assignmentOne.contains(other: assignmentTwo) || assignmentTwo.contains(other: assignmentOne) {
            fullyContainCount += 1
        }
    }
    return fullyContainCount
}