//
//  ThemeViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.09.2021.
//

import SwiftUI

class ThemeViewModel: ObservableObject {
    @Published var themes: [ThemeModel]
    @Published var selectedTheme: ThemeModel
    func randomTheme ()->ThemeModel {
        let imageIndex = Array(0...32).shuffled().first!
        let fontIndex = Array(0...81).shuffled().first!
        let shuffledIndex = fontIndex == 15 ? 17 : fontIndex
        return ThemeModel(image: UIImage(named: imageIndex.description)!,
                               font: Font.custom(Fonts[shuffledIndex],
                                                 size: SettingsViewModel.shared.affirmationFontSize).bold(),
                               index: imageIndex)
        
//        if shuffledIndex == 15 {
//            model = ThemeModel(image: UIImage(named: shuffledIndex.description)!,
//                               font: Font.custom(Fonts[shuffledIndex+2], size: SettingsViewModel.shared.affirmationFontSize).bold(), index: shuffledIndex
//            )
//        } else {
//            model = ThemeModel(image: UIImage(named: shuffledIndex.description)!,
//                               font: Font.custom(Fonts[shuffledIndex], size: SettingsViewModel.shared.affirmationFontSize).bold(), index: shuffledIndex
//            )
//        }
//        return model
    }
    
    init() {

        let arrayOfThemes = Array(0...32).map { index -> ThemeModel in
            var model: ThemeModel!
            if index == 15 {
                model = ThemeModel(image: UIImage(named: index.description)!,
                                   font: Font.custom(Fonts[index+2], size: SettingsViewModel.shared.affirmationFontSize).bold(), index: index
                )
            } else {
                model = ThemeModel(image: UIImage(named: index.description)!,
                                   font: Font.custom(Fonts[index+1], size: SettingsViewModel.shared.affirmationFontSize).bold(), index: index
                )
            }
            return model
        }
        themes = arrayOfThemes
        selectedTheme = arrayOfThemes.first!
    }
}
