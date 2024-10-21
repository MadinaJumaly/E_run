//
//  ContentView.swift
//  E.run
//
//  Created by Madina Jumaly on 11.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let session = AuthService.shared.currentSession{
            E_runTabView()
        } else {
            LoginView()
        }
        
    }
    
}

#Preview {
    ContentView()
}
