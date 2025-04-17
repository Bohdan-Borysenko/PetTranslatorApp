//
//  TranslatorView.swift
//  PetTranslatorApp
//
//  Created by Bohdan Borysenko
//

import SwiftUI
import AVFoundation

struct TranslatorView: View {
    @StateObject private var viewModel = TranslatorViewModel()
    @State private var showProcessView = false
    @State private var showSettingsAlert = false
    @State private var selectedPetForNavigation: String = ""

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.white, Color.green.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            NavigationStack {
                VStack(spacing: 24) {
                    Text("Translator")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    HStack(spacing: 12) {
                        Text("HUMAN")
                            .fontWeight(.semibold)
                            .foregroundColor(viewModel.direction == .humanToPet ? .black : .gray)
                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundColor(.gray)
                        Text("PET")
                            .fontWeight(.semibold)
                            .foregroundColor(viewModel.direction == .petToHuman ? .black : .gray)
                    }
                    .onTapGesture {
                        withAnimation {
                            viewModel.direction = viewModel.direction == .humanToPet ? .petToHuman : .humanToPet
                        }
                    }

              
                    HStack(spacing: 16) {
                       
                        Button(action: {
                            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                                DispatchQueue.main.async {
                                    if granted {
                                        selectedPetForNavigation = viewModel.selectedPet
                                        showProcessView = true
                                    } else {
                                        showSettingsAlert = true
                                    }
                                }
                            }
                        }) {
                            VStack(spacing: 10) {
                                Image(systemName: "mic")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                                Text("Start Speak")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                            .frame(width: 140, height: 140)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 4)
                        }

                     
                        VStack(spacing: 16) {
                            petButton(imageName: "cat", isSelected: viewModel.selectedPet == "cat") {
                                viewModel.selectedPet = "cat"
                            }
                            petButton(imageName: "Dog", isSelected: viewModel.selectedPet == "dog") {
                                viewModel.selectedPet = "dog"
                            }
                        }
                        .frame(width: 80)
                    }
                    .padding(.top, 10)

                    Spacer()

                    
                    Image(viewModel.selectedPet == "dog" ? "Dog" : "cat")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)

                    Spacer()
                }
                .padding()
                .navigationDestination(isPresented: $showProcessView) {
                    ProcessView(pet: selectedPetForNavigation)
                }
                .alert("Microphone Access Required", isPresented: $showSettingsAlert) {
                    Button("Go to Settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Please enable microphone access to use this feature.")
                }
            }
        }
    }

    
    private func petButton(imageName: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.green : Color.clear, lineWidth: 3)
                )
                .shadow(radius: isSelected ? 4 : 0)
        }
    }
}

#Preview {
    TranslatorView()
}
