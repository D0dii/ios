import SwiftUI
import MapKit

struct TodoDetailsView: View {
    @Environment(ModelData.self) var modelData
    var todo: Todo
    @Environment(\.presentationMode) var presentationMode
    @State private var showDeleteAlert = false
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(todo.latitude), longitude: Double(todo.longitude))
    }

    struct LocationAnnotation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }
    
    var body: some View {
        VStack() {
            
            Text(todo.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
            VStack() {
                Text("Description")
                    .font(.headline)
                Text(todo.desc)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            
            VStack() {
                Text("Priority")
                    .font(.headline)
                Text(todo.priority)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            
            VStack() {
                Text("Deadline")
                    .font(.headline)
                Text(todo.deadline, style: .date)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            
            Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                ),
                annotationItems: [LocationAnnotation(coordinate: coordinate)]) { location in
                    MapPin(coordinate: location.coordinate, tint: .red)
                }
                .frame(height: 250)
                .cornerRadius(12)
                .padding(.top, 20)
            
            Spacer()

            
            HStack(spacing: 20) {
                NavigationLink(destination: EditTodoView(todo: todo)) {
                                Text("Edit Todo")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }

                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("Delete Todo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Todo"),
                message: Text("Are you sure you want to delete this Todo? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    deleteTodo()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func deleteTodo() {
        if let index = modelData.todos.firstIndex(where: { $0.id == todo.id }) {
                modelData.todos.remove(at: index)
            }
        presentationMode.wrappedValue.dismiss()
    }
}
