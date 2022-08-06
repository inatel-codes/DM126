//
//  LoginView.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import Foundation
import FirebaseAuthUI
import SwiftUI

struct LoginView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return FUIAuth.defaultAuthUI()!.authViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
