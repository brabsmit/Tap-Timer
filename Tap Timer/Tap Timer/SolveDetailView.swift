//
//  SolveDetailView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/27/20.
//

import SwiftUI

struct SolveDetailView: View {
    
    let solve: Solve
    
    func stringToDate(solveDate: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return(formatter1.string(from: solveDate))
    }
    
    var body: some View {
        VStack {
            Text(stringToDate(solveDate: solve.solveDate ?? Date()))
            Text(String(format: "%.2f", solve.solveTime))
        }
    }
}
