//
//  StopWatchManager.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/26/20.
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        let newSolve = Solve(context: self.context)
        newSolve.solveDate = Date()
        newSolve.solveTime = secondsElapsed
        do {
            try self.context.save()
        } catch {
            // TODO: catch context save exception
            print(error.localizedDescription)
        }
        
        secondsElapsed = 0
        mode = .stopped
    }
}
