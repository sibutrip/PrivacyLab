//
//  HealthView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

#warning("Health Step 2: Go through the HealthKit documentation to find out how to access the user's step count")
#warning("Health Step 2: Delay requesting permission to health data for as long as possible")


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

#Preview {
    HealthView()
}
