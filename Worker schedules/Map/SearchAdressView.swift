//
//  LocationDetailView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/30/24.
//

import SwiftUI
import MapKit

struct SearchAdressView: View {
    
    @Environment(\.dismiss) private var dismiss
   
    @State var startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: .init(latitude: 35.41400293060255, longitude: 129.17414770269838),
            span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    //    @State private var startPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    
    @State private var selectPlace: Location?
    @State private var searchText = ""
    
    
    
    
    var body: some View {
        MapReader { proxy in
            Map(position: $startPosition) {
                if let selectMarker = selectPlace {
                    Marker(selectMarker.name, coordinate: CLLocationCoordinate2D(latitude: selectMarker.latitude, longitude: selectMarker.longitude))

                }
            }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        selectPlace = Location(id: UUID(), latitude: coordinate.latitude, longitude: coordinate.longitude)
                    }
                    
                }
               
        }
    }
}

extension MapView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
        
              
    }
}

//#Preview {
//    LocationDetailView(mapSelection: .constant(nil))
//}


struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String = ""
    var description: String = ""
    var latitude: Double
    var longitude: Double
}
