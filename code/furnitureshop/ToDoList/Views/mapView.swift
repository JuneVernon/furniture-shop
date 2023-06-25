import SwiftUI
import MapKit

struct MapView: View {
    struct AnnotationItem: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }
    
    @Binding var selectedLocation: String
    @Binding var isPresented: Bool
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var annotationItems: [AnnotationItem] {
        return [AnnotationItem(coordinate: region.center)]
    }
    
    var body: some View {
        VStack {
            Text("Select Location")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            
            Map(coordinateRegion: $region, annotationItems: annotationItems) { item in
                MapPin(coordinate: item.coordinate, tint: .red)
            }
            .frame(height: 300)
            .padding()
            
            Button(action: {
                selectedLocation = "\(region.center.latitude), \(region.center.longitude)"
                isPresented = false
            }) {
                Text("Select")
            }
            .padding()
            
            Button(action: {
                isPresented = false
            }) {
                Text("Cancel")
            }
            .padding()
        }
    }
}
