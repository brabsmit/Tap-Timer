//
//  ContentView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/13/20.
//

import SwiftUI

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
    @ObservedObject var stopWatchManager = StopWatchManager()
    @Environment(\.managedObjectContext) var managedObjectContext
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
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
