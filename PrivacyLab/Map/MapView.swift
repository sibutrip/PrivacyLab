//
//  MapView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

/// 1. make it not ask for permission until you navigate to the mapview
///
struct MapView: View {
    @EnvironmentObject var privateDataManager: PrivateDataManager
    var body: some View {
        if privateDataManager.hasLocationPermission {
            Text("map")
        } else {
            // they should make the text that tells the user what to do to enable permission
            // make an alert to take them to settings. (they can reference contacts view for the instructions)
            Text("hey you need to enable blah blah blah")
        }
    }
}

#Preview {
    MapView()
}
