//
//  ProcessView.swift
//  PetTranslatorApp
//
//  Created by Bohdan Borysenko
//

import Foundation
import SwiftUI

struct ProcessView: View {
    var pet: String
    @State private var navigateToResult = false
    @State private var message = ""

    let fakeMessages = [
        "I'm hungry, feed me!",
        "Take me outside, now!",
        "I need belly rubs 🐾",
        "Let's play!",
        "Time for a nap..."
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                Text("Processing translation…")
                    .font(.headline)
                    .padding(.top, 20)
                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    message = fakeMessages.randomElement() ?? "Meow?"
                    navigateToResult = true
                }
            }
            .navigationDestination(isPresented: $navigateToResult) {
                ResultView(pet: pet)
                    .navigationBarBackButtonHidden(true)
            }
            .padding()
            .background(
                LinearGradient(colors: [Color.white, Color.green.opacity(0.15)],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
            )
        }
    }
}
