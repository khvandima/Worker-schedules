//
//  MapView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/29/24.
//
//TODO: Сделать отслеживаемый UserLocation и кнопку

import SwiftUI
import MapKit

struct InThisWeekDitail: View {
    
    let factory: Factory
    
    @Environment(\.dismiss) private var dismiss
    
//    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)

    @State private var cameraPosition: MapCameraPosition = .automatic

    
    @State private var tabSelectedValue = 0
    @State private var resultsDayItems = [MKMapItem]()
    @State private var resultsNightItems = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var isTaping: Bool = true

    var body: some View {
        ZStack {
            VStack{
                Map(position: $cameraPosition, selection: $mapSelection) {
                    
                    
                    
                    if tabSelectedValue == 0 {
                        
                        ForEach(resultsDayItems, id: \.self) { item in
                            let placemark = item.placemark
   
                            Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                        }
                    } else {
                        ForEach(resultsNightItems, id: \.self) { item in
                            let placemark = item.placemark

                            Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                        }
                    }
                }
                .toolbar(.hidden, for: .tabBar)
                .navigationBarBackButtonHidden(true)
                .onChange(of: mapSelection) { oldValue, newValue in
                    
                    
                    //MARK: Ставит центр карты в выбранный Пин 
//                    if let tempLocation = newValue?.placemark.coordinate {
//                        cameraPosition = .region(MKCoordinateRegion(center: tempLocation, latitudinalMeters: 300, longitudinalMeters: 300))
//                    }
                }
                
                Picker("", selection: $tabSelectedValue) {
                    Text("Day").tag(0)
                    Text("Night").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // TabView
                TabView(selection: $tabSelectedValue) {
                    Section {
                        if factory.workers.isEmpty {
                            VStack {
                                Image(systemName: "person.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .foregroundColor(.brown)
                                Text("No workers")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.indigo)
                            }
                            .padding()
                        }else {
                            List{
                                ForEach(factory.workers) { worker in
                                    if worker.isDay {
                                        HStack {
                                            Text(worker.name)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                            Spacer()
                                            
                                            Button {
                                                //
                                                guard let url = URL(string: "tel:\(worker.name)") else { return }
//                                                Link(worker.name, destination: url)
                                                
        //                                        UIApplication.shared.open(url)
                                                
                                            } label: {
                                                Image(systemName: "phone.circle")
                                                    .font(.title)
                                                    .foregroundStyle(Color.green)
                                                    .padding(.horizontal)
                                                    .imageScale(.large)
                                            }.buttonStyle(PlainButtonStyle())
                                        }
                                        .listRowBackground(mapSelection?.name == worker.name ? Color.orange.opacity(0.7) : Color(UIColor.secondarySystemGroupedBackground))
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            let mapSelectionTemp = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: worker.adress.latitude, longitude: worker.adress.longitude)))
                                            mapSelectionTemp.name = worker.name
                                            withAnimation(.easeIn) {
                                                mapSelection = mapSelectionTemp
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                    .tag(0)
                    Section {
                        if factory.workers.isEmpty {
                            VStack {
                                Image(systemName: "person.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .foregroundColor(.gray)
                                Text("No workers")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.indigo)
                            }
                            .padding()
                        }else {
                            List{
                                ForEach(factory.workers) { worker in
                                    if !worker.isDay {
                                        HStack {
                                            Text(worker.name)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                            Spacer()
                                            
                                            Button {
                                                //
                                            } label: {
                                                Image(systemName: "phone.circle")
                                                    .font(.title)
                                                    .foregroundStyle(Color.green)
                                                    .padding(.horizontal)
                                                    .imageScale(.large)
                                            }.buttonStyle(PlainButtonStyle())
                                        }
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            let mapSelectionTemp = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: worker.adress.latitude, longitude: worker.adress.longitude)))
                                            mapSelectionTemp.name = worker.name
                                            withAnimation(.easeIn) {
                                                mapSelection = mapSelectionTemp
                                            }
                                        }
                                        .listRowBackground(mapSelection?.name == worker.name ? Color.orange.opacity(0.7) : Color(UIColor.secondarySystemGroupedBackground))
                                    }
                                }
                            }
                        }
                    }
                    .tag(1)
                }
                Spacer()
            }
            // Custom NavigationLonk Back button
            VStack {
                HStack {
                    Button(action: {
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
        .onAppear{
            addResItemsArr()
            
        }
    }
    
    func addResItemsArr() {
        for worker in factory.workers {
            let mapItem = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: worker.adress.latitude, longitude: worker.adress.longitude))
            let result = MKMapItem(placemark: mapItem)
            result.name = worker.name
            if worker.isDay {
                self.resultsDayItems.append(result)
            } else {
                self.resultsNightItems.append(result)
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 35.41400293060255, longitude: 129.17414770269838)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 600, longitudinalMeters: 600)
    }
}

//#Preview {
//    InThisWeekDitail(factory: )
//}      MKCoordinateRegion(center: .userLocation, latitudinalMeters: 600, longitudinalMeters: 600)

