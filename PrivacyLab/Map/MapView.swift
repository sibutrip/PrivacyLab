//
//  MapView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var privateDataManager: PrivateDataManager
    var body: some View {
        if privateDataManager.hasLocationPermission {
            Text("map")
        } else {
            Text("hey you need to enable blah blah blah")
        }
    }
}

#Preview {
    MapView()
}
