//
//  FirebaseBasicsApp.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 29.08.24.
//

import SwiftUI
import FirebaseCore

@main
struct FirebaseBasicsApp: App {
    
    
    init(){
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
