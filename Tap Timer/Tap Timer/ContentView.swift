//
//  ContentView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/26/20.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Solve.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Solve.solveDate, ascending: false)]
        ) var fetchedSolves: FetchedResults<Solve>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    StopWatchView().padding(.bottom, 20)
                    HStack {
                        RecentSolvesLineChartView(fetchedSolves: fetchedSolves)
                        AverageSolvesBarChartView(fetchedSolves: fetchedSolves)
                    }
                    SolvesListView(fetchedSolves: fetchedSolves).padding(.bottom, 20)
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
