//
//  AffirmationDataManager.swift
//  Mriffa
//
//  Created by Sergei Volkov on 24.08.2021.
//

import Foundation
import WidgetKit

struct DataManager {
    
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
            { return AffirmationDefaultData }
            return affirmations
        }

        static func saveAffirmations(affirmations: [AffirmationModel]) {
            let encoder = PropertyListEncoder()
            
            if let data = try? encoder.encode(affirmations) {
                
                if FileManager.default.fileExists(atPath: affirmationDataContainerURL.path) {
                    try? data.write(to: affirmationDataContainerURL)
                } else {
                    FileManager.default.createFile(atPath: affirmationDataContainerURL.path, contents: data, attributes: nil)
                }
                
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                
                if UserDefaults.standard.bool(forKey: UDKeys.autoSaveInIcloud) {
                    ICloudDocumentsManager.saveFilesToICloudDOcuments(localFilePaths: [affirmationDataContainerURL.path],
                                                                      icloudFolder: SettingsViewModel.shared.iCloudFolder) {_ in}
                    
                }
                
                WidgetCenter.shared.reloadAllTimelines()
            }
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

        static func saveSelectedCategory(categories: Set<CategoryModel>) {
            let encoder = PropertyListEncoder()
            if let data = try? encoder.encode(Array(categories)) {
                
                if FileManager.default.fileExists(atPath: selectedCategoriesContainerURL.path) {
                    try? data.write(to: selectedCategoriesContainerURL)
                } else {
                    FileManager.default.createFile(atPath: selectedCategoriesContainerURL.path, contents: data, attributes: nil)
                }
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                
                if UserDefaults.standard.bool(forKey: UDKeys.autoSaveInIcloud) {
                    ICloudDocumentsManager.saveFilesToICloudDOcuments(localFilePaths: [selectedCategoriesContainerURL.path],
                                                                      icloudFolder: SettingsViewModel.shared.iCloudFolder) {_ in}
                }
                
                WidgetCenter.shared.reloadAllTimelines()
            }
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
        
        static func saveSelectedTheme(theme: ThemeModel) {
            let encoder = PropertyListEncoder()
            if let data = try? encoder.encode(theme) {
                if FileManager.default.fileExists(atPath: selectedThemeContainerURL.path) {
                    try? data.write(to: selectedThemeContainerURL)
                } else {
                    FileManager.default.createFile(atPath: selectedThemeContainerURL.path, contents: data, attributes: nil)
                }
                
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                
                if UserDefaults.standard.bool(forKey: UDKeys.autoSaveInIcloud) {
                    ICloudDocumentsManager.saveFilesToICloudDOcuments(localFilePaths: [selectedThemeContainerURL.path],
                                                                      icloudFolder: SettingsViewModel.shared.iCloudFolder) {_ in}
                }

                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        
    }
}
