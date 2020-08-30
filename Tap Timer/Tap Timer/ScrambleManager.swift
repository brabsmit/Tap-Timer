//
//  ScrambleManager.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/30/20.
//

import Foundation
import SwiftUI

class ScrambleManager {

    let rotations = ["F", "R", "U", "L", "B", "D"]
    let directions = ["", "'"]
    let turns = ["", "2"]

    func run() -> String {
        
        var scramble = [String]()
        var scrambleLength = 10
        var scrambleText = ""
        
        while scrambleLength > 1 {
            
            // Pick the rotation face
            let rotation = rotations[Int.random(in: 0..<rotations.count)]
            var turn = ""
            var direction = ""
            
            // Pick rotation direction
            let clockwise = [true, false][Int.random(in: 0...1)]
            
            if clockwise {
                
                // If clockwise, pick number of turns
                turn = turns[Int.random(in: 0...1)]
            } else {
                
                // If counterclockwise
                direction = directions[Int.random(in: 0...1)]
            }
            
            var goodScramble = true
            
            // Check if valid scramble move
            if scramble.count > 0 {
                let prevScramble = scramble[scramble.endIndex-1]
                let prevRotation = prevScramble.character(at: 0)
                if prevRotation == rotation {
                    goodScramble = false
                }
            }
            
            if goodScramble {
                // Append good scramble move
                scramble.append(rotation + direction + turn)
                scrambleLength -= 1
            }
            
        }
        
        for move in scramble {
            scrambleText += move + " "
        }
        
        return String(scrambleText.dropLast())
    }
}

extension String {
 
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
 
    func character(at position: Int) -> String? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return String(self[indexPosition])
    }
}
