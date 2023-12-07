//
//  ContentView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/4/23.
//

import SwiftUI


/// three views:
/// map, contacts, health
/// every view has a protected resources associated with it.
/// all of those views have a shared notifications thing with it??? maybe??
///
struct ContentView: View {
    @StateObject var notificationManager = NotificationManager()
    var body: some View {
        TabView {
            MapView()
                .tabItem { Label("Map", systemImage: "map") }
            ContactsView()
                .tabItem { Label("Contacts", systemImage: "person.3") }
            HealthView()
                .tabItem { Label("Health", systemImage: "cross") }
        }
    }
}

#Preview {
    ContentView()
}
