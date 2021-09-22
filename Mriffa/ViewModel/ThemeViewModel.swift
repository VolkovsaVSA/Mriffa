//
//  ThemeViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.09.2021.
//

import SwiftUI

class ThemeViewModel: ObservableObject {
    static let shared = ThemeViewModel()
    @Published var themes: [ThemeModel]
    @Published var selectedTheme: ThemeModel {
        didSet {
            DataManager.Theme.saveSelectedTheme(theme: selectedTheme)
        }
    }
    
    func randomTheme ()->ThemeModel {
        let imageIndex = Array(0...80).shuffled().first!
        let fontIndex = Array(0...80).shuffled().first!
        let shuffledIndex = fontIndex == 15 ? 17 : fontIndex
        return ThemeModel(image: imageIndex.description,
                          font: themes[shuffledIndex].font,
                          index: imageIndex, fontSize: themes[shuffledIndex].fontSize)
    }
    
    init() {

        let arrayOfThemes = Array(0...80).map { index -> ThemeModel in
            var model: ThemeModel!
            
            switch index {
            case 15:
                model = ThemeModel(image: index.description,
                                   font: Fonts[17],
                                   index: index,
                                   fontSize: SettingsViewModel.shared.affirmationFontSize)
            case 65:
                model = ThemeModel(image: index.description,
                                   font: Fonts[index+1],
                                   index: index,
                                   fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 80 : 50)
            case 70:
                model = ThemeModel(image: index.description,
                                   font: Fonts[index+1],
                                   index: index, fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 24)
            case 80:
                model = ThemeModel(image: index.description,
                                   font: Fonts[index+1],
                                   index: index, fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 24)
                
            default: model = ThemeModel(image: index.description,
                                            font: Fonts[index+1],
                                            index: index, fontSize: SettingsViewModel.shared.affirmationFontSize)
            }

            return model
        }
        themes = arrayOfThemes

        if let theme = DataManager.Theme.loadSelectedTheme() {
            selectedTheme = theme
        } else {
            selectedTheme = arrayOfThemes.first!
        }
        
    }
}
