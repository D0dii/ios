//
//  TodoListView.swift
//  todo-app
//
//  Created by stud on 05/11/2024.
//

import SwiftUI

struct TodoListView: View {
    @Environment(ModelData.self) var modelData
    var todos: [Todo]
    
    var body: some View {
        @Bindable var modelData = modelData
        
        NavigationStack{
            List{
                ForEach(todos){ todo in
                    NavigationLink(destination: TodoDetailsView(todo: todo)) {
                        HStack {
                            Rectangle()
                                                            .frame(width: 10)
                                                            .foregroundColor(priorityColor(for: todo.priority))
                                                            .cornerRadius(5)
                                                    VStack(alignment: .leading) {
                                                        Text(todo.title)
                                                            .strikethrough(todo.isCompleted, color: .gray)
                                                            .font(.headline)

                                                        HStack {
                                                            Image(systemName: "calendar")
                                                                .foregroundColor(.gray)
                                                            Text(formatDate(todo.deadline))
                                                                .font(.subheadline)
                                                                .foregroundColor(.gray)
                                                        }
                                                    }
                                                    Spacer()
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .foregroundColor(todo.isCompleted ? .green : .gray)
                                                        .onTapGesture {
                                                            if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                                                                modelData.todos[index].isCompleted.toggle()
                                                            }
                                                        }
                                                }
                                                .contentShape(Rectangle())
                    }
                    
                    
                }
            }
            .navigationTitle("To-Dos")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddTodoView(todos: todos)) {
                        Image(systemName: "plus").font(.title)
                    }
                }
            }
            .navigationBarTitleDisplayMode (.inline)
        }
    }
    private func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter.string(from: date)
        }
    private func priorityColor(for priority: String) -> Color {
            switch priority.lowercased() {
            case "low":
                return .green
            case "medium":
                return .yellow
            case "high":
                return .red
            default:
                return .gray
            }
        }
}

