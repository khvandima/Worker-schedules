//
//  ContentView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/17/24.
//

import SwiftUI
import MapKit
import SwiftData

struct ContentView: View {
    
    @Query(animation: .snappy) private var factories: [Factory]
    
    var body: some View {
        TabView{
            InThisWeekPage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                       
                }
                .toolbarBackground(Color.black.opacity(0.8),for: .tabBar)
            
            FactoriesView()
                .tabItem {
                    Image(systemName: "building.2")
                    Text("Factories")
                }
                .toolbarBackground(Color.black.opacity(0.8),for: .tabBar)
            
            AllView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("All")
                }
                .toolbarBackground(Color.black.opacity(0.8),for: .tabBar)
//            SearchAdressView()
//                .tabItem {
//                    Image(systemName: "map")
//                    Text("All")
//                }
//                .toolbarBackground(Color.black.opacity(0.8),for: .tabBar)
//                
        }
        .onAppear{
            CLLocationManager().requestWhenInUseAuthorization()
            let calendar = Calendar(identifier: .gregorian)
            let weekDay = calendar.component(.weekday, from: Date())
            for factory in factories {
                if weekDay == 1 {
                    if !factory.dayOnly && factory.isAuto {
                        for worker in factory.workers {
                            worker.isDay.toggle()
                        }
                    }
                }
                
            }
        }
        .tint(Color.plusButton)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Factory.self)
}
