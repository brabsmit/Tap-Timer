//
//  ScramblerView.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/30/20.
//

import SwiftUI

struct ScramblerView: View {
    
    var scrambleManager = ScrambleManager()
    
    var body: some View {
        
        let scramble = scrambleManager.run()

        Text(scramble)
    }
}

struct ScramblerView_Previews: PreviewProvider {
    static var previews: some View {
        ScramblerView()
    }
}
