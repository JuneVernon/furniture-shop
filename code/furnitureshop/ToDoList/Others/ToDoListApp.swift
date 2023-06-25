//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//
import FirebaseAnalytics

import SwiftUI
import FirebaseCore

@main
struct ToDoListApp: App {
    
    init(){

        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(false)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}
