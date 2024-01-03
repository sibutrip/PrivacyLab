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
    // MARK: - Health
    
    private let healthStore = HKHealthStore()
    @State var steps = 0.0
    
    
    func requestHealthPermission() {
        Task(priority: .userInitiated) {
            try await healthStore.requestAuthorization(toShare: [], read: [HKSampleType.quantityType(forIdentifier: .stepCount)!])
        }
    }
    
    func stepsFromToday() {
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
    
    
    // get permission for health data. (use x method)
    // display the data
    // give them instructions on what to do if they havent given permission
}
