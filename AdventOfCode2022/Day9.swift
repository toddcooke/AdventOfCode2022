//
// Created by Todd Cooke on 12/9/22.
//

import Foundation

class Point: CustomStringConvertible {
    var description: String {
        "x:\(x) y:\(y) tilesVisited:\(tilesVisited) head=\(head != nil)"
    }

    var x: Int = 0
    var y: Int = 0
    var tilesVisited: Set<[Int]> = [[0, 0]]
    var head: Point? = nil // only tail should have pointer to head
    var lastMove = ""

    init(x: Int, y: Int, head: Point?) {
        self.x = x
        self.y = y
        self.head = head
    }

    func move(_ direction: String) {
        if head != nil && onTopOf(head!) {
            return
        }
        if head != nil && isDiagonal(head!) {
            // do nothing
            print("moving diagonally...")
            return
        }
        if head == nil || (head != nil && isAdjacent(head!)) {
            lastMove = direction
            // move normally
            if direction == "U" {
                up()
            } else if direction == "R" {
                right()
            } else if direction == "D" {
                down()
            } else if direction == "L" {
                left()
            } else {
                fatalError("Error: missing normal move case, direction:" + direction)
            }
        } else {
            // move diagonally
            guard let head else {
                fatalError("head must not be nil")
            }
            if head.x > x && head.y > y {
                upright()
            } else if head.x < x && head.y < y {
                downleft()
            } else if head.x > x && head.y < y {
                downright()
            } else if head.x < x && head.y > y {
                upleft()
            } else {
                fatalError("Error: missing move diagonally case")
            }
        }
    }

    func up() {
        y += 1
        tilesVisited.insert([x, y])
    }

    func right() {
        x += 1
        tilesVisited.insert([x, y])
    }

    func down() {
        y -= 1
        tilesVisited.insert([x, y])
    }

    func left() {
        x -= 1
        tilesVisited.insert([x, y])
    }

    func upright() {
        x += 1
        y += 1
        tilesVisited.insert([x, y])
    }

    func downright() {
        x += 1
        y -= 1
        tilesVisited.insert([x, y])
    }

    func downleft() {
        x -= 1
        y -= 1
        tilesVisited.insert([x, y])
    }

    func upleft() {
        x -= 1
        y += 1
        tilesVisited.insert([x, y])
    }

    func isAdjacent(_ other: Point) -> Bool {
        (abs(x - other.x) + abs(y - other.y)) <= 1
    }

    func isDiagonal(_ other: Point) -> Bool {
        (x + 1 == other.x && y + 1 == other.y ||
                x - 1 == other.x && y - 1 == other.y ||
                x - 1 == other.x && y + 1 == other.y ||
                x + 1 == other.x && y - 1 == other.y
        )
    }

    func onTopOf(_ other: Point) -> Bool {
        x == other.x && y == other.y
    }
}

func day9() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day9.txt")
    let output: [String] = contents.components(separatedBy: "\n")

    let head = Point(x: 0, y: 0, head: nil)
    let tail = Point(x: 0, y: 0, head: head)

    for line in output {
        let components = line.components(separatedBy: " ")
        let direction = components[0]
        let distance = Int(components[1])!

        for _ in 0...distance - 1 {
            head.move(direction)
            tail.move(direction)
        }
    }

    print(tail.tilesVisited.sorted { x, y in
        x.first! < y.first!
    })
//    var grid: [[Int]] = [[Int]](repeating: [], count: 10)
//    for tile in tail.tilesVisited {
//
//    }
    return tail.tilesVisited.count
}