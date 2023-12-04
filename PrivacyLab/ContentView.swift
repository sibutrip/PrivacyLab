//
//  ContentView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var notificationManager = NotificationManager()
    var body: some View {
        TabView {
            Text("Map / Location")
                .tabItem { Label("Map", systemImage: "map") }
            Text("Contacts")
                .tabItem { Label("Contacts", systemImage: "person.3") }
            Text("Health")
                .tabItem { Label("Health", systemImage: "cross") }
        }
    }
}

#Preview {
    ContentView()
}
