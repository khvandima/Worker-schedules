//
//  Worker_schedulesApp.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/17/24.
//

import SwiftUI
import SwiftData

@main
struct Worker_schedulesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Worker.self, Factory.self])
        }
        .environment(\.colorScheme, .dark)
    }
}
