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
    
    let debug = true
    
    @FetchRequest(
        entity: Solve.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Solve.solveDate, ascending: false)]
        ) var fetchedSolves: FetchedResults<Solve>
    
    func removeSolve(at offsets: IndexSet) {
        for index in offsets {
            let solve = fetchedSolves[index]
            context.delete(solve)
        }
        do {
            try context.save()
        } catch {
            // TODO: catch context save exception
            print(error.localizedDescription)
        }
    }
    
    func removeAllSolves() {
        for solve in fetchedSolves {
            context.delete(solve)
        }
        do {
            try context.save()
        } catch {
            // TODO: catch context save exception
            print(error.localizedDescription)
        }
    }
    
    @State private var showAlert = false
    var removeAllSolvesAlert: Alert {
        Alert(title: Text("DEBUG: Remove all solves?"), message: Text("All data will be lost."), primaryButton: .destructive(Text("Yes"), action: removeAllSolves), secondaryButton: .cancel(Text("No")))
        }
    
    var body: some View {
        VStack {
            Text(String(format: "%.2f", stopWatchManager.secondsElapsed))
                .font(.custom("Avenir", size: 40))
                .padding(.top, 200)
                .padding(.bottom, 100)
            if stopWatchManager.mode == .stopped && debug == false {
                Button(action: {self.stopWatchManager.start()}) {
                        TimerButton(label: "Start", buttonColor: .green)
                            }
            }
            if stopWatchManager.mode == .stopped && debug == true {
                Button(action: {self.stopWatchManager.start()}) {
                        TimerButton(label: "Start", buttonColor: .green)
                            .alert(isPresented: $showAlert, content: { self.removeAllSolvesAlert })
                            .onLongPressGesture { self.showAlert.toggle() }
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
                }.onDelete(perform: removeSolve)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
