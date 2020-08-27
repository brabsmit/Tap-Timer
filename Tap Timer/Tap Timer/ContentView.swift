//
//  ContentView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/26/20.
//

import SwiftUI
import CoreData

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

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    let debug = false
    
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
        NavigationView {
            VStack {
                Text("3x3")
                    .font(.custom("Avenir", size: 30))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Text(String(format: "%.2f", stopWatchManager.secondsElapsed))
                    .font(.custom("Avenir", size: 40))
                    .padding(.top, 100)
                    .padding(.bottom, 100)
                if stopWatchManager.mode == .stopped && debug == false {
                    Button(action: {self.stopWatchManager.start()}) {
                            Text("Start")
                    }.buttonStyle(TimerButton(buttonColor:.green, isPressable: false))
                }
                if stopWatchManager.mode == .stopped && debug == true {
                    Button(action: {self.stopWatchManager.start()}) {
                            Text("Start")
                                .alert(isPresented: $showAlert, content: { self.removeAllSolvesAlert })
                                .onLongPressGesture { self.showAlert.toggle() }
                    }.buttonStyle(TimerButton(buttonColor:.green,  isPressable: false))
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
                List {
                    ForEach(fetchedSolves) { solve in
                        NavigationLink(destination: SolveDetailView(solve:solve)) { Text(String(format: "%.2f", solve.solveTime))
                        }
                    }.onDelete(perform: removeSolve)
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
