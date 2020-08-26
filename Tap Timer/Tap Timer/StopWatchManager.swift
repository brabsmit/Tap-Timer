//
//  StopWatchManager.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/13/20.
//

import Foundation
import SwiftUI

class StopWatchManager: ObservableObject {
    enum stopWatchMode {
        case running
        case paused
        case stopped
    }
    
    @Published var secondsElapsed = 0.00
    @Published var mode: stopWatchMode = .stopped
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
            timer in
            self.secondsElapsed += 0.01
        }
    }
    
    func pause() {
        timer.invalidate()
        mode = .paused
    }
    
    func stop() {
        /*let newSolve = Solve(context: managedObjectContext)
        newSolve.solveDate = Date()
        newSolve.solveTime = secondsElapsed
        do {
            try managedObjectContext.save()
            print("Order saved.")
        } catch {
            print(error.localizedDescription)
        }*/
        
        secondsElapsed = 0
        mode = .stopped
    }
}
