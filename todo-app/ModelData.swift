//
//  ModelData.swift
//  todo-app
//
//  Created by stud on 12/11/2024.
//

import Foundation

@Observable
class ModelData: ObservableObject {
    var todos: [Todo] = [
        Todo(id: UUID(), title: "Buy Groceries", desc: "Purchase milk, eggs, and bread.", priority: "High", deadline: Date().addingTimeInterval(3600), longitude: -122.4194, latitude: 37.7749, isCompleted: false),
        Todo(id: UUID(), title: "Complete Assignment", desc: "Finish the final project for the Swift course.", priority: "Medium", deadline: Date().addingTimeInterval(86400), longitude: -73.935242, latitude: 40.730610, isCompleted: false),
        Todo(id: UUID(), title: "Morning Exercise", desc: "Go for a 30-minute run in the park.", priority: "Low", deadline: Date().addingTimeInterval(7200), longitude: -118.2437, latitude: 34.0522, isCompleted: true),
        Todo(id: UUID(), title: "Team Meeting", desc: "Discuss project progress and upcoming deadlines.", priority: "High", deadline: Date().addingTimeInterval(14400), longitude: -122.2711, latitude: 37.8044, isCompleted: false),
        Todo(id: UUID(), title: "Read a Book", desc: "Finish reading the current book on productivity.", priority: "Medium", deadline: Date().addingTimeInterval(172800), longitude: -74.0060, latitude: 40.7128, isCompleted: true),
        Todo(id: UUID(), title: "Laundry", desc: "Wash and fold clothes.", priority: "Low", deadline: Date().addingTimeInterval(43200), longitude: -122.4194, latitude: 37.7749, isCompleted: false),
        Todo(id: UUID(), title: "Running", desc: "Running", priority: "Low", deadline: Date().addingTimeInterval(43200), longitude: -122.4194, latitude: 37.7749, isCompleted: false)
    ]
}
