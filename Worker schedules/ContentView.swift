//
//  ContentView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/17/24.
//

import SwiftUI

struct ContentView: View {
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
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Factory.self)
}
