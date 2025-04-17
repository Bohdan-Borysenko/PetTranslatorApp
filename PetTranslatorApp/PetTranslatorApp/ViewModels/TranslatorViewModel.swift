//
//  TranslatorViewModel.swift
//  PetTranslatorApp
//
//  Created by Bohdan Borysenko 
//

import SwiftUI

class TranslatorViewModel: ObservableObject {
    @Published var direction: TranslationDirection = .humanToPet
    @Published var selectedPet: String = "dog"
}
