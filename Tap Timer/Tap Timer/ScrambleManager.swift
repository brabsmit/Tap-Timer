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
            
            scramble.append(rotation + direction + turn)
            scrambleLength -= 1
        }
        
        for move in scramble {
            scrambleText += move + " "
        }
        
        return String(scrambleText.dropLast())
    }
}
