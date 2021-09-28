//
//  AlertMAnager.swift
//  Mriffa
//
//  Created by Sergei Volkov on 24.09.2021.
//

import Foundation
import SwiftUI

class AlertManager: ObservableObject {
    
    static let shared = AlertManager()
    
    @Published var alertType: AlertTypes? = nil
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertText = ""
    @Published var secondButtonTitle = ""
    var alertAction: ()->() = {}
    
    func oneButtonAlert(buttonTitle: String, buttonAction: @escaping()->()?)->Alert {
        Alert(title: Text(alertTitle),
              message: Text(alertText),
              dismissButton: .default(Text(buttonTitle), action: {
            buttonAction()
        }))
    }
    func createAlert(alertType: AlertTypes)->Alert {
        switch alertType {
        case .oneButton:
            return Alert(title: Text(alertTitle),
                  message: Text(alertText),
                  dismissButton: .default(Text("OK"), action: {
                self.alertAction()
            }))
        case .twoButton:
            return Alert(title: Text(alertTitle),
                  message: Text(alertText),
                  primaryButton: .default(Text(secondButtonTitle), action: {
                self.alertAction()
            }),
                  secondaryButton: .cancel())
        }
    }
}
