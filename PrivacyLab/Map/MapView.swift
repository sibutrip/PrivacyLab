//
//  MapView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI
import MapKit

/// 1. make it not ask for permission until you navigate to the mapview
///
struct MapView: View {
    @EnvironmentObject var privateDataManager: PrivateDataManager
    @State private var mapCameraPosition = MapCameraPosition.automatic
    @State private var hasLocationPermission = false
    
    var body: some View {
        Group {
            if hasLocationPermission {
                Map(position: $mapCameraPosition)
            } else {
                // they should make the text that tells the user what to do to enable permission
                // make an alert to take them to settings. (they can reference contacts view for the instructions)
                Button {
                    privateDataManager.navigateToSettings()
                } label: {
                    Text("hey you need to enable blah blah blah")
                }
            }
        }
        .onAppear {
            privateDataManager.requestLocationPermission()
        }
        .onChange(of: privateDataManager.mapArea) { _ , mapLocation in
            if let mapLocation {
                let cameraPosition = MapCameraPosition.rect(mapLocation)
                mapCameraPosition = cameraPosition
                hasLocationPermission = true
            } else {
                hasLocationPermission = false
            }
        }
    }
}

#Preview {
    MapView()
}