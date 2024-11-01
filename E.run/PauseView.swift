//
//  PauseView.swift
//  E.run
//
//  Created by Madina Jumaly on 21.10.2024.
//

import SwiftUI
import MapKit
import AudioToolbox

struct PauseView: View {
    @EnvironmentObject var runTracker: RunTracker
    var body: some View {
        VStack {
            AreaMap(region: $runTracker.region)
                .ignoresSafeArea()
                .frame(height: 300)
            HStack {
                VStack {
                    Text("\(runTracker.distance / 1000,specifier:"%.2f" )")
                        .font(.title)
                        .bold()
                    
                    Text("Km")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("\(runTracker.pace, specifier: "%.2f") min")
                        .font(.title)
                        .bold()
                    
                    Text("Avg Pace")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("\(runTracker.elapsedTime.convertDurationToString())")
                        .font(.title)
                        .bold()
                    
                    Text("Time")
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            
            HStack {
                VStack {
                    Text("0")
                        .font(.title)
                        .bold()
                    
                    Text("Calories")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("0f")
                        .font(.title)
                        .bold()
                    
                    Text("Elevation")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("65")
                        .font(.title)
                        .bold()
                    
                    Text("BPM")
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            
            HStack{
                Button {
                    //no action on tap of stop button
                } label: {
                    Image(systemName: "stop.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(36)
                        .background(.black)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture().onEnded({ _ in
                    withAnimation{
                        runTracker.stopRun()
                        AudioServicesPlayAlertSoundWithCompletion (SystemSoundID(kSystemSoundID_Vibrate)){}
                    }
                }))
                Button {
                    withAnimation{
                        runTracker.resumeRun()
                    }
                } label: {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(36)
                        .background(.black)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    PauseView()
        .environmentObject(RunTracker())
}
