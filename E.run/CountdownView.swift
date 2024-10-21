//
//  CountdownView.swift
//  E.run
//
//  Created by Madina Jumaly on 18.10.2024.
//

import SwiftUI

struct CountdownView: View {
    @EnvironmentObject var runTracker: RunTracker
    @State var timer: Timer?
    @State var countdown = 3
    
    var body: some View {
        Text("\(countdown)")
            .font(.system(size: 256))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
            .onAppear{
                setupCountdown()
            }
    }
    
    func setupCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            if countdown <= 1 {
                timer?.invalidate()
                timer = nil
                runTracker.presentCountdown = false
                runTracker.startRun()
            } else {
                countdown -= 1
            }
        }
    }
}
#Preview {
    CountdownView()
}
