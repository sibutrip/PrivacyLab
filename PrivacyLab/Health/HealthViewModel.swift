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
    @State var steps = 0.0
    
    
    public func requestHealthPermission() {
        Task(priority: .userInitiated) {
#warning("Health Step 1: Go through the HealthKit documentation to find out how to request access the user's step count. You will also need to add this permission to the project's info.plist file")
//            try await healthStore.requestAuthorization(toShare: [], read: [HKSampleType.quantityType(forIdentifier: .stepCount)!])
        }
    }
    
    public func getStepsFromToday() {
        guard let stepType = HKSampleType.quantityType(forIdentifier: .stepCount) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: .distantPast, end: .distantFuture, options: HKQueryOptions())
        
        var interval = DateComponents()
        interval.day = 1
        
        var stepCount: Double = 0
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate) { query, results, error in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            let steps = results?.sumQuantity()?.doubleValue(for: .count())
            stepCount += steps!
        }
        healthStore.execute(query)
        self.steps = stepCount
    }
}
