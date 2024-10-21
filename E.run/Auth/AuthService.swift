//
//  AuthService.swift
//  E.run
//
//  Created by Madina Jumaly on 21.10.2024.
//

import Foundation
import Supabase

struct Secrets {
    static let supabaseURL = URL(string: "https://hrhncfjsmciztkjyfiar.supabase.co")!
    static let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhyaG5jZmpzbWNpenRranlmaWFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk0ODYyODUsImV4cCI6MjA0NTA2MjI4NX0.HUqx0EZAxKvmhdlMLxi7amtio1dFg_ir4HCU-BWKQqk"
}

@Observable
final class AuthService {
    
    static let shared = AuthService()
    private var supabase = SupabaseClient(supabaseURL: Secrets.supabaseURL, supabaseKey: Secrets.supabaseKey)
    
    var currentSession: Session?
    
    private init() {
        Task {
            currentSession = try? await supabase.auth.session
        }
    }
    
    func magicLinkLogin(email: String) async throws{
        try await supabase.auth.signInWithOTP(
          email: email,
          redirectTo: URL(string: "com.e-run-fll://login-callback")!
        )

    }
    func handleOpenURL(url: URL) async throws{
        currentSession = try await supabase.auth.session(from: url)
    }
    
    func logout () async throws{
        try await supabase.auth.signOut()
        currentSession = nil
    }
    
}

