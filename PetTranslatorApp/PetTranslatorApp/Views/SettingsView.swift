//
//  SettingsView.swift
//  PetTranslatorApp
//
//  Created by Bohdan Borysenko
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)

            VStack(spacing: 16) {
                settingsButton(title: "Rate Us") {
                    rateApp()
                }

                settingsButton(title: "Share App") {
                    shareApp()
                }

                settingsButton(title: "Contact Us") {
                    contactSupport()
                }

                settingsButton(title: "Restore Purchases") {
                    // Restore action
                }

                settingsButton(title: "Privacy Policy") {
                    openURL("https://github.com/Bohdan-Borysenko")
                }

                settingsButton(title: "Terms of Use") {
                    openURL("https://github.com/Bohdan-Borysenko")
                }
            }

            Spacer()
        }
        .padding(.horizontal)
        .background(
            LinearGradient(colors: [Color.white, Color.green.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
        )
    }

    func settingsButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.purple.opacity(0.15))
            .cornerRadius(16)
        }
    }

    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    func shareApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let activityVC = UIActivityViewController(activityItems: ["Check out Pet Translator! 🐶🐱"], applicationActivities: nil)

        if let root = windowScene.windows.first?.rootViewController {
            root.present(activityVC, animated: true, completion: nil)
        }
    }

    func contactSupport() {
        let email = "support@yourapp.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }

    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
}
