//
//  SolvesListView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/27/20.
//

import SwiftUI

struct SolvesListView: View {
    
    @Environment(\.managedObjectContext) var context
    
    let debug = false
    let fetchedSolves: FetchedResults<Solve>
    
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
        ScrollView {
            List {
                Section(header: Text("Recent Solves")) {
                    ForEach(fetchedSolves) { solve in
                        NavigationLink(destination: SolveDetailView(solve:solve)) {
                            Text(String(format: "%.2f", solve.solveTime))
                        }
                    }.onDelete(perform: removeSolve)
                }
            }.frame(height: 300)
        }
    }
}
