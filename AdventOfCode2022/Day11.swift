//
// Created by Todd Cooke on 12/11/22.
//

import Foundation

private extension String {
    func expression(one: Int, two: Int) -> Int {
        if self == "+" {
            return one + two
        } else if self == "-" {
            return one - two
        } else if self == "*" {
            return one * two
        } else if self == "/" {
            return one / two
        } else {
            fatalError("op case not handled: " + self)
        }
    }
}

class Monkey {
    var monkeyNumber: Int
    var startingItems: [Int]
    var op: String // +, -
    var opNumbers: [Int] // 19 / []
    var testDivisibleBy: Int
    var ifTrue: Monkey?
    var ifFalse: Monkey?
    var inspectCount = 0

    init(monkeyNumber: Int, startingItems: [Int], op: String, opNumbers: [Int], testDivisibleBy: Int, ifTrue: Monkey?, ifFalse: Monkey?) {
        self.monkeyNumber = monkeyNumber
        self.startingItems = startingItems
        self.op = op
        self.opNumbers = opNumbers
        self.testDivisibleBy = testDivisibleBy
        self.ifTrue = ifTrue
        self.ifFalse = ifFalse
    }

    /**
    Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3
     */
    func inspect() {
        for _ in startingItems {
            let item = startingItems.removeFirst()
            inspectCount += 1
            let itemResult = {
                if opNumbers.isEmpty {
                    return op.expression(one: item, two: item)
                } else {
                    return op.expression(one: item, two: opNumbers.first!)
                }
            }() / 3

            print()
            print("Monkey \(monkeyNumber) inspected items \(inspectCount) times.")
            print("""
                  Monkey \(monkeyNumber):
                    Monkey inspects an item with a worry level of \(item).
                        Worry level is \(op) by \(opNumbers) to \(itemResult).
                        Monkey gets bored with item. Worry level is divided by \(testDivisibleBy) to \(itemResult / testDivisibleBy).
                  """)
            // test if divisible
            if itemResult % testDivisibleBy == 0 {
                print("Current worry level is divisible by \(testDivisibleBy)")
                print("Item with worry level \(itemResult / testDivisibleBy) is thrown to monkey \(String(describing: ifTrue?.monkeyNumber))")
                ifTrue!.startingItems.append(itemResult / testDivisibleBy)
            } else {
                print("Current worry level is not divisible by \(testDivisibleBy)")
                print("Item with worry level \(itemResult / testDivisibleBy) is thrown to monkey \(String(describing: ifFalse?.monkeyNumber))")
                ifFalse!.startingItems.append(itemResult / testDivisibleBy)
            }
        }
    }
}

func day11() -> Int {
    let contents = try! String(contentsOfFile: adventDir + "day11.txt")
    let monkeyStrings: [String] = contents.components(separatedBy: "\n\n")
    var monkeyMap = [Int: Monkey]()

    // init monkeys
    for monkey in monkeyStrings {
        let monkeyNum: Int = Int(String(monkey.components(separatedBy: ":")[0].last!))!
        let startingItems: [Int] = monkey
                .components(separatedBy: "\n")[1]
                .components(separatedBy: ": ")[1]
                .components(separatedBy: ", ")
                .map { str in
                    Int(str)!
                }
        let opNumbers: [Int] = monkey
                .components(separatedBy: "\n")[2]
                .components(separatedBy: "= ")[1]
                .components(separatedBy: " ")
                .filter { str in
                    Int(str) != nil
                }
                .map { str in
                    Int(str.trimmingCharacters(in: .whitespacesAndNewlines))!
                }
        print("xxx", opNumbers)
        let op: String = monkey
                .components(separatedBy: "\n")[2]
                .components(separatedBy: " ")
                .reversed()[1]
        let testDivisibleBy = Int(monkey
                .components(separatedBy: "\n")[3]
                .components(separatedBy: " ").last!)!

        let m = Monkey(
                monkeyNumber: monkeyNum,
                startingItems: startingItems,
                op: op,
                opNumbers: opNumbers,
                testDivisibleBy: testDivisibleBy,
                ifTrue: nil,
                ifFalse: nil)
        monkeyMap[monkeyNum] = m
    }

    // set true/false monkeys
    for monkey in monkeyStrings {
        let trueMonkeyNum = Int(monkey
                .components(separatedBy: "\n")[4]
                .components(separatedBy: " ").last!)!
        let falseMonkeyNum = Int(monkey
                .components(separatedBy: "\n")[5]
                .components(separatedBy: " ").last!)!
        let monkeyNum: Int = Int(String(monkey.components(separatedBy: ":")[0].last!))!
        monkeyMap[monkeyNum]?.ifTrue = monkeyMap[trueMonkeyNum]
        monkeyMap[monkeyNum]?.ifFalse = monkeyMap[falseMonkeyNum]
    }

    for _ in 1...20 {
//        print(round)
        for monkey in monkeyMap.values.sorted(by: { element, element2 in
            element.monkeyNumber < element2.monkeyNumber
        }) {
            monkey.inspect()
        }
    }

    let topMonkeys = monkeyMap.values
            .sorted { one, two in
                one.inspectCount > two.inspectCount
            }[0...1]
            .map { monkey in
                print(monkey.inspectCount)
                return monkey.inspectCount
            }

    print("final values", monkeyMap.values.map {
        $0.inspectCount
    })

    print(topMonkeys)
    return topMonkeys.first! * topMonkeys.last!
}