//
// Created by Todd Cooke on 12/9/22.
//

import Foundation

class Point: CustomStringConvertible {
    var description: String {
        "x:\(x) y:\(y) head=\(head != nil)"
    }

    var x: Int = 0
    var y: Int = 0
    var tilesVisited: Set<[Int]> = [[0, 0]]
    var head: Point? = nil // only tail should have pointer to head
    var lastPoint: [Int] = [0, 0] // used for tail to jump back to head

    init(x: Int, y: Int, head: Point?) {
        self.x = x
        self.y = y
        self.head = head
    }

    func move(_ direction: String) {
        if head == nil { // Move head
            lastPoint = [x, y]
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
        } else { // Move tail
            if onTopOf(head!) || isDiagonal(head!) || isAdjacent(head!) {
                return
            }
            moveToLastPoint()
        }
    }

    func moveToLastPoint() {
        x = head!.lastPoint.first!
        y = head!.lastPoint.last!
        tilesVisited.insert([x, y])
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
        x + 1 == other.x && y == other.y ||
                x - 1 == other.x && y == other.y ||
                y + 1 == other.y && x == other.x ||
                y - 1 == other.y && x == other.x
    }

    func isDiagonal(_ other: Point) -> Bool {
        x + 1 == other.x && y + 1 == other.y || // Top right
                x + 1 == other.x && y - 1 == other.y || // Bottom right
                x - 1 == other.x && y - 1 == other.y || // Bottom left
                x - 1 == other.x && y + 1 == other.y // Top left
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
//            print("\nBefore move")
//            print("head", head)
//            print("tail", tail)
            head.move(direction)
            tail.move(direction)
//            print("After move")
//            print("head", head)
//            print("tail", tail)
        }
    }

    return tail.tilesVisited.count
}