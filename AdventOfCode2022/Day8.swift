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
    for (_, line) in lines.enumerated() {
        var lineOfTrees: [Int] = []
        for (_, tree) in line.enumerated() {
            lineOfTrees.append(Int(String(tree))!)
        }
        trees.append(lineOfTrees)
        visibleTrees.append(lineOfTrees.map { element in
            1
        })
    }

//    print(trees[2])
//    print(isTreeHidden(treeIndex: 0, row: trees[2]))
//    print(isTreeHidden(treeIndex: 1, row: trees[2]))
//    print(isTreeHidden(treeIndex: 2, row: trees[2]))
//    print(isTreeHidden(treeIndex: 3, row: trees[2]))
//    print(isTreeHidden(treeIndex: 4, row: trees[2]))
//    exit(1)


    // Find visible trees
    for (i, line) in trees.enumerated() {
        for (j, _) in line.enumerated() {
            // if row and col hidden: visible[i][j] = 1
            let rowHidden = isTreeHidden(treeIndex: i, row: line)
            let colHidden = isTreeHidden(treeIndex: j, row: columnToArray(col: j, arr: trees))
            if rowHidden && colHidden {
                visibleTrees[i][j] = 0
            }
        }
    }

    // Count visible trees
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
    print(visibleTrees)
    return total
}

func isTreeHidden(treeIndex: Int, row: [Int]) -> Bool {
    if treeIndex == 0 || treeIndex == row.count - 1 {
        return false
    }
    let tree = row[treeIndex]
    let leftOfTree = row[0...treeIndex - 1]
    let rightOfTree = row[treeIndex + 1...row.count - 1]
//    print("tree:\(row[treeIndex]) left of tree:\(leftOfTree) rightOfTree:\(rightOfTree)")
    if leftOfTree.max()! >= tree && rightOfTree.max()! >= tree {
        return true
    } else {
        return false
    }
}


/// col = 1
/// arr = [[1,2],[3,4]]
/// ret [2,4]
func columnToArray(col: Int, arr: [[Int]]) -> [Int] {
    var result: [Int] = []

    for i in arr {
        for (j, item) in i.enumerated() {
            if j == col {
                result.append(item)
            }
        }
    }
    return result
}