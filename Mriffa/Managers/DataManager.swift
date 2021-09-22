//
//  AffirmationDataManager.swift
//  Mriffa
//
//  Created by Sergei Volkov on 24.08.2021.
//

import Foundation

struct DataManager {
    
    
    static var localFolderURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    static private var affirmationURL: URL {
        return localFolderURL.appendingPathComponent("affirmationData.plist")
    }
    static private var selectedCategoriesURL: URL {
        return localFolderURL.appendingPathComponent("selectedCategories.plist")
    }
    static private var selectedThemeURL: URL {
        return localFolderURL.appendingPathComponent("selectedTheme.plist")
    }
    static func localFilePaths() -> [String] {
        return [
            affirmationURL.path,
            selectedCategoriesURL.path,
            selectedThemeURL.path
        ]
    }
    struct Affirmation {
        static func loadAffirmations() -> [AffirmationModel] {
            let decoder = PropertyListDecoder()
            
            guard let data = try? Data.init(contentsOf: affirmationURL),
                  let affirmations = try? decoder.decode([AffirmationModel].self, from: data)
            else
            { return AffirmationDefaultData }
            print(#function, affirmations.filter() {$0.isFavorite}.description)
            return affirmations
        }
        
        static func saveAffirmations(affirmations: [AffirmationModel]) {
            let encoder = PropertyListEncoder()
            
            if let data = try? encoder.encode(affirmations) {
                
                if FileManager.default.fileExists(atPath: affirmationURL.path) {
                    try? data.write(to: affirmationURL)
                } else {
                    FileManager.default.createFile(atPath: affirmationURL.path, contents: data, attributes: nil)
                }
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                
                if UserDefaults.standard.bool(forKey: UDKeys.autoSaveInIcloud) {
                    do {
                        try ICloudDocumentsManager.saveFilesToICloudDOcuments(localFilePaths: [affirmationURL.path], icloudFolder: SettingsViewModel.shared.iCloudFolder)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
    }

    struct Category {
        static func loadSelectedCategory() -> Set<CategoryModel> {
            let decoder = PropertyListDecoder()
            
            guard let data = try? Data.init(contentsOf: selectedCategoriesURL),
                  let preferences = try? decoder.decode([CategoryModel].self, from: data)
            else { return [] }
            return Set(preferences)
        }
        static func saveSelectedCategory(categories: Set<CategoryModel>) {
            let encoder = PropertyListEncoder()
            if let data = try? encoder.encode(Array(categories)) {
                if FileManager.default.fileExists(atPath: selectedCategoriesURL.path) {
                    try? data.write(to: selectedCategoriesURL)
                } else {
                    FileManager.default.createFile(atPath: selectedCategoriesURL.path, contents: data, attributes: nil)
                }
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                if UserDefaults.standard.bool(forKey: UDKeys.autoSaveInIcloud) {
                    do {
                        try ICloudDocumentsManager.saveFilesToICloudDOcuments(localFilePaths: [selectedCategoriesURL.path], icloudFolder: SettingsViewModel.shared.iCloudFolder)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
    }
    
    struct Theme {
        static func loadSelectedTheme() -> ThemeModel? {
            let decoder = PropertyListDecoder()
            
            guard let data = try? Data.init(contentsOf: selectedThemeURL),
                  let theme = try? decoder.decode(ThemeModel.self, from: data)
            else { return nil }
            return theme
        }
        static func saveSelectedTheme(theme: ThemeModel) {
            let encoder = PropertyListEncoder()
            if let data = try? encoder.encode(theme) {
                if FileManager.default.fileExists(atPath: selectedThemeURL.path) {
                    try? data.write(to: selectedThemeURL)
                } else {
                    FileManager.default.createFile(atPath: selectedThemeURL.path, contents: data, attributes: nil)
                }
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                if UserDefaults.standard.bool(forKey: UDKeys.autoSaveInIcloud) {
                    do {
                        try ICloudDocumentsManager.saveFilesToICloudDOcuments(localFilePaths: [selectedThemeURL.path], icloudFolder: SettingsViewModel.shared.iCloudFolder)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
        
    }
}
