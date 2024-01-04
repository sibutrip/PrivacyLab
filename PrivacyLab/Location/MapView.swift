//
//  MapView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI
import MapKit

#warning("Location Step 1: Delay requesting access to the user's location as long as possible. Where do we currently request permission to this resource? Where would be a better place to request that?")
#warning("Location Step 2: As of now, if you deny permission of the app, the show the user the `mapCameraPosition` which is centered on the United States. Instead of this, let's show the `mapCameraPosition` only if the user has enabled location permissions (use the `hasLocationPermission` property of our `MapViewModel`); otherwise, show a button that takes the user to PrivacyLab's Settings page (hint: use the `navigateToSettings` method in `SettingsService`, look at how we use it `ContactsView` if you get stuck).")
#warning("Location Step 3: Change the `NSLocationWhenInUseUsageDescription` description in PrivacyLab's info.plist to be more descriptive.")

struct MapView: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    @State private var mapCameraPosition = MapCameraPosition.automatic
    
    var body: some View {
        Map(position: $mapCameraPosition)
            .onChange(of: mapViewModel.mapArea) { _ , mapLocation in
                if let mapLocation {
                    let cameraPosition = MapCameraPosition.rect(mapLocation)
                    mapCameraPosition = cameraPosition
                }
            }
    }
}
