//
//  HealthView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

#warning("Health Step 2: Delay requesting access the user's step count for as long as possible")
#warning("Health Step 3: If the user does not give permission to access their step count, show  a button that takes the user to PrivacyLab's Settings page.")
#warning("Health Step 4: Find the necessary usage description key-value pair to add to the the app's info.plist in order to access Health information")


struct HealthView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    @State private var isShowingStepCount = false
    var body: some View {
        Button("View my step count") {
            isShowingStepCount = true
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isShowingStepCount) {
            Text("You've walked \(healthViewModel.steps) steps today!")
        }
        .onAppear {
            healthViewModel.getStepsFromToday()
        }
    }
}
