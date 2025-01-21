//
//  ContentView.swift
//  todo-app
//
//  Created by stud on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    var todos: [Todo]{ modelData.todos }
    var body: some View {
        VStack {
            TabView{
                UpcomingTodos(todos: todos).tabItem{Image(systemName: "house")}
                SurroundingTodos().tabItem{Image(systemName: "paperplane.fill")}
                
                TodoListView(todos: todos).tabItem{Image(systemName: "tray.2.fill")}
                
                StatisticsView().tabItem{Image(systemName: "chart.line.uptrend.xyaxis")}
            }
        }
        .padding()
    }
}

#Preview {
    ContentView().environment(ModelData())
}
