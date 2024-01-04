//
//  ContentView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contactsViewModel = ContactsViewModel()
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var healthViewModel = HealthViewModel()
    var body: some View {
        TabView {
            ContactsView()
                .tabItem { Label("Contacts", systemImage: "person.3") }
            MapView()
                .tabItem { Label("Map", systemImage: "map") }
            HealthView()
                .tabItem { Label("Health", systemImage: "cross") }
        }
        .environmentObject(contactsViewModel)
        .environmentObject(mapViewModel)
        .environmentObject(healthViewModel)
        .task {
            await contactsViewModel.requestContactsPermission()
            mapViewModel.requestLocationPermission()
            healthViewModel.requestHealthPermission()
        }
#warning("Contacts Step 1: First we need to delay requesting access to contacts for as long as possible. Right now the app requests permission to access the user's contacts before ContentView appears by calling `contactsViewModel.requestContactsPermission` (See above). Let's call this function only when the app actively needs to access the user's contacts. Before moving to Step 2, take a moment to explore the contacts portion of the app and figure out when this permission should be requested.")
    }
}

#Preview {
    ContentView()
}
