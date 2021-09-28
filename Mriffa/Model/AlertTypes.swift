//
//  AlertTypes.swift
//  Mriffa
//
//  Created by Sergei Volkov on 24.09.2021.
//

import Foundation

enum AlertTypes: Identifiable {
    case oneButton, twoButton
    
    var id: Int {
        hashValue
    }
}
