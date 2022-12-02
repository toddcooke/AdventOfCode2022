//
// Created by Todd Cooke on 12/2/22.
//

import Foundation

protocol Material {

}

/// 1 for rock
// 2 for paper
// 3 for scissors
// 0 if loss
// 3 if draw
// 6 if win
extension Material {
    func versus(_ other: Material) -> Int {
        if self is Rock && other is Rock {
            return 1 + 3
        } else if self is Rock && other is Paper {
            return 1 + 0
        } else if self is Rock && other is Scissors {
            return 1 + 6
        }

        if self is Paper && other is Paper {
            return 2 + 3
        } else if self is Paper && other is Scissors {
            return 2 + 0
        } else if self is Paper && other is Rock {
            return 2 + 6
        }

        if self is Scissors && other is Scissors {
            return 3 + 3
        } else if self is Scissors && other is Rock {
            return 3 + 0
        } else if self is Scissors && other is Paper {
            return 3 + 6
        }

        print("error: shouldn't get here")
        exit(1)
    }
}

struct Rock: Material {
}

struct Paper: Material {
}

struct Scissors: Material {
}

extension String {
    func toMaterial() -> Material {
        if self == "A" || self == "X" {
            return Rock()
        } else if self == "B" || self == "Y" {
            return Paper()
        } else if self == "C" || self == "Z" {
            return Scissors()
        }
        print("oops, not a material!")
        exit(1)
    }
}

func day2() -> Int {
    var score = 0
    let contents = try! String(contentsOfFile: adventDir + "day2.txt")
    let rounds = contents.split(separator: "\n")

    for round in rounds {
        let opponentAndSelf = round.split(separator: " ")
        let opponent = String(opponentAndSelf[0]).toMaterial()
        let me = String(opponentAndSelf[1]).toMaterial()
        let result = me.versus(opponent)
        score += result
    }
    return score
}