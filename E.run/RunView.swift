//
//  RunView.swift
//  E.run
//
//  Created by Madina Jumaly on 21.10.2024.
//

import SwiftUI
import AudioToolbox

struct RunView: View {
    @EnvironmentObject var runTracker: RunTracker
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("\(runTracker.distance,specifier: "%.2f" ) m")
                        .font(.title3)
                        .bold()
                    Text("Distance")
                }
                .frame(maxWidth: .infinity)
                
                VStack{
                    Text("BPM")
                }
                .frame(maxWidth: .infinity)
                
                VStack{
                    Text("\(runTracker.pace, specifier: "%.2f") min/km")
                        .font(.title3)
                        .bold()
                    Text("Pace")
                }
                .frame(maxWidth: .infinity)
            }
            
            VStack{
                Text("\(runTracker.elapsedTime.convertDurationToString())")
                    .font(.system(size: 64))
                
                Text("Time")
                    .foregroundStyle(.gray)
            }
            .frame(maxHeight: .infinity)
            
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
                    runTracker.pauseRun()
                    
                } label: {
                    Image(systemName: "pause.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(36)
                        .background(.black)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.yellow)
    }
}

#Preview{
    RunView()
        .environmentObject(RunTracker())
}
