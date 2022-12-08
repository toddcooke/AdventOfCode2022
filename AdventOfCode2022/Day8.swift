//
// Created by Todd Cooke on 12/8/22.
//

import Foundation

func day8() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day8.txt")
    let lines: [String] = contents.components(separatedBy: "\n")
    var trees: [[Int]] = []
    var visibleTrees: [[Int]] = []

    // Create array of trees
    for (i, line) in lines.enumerated() {
        var lineOfTrees: [Int] = []
        for (j, tree) in line.enumerated() {
            lineOfTrees.append(Int(String(tree))!)
        }
        trees.append(lineOfTrees)
        visibleTrees.append(lineOfTrees.map {
            $0 * 0
        })
    }

    // Count visible trees
    for (i, line) in trees.enumerated() {
        for (j, tree) in line.enumerated() {
            var row = i
            var col = j

            // go down row
            while row < trees.count {
                print(row, col)
                if trees[row][col] < trees[i][j] {
                    visibleTrees[row][col] = 1
                    break
                }
                row += 1
            }
            row = i

            // go up row
            while row < trees.count {
                print(row, col)
                if trees[row][col] < trees[i][j] {
                    visibleTrees[row][col] = 1
                    break
                }
                row -= 1
            }
            row = i

            // go right across col
            while col < trees[0].count {
                print(row, col)
                if trees[row][col] < trees[i][j] {
                    visibleTrees[row][col] = 1
                    break
                }
                col += 1
            }
            col = j

            // go left across col
            while col >= 0 {
                print(row, col)
                if trees[row][col] < trees[i][j] {
                    visibleTrees[row][col] = 1
                    break
                }
                col -= 1
            }
            col = j
        }
    }

    var total = 0
    for (i, line) in visibleTrees.enumerated() {
        for (j, tree) in line.enumerated() {
            let intTree = Int(String(tree))!
            // trees around edge are always visible
            if i == 0 || j == 0 || i == visibleTrees.count - 1 || j == visibleTrees[0].count - 1 {
                visibleTrees[i][j] = 1
            }
            if intTree > 0 {
                total += 1
            }
        }
    }
    return total
}