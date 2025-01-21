//
//  todo_appApp.swift
//  todo-app
//
//  Created by stud on 29/10/2024.
//

import SwiftUI

@main
struct todo_appApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
