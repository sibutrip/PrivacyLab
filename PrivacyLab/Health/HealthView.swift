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
#warning("Heath Bonus: If you deny permission initially, enable it in Health, and switch back to the app, the step count doesn't refresh. Why is that? To to make the app automatically refresh the step count when you switch back to it.")

struct HealthView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    @State private var isShowingStepCount = false
    
    var body: some View {
        Button("View today's step count") {
            isShowingStepCount = true
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isShowingStepCount) {
            Text("You've walked \(healthViewModel.steps) steps today!")
        }
    }
}
