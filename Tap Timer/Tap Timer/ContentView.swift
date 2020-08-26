//
//  ContentView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/26/20.
//

import SwiftUI
import CoreData

struct TimerButton: View {
    
    let label: String
    let buttonColor: Color
    
    var body: some View {
        Text(label)
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 90)
            .background(buttonColor)
            .cornerRadius(10)
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    @FetchRequest(
        entity: Solve.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Solve.solveDate, ascending: false)]
        ) var fetchedSolves: FetchedResults<Solve>
    
    var body: some View {
        VStack {
            Text(String(format: "%.2f", stopWatchManager.secondsElapsed))
                .font(.custom("Avenir", size: 40))
                .padding(.top, 200)
                .padding(.bottom, 100)
            if stopWatchManager.mode == .stopped {
                Button(action: {self.stopWatchManager.start()}) {
                        TimerButton(label: "Start", buttonColor: .green)
                            }
            }
            if stopWatchManager.mode == .running {
                Button(action:
                        {self.stopWatchManager.pause()}) {
                    TimerButton(label: "Stop", buttonColor:.red)
                }
            }
            if stopWatchManager.mode == .paused {
                Button(action:
                        {self.stopWatchManager.stop()})
                {
                    TimerButton(label:"Reset", buttonColor:.blue)
                }
            }
            List {
                ForEach(fetchedSolves) { solve in
                    Text(String(format: "%.2f", solve.solveTime))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
