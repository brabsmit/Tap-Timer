//
//  SolveDetailView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/27/20.
//

import SwiftUI

struct SolveDetailView: View {
    
    let solve: Solve
    
    func dateToString(solveDate: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return(formatter1.string(from: solveDate))
    }
    
    var body: some View {
        VStack {
            Text(dateToString(solveDate: solve.solveDate))
            Text(String(format: "%.2f", solve.solveTime))
            Text(solve.solveScramble)
            Text(solve.solveType)
        }
    }
}
