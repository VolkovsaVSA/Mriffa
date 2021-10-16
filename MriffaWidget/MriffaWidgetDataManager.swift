//
//  MriffaWidgetDataManager.swift
//  Mriffa
//
//  Created by Sergei Volkov on 14.10.2021.
//

import Foundation

struct MriffaWidgetDataManager {
    
    static private let groupName = "group.VSA.Mriffa"
    static var groupContainer: URL {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupName)!
    }
    static private var affirmationDataContainerURL: URL {
        groupContainer.appendingPathComponent("affirmationData.plist")
    }
    static private var selectedCategoriesContainerURL: URL {
        groupContainer.appendingPathComponent("selectedCategories.plist")
    }
    static private var selectedThemeContainerURL: URL {
        groupContainer.appendingPathComponent("selectedTheme.plist")
    }
    
    static func localFileContainerPaths() -> [String] {
        return [
            affirmationDataContainerURL.path,
            selectedCategoriesContainerURL.path,
            selectedThemeContainerURL.path
        ]
    }
    
    struct Affirmation {
        static func loadAffirmations() -> [AffirmationModel] {
            let decoder = PropertyListDecoder()
            
            guard let data = try? Data.init(contentsOf: affirmationDataContainerURL),
                  let affirmations = try? decoder.decode([AffirmationModel].self, from: data)
            else
            {
                FavoritesCount = AffirmationDefaultData.filter {$0.isFavorite}.count
                return AffirmationDefaultData
            }
            FavoritesCount = affirmations.filter {$0.isFavorite}.count
            return affirmations
        }
    }

    struct Categories {
        static func loadSelectedCategory() -> Set<CategoryModel> {
            let decoder = PropertyListDecoder()
            
            guard let data = try? Data.init(contentsOf: selectedCategoriesContainerURL),
                  let preferences = try? decoder.decode([CategoryModel].self, from: data)
            else {
                return Set(arrayLiteral: CategoryModel(category: Category.health,
                                                       title: Category.health.localizedTitle,
                                                       image: Category.health.rawValue))
            }
            return Set(preferences)
        }
    }
    
    struct Theme {
        static func loadSelectedTheme() -> ThemeModel? {
            let decoder = PropertyListDecoder()
            
            guard let data = try? Data.init(contentsOf: selectedThemeContainerURL),
                  let theme = try? decoder.decode(ThemeModel.self, from: data)
            else { return nil }
            return theme
        }
    }
    
}
