//
//  ResultView.swift
//  PetTranslatorApp
//
//  Created by Bohdan Borysenko
//


import SwiftUI
import AVFoundation

struct ResultView: View {
    var pet: String

    @Environment(\.dismiss) var dismiss
    @State private var message: String = ""
    @State private var synthesizer = AVSpeechSynthesizer()

    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(colors: [Color.white, Color.green.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal)

                Text("Result")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, -30)

        
                VStack(alignment: .leading, spacing: 0) {
                    Text(message)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.purple.opacity(0.3), lineWidth: 1)
                        )

                   
                    Triangle()
                        .fill(Color.purple.opacity(0.2))
                        .frame(width: 20, height: 10)
                        .rotationEffect(.degrees(45))
                        .offset(x: 30, y: -5)
                }
                .padding(.horizontal, 40)

               
                Image(pet == "dog" ? "Dog" : "cat")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.top, 10)

            
                Button(action: {
                    withAnimation {
                        message = getRandomMessage(for: pet)
                        speak(message)
                    }
                }) {
                    Text("Repeat")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 160)
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding(.top, 12)

                Spacer()
            }
            .padding()
            .onAppear {
                message = getRandomMessage(for: pet)
                speak(message)
            }
        }
    }

    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }

    private func getRandomMessage(for pet: String) -> String {
        let catPhrases = [
            "I demand tuna. Now.",
            "Don’t touch me. Okay, touch me.",
            "Why did you stop petting me?",
            "I rule this house.",
            "I knocked it over. Deal with it."
        ]

        let dogPhrases = [
            "Where's the ball?!",
            "You're my favorite human!",
            "Can we go for a walk?",
            "Tail wag means love.",
            "Please feed me!"
        ]

        return pet == "cat" ? catPhrases.randomElement() ?? "Meow?" : dogPhrases.randomElement() ?? "Woof!"
    }

    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}


#Preview {
    ResultView(pet: "dog")
}
