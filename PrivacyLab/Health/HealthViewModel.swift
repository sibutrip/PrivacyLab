//
//  HealthViewModel.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 1/3/24.
//

import SwiftUI
import HealthKit

@MainActor
class HealthViewModel: ObservableObject {
    
    private let healthStore = HKHealthStore()
    @Published var steps = 0
    
    public func requestHealthPermission() async {
        #warning("Heath Setup: To start this, we need to manually add steps to the simulator's Health app. Open Health and tap Steps > Add Data. Add some number of steps to today's step count.")
#warning("Health Step 1: Go through the HealthKit documentation to find out how to request access the user's step count. You will also need to add this permission to the project's info.plist file. Hint: In Xcode, use ⌘ ⇧ 0 to open up the Swift Documentation. Search for HealthKit and look for ways to request authorization for reading health data")
        do {
            try await healthStore.requestAuthorization(toShare: [], read: [HKSampleType.quantityType(forIdentifier: .stepCount)!])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getStepsFromToday() {
        guard let stepType = HKSampleType.quantityType(forIdentifier: .stepCount) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: Date().advanced(by: -86400), end: Date().addingTimeInterval(86400), options: HKQueryOptions())
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate) { query, results, error in
            if error != nil {
                print("Permission denied or no step information was provided")
                print("iPhone simulator has no step information by default. Add steps for today manually in the Health app to simulate this.")
                return
            }
            
            let steps = results?.sumQuantity()?.doubleValue(for: .count()) ?? 0
            Task {
                await MainActor.run {
                    self.steps = Int(steps)
                }
            }
        }
        healthStore.execute(query)
    }
}
