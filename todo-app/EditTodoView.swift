import SwiftUI

struct EditTodoView: View {
    @Environment(ModelData.self) var modelData
    @State var todo: Todo
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $todo.title)
            }

            Section(header: Text("Description")) {
                TextField("Enter description", text: $todo.desc)
            }

            Section(header: Text("Priority")) {
                Picker("Priority", selection: $todo.priority) {
                    Text("Low").tag("Low")
                    Text("Medium").tag("Medium")
                    Text("High").tag("High")
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Deadline")) {
//                DatePicker("Select deadline", selection: $todo.deadline, displayedComponents: .date)
                DatePicker("Enter deadline", selection: $todo.deadline).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 6)
            }

            Section {
                Button(action: saveTodo) {
                    Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .navigationTitle("Edit Todo")
    }
    
    private func saveTodo() {
        if let index = modelData.todos.firstIndex(where: { $0.id == todo.id }) {
            modelData.todos[index] = todo // Update the todo in the model
        }
        presentationMode.wrappedValue.dismiss()
    }
}
