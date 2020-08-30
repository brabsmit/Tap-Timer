//
//  StopWatchView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/27/20.
//

import SwiftUI

struct TimerButton: ButtonStyle {
    
    let buttonColor: Color
    let isPressable: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 90)
            .background(isPressable ? configuration.isPressed ? .yellow : buttonColor : buttonColor)
            .cornerRadius(10)
    }
}

struct StopWatchView: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        Text(String(format: "%.2f", stopWatchManager.secondsElapsed))
            .font(.custom("Avenir", size: 40))
            .padding(.top, 100)
            .padding(.bottom, 100)
        if stopWatchManager.mode == .stopped {
            Button(action: {self.stopWatchManager.start()}) {
                    Text("Start")
            }.buttonStyle(TimerButton(buttonColor:.green, isPressable: false))
        }
        if stopWatchManager.mode == .running {
            Button(action:
                    {self.stopWatchManager.pause()}) {
                Text("Stop")
            }.buttonStyle(TimerButton(buttonColor:.red, isPressable: true))
        }
        if stopWatchManager.mode == .paused {
            Button(action:
                    {self.stopWatchManager.stop()})
            {
                Text("Save & Reset")
            }.buttonStyle(TimerButton(buttonColor:.blue, isPressable: false))
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
