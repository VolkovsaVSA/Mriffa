//
//  UDKeys.swift
//  Mriffa
//
//  Created by Sergei Volkov on 25.08.2021.
//

import Foundation

struct UDKeys {
    static let noFirstRun = "noFirstRun"
    static let fv = "fullVersion"
    static let autoSaveInIcloud = "autoSaveInIcloud"
    static let firstCheckBackup = "firstCheckBackup"
    static let startView = "startView"
    
    static let refreshMinutes = "refreshMinutes"
    
    static let affirmationID = "affirmationID"

    struct AppGroup {
        private static let groupName = "group.VSA.Mriffa"

        static func save(value: Any, key: String) {
            if let groupUserDefaults = UserDefaults(suiteName: groupName) {
                groupUserDefaults.set(value, forKey: key)
                print("save mydefaults: \(value)")
            }
        }

        static func load(key: String) -> Any? {
            var object: Any?
            if let groupUserDefaults = UserDefaults(suiteName: groupName) {
                object = groupUserDefaults.object(forKey: key)
                print("load mydefaults \(object.debugDescription)")
            }
            return object
        }
    }
    
}
