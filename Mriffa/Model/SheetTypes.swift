//
//  SheetTypes.swift
//  Mriffa
//
//  Created by Sergei Volkov on 07.09.2021.
//

import Foundation

enum SheetTypes: Identifiable {
    
    case categories, favorites, settings, sendMail
    
    var id: Int {
        hashValue
    }
}
