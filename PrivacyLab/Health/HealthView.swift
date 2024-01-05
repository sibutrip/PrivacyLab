//
//  HealthView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

#warning("Health Step 2: Delay requesting access the user's step count for as long as possible")
#warning("Health Step 3: If the user does not give permission to access their step count, show  a button that takes the user to the Health app to enable these permissions.")
#warning("Health Step 4: Find the necessary usage description key-value pair to add to the the app's info.plist in order to access Health information")

struct HealthView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    @State private var isShowingStepCount = false
    
    var body: some View {
        ZStack {
            if healthViewModel.steps > 0 {
                Button("View today's step count") {
                    healthViewModel.getStepsFromToday()
                    isShowingStepCount = true
                }
                .buttonStyle(.borderedProminent)
            } else {
                VStack {
                    Text("No steps found for today")
                    Button {
                        SettingsService.navigateToHealthSettings()
                    } label: {
                        VStack {
                            Label("Enable Fitness Permissions", systemImage: "figure.walk")
                            Text("In Health > Steps > Data Sources & Access")
                                .font(.caption)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .sheet(isPresented: $isShowingStepCount) {
            Text("You've walked \(healthViewModel.steps) steps today!")
        }
        .task {
            await healthViewModel.requestHealthPermission()
            healthViewModel.getStepsFromToday()
        }
    }
}
