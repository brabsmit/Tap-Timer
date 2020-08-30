//
//  AverageSolvesBarChartView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/27/20.
//

import SwiftUI
import SwiftUICharts
import CoreData

struct AverageSolvesBarChartView: View {
    
    @Environment(\.managedObjectContext) var context
    
    let fetchedSolves: FetchedResults<Solve>
    
    class DateSolve {
        var date: Date
        var solve: Double
        
        init(date: Date, solve: Double) {
            self.date = date
            self.solve = solve
        }
    }
    
    class DateSolveArray {
        var dateSolve: Array<DateSolve>
        
        init(dateSolves: Array<DateSolve>) {
            self.dateSolve = [DateSolve]()
            for dateSolve in dateSolves {
                self.dateSolve.append(dateSolve)
            }
        }
        
        func append(dateSolve: DateSolve) {
            self.dateSolve.append(dateSolve)
        }
    }
    
    func makeAverageSolveTimeBarChart(fetchedSolves: FetchedResults<Solve>) -> Array<(String, Double)> {
        var solvesList = [(String, Double)]()
        
        let calendar = Calendar.current
        let searchDate = Date()
        
        var daysInChart = 0
        var daysSearched = 0
        
        for solve in fetchedSolves {
            while daysSearched < 5 {
                let dateFrom = Calendar.current.startOfDay(for: calendar.date(byAdding: .day, value: (-1*daysSearched), to: searchDate)!)
                let dateTo = Calendar.current.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: dateFrom)!)
                
                let range = dateFrom...dateTo
                
                if range.contains(solve.solveDate) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMM d"
                    let solveDate = formatter.string(from: solve.solveDate)
                    solvesList.append((solveDate,solve.solveTime))
                }
                daysSearched += 1
            }
        }
        
        return solvesList.reversed()
    }
    
    var body: some View {
        
        let _ = makeAverageSolveTimeBarChart(fetchedSolves: fetchedSolves)
        
        BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "3x3", legend: "Daily") // legend is optional
    }
}
