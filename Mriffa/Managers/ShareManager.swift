//
//  ShareManager.swift
//  Mriffa
//
//  Created by Sergei Volkov on 17.09.2021.
//

import SwiftUI

struct ShareManager {
    static func actionSheet(items: [Any]) {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}
