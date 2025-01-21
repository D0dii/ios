import SwiftUI
import MapKit

struct SurroundingTodos: View {
    @Environment(ModelData.self) var modelData
    @StateObject private var locationManager = LocationManager()
    @State private var filteredTodos: [Todo] = []
    @State private var selectedTodo: Todo? = nil
    @State private var showLocationError = false
    
    // Default location (San Francisco)
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    
    var body: some View {
        VStack {
            // Map showing todos within a radius
            Map(coordinateRegion: .constant(region),
                showsUserLocation: true,
                annotationItems: filteredTodos) { todo in
                    // Use MapAnnotation instead of MapPin for tap interaction
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(todo.latitude), longitude: Double(todo.longitude))) {
                        VStack {
                            Image(systemName: "pin.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    selectedTodo = todo
                                }
                        }
                    }
            }
            .frame(height: 300)
            .cornerRadius(12)
            .padding(.top, 20)
            
            Text("Todos within 5 km radius")
                .font(.headline)
                .padding()
            
            // Display selected todo information below the map
            if let selectedTodo = selectedTodo {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Title: \(selectedTodo.title)")
                        .font(.title2)
                        .bold()
                    Text("Description: \(selectedTodo.desc)")
                        .font(.body)
                    Text("Priority: \(selectedTodo.priority)")
                        .font(.body)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.horizontal)
            } else {
                Text("Tap on a pin to see todo details.")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
        }
        .onAppear {
            // Filter todos when the view appears
            filterTodosByProximity()
        }
        .alert(isPresented: $showLocationError) {
            Alert(
                title: Text("Location Error"),
                message: Text("Unable to retrieve your location. Showing results around the default location."),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle("Nearby Todos")
    }
    
    var region: MKCoordinateRegion{
        if let userLocation = locationManager.userLocation{
            return MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        } else {
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    private func filterTodosByProximity() {
        // Use the user's location or fallback to the default location
        guard let userLocation = locationManager.userLocation else {
            showLocationError = true
            locationManager.userLocation = defaultLocation
            return
        }
        
        // Filter todos by proximity to the user's location (or default location)
        filteredTodos = modelData.todos.filter { todo in
            let todoLocation = CLLocation(latitude: Double(todo.latitude), longitude: Double(todo.longitude))
            let userLocationCL = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let distance = userLocationCL.distance(from: todoLocation) // distance in meters
            return distance <= 5000 // Filtering todos within 5 kilometers (5000 meters)
        }
    }
}
