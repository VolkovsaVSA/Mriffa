//
//  ShareManager.swift
//  Mriffa
//
//  Created by Sergei Volkov on 17.09.2021.
//

import SwiftUI

//struct ShareManager {
//    static func actionSheet(items: [Any]) {
//        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
//        activityVC.modalPresentationStyle = .pageSheet
//        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
//    }
//}

struct ShareSheet: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController

    var sharing: [Any]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        UIActivityViewController(activityItems: sharing, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {

    }
}
