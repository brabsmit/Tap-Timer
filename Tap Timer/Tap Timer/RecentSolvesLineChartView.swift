//
//  ChartsView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/27/20.
//

import SwiftUI
import SwiftUICharts
import CoreData

struct RecentSolvesLineChartView: View {
    
    @Environment(\.managedObjectContext) var context
    
    let fetchedSolves: FetchedResults<Solve>
    
    func makeLineChartFromSolves(solveCount: Int) -> Array<Double> {
        
        var solveTimes = [Double]()
        var i = 1
        
        // Check to see if we have enough solves
        if (fetchedSolves.count < solveCount) {
            i = solveCount - fetchedSolves.count
        }
        // This function returns an array with the solveCount most recent solve times
        while i < solveCount {
            for solve in fetchedSolves {
                solveTimes.append(solve.solveTime)
                i += 1
            }
        }
        return solveTimes.reversed()
    }
    
    var body: some View {
        
        let lineChartFromSolves = makeLineChartFromSolves(solveCount: 6)
        
        NavigationLink(destination: LineChartDetailView()) {
            LineChartView(data: lineChartFromSolves, title: "3x3")
        }
    }
}

struct LineChartDetailView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Solve.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Solve.solveDate, ascending: false)]
        ) var fetchedSolves: FetchedResults<Solve>
    
    func makeLineChartFromAllSolves() -> Array<Double> {
        
        var solveTimes = [Double]()
        
        for solve in fetchedSolves {
            solveTimes.append(solve.solveTime)
        }
        
        return solveTimes
    }
    
    var body: some View {
        
        let solveTimes = makeLineChartFromAllSolves()
        
        LineView(data: solveTimes, title: "3x3", legend: "Seconds")
    }
    
}
