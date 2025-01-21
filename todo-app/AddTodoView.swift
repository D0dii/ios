    //
    //  AddTodoView.swift
    //  todo-app
    //
    //  Created by stud on 05/11/2024.
    //

    import SwiftUI
    import MapKit

    struct LocationAnnotation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

    struct AddTodoView: View {
        @Environment(ModelData.self) var modelData
        var todos: [Todo]
        @Environment(\.presentationMode) var presentationMode
        @State private var newTodoTitle = ""
        @State private var newTodoDesc = ""
        @State private var newTodoPriority: String = "Medium"
        @State private var newTodoDeadline = Date()
        
        @StateObject private var locationManager = LocationManager()
        @State private var selectedLocation: LocationAnnotation?
        
        var body: some View {
            @Bindable var modelData = modelData
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $newTodoTitle)
                }

                Section(header: Text("Description")) {
                    TextField("Enter description", text: $newTodoDesc)
                }

                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $newTodoPriority) {
                        Text("Low").tag("Low")
                        Text("Medium").tag("Medium")
                        Text("High").tag("High")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Deadline")) {
                    DatePicker("Enter deadline", selection: $newTodoDeadline).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 6)
                }
                
                MapView(region: region, onTap: selectLocation, selectedLocation: selectedLocation)
                    .frame(height: 300)

                Section {
                    Button(action: addTodo) {
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
            .navigationTitle("Add Todo")
        }
        
        private func addTodo(){
            guard !newTodoTitle.isEmpty else { return }
            guard !newTodoDesc.isEmpty else { return }
            guard !newTodoPriority.isEmpty else { return }
            
            let latitude = selectedLocation?.coordinate.latitude ?? 51.105
            let longitude = selectedLocation?.coordinate.longitude ?? 17.06
            
            let newTodo = Todo(title: newTodoTitle, desc: newTodoDesc, priority: newTodoPriority, deadline: newTodoDeadline, longitude: Float(longitude), latitude: Float(latitude), isCompleted: false)
            modelData.todos.append(newTodo)
            newTodoTitle = ""
            newTodoDesc = ""
            newTodoPriority = ""
            newTodoDeadline = Date()
            presentationMode.wrappedValue.dismiss()
        }
        
        var region: MKCoordinateRegion{
            if let userLocation = locationManager.userLocation{
                return MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }else{
                return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.105, longitude: 17.06), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
        }
        
        
        func selectLocation(_ coordinate: CLLocationCoordinate2D) {
                selectedLocation = LocationAnnotation(coordinate: coordinate)
            }
    }
