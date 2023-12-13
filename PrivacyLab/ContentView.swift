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
///
///for all of them, provide a better plist description

/// Enact user privacy protections.
///

struct ContentView: View {
    @StateObject var privateDataManager = PrivateDataManager()
    var body: some View {
        TabView {
            ContactsView()
                .tabItem { Label("Contacts", systemImage: "person.3") }
            MapView()
                .tabItem { Label("Map", systemImage: "map") }
            HealthView()
                .tabItem { Label("Health", systemImage: "cross") }
        }
        .environmentObject(privateDataManager)
    }
}

#Preview {
    ContentView()
}
