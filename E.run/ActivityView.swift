//
//  ActivityView.swift
//  E.run
//
//  Created by Madina Jumaly on 21.10.2024.
//

import SwiftUI

struct ActivityView: View {
    @State var activities = [RunPayload]()
      
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities){ run in
                    VStack (alignment: .leading){
                        Text("Morning Run")
                            .font(.title3)
                            .bold()
                        
                        Text(formatDate(date: run.createdAt))
                            .font(.caption)
                        
                        HStack (spacing: 24){
                            VStack(alignment: .leading){
                                Text("Distance")
                                    .font(.caption)
                                
                                Text("\(run.distance / 1000, specifier: "%.2f") km")
                                    .font(.headline)
                                    .bold()
                            }
                            
                            VStack{
                                Text("Pace")
                                    .font(.caption)
                                
                                Text("\(Int(run.pace).convertDurationToString()) /km")
                                    .font(.headline)
                                    .bold()
                            }
                            
                            VStack{
                                Text("Time")
                                    .font(.caption)
                                
                                Text("\(run.time.convertDurationToString())")
                                    .font(.headline)
                                    .bold()
                            }
                        }
                        .padding(.vertical)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Activity")
            .onAppear{
                Task {
                    do {
                        activities = try await DatabaseService.shared.fetchWorkouts()
                        activities.sort(by: { $0.createdAt >= $1.createdAt})
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    ActivityView()
}
