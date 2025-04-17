//
//  MainTabView.swift
//  PetTranslatorApp
//
//  Created by Bohdan Borysenko
//

import SwiftUI

enum Tab {
    case translator
    case clicker
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .translator

    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(colors: [Color.white, Color.green.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

        
            Group {
                switch selectedTab {
                case .translator:
                    TranslatorView()
                case .clicker:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

    
            HStack {
                tabBarItem(icon: "waveform", title: "Translator", tab: .translator)
                tabBarItem(icon: "gearshape", title: "Clicker", tab: .clicker)
            }
            .padding()
            .background(.white)
            .cornerRadius(24)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
            .padding(.bottom, 20)
        }
    }

    private func tabBarItem(icon: String, title: String, tab: Tab) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
            Text(title)
                .font(.caption2)
        }
        .foregroundColor(selectedTab == tab ? .black : .gray)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedTab = tab
        }
    }
}

#Preview {
    MainTabView()
}
