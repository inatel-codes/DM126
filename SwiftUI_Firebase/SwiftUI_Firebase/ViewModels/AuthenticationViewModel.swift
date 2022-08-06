//
//  AuthenticationViewModel.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import Foundation
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class AuthenticationViewModel: NSObject, ObservableObject, FUIAuthDelegate {
    @Published var isLogged = false
    
    override init() {
        super.init()
        
        let authUI = FUIAuth.defaultAuthUI()!
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI)
        ]
        
        authUI.providers = providers
        authUI.delegate = self
        
        if Auth.auth().currentUser != nil {
            isLogged = true
        }
        else {
            isLogged = false
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let _ = error {
            isLogged = false
        }
        else {
            isLogged = true
            print("Signed in as " + "\(String(describing: Auth.auth().currentUser?.displayName))")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        isLogged = false
    }
}
