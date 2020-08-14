//
//  StopWatchManager.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/13/20.
//

import Foundation
import SwiftUI
import CoreData

class StopWatchManager: ObservableObject {
    enum stopWatchMode {
        case running
        case paused
        case stopped
    }
    
    @Published var secondsElapsed = 0.00
    @Published var mode: stopWatchMode = .stopped
    
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
        secondsElapsed = 0
        mode = .stopped
    }
}
