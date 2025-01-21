import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var region: MKCoordinateRegion
    var onTap: (CLLocationCoordinate2D) -> Void
    var selectedLocation: LocationAnnotation?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: true)
        mapView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let selectedLocation = selectedLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = selectedLocation.coordinate
            uiView.removeAnnotations(uiView.annotations)  // Remove previous annotations
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(onTap: onTap)
    }

    class Coordinator: NSObject {
        var onTap: (CLLocationCoordinate2D) -> Void

        init(onTap: @escaping (CLLocationCoordinate2D) -> Void) {
            self.onTap = onTap
        }

        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let location = gestureRecognizer.location(in: gestureRecognizer.view)
            let mapView = gestureRecognizer.view as! MKMapView
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            onTap(coordinate)
        }
    }
}
