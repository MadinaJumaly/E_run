//
//  LoginView.swift
//  E.run
//
//  Created by Madina Jumaly on 21.10.2024.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    var body: some View {
        VStack{
            TextField("E-mail", text: $email)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            Button {
                Task {
                    do {
                        try await AuthService.shared.magicLinkLogin(email: email)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Login")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.black)
                    .background(Color.yellow)
                    .clipShape(Capsule())
            }
            .disabled(email.count < 7)
        }
        .padding()
        .onOpenURL(perform: { url in
            Task {
                do {
                    try await AuthService.shared.handleOpenURL(url: url)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
    }
}

#Preview {
    LoginView()
}
