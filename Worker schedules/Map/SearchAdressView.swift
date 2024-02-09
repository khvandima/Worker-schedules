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
    
    @State private var searchButtonView = false
    @State var searchText: String = ""
    @Binding var selectPlace: Location?
    
    @FocusState private var isFocused: Bool
    
    let name: String
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $startPosition) {
                    if let selectMarker = selectPlace {
                        Marker(selectMarker.name, coordinate: CLLocationCoordinate2D(latitude: selectMarker.latitude, longitude: selectMarker.longitude))
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar(.hidden, for: .tabBar)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        selectPlace = Location(id: UUID(), name: name, latitude: coordinate.latitude, longitude: coordinate.longitude)
                        withAnimation(.easeInOut(duration: 0.3)) {
                            searchButtonView = true
                        }
                    }
                }
                // Полe поиска TextField
                .overlay(alignment: .topLeading) {
                    VStack {
                        HStack {
                            Button(action: {
                                selectPlace = nil
                                dismiss()
                            }, label: {
                                Image(systemName: "arrow.left.circle")
                                    .font(.largeTitle)
                            })
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .overlay(alignment: .bottom) {
                    VStack {
                        TextField("Search for a location... ", text: $searchText)
                            .font(.subheadline)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .padding()
                            .shadow(radius: 16)
                            .focused($isFocused)
                            .onChange(of: isFocused) { oldValue, newValue in
                                withAnimation(.easeIn) {
                                    searchButtonView = false
                                }
                            }
                        if searchButtonView {
                            HStack {
                                Button(action: {
                                    selectPlace = nil
                                    dismiss()

                                }, label: {
                                    Text("Cancel")
                                })/*.buttonStyle(.borderedProminent)*/
                                .padding(12)
                                .padding(.horizontal, 16)
                                .background(.ultraThinMaterial)
                                .tint(.plusButton)
                                .cornerRadius(12)
                                
                                Button(action: {
                                    dismiss()
                                }, label: {
                                    Text("Save")
                                })/*.buttonStyle(.borderedProminent)*/
                                .padding(12)
                                .padding(.horizontal, 16)
                                .background(.ultraThinMaterial)
                                .tint(.red)
                                .cornerRadius(12)
                            }
                        }
                    }
                }
                // При вводе текста и нажатии Enter запускается метод searchPlaces
                .onSubmit(of: .text) {
                    Task { await searchPlaces() }
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

extension SearchAdressView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        
        if let searchResults = results?.mapItems {
            for item in searchResults {
                let placemark = item.placemark
                selectPlace = Location(id: UUID(), name: name, latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
                startPosition = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: .init(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude),
                        span: .init(latitudeDelta: 0.003, longitudeDelta: 0.003)
                    )
                )
            }
            withAnimation(.easeInOut(duration: 0.3)) {
                searchButtonView = true
            }
        }
    }
}

//#Preview {
//    LocationDetailView(mapSelection: .constant(nil))
//}
