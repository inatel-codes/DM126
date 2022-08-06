//
//  SwiftUI_FirebaseApp.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import SwiftUI
import Firebase
import FirebaseStorageUI

@main
struct SwiftUI_FirebaseApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}
