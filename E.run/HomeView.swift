//
//  HomeView.swift
//  E.run
//
//  Created by Madina Jumaly on 17.10.2024.
//

import SwiftUI
import MapKit

struct AreaMap: View {
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        let binding = Binding(
            get: { self.region },
            set: { newValue in
                DispatchQueue.main.async {
                    self.region = newValue
                }
            }
        )
        return Map(coordinateRegion: binding, showsUserLocation: true)
            .ignoresSafeArea()
    }
}

struct HomeView: View {
    @StateObject var runTracker = RunTracker()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .bottom) {
                    AreaMap(region: $runTracker.region)
                    Button{
                        runTracker.presentCountdown = true
                    } label:{
                        Text("Start")
                            .bold()
                            .font(.title)
                            .foregroundStyle(.black)
                            .padding(36)
                            .background(.yellow)
                            .clipShape(Circle())
                    }
                    .padding(.bottom, 48)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("E.run")
            .fullScreenCover(isPresented: $runTracker.presentCountdown, content: {
                CountdownView()
                    .environmentObject(runTracker)
            })
            .fullScreenCover(isPresented: $runTracker.presentRunView, content: {
                RunView()
                    .environmentObject(runTracker)
            })
            .fullScreenCover(isPresented: $runTracker.presentPauseView, content: {
                PauseView()
                    .environmentObject(runTracker)
            })
        }
    }
}

#Preview {
    HomeView()
}
